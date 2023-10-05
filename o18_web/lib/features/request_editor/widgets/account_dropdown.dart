// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/request_editor/model/account_text.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AccountDropdown extends StatefulWidget {
  final List<Account> list;
  final Account? account;
  final Function(Account?) onChanged;
  final double width;
  final String? userRequestStatus;
  final bool enabled;
  String? Function(Account?)? validator;

  AccountDropdown({
    required this.list,
    required this.onChanged,
    this.width = 430,
    this.account,
    this.userRequestStatus,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AccountDropdown> createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown> {
  Account? account;

  @override
  void initState() {
    if (widget.account != null) {
      account = widget.account;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            RequestEditorString.accountNumber,
            style: AppFonts.commonText,
          ),
          SizedBox(height: 8.h),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField2(
              validator: widget.validator,
              hint: Text(
                RequestEditorString.selectFromList,
                style: AppFonts.dropDownGrey,
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 28.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                width: widget.width.w,
                height: 56.h,
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 35.h,
                padding: EdgeInsets.only(left: 28.w),
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                errorStyle: const TextStyle(fontSize: 0.01),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: AppColors.grey_3,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: widget.enabled
                    ? Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.w,
                          color: AppColors.green_0,
                        ),
                      )
                    : const SizedBox(),
              ),
              items: widget.list
                  .map(
                    (a) => DropdownMenuItem(
                      value: a,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: AccountText(
                          account: a,
                          enabled: widget.enabled,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: account,
              onChanged: widget.enabled
                  ? (val) {
                      widget.onChanged(val! as Account);
                      setState(() {
                        account = val as Account;
                      });
                    }
                  : null,
            ),
          ),
        ],
      );
}
