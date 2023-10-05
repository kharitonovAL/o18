import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';

class HouseDetailView extends StatelessWidget {
  final House house;

  const HouseDetailView({
    required this.house,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            house.addressToString,
            style: AppFonts.editorTitle,
          ),
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                top: 24.h,
                bottom: 24.h,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 28.w,
                color: AppColors.green_0,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            40.w,
            32.h,
            40.w,
            32.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: FlatListView(house: house),
              ),
              SizedBox(width: 40.w),
              const Flexible(
                child: AccountListView(),
              ),
              SizedBox(width: 40.w),
              const Flexible(
                child: OwnerListView(),
              ),
            ],
          ),
        ),
      );
}
