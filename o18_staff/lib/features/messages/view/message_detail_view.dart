import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/features/messages/store/messages_store.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:provider/provider.dart';

class MessageDetailView extends StatefulWidget {
  final StaffMessage message;

  const MessageDetailView({
    required this.message,
  });

  @override
  State<MessageDetailView> createState() => _MessageDetailViewState();
}

class _MessageDetailViewState extends State<MessageDetailView> {
  @override
  void initState() {
    if (widget.message.wasSeenDate == null) {
      final store = context.read<MessagesStore>();
      store.updateMessageDate(
        message: widget.message,
      );
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.h,
            shadowColor: AppColors.appBarShadow,
            leading: const BackButton(
              color: AppColors.green_0,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Container(
              width: 374.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(22.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.message.title!,
                          style: AppFonts.commonTextBold,
                        ),
                        Text(widget.message.body!),
                      ],
                    ),
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.r),
                        color: AppColors.grey_3,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.mail_outline,
                          color: AppColors.green_0,
                          size: 26.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
