import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/house_editor/cubit/cubit.dart';
import 'package:o18_web/features/house_editor/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class HouseCardForm extends StatefulWidget {
  final House house;

  const HouseCardForm({
    required this.house,
  });

  @override
  State<HouseCardForm> createState() => _HouseCardFormState();
}

class _HouseCardFormState extends State<HouseCardForm> {
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _yearController = TextEditingController();
  final _flatAmountController = TextEditingController();
  final _floorAmountController = TextEditingController();
  final _entranceAmountController = TextEditingController();
  final _powerSwitchEntranceController = TextEditingController();
  final _basementEntrnceController = TextEditingController();

  String? _selectedHouseType;
  String? _selectedRoofType;
  String? _selectedRoofMaterial;
  String? _selectedPowerSupplyType;
  String? _selectedGasSupplyType;
  String? _selectedHeatSupplyType;
  bool? _hasBasement;
  bool? _hasFireFightingSupply;

  final dateWithTime = DateFormat('dd.MM.yy HH:mm');

  // This controllers need for messages and council members lists
  // because otherwise they will use primary ScrollController
  final _messagesScrollController = ScrollController();
  final _councilScrollController = ScrollController();

  @override
  void initState() {
    _cityController.text = widget.house.city ?? '';
    _streetController.text = widget.house.street ?? '';
    _houseNumberController.text = widget.house.houseNumber ?? '';
    _yearController.text = widget.house.yearOfConstruction.toString();
    _flatAmountController.text = widget.house.flatsCount.toString();
    _floorAmountController.text = widget.house.floorsCount.toString();
    _entranceAmountController.text = widget.house.entranceCount.toString();
    _powerSwitchEntranceController.text =
        widget.house.entranceWithPowerSwitch.toString();
    _basementEntrnceController.text =
        widget.house.entranceToBasement.toString();
    _selectedHouseType = widget.house.houseType;
    _selectedRoofType = widget.house.roofType;
    _selectedRoofMaterial = widget.house.roofMaterial;
    _selectedPowerSupplyType = widget.house.powerSupply;
    _selectedGasSupplyType = widget.house.gasSupply;
    _selectedHeatSupplyType = widget.house.heatSupply;
    _hasBasement = widget.house.hasBasement;
    _hasFireFightingSupply = widget.house.hasFireFightingSupply;

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SingleChildScrollView(
        child: SizedBox(
          height: 1700.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 170.w,
                      top: 55.h,
                    ),
                    child: Text(
                      HouseString.houseInfo,
                      style: AppFonts.houseInfo,
                    ),
                  ),
                  SizedBox(height: 26.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 170.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 1000.w,
                          height: 1480.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(26.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 39.h,
                                  left: 50.w,
                                ),
                                child: Text(
                                  HouseString.address,
                                  style: AppFonts.houseCardSection,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 28.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextfield(
                                      controller: _cityController,
                                      title: HouseString.city,
                                      labelText: HouseString.enterCity,
                                    ),
                                    AppTextfield(
                                      controller: _streetController,
                                      title: HouseString.street,
                                      labelText: HouseString.enterStreet,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextfield(
                                      controller: _houseNumberController,
                                      title: HouseString.houseNumber,
                                      labelText: HouseString.enterHouseNumber,
                                    ),
                                    AppTextfield(
                                      controller: _yearController,
                                      title: HouseString.year,
                                      labelText: HouseString.enterYear,
                                      digitsOnly: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 44.h),
                              Divider(
                                thickness: 2.h,
                                color: AppColors.grey_3,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 34.h,
                                  left: 50.w,
                                ),
                                child: Text(
                                  HouseString.houseInfo,
                                  style: AppFonts.houseCardSection,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 28.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextfield(
                                      controller: _entranceAmountController,
                                      title: HouseString.entranceAmount,
                                      labelText:
                                          HouseString.enterEntranceAmount,
                                      digitsOnly: true,
                                    ),
                                    AppTextfield(
                                      controller: _flatAmountController,
                                      title: HouseString.houseFlatAmount,
                                      labelText:
                                          HouseString.houseEnterFlatAmount,
                                      digitsOnly: true,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextfield(
                                      controller: _floorAmountController,
                                      title: HouseString.houseFloorAmount,
                                      labelText:
                                          HouseString.houseEnterFloorAmount,
                                      digitsOnly: true,
                                    ),
                                    AppTextfield(
                                      controller:
                                          _powerSwitchEntranceController,
                                      title:
                                          HouseString.entranceWithPowerSwitch,
                                      labelText: HouseString
                                          .enterEntranceWithPowerSwitch,
                                      digitsOnly: true,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                ),
                                child: AppTextfield(
                                  controller: _basementEntrnceController,
                                  title: HouseString.entranceToBasement,
                                  labelText:
                                      HouseString.enterEntranceToBasement,
                                  digitsOnly: true,
                                ),
                              ),
                              SizedBox(height: 44.h),
                              Divider(
                                thickness: 2.h,
                                color: AppColors.grey_3,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 44.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppDropdown(
                                      title: HouseString.houseType,
                                      list: HouseType.list,
                                      value: _selectedHouseType,
                                      onChanged: (val) =>
                                          _selectedHouseType = val,
                                    ),
                                    SizedBox(width: 36.h),
                                    AppDropdown(
                                      title: HouseString.roofType,
                                      list: RoofType.list,
                                      value: _selectedRoofType,
                                      onChanged: (val) =>
                                          _selectedRoofType = val,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  children: [
                                    AppDropdown(
                                      title: HouseString.roofMaterialType,
                                      list: RoofMaterial.list,
                                      value: _selectedRoofMaterial,
                                      onChanged: (val) =>
                                          _selectedRoofMaterial = val,
                                    ),
                                    SizedBox(width: 36.h),
                                    AppDropdown(
                                      title: HouseString.powerType,
                                      list: PowerSupply.list,
                                      value: _selectedPowerSupplyType,
                                      onChanged: (val) =>
                                          _selectedPowerSupplyType = val,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  children: [
                                    AppDropdown(
                                      title: HouseString.gasType,
                                      list: GasSupply.list,
                                      value: _selectedGasSupplyType,
                                      onChanged: (val) =>
                                          _selectedGasSupplyType = val,
                                    ),
                                    SizedBox(width: 36.h),
                                    AppDropdown(
                                      title: HouseString.heatType,
                                      list: HeatSupply.list,
                                      value: _selectedHeatSupplyType,
                                      onChanged: (val) =>
                                          _selectedHeatSupplyType = val,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 24.h,
                                  right: 50.w,
                                ),
                                child: Row(
                                  children: [
                                    AppDropdown(
                                      title: HouseString.hasBasement,
                                      list: Basement.list,
                                      value: _hasBasement == null
                                          ? Basement.notExist
                                          : _hasBasement!
                                              ? Basement.exist
                                              : Basement.notExist,
                                      onChanged: (val) => val == Basement.exist
                                          ? _hasBasement = true
                                          : _hasBasement = false,
                                    ),
                                    SizedBox(width: 36.h),
                                    AppDropdown(
                                      title: HouseString.hasFireSystem,
                                      list: FireFightingSupply.list,
                                      value: _hasFireFightingSupply == null
                                          ? FireFightingSupply.notExist
                                          : _hasFireFightingSupply!
                                              ? FireFightingSupply.exist
                                              : FireFightingSupply.notExist,
                                      onChanged: (val) =>
                                          val == FireFightingSupply.exist
                                              ? _hasFireFightingSupply = true
                                              : _hasFireFightingSupply = false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50.w,
                                  top: 56.h,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 270.w,
                                      height: 57.h,
                                      child: AppElevatedButton(
                                        title: HouseString.saveChanges,
                                        onPressed: () async {
                                          await context
                                              .read<HouseCardCubit>()
                                              .saveChanges(
                                                house: widget.house,
                                                city: _cityController.text,
                                                street: _streetController.text,
                                                houseNumber:
                                                    _houseNumberController.text,
                                                year: int.parse(
                                                    _yearController.text),
                                                flatAmount: int.parse(
                                                    _flatAmountController.text),
                                                floorAmount: int.parse(
                                                    _floorAmountController
                                                        .text),
                                                entranceAmount: int.parse(
                                                    _entranceAmountController
                                                        .text),
                                                powerSwitchEntrance: int.parse(
                                                    _powerSwitchEntranceController
                                                        .text),
                                                basementEntrance: int.parse(
                                                    _basementEntrnceController
                                                        .text),
                                                houseType: _selectedHouseType,
                                                roofType: _selectedRoofType,
                                                roofMaterialType:
                                                    _selectedRoofMaterial,
                                                powerSupply:
                                                    _selectedPowerSupplyType,
                                                gasSupply:
                                                    _selectedGasSupplyType,
                                                heatSupply:
                                                    _selectedHeatSupplyType,
                                                hasBasement: _hasBasement,
                                                hasFireFightingSupply:
                                                    _hasFireFightingSupply,
                                              );

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    SizedBox(
                                      width: 200.w,
                                      height: 57.h,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          final deleteConfirmed =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                              title: const Text(
                                                HouseString.attention,
                                              ),
                                              content: const Text(
                                                HouseString.houseDeleteConfirm,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text(
                                                    HouseString.cancel,
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        AppColors.red,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: const Text(
                                                    HouseString.deleteHouse,
                                                    style: TextStyle(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (deleteConfirmed ?? false) {
                                            await context
                                                .read<HouseCardCubit>()
                                                .deleteHouse(
                                                  house: widget.house,
                                                );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.red,
                                          side: const BorderSide(
                                            color: AppColors.red,
                                          ),
                                        ),
                                        child: const Text(
                                          HouseString.delete,
                                          style: TextStyle(
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ], // end of white spece with text fields
                          ),
                        ),
                        SizedBox(width: 24.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 580.w,
                              height: 340.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 40.w,
                                      top: 30.h,
                                    ),
                                    child: Text(
                                      HouseString.messages,
                                      style: AppFonts.heading_4,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    height: 220.h,
                                    child: BlocBuilder<HouseMessagesCubit,
                                        HouseMessagesState>(
                                      builder: (context, state) {
                                        if (state is HouseMessagesLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is HouseMessagesLoaded) {
                                          if (state.list.isEmpty) {
                                            return const Center(
                                              child: Text(
                                                HouseString.noMessages,
                                              ),
                                            );
                                          } else {
                                            return Scrollbar(
                                              controller:
                                                  _messagesScrollController,
                                              child: ListView.builder(
                                                controller:
                                                    _messagesScrollController,
                                                itemCount: state.list.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    HouseMessageListItem(
                                                  message: state.list[index],
                                                ),
                                              ),
                                            );
                                          }
                                        } else if (state
                                            is HouseMessagesLoadFailed) {
                                          return Center(
                                            child: Text(
                                              state.error.toString(),
                                            ),
                                          );
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              width: 580.w,
                              height: 500.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 40.w,
                                      top: 30.h,
                                    ),
                                    child: Text(
                                      HouseString.council,
                                      style: AppFonts.heading_4,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    height: 300.h,
                                    child: BlocBuilder<HouseCouncilCubit,
                                        HouseCouncilState>(
                                      builder: (context, state) {
                                        if (state is HouseCouncilLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is HouseCouncilLoaded) {
                                          if (state.list.isEmpty) {
                                            return const Center(
                                              child: Text(
                                                HouseString.noCouncil,
                                              ),
                                            );
                                          } else {
                                            return Scrollbar(
                                              controller:
                                                  _councilScrollController,
                                              child: ListView.builder(
                                                controller:
                                                    _councilScrollController,
                                                itemCount: state.list.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    CouncilListItem(
                                                  memberList: state.list,
                                                  member: state.list[index],
                                                  house: widget.house,
                                                  currentIndex: index,
                                                ),
                                              ),
                                            );
                                          }
                                        } else if (state
                                            is HouseCouncilLoadFailed) {
                                          return Center(
                                            child: Text(
                                              state.error.toString(),
                                            ),
                                          );
                                        } else if (state is HouseCouncilAdded) {
                                          context
                                              .read<HouseCouncilCubit>()
                                              .loadHouseCouncil();
                                        } else if (state
                                            is HouseCouncilAddFailed) {
                                          return Center(
                                            child: Text(
                                              state.error.toString(),
                                            ),
                                          );
                                        } else if (state
                                            is HouseCouncilUpdated) {
                                          context
                                              .read<HouseCouncilCubit>()
                                              .loadHouseCouncil();
                                        } else if (state
                                            is HouseCouncilUpdateFailed) {
                                          return Center(
                                            child: Text(
                                              state.error.toString(),
                                            ),
                                          );
                                        } else if (state
                                            is HouseCouncilDeleted) {
                                          context
                                              .read<HouseCouncilCubit>()
                                              .loadHouseCouncil();
                                        } else if (state
                                            is HouseCouncilDeleteFailed) {
                                          return Center(
                                            child: Text(
                                              state.error.toString(),
                                            ),
                                          );
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  AddCouncilMemberButton()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
