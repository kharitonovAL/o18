import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';

class RequestPhotoButton extends StatefulWidget {
  final List<ImageFile> imageList;

  const RequestPhotoButton({
    required this.imageList,
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
        width: 374.h,
        height: 44.h,
        child: OutlinedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  '${RequestDetailString.requestPhoto} ${widget.imageList.isNotEmpty ? '(${widget.imageList.length})' : ''}',
                  style: AppFonts.heading_4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                actionsPadding: EdgeInsets.only(
                  bottom: 24.h,
                  right: 24.w,
                ),
                contentPadding: EdgeInsets.fromLTRB(
                  20.w,
                  20.h,
                  20.w,
                  0.h,
                ),
                content: SizedBox(
                  width: 300.w,
                  height: 300.h,
                  child: widget.imageList.isNotEmpty
                      ? Scrollbar(
                          child: GridView.builder(
                            itemCount: widget.imageList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 11.w,
                              mainAxisSpacing: 11.h,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  color: AppColors.greyPhotoBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14.r),
                                  child: Image.network(
                                    widget.imageList[index].file!.url!.toString(),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) => progress == null
                                        ? child
                                        : Center(
                                            child: CircularProgressIndicator(
                                              value: progress.expectedTotalBytes != null
                                                  ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                                  : null,
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
                                    widget.imageList[index].file!.url!.toString(),
                                    loadingBuilder: (context, child, progress) => progress == null
                                        ? child
                                        : Center(
                                            child: CircularProgressIndicator(
                                              value: progress.expectedTotalBytes != null
                                                  ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
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
                            RequestDetailString.noPhotoForRequest,
                          ),
                        ),
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text(RequestDetailString.ok),
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
          child: Text(
            RequestDetailString.requestPhoto,
            style: AppFonts.requestEditorButton,
          ),
        ),
      );
}
