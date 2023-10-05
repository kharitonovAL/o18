import 'dart:io';
import 'package:bot_app/models/models.dart';
import 'package:bot_app/repositories/repos.dart';

class UserRequestRepository {
  UserRequestRepository();

  static const int queryLimit = 1000000;

  Future<bool> sendRequest({
    required String accountNumber,
    required int requestNumber,
    required int phoneNumber,
    required String request,
    required OwnerRepository ownerRepository,
    required AccountRepository accountRepository,
    required FlatRepository flatRepository,
    required HouseRepository houseRepository,
    required RequestNumberRepository requestNumberRepository,
    required ImageFileRepository imageFileRepository,
    File? image1,
    File? image2,
    File? image3,
    File? image4,
    File? image5,
  }) async {
    final ownerList = await ownerRepository.getOwnerListByAccountNumber(
      accountNumber: accountNumber,
      accountRepository: accountRepository,
    );

    final owner = ownerList.first;
    final account = await accountRepository.accountByOwner(owner: owner);
    final flat = await flatRepository.flatByAccount(
      accountId: account.objectId!,
    );

    if (flat == null) {
      return false;
    }

    final house = await houseRepository.houseByFlat(flat: flat);

    if (house != null) {
      // update owner phone number
      owner.phoneNumber = phoneNumber;
      if (owner.phoneNumberList != null) {
        if (!owner.phoneNumberList!.contains(phoneNumber)) {
          owner.setAdd(Owner.keyPhoneNumberList, phoneNumber);
        }
      }
      await owner.update();

      final address = 'улица ${house.street}, ${house.houseNumber}';
      final today = DateTime.now().toLocal();
      final responseDate = today.hour < 12
          ? DateTime(today.year, today.month, today.day, 17)
          : DateTime(today.year, today.month, today.day, 12)
              .add(const Duration(days: 1));

      final userRequest = UserRequest();
      userRequest
        ..userRequest = request
        ..requestDate = DateTime.now().toLocal()
        ..responseDate = responseDate
        ..status = RequestStatus.received
        ..accountNumber = account.accountNumber
        ..address = address
        ..flatNumber = flat.flatNumber
        ..author = 'Бот'
        ..phoneNumber = owner.phoneNumber
        ..userName = owner.name
        ..requestNumber = requestNumber
        ..isFailure = false
        ..isPaid = false
        ..wasSeen = false
        ..partnerTitle = 'ООО УК "НАЗВАНИЕ УК"'
        ..ownerId = owner.objectId
        ..debt = account.debt;

      final response = await userRequest.save();

      if (response.success) {
        if (response.results != null) {
          final uRequestList =
              response.results!.map((dynamic ur) => ur as UserRequest).toList();

          if (uRequestList.isNotEmpty) {
            final uRequest = uRequestList.first;
            final requestId = uRequest.objectId!;

            if (image1 != null) {
              await imageFileRepository.loadImage(
                file: image1,
                requestId: requestId,
              );
            }
            if (image2 != null) {
              await imageFileRepository.loadImage(
                file: image2,
                requestId: requestId,
              );
            }
            if (image3 != null) {
              await imageFileRepository.loadImage(
                file: image3,
                requestId: requestId,
              );
            }
            if (image4 != null) {
              await imageFileRepository.loadImage(
                file: image4,
                requestId: requestId,
              );
            }
            if (image5 != null) {
              await imageFileRepository.loadImage(
                file: image5,
                requestId: requestId,
              );
            }

            await requestNumberRepository.incrementRequestNumbers();
            return true;
          } else {
            print('uRequestList is empty in UserRequestRepository');
          }
        } else {
          print('response.results is null in UserRequestRepository');
        }
      }
    }

    return false;
  }
}
