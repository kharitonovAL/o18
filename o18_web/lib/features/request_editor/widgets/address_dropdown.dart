// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';

import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AddressDropDown extends StatelessWidget {
  final List<House> houseList;
  final Address? selectedAddress;
  final Function(Address?) onAddressSelected;
  final bool enabled;
  String? Function(String?)? validator;

  AddressDropDown({
    required this.houseList,
    required this.onAddressSelected,
    this.selectedAddress,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final addressList = houseList
        .map((e) => Address(
              street: e.street!,
              houseNumber: e.houseNumber!,
            ))
        .toList();

    addressList.sort(
      (a, b) => a.addressToString.compareTo(b.addressToString),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          RequestEditorString.requiredRequestAddress,
          style: AppFonts.commonText,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 430.w,
          height: 56.h,
          child: DropdownSearch<String>(
            enabled: enabled,
            validator: validator,
            selectedItem: selectedAddress?.addressToString,
            onChanged: (selectedAddress) {
              final address = addressList.firstWhere(
                (e) => e.addressToString == selectedAddress,
              );
              onAddressSelected(address);
            },
            items: addressList.map((e) => e.addressToString).toList(),
            dropdownButtonProps: DropdownButtonProps(
              icon: enabled
                  ? Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.w,
                      color: AppColors.green_0,
                    )
                  : const SizedBox(),
              iconSize: 20.h,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: RequestEditorString.selectFromList,
                errorStyle: const TextStyle(fontSize: 0.01),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
              ),
              baseStyle: AppFonts.dropDownGrey,
            ),
            dropdownBuilder: (context, address) => address == null
                ? Text(
                    RequestEditorString.selectFromList,
                    style: AppFonts.dropDownGrey,
                  )
                : Text(
                    address,
                    style: enabled
                        ? AppFonts.dropDownBlack
                        : AppFonts.dropDownGrey,
                  ),
            popupProps: PopupProps.dialog(
              dialogProps: DialogProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                style: AppFonts.dropDownBlack,
                decoration: InputDecoration(
                  hintText: RequestEditorString.search,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              constraints: BoxConstraints(
                minWidth: 700.w,
                maxWidth: 700.w,
                maxHeight: 700.h,
              ),
              emptyBuilder: (context, _) => Center(
                child: Text(
                  RequestEditorString.nothingFound,
                  style: AppFonts.dropDownBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
