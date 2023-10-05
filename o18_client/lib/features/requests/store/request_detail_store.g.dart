// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestDetailStore on _RequestDetailStoreBase, Store {
  late final _$ownerAtom =
      Atom(name: '_RequestDetailStoreBase.owner', context: context);

  @override
  ObservableFuture<Owner?>? get owner {
    _$ownerAtom.reportRead();
    return super.owner;
  }

  @override
  set owner(ObservableFuture<Owner?>? value) {
    _$ownerAtom.reportWrite(value, super.owner, () {
      super.owner = value;
    });
  }

  late final _$staffAtom =
      Atom(name: '_RequestDetailStoreBase.staff', context: context);

  @override
  ObservableFuture<Staff?>? get staff {
    _$staffAtom.reportRead();
    return super.staff;
  }

  @override
  set staff(ObservableFuture<Staff?>? value) {
    _$staffAtom.reportWrite(value, super.staff, () {
      super.staff = value;
    });
  }

  late final _$imageListAtom =
      Atom(name: '_RequestDetailStoreBase.imageList', context: context);

  @override
  ObservableFuture<List<ImageFile>?>? get imageList {
    _$imageListAtom.reportRead();
    return super.imageList;
  }

  @override
  set imageList(ObservableFuture<List<ImageFile>?>? value) {
    _$imageListAtom.reportWrite(value, super.imageList, () {
      super.imageList = value;
    });
  }

  late final _$imageUploadingAtom =
      Atom(name: '_RequestDetailStoreBase.imageUploading', context: context);

  @override
  bool get imageUploading {
    _$imageUploadingAtom.reportRead();
    return super.imageUploading;
  }

  @override
  set imageUploading(bool value) {
    _$imageUploadingAtom.reportWrite(value, super.imageUploading, () {
      super.imageUploading = value;
    });
  }

  late final _$image1Atom =
      Atom(name: '_RequestDetailStoreBase.image1', context: context);

  @override
  File? get image1 {
    _$image1Atom.reportRead();
    return super.image1;
  }

  @override
  set image1(File? value) {
    _$image1Atom.reportWrite(value, super.image1, () {
      super.image1 = value;
    });
  }

  late final _$image2Atom =
      Atom(name: '_RequestDetailStoreBase.image2', context: context);

  @override
  File? get image2 {
    _$image2Atom.reportRead();
    return super.image2;
  }

  @override
  set image2(File? value) {
    _$image2Atom.reportWrite(value, super.image2, () {
      super.image2 = value;
    });
  }

  late final _$image3Atom =
      Atom(name: '_RequestDetailStoreBase.image3', context: context);

  @override
  File? get image3 {
    _$image3Atom.reportRead();
    return super.image3;
  }

  @override
  set image3(File? value) {
    _$image3Atom.reportWrite(value, super.image3, () {
      super.image3 = value;
    });
  }

  late final _$image4Atom =
      Atom(name: '_RequestDetailStoreBase.image4', context: context);

  @override
  File? get image4 {
    _$image4Atom.reportRead();
    return super.image4;
  }

  @override
  set image4(File? value) {
    _$image4Atom.reportWrite(value, super.image4, () {
      super.image4 = value;
    });
  }

  late final _$image5Atom =
      Atom(name: '_RequestDetailStoreBase.image5', context: context);

  @override
  File? get image5 {
    _$image5Atom.reportRead();
    return super.image5;
  }

  @override
  set image5(File? value) {
    _$image5Atom.reportWrite(value, super.image5, () {
      super.image5 = value;
    });
  }

  late final _$image6Atom =
      Atom(name: '_RequestDetailStoreBase.image6', context: context);

  @override
  File? get image6 {
    _$image6Atom.reportRead();
    return super.image6;
  }

  @override
  set image6(File? value) {
    _$image6Atom.reportWrite(value, super.image6, () {
      super.image6 = value;
    });
  }

  late final _$image7Atom =
      Atom(name: '_RequestDetailStoreBase.image7', context: context);

  @override
  File? get image7 {
    _$image7Atom.reportRead();
    return super.image7;
  }

  @override
  set image7(File? value) {
    _$image7Atom.reportWrite(value, super.image7, () {
      super.image7 = value;
    });
  }

  late final _$image8Atom =
      Atom(name: '_RequestDetailStoreBase.image8', context: context);

  @override
  File? get image8 {
    _$image8Atom.reportRead();
    return super.image8;
  }

  @override
  set image8(File? value) {
    _$image8Atom.reportWrite(value, super.image8, () {
      super.image8 = value;
    });
  }

  late final _$image9Atom =
      Atom(name: '_RequestDetailStoreBase.image9', context: context);

  @override
  File? get image9 {
    _$image9Atom.reportRead();
    return super.image9;
  }

  @override
  set image9(File? value) {
    _$image9Atom.reportWrite(value, super.image9, () {
      super.image9 = value;
    });
  }

  late final _$image10Atom =
      Atom(name: '_RequestDetailStoreBase.image10', context: context);

  @override
  File? get image10 {
    _$image10Atom.reportRead();
    return super.image10;
  }

  @override
  set image10(File? value) {
    _$image10Atom.reportWrite(value, super.image10, () {
      super.image10 = value;
    });
  }

  late final _$responseDateUpdatingAtom = Atom(
      name: '_RequestDetailStoreBase.responseDateUpdating', context: context);

  @override
  bool get responseDateUpdating {
    _$responseDateUpdatingAtom.reportRead();
    return super.responseDateUpdating;
  }

  @override
  set responseDateUpdating(bool value) {
    _$responseDateUpdatingAtom.reportWrite(value, super.responseDateUpdating,
        () {
      super.responseDateUpdating = value;
    });
  }

  late final _$loadImageAsyncAction =
      AsyncAction('_RequestDetailStoreBase.loadImage', context: context);

  @override
  Future<void> loadImage({required File image, required String requestId}) {
    return _$loadImageAsyncAction
        .run(() => super.loadImage(image: image, requestId: requestId));
  }

  late final _$sendPushToTokenAsyncAction =
      AsyncAction('_RequestDetailStoreBase.sendPushToToken', context: context);

  @override
  Future<void> sendPushToToken(
      {required String title, required String message, required String token}) {
    return _$sendPushToTokenAsyncAction.run(() =>
        super.sendPushToToken(title: title, message: message, token: token));
  }

  late final _$_RequestDetailStoreBaseActionController =
      ActionController(name: '_RequestDetailStoreBase', context: context);

  @override
  Future<void> loadOwner({required String ownerId}) {
    final _$actionInfo = _$_RequestDetailStoreBaseActionController.startAction(
        name: '_RequestDetailStoreBase.loadOwner');
    try {
      return super.loadOwner(ownerId: ownerId);
    } finally {
      _$_RequestDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadStaff({required String staffId}) {
    final _$actionInfo = _$_RequestDetailStoreBaseActionController.startAction(
        name: '_RequestDetailStoreBase.loadStaff');
    try {
      return super.loadStaff(staffId: staffId);
    } finally {
      _$_RequestDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadImageList({required String userRequestId}) {
    final _$actionInfo = _$_RequestDetailStoreBaseActionController.startAction(
        name: '_RequestDetailStoreBase.loadImageList');
    try {
      return super.loadImageList(userRequestId: userRequestId);
    } finally {
      _$_RequestDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
owner: ${owner},
staff: ${staff},
imageList: ${imageList},
imageUploading: ${imageUploading},
image1: ${image1},
image2: ${image2},
image3: ${image3},
image4: ${image4},
image5: ${image5},
image6: ${image6},
image7: ${image7},
image8: ${image8},
image9: ${image9},
image10: ${image10},
responseDateUpdating: ${responseDateUpdating}
    ''';
  }
}
