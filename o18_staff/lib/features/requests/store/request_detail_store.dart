import 'dart:io';

import 'package:database_repository/database_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
part 'request_detail_store.g.dart';

class RequestDetailStore = _RequestDetailStoreBase with _$RequestDetailStore;

abstract class _RequestDetailStoreBase with Store {
  @observable
  ObservableFuture<Owner?>? owner;

  @observable
  ObservableFuture<Staff?>? staff;

  @observable
  ObservableFuture<List<ImageFile>?>? imageList;

  @observable
  bool imageUploading = false;

  @observable
  File? image1;

  @observable
  File? image2;

  @observable
  File? image3;

  @observable
  File? image4;

  @observable
  File? image5;

  @observable
  File? image6;

  @observable
  File? image7;

  @observable
  File? image8;

  @observable
  File? image9;

  @observable
  File? image10;

  @observable
  bool responseDateUpdating = false;

  final _ownerRepository = OwnerRepository();
  final _staffRepository = StaffRepository();
  final _imageRepository = ImageRepository();
  final _messagesRepository = MessagesRepository();

  @action
  Future<void> loadOwner({
    required String ownerId,
  }) =>
      owner = ObservableFuture(
        _loadOwner(ownerId: ownerId),
      );

  @action
  Future<void> loadStaff({
    required String staffId,
  }) =>
      staff = ObservableFuture(
        _loadStaff(staffId: staffId),
      );

  Future<Owner?> _loadOwner({
    required String ownerId,
  }) async =>
      _ownerRepository.getOwnerById(ownerId: ownerId);

  Future<Staff?> _loadStaff({
    required String staffId,
  }) async {
    final staffList = await _staffRepository.getStaffList();
    final staff = staffList.firstWhere(
      (s) => s.objectId == staffId,
    );
    return staff;
  }

  @action
  Future<void> loadImageList({
    required String userRequestId,
  }) =>
      imageList = ObservableFuture(
        _loadImageList(userRequestid: userRequestId),
      );

  Future<List<ImageFile>> _loadImageList({
    required String userRequestid,
  }) async =>
      _imageRepository.getImageListForRequestId(
        requestId: userRequestid,
      );

  @action
  Future<void> loadImage({
    required File image,
    required String requestId,
  }) async {
    final parseFile = ParseFile(File(image.path));

    final file = ImageFile();
    file.set(ImageFile.keyRequestId, requestId);
    file.set(ImageFile.keyFile, parseFile);

    await file.save();
  }

  @action
  Future<void> sendPushToToken({
    required String title,
    required String message,
    required String token,
  }) async {
    responseDateUpdating = true;
    await _messagesRepository.sendPushToToken(
      title: title,
      message: message,
      token: token,
    );
    responseDateUpdating = false;
  }
}
