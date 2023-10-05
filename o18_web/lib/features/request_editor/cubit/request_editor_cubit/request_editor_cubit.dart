// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'request_editor_state.dart';

class RequestEditorCubit extends Cubit<RequestEditorState> {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;
  final User? user;

  RequestEditorCubit({
    this.user,
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  }) : super(RequestEditorInitial()) {
    if (requestSelection == RequestSelection.existedRequest) {
      loadRequestData(userRequest: userRequest!);
    }

    if (requestSelection == RequestSelection.newReques) {
      createNewRequest();
    }
  }

  final _requestNumberRepository = RequestNumberRepository();
  final _userRequestRepository = UserRequestRepository();
  final _houseRepository = HouseRepository();
  final _accountRepository = AccountRepository();
  final _partnerRepository = PartnerRepository();
  final _staffRepository = StaffRepository();
  final _ownerRepository = OwnerRepository();
  final _messagesRepository = MessagesRepository();
  final _imageRepository = ImageRepository();

  Future<void> loadRequestData({
    required UserRequest userRequest,
  }) async {
    // get user request list
    final list = await _userRequestRepository.getUserRequestList();
    list!.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));

    // get account
    final accountList = await _accountRepository.getAccountList();
    final account = accountList.firstWhere(
      (a) => a.accountNumber == userRequest.accountNumber,
    );

    // get address
    final houseList = await _houseRepository.getHouseList();
    final addressList = houseList
        .map((e) => Address(
              street: e.street!,
              houseNumber: e.houseNumber!,
            ))
        .toList();

    final address = addressList.firstWhere(
      (a) => a.addressToString == userRequest.address,
    );

    // get owner
    final owner = await _ownerRepository.getOwnerById(
      ownerId: userRequest.ownerId!,
    );

    Partner? partner;
    Staff? master;
    Staff? staff;

    /// store entire staff list with no separation on it's role
    var staffList = <Staff>[];

    // get partner
    if (userRequest.partnerId != '' && userRequest.partnerId != null) {
      final partnerList = await _partnerRepository.getPartnerList();
      partner = partnerList.firstWhere(
        (p) => p.objectId == userRequest.partnerId,
      );
      staffList = await _staffRepository.getStaffList();
    }

    // get master
    if (userRequest.masterId != '' && userRequest.masterId != null) {
      master = staffList.firstWhere((m) => m.objectId == userRequest.masterId);
    }

    // get staff
    if (userRequest.staffId != '' && userRequest.staffId != null) {
      staff = staffList.firstWhere((s) => s.objectId == userRequest.staffId);
    }

    emit(RequestDataLoaded(
      userRequest: userRequest,
      operatorName: user?.name ?? 'Оператор',
      requestList: list,
      account: account,
      address: address,
      owner: owner!,
      partner: partner,
      master: master,
      staff: staff,
    ));
  }

  Future<void> createNewRequest() async {
    emit(RequestDataLoading());
    final requestNumber = await _requestNumberRepository.getLastRequestNumber();
    final list = await _userRequestRepository.getUserRequestList();
    list!.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));

    emit(CreateNewRequest(
      requestNumber,
      list,
      user?.name ?? 'Оператор',
    ));
  }

  Future saveRequest({
    required int requestNumber,
    required String requestText,
    required String requestType,
    required String jobType,
    required Address address,
    required DateTime responseDate,
    required String phoneNumber,
    required Account account,
    required Owner owner,
    required String flatNumber,
    required RequestSelection requestSelection,
    String? requestNote,
    Partner? partner,
    Staff? masterStaff,
    Staff? partnerStaff,
    UserRequest? userRequest,
  }) async {
    var uRequest = UserRequest();
    var requestDate = DateTime.now();

    // if this is existing userRequest, then assign it to variable
    if (requestSelection == RequestSelection.existedRequest) {
      uRequest = userRequest!;
    }

    // if this is new request, then set it's status to Recieved
    if (requestSelection == RequestSelection.newReques) {
      uRequest.status = RS.received;
    }

    // if this is not new request, then assign existing date
    if (requestSelection == RequestSelection.existedRequest) {
      requestDate = userRequest!.requestDate ?? DateTime.now();
    }

    uRequest
      ..requestNumber = requestNumber
      ..userRequest = requestText
      ..accountNumber = account.accountNumber
      ..address = address.addressToString
      ..flatNumber = flatNumber
      ..responseDate = responseDate
      ..requestDate = requestDate
      ..phoneNumber = phoneNumber.cleanNumber
      ..userName = owner.name
      ..ownerId = owner.objectId
      ..requestType = requestType
      ..jobType = jobType
      ..author = RequestEditorString.operator
      ..partnerId = partner?.objectId
      ..masterId = masterStaff?.objectId
      ..staffId = partnerStaff?.objectId
      ..requestNote = requestNote
      ..debt = account.debt
      ..wasSeen = true;

    // save or update request and get response
    var response = ParseResponse();

    if (requestSelection == RequestSelection.existedRequest) {
      response = await uRequest.update();
    } else {
      response = await uRequest.save();
    }

    log(
      'request was ${response.success ? '' : 'NOT'} ${requestSelection == RequestSelection.existedRequest ? 'updated' : 'saved'}',
      name: 'RequestEditorCubit',
      error: response.error?.message,
    );

    if (response.success) {
      if (requestSelection == RequestSelection.newReques) {
        unawaited(_requestNumberRepository.incrementRequestNumber());
      }
      emit(RequestOperationSuccess());
    } else {
      emit(RequestOperationFailed(
        error: response.error.toString(),
      ));
    }
  }

  Future<void> closeUserRequest({
    required UserRequest userRequest,
  }) async {
    userRequest.status = RS.closed;
    final response = await userRequest.update();

    // notify user via push
    final owner = await _ownerRepository.getOwnerById(
      ownerId: userRequest.ownerId!,
    );

    final houseList = await _houseRepository.getHouseList();
    final house = houseList.firstWhere(
      (h) => h.addressToString == userRequest.address,
    );

    // if user post new request from his phone (mobile app)
    // then send push only for this device
    if (userRequest.userToken != null) {
      await _messagesRepository.sendPushToToken(
        title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
        message: RequestEditorString.requestIsClosed,
        token: userRequest.userToken!,
        ownerId: owner!.objectId!,
        houseId: house.objectId!,
      );

      // otherwise get device list for user and send push to
      // all devices
    } else if (owner!.deviceTokenList != null && owner.deviceTokenList!.isNotEmpty) {
      owner.deviceTokenList!.forEach((token) {
        _messagesRepository.sendPushToToken(
          title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
          message: RequestEditorString.requestIsClosed,
          token: token.toString(),
          ownerId: owner.objectId!,
          houseId: house.objectId!,
        );
      });
    }

    log(
      'request was ${response.success ? '' : 'NOT'} closed',
      name: 'RequestEditorCubit',
      error: response.error?.message,
    );

    if (response.success) {
      emit(RequestOperationSuccess());
    } else {
      emit(RequestOperationFailed(error: response.error.toString()));
    }
  }

  Future<void> cancelUserRequest({
    required UserRequest userRequest,
    required String cancelReason,
  }) async {
    // update user request status
    userRequest.status = RS.canceled;
    userRequest.cancelReason = cancelReason;
    userRequest.response = RequestEditorString.requestIsCancelled;
    userRequest.responseDate = DateTime.now();
    userRequest.wasSeen = true;

    final response = await userRequest.update();

    // notify user via push
    final owner = await _ownerRepository.getOwnerById(
      ownerId: userRequest.ownerId!,
    );

    final houseList = await _houseRepository.getHouseList();
    final house = houseList.firstWhere(
      (h) => h.addressToString == userRequest.address,
    );

    // if user post new request from his phone (mobile app)
    // then send push only for this device
    if (userRequest.userToken != null) {
      await _messagesRepository.sendPushToToken(
        title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
        message: RequestEditorString.requestIsCancelled,
        token: userRequest.userToken!,
        ownerId: owner!.objectId!,
        houseId: house.objectId!,
      );

      // otherwise get device list for user and send push to
      // all devices
    } else if (owner!.deviceTokenList != null && owner.deviceTokenList!.isNotEmpty) {
      owner.deviceTokenList!.forEach((token) {
        _messagesRepository.sendPushToToken(
          title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
          message: RequestEditorString.requestIsCancelled,
          token: token.toString(),
          ownerId: owner.objectId!,
          houseId: house.objectId!,
        );
      });
    }

    log(
      'request was ${response.success ? '' : 'NOT'} canceled',
      name: 'RequestEditorCubit',
      error: response.error?.message,
    );

    if (response.success) {
      emit(RequestOperationSuccess());
    } else {
      emit(RequestOperationFailed(error: response.error.toString()));
    }
  }

  Future<void> submitRequestToWork({
    required UserRequest userRequest,
    required Partner partner,
    required Staff master,
    required Staff staff,
  }) async {
    final dateWithTime = DateFormat('dd.MM.yy HH:mm');

    // prepare push notification data
    final _notificationTitle = '${RequestEditorString.requestNumber} ${userRequest.requestNumber}';
    final _notificationMessage = '${RequestEditorString.requestAddress}: ${userRequest.address}.\n\n'
        '${RequestEditorString.requestDetails}: ${userRequest.userRequest}.\n\n'
        '${RequestEditorString.seeRequestDetailsInTab}.';

    // send push to staff
    final staffList = await _staffRepository.getStaffList();

    final _staffList = staffList.toList()
      ..retainWhere(
        (s) => s.role == StaffRole.staff,
      );

    final _staff = _staffList.firstWhere(
      (s) => s.name == staff.name && s.partnerId == partner.objectId,
    );
    final staffMessage = StaffMessage()
      ..title = _notificationTitle
      ..body = _notificationMessage
      ..date = DateTime.now()
      ..staffId = _staff.objectId;

    final staffMessageResponse = await staffMessage.save();

    if (staffMessageResponse.success) {
      final staffToken = await _staffRepository.getStaffToken(
        staffName: staff.name!,
        partnerId: partner.title!,
      );

      if (staffToken != null) {
        final messageWasSent = await _messagesRepository.sendPushToToken(
          title: _notificationTitle,
          message: _notificationMessage,
          token: staffToken,
        );

        if (messageWasSent) {
          log(
            'staff message WAS sent',
            name: 'RequestEditorCubit: submitRequestToWork',
          );
        } else {
          log(
            'staff message wa NOT sent',
            name: 'RequestEditorCubit: submitRequestToWork',
            error: 'staff message wa NOT sent',
          );
        }
      } else {
        log(
          'no staff token',
          name: 'RequestEditorCubit: submitRequestToWork',
          error: 'no staff token',
        );
      }
    } else {
      log(
        'staff message was NOT saved',
        name: 'RequestEditorCubit: submitRequestToWork',
        error: staffMessageResponse.error.toString(),
      );
    }

    // send push to master
    final _masterList = staffList.toList()
      ..retainWhere(
        (m) => m.role == StaffRole.master,
      );

    final _master = _masterList.firstWhere(
      (m) => m.name == master.name && m.partnerId == partner.objectId!,
    );

    final masterMessage = StaffMessage()
      ..title = _notificationTitle
      ..body = _notificationMessage
      ..date = DateTime.now()
      ..staffId = _master.objectId;

    final masterMessageResponse = await masterMessage.save();

    if (masterMessageResponse.success) {
      final masterToken = await _staffRepository.getStaffToken(
        staffName: master.name!,
        partnerId: partner.objectId!,
      );
      if (masterToken != null) {
        final messageWasSent = await _messagesRepository.sendPushToToken(
          title: _notificationTitle,
          message: _notificationMessage,
          token: masterToken,
        );

        if (messageWasSent) {
          log(
            'master message WAS sent',
            name: 'RequestEditorCubit: submitRequestToWork',
          );
        } else {
          log(
            'master message was NOT sent',
            name: 'RequestEditorCubit: submitRequestToWork',
            error: 'master message was NOT sent',
          );
        }
      } else {
        log(
          'no master token',
          name: 'RequestEditorCubit: submitRequestToWork',
          error: 'no master token',
        );
      }
    } else {
      log(
        'master message was NOT saved',
        name: 'RequestEditorCubit: submitRequestToWork',
        error: masterMessageResponse.error.toString(),
      );
    }
    // send push to owner
    final owner = await _ownerRepository.getOwnerById(
      ownerId: userRequest.ownerId!,
    );

    final houseList = await _houseRepository.getHouseList();
    final house = houseList.firstWhere(
      (h) => h.addressToString == userRequest.address,
    );
    final ownerMessage = ParseMessage()
      ..body = '${RequestEditorString.requestPassedToWork} ${dateWithTime.format(DateTime.now())}!'
          ' ${RequestEditorString.master}: ${master.name}, ${RequestEditorString.staff}: ${staff.name}.'
      ..date = DateTime.now()
      ..title = '${RequestEditorString.requestNotification} ${userRequest.requestNumber}'
      ..wasSeen = false
      ..ownerId = owner!.objectId
      ..houseId = house.objectId;

    final ownerMessageResponse = await ownerMessage.save();

    if (ownerMessageResponse.success) {
      // if user post new request from his phone (mobile app)
      // then send push only for this device
      if (userRequest.userToken != null) {
        await _messagesRepository.sendPushToToken(
          title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
          message: '${RequestEditorString.requestPassedToWork} ${dateWithTime.format(DateTime.now())}!'
              ' ${RequestEditorString.master}: ${master.name}, ${RequestEditorString.staff}: ${staff.name}.',
          token: userRequest.userToken!,
          ownerId: owner.objectId!,
          houseId: house.objectId!,
        );

        // otherwise get device list for user and send push to
        // all devices
      } else if (owner.deviceTokenList != null && owner.deviceTokenList!.isNotEmpty) {
        owner.deviceTokenList!.forEach((token) async {
          await _messagesRepository.sendPushToToken(
            title: '${RequestEditorString.requestNotification} ${userRequest.requestNumber}',
            message: '${RequestEditorString.requestPassedToWork} ${dateWithTime.format(DateTime.now())}!'
                ' ${RequestEditorString.master}: ${master.name}, ${RequestEditorString.staff}: ${staff.name}.',
            token: token.toString(),
            ownerId: owner.objectId!,
            houseId: house.objectId!,
          );
        });
      }

      userRequest.status = RS.inProgress;
      userRequest.partnerId = partner.objectId;
      userRequest.masterId = master.name;
      userRequest.staffId = staff.name;
      final userRequestResponse = await userRequest.update();

      if (staffMessageResponse.success &&
          masterMessageResponse.success &&
          ownerMessageResponse.success &&
          userRequestResponse.success) {
        emit(RequestOperationSuccess());
      } else {
        emit(const RequestOperationFailed(
          error: RequestEditorString.error,
        ));
      }
    }
  }

  Future<List<ImageFile>> getImages({
    required String userRequestId,
  }) async {
    final list = await _imageRepository.getImageListForRequestId(
      requestId: userRequestId,
    );

    if (list.isNotEmpty) {
      // fixing url address
      list.forEach((image) {
        final url = image.file!.url!.replaceAll('http://', 'https://');
        image.file!.url = url;
      });

      return list;
    }

    return [];
  }
}
