import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/features/requests/store/request_detail_store.dart';
import 'package:o18_client/features/widgets/widgets.dart';
import 'package:o18_client/theme/theme.dart';
import 'package:o18_client/utils/strings/requiest_detail_string.dart';

class AddPhotoView extends StatelessWidget {
  final UserRequest userRequest;
  final RequestDetailStore store;

  AddPhotoView({
    required this.userRequest,
    required this.store,
  });

  final imagePicker = ImagePicker();

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.h,
            shadowColor: AppColors.appBarShadow,
            title: Text(
              RequestDetailString.addPhoto,
              style: AppFonts.heading_3,
            ),
            leading: const BackButton(
              color: AppColors.green_0,
            ),
          ),
          body: Observer(
            builder: (_) => SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20.w,
                      runSpacing: 20.h,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage1(),
                                store.image1 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          onTap: () async => store.image1 == null ? await getImage1() : store.image1 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage2(),
                                store.image2 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image2 == null ? await getImage2() : store.image2 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage3(),
                                store.image3 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image3 == null ? await getImage3() : store.image3 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage4(),
                                store.image4 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image4 == null ? await getImage4() : store.image4 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage5(),
                                store.image5 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image5 == null ? await getImage5() : store.image5 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage6(),
                                store.image6 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image6 == null ? await getImage6() : store.image6 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage7(),
                                store.image7 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image7 == null ? await getImage7() : store.image7 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage8(),
                                store.image8 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image8 == null ? await getImage8() : store.image8 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage9(),
                                store.image9 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image9 == null ? await getImage9() : store.image9 = null,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.greyPhotoBackground,
                            ),
                            width: 98.w,
                            height: 98.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                setImage10(),
                                store.image10 != null
                                    ? const Positioned(
                                        child: Icon(Icons.cancel),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          onTap: () async => store.image10 == null ? await getImage10() : store.image10 = null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: store.imageUploading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 314.w,
                            height: 52.h,
                            child: AppElevatedButton(
                              title: RequestDetailString.savePhoto,
                              onPressed: () async {
                                await _saveImages(
                                  requestId: userRequest.objectId!,
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _saveImages({
    required String requestId,
  }) async {
    store.imageUploading = true;

    if (store.image1 != null) {
      await store.loadImage(
        image: store.image1!,
        requestId: requestId,
      );
    }
    if (store.image2 != null) {
      await store.loadImage(
        image: store.image2!,
        requestId: requestId,
      );
    }
    if (store.image3 != null) {
      await store.loadImage(
        image: store.image3!,
        requestId: requestId,
      );
    }
    if (store.image4 != null) {
      await store.loadImage(
        image: store.image4!,
        requestId: requestId,
      );
    }
    if (store.image5 != null) {
      await store.loadImage(
        image: store.image5!,
        requestId: requestId,
      );
    }
    if (store.image6 != null) {
      await store.loadImage(
        image: store.image6!,
        requestId: requestId,
      );
    }
    if (store.image7 != null) {
      await store.loadImage(
        image: store.image7!,
        requestId: requestId,
      );
    }
    if (store.image8 != null) {
      await store.loadImage(
        image: store.image8!,
        requestId: requestId,
      );
    }
    if (store.image9 != null) {
      await store.loadImage(
        image: store.image9!,
        requestId: requestId,
      );
    }
    if (store.image10 != null) {
      await store.loadImage(
        image: store.image10!,
        requestId: requestId,
      );
    }

    store.imageUploading = false;
  }

  Future<void> getImage1() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image1 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage2() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image2 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage3() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image3 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage4() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image4 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage5() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image5 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage6() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image6 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage7() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image7 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage8() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image8 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage9() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image9 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Future<void> getImage10() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    pickedFile != null ? store.image10 = File(pickedFile.path) : debugPrint('No image selected.');
  }

  Widget setImage1() => store.image1 != null
      ? Image.file(
          File(store.image1!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage2() => store.image2 != null
      ? Image.file(
          File(store.image2!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage3() => store.image3 != null
      ? Image.file(
          File(store.image3!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage4() => store.image4 != null
      ? Image.file(
          File(store.image4!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage5() => store.image5 != null
      ? Image.file(
          File(store.image5!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage6() => store.image6 != null
      ? Image.file(
          File(store.image6!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage7() => store.image7 != null
      ? Image.file(
          File(store.image7!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage8() => store.image8 != null
      ? Image.file(
          File(store.image8!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage9() => store.image9 != null
      ? Image.file(
          File(store.image9!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );

  Widget setImage10() => store.image10 != null
      ? Image.file(
          File(store.image10!.path),
          fit: BoxFit.fill,
        )
      : const Icon(
          Icons.add,
          color: AppColors.green_0,
        );
}
