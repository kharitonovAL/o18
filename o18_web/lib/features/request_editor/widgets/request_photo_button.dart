import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/request_editor/cubit/cubit.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class RequestPhotoButton extends StatefulWidget {
  final String? userRequestId;

  const RequestPhotoButton({
    required this.userRequestId,
  });

  @override
  State<RequestPhotoButton> createState() => _RequestPhotoButtonState();
}

class _RequestPhotoButtonState extends State<RequestPhotoButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 220.h,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () async {
            final list = await context.read<RequestEditorCubit>().getImages(
                  userRequestId: widget.userRequestId!,
                );

            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  '${RequestEditorString.requestPhoto} ${list.isNotEmpty ? '(${list.length})' : ''}',
                  style: AppFonts.heading_4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
                actionsPadding: EdgeInsets.only(
                  bottom: 24.h,
                  right: 24.w,
                ),
                content: SizedBox(
                  width: 800.w,
                  height: 600.h,
                  child: list.isNotEmpty
                      ? Scrollbar(
                          child: GridView.builder(
                            itemCount: list.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 17,
                              mainAxisSpacing: 17,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Container(
                                  width: 167.w,
                                  height: 167.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    color: AppColors.greyPhotoBackground,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.r),
                                    child: Image.network(
                                      list[index].file!.url!,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) =>
                                              progress == null
                                                  ? child
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: progress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? progress
                                                                    .cumulativeBytesLoaded /
                                                                progress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => GestureDetector(
                                  onTap: Navigator.of(context).pop,
                                  child: Image.network(
                                    list[index].file!.url!,
                                    loadingBuilder:
                                        (context, child, progress) =>
                                            progress == null
                                                ? child
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? progress
                                                                  .cumulativeBytesLoaded /
                                                              progress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            RequestEditorString.noPhotoForRequest,
                          ),
                        ),
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text(RequestEditorString.ok),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.image_outlined,
                size: 24.w,
                color: AppColors.green_0,
              ),
              SizedBox(width: 13.w),
              Text(
                RequestEditorString.requestPhoto,
                style: AppFonts.requestEditorButton_0,
              ),
            ],
          ),
        ),
      );
}
