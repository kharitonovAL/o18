import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/partners_tab/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class PartnerEditor extends StatefulWidget {
  final Partner? partner;
  final bool isNewPartner;

  const PartnerEditor({
    this.partner,
    this.isNewPartner = false,
  });

  @override
  State<PartnerEditor> createState() => _PartnerEditorState();
}

class _PartnerEditorState extends State<PartnerEditor> {
  final _titleController = TextEditingController();
  final _activityController = TextEditingController();
  final _indexController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _officeNumberController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _managerPositionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );
  final _faxController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );
  final _bankTitleController = TextEditingController();
  final _bicController = TextEditingController();
  final _accountController = TextEditingController();
  final _corrAccountController = TextEditingController();

  // This controllers need for messages and council members lists
  // because otherwise they will use primary ScrollController
  final _staffScrollController = ScrollController();

  @override
  void initState() {
    if (!widget.isNewPartner) {
      _titleController.text = widget.partner!.title!;
      _activityController.text = widget.partner!.fieldOfActivity ?? '';
      _indexController.text = widget.partner!.postIndex.toString();
      _cityController.text = widget.partner!.city ?? '';
      _streetController.text = widget.partner!.street ?? '';
      _houseNumberController.text = widget.partner!.houseNumber ?? '';
      _officeNumberController.text = widget.partner!.officeNumber ?? '';
      _managerNameController.text = widget.partner!.managerName ?? '';
      _managerPositionController.text = widget.partner!.managerPosition ?? '';
      _phoneController.text = widget.partner!.phoneNumber.toString();
      _faxController.text = widget.partner!.fax.toString();
      _bankTitleController.text = widget.partner!.bankTitle ?? '';
      _bicController.text = widget.partner!.bankBic ?? '';
      _accountController.text = widget.partner!.bankAccount ?? '';
      _corrAccountController.text = widget.partner!.bankCorrespondingAccount ?? '';
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            PartnerString.partnerEditor,
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
        body: SingleChildScrollView(
          child: SizedBox(
            height: 2024.h,
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
                        PartnerString.info,
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
                            height: 1700.h,
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
                                    PartnerString.data,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _titleController,
                                        title: PartnerString.titleLong,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _activityController,
                                        title: PartnerString.activity,
                                        labelText: PartnerString.enterData,
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
                                    top: 44.h,
                                    left: 50.w,
                                  ),
                                  child: Text(
                                    PartnerString.address,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _indexController,
                                        title: PartnerString.index,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _cityController,
                                        title: PartnerString.city,
                                        labelText: PartnerString.enterData,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 50.w,
                                    top: 28.h,
                                    right: 50.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _streetController,
                                        title: PartnerString.street,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _houseNumberController,
                                        title: PartnerString.houseNumber,
                                        labelText: PartnerString.enterData,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 50.w,
                                    top: 28.h,
                                    right: 50.w,
                                  ),
                                  child: AppTextfield(
                                    controller: _officeNumberController,
                                    title: PartnerString.office,
                                    labelText: PartnerString.enterData,
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
                                    PartnerString.contacts,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _managerNameController,
                                        title: PartnerString.managerName,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _managerPositionController,
                                        title: PartnerString.managerPosition,
                                        labelText: PartnerString.enterData,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 50.w,
                                    top: 28.h,
                                    right: 50.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _phoneController,
                                        title: PartnerString.phone,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _emailController,
                                        title: PartnerString.email,
                                        labelText: PartnerString.enterData,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 50.w,
                                    top: 28.h,
                                    right: 50.w,
                                  ),
                                  child: AppTextfield(
                                    controller: _faxController,
                                    title: PartnerString.fax,
                                    labelText: PartnerString.enterData,
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
                                    PartnerString.requisites,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _bankTitleController,
                                        title: PartnerString.bankTitle,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _bicController,
                                        title: PartnerString.bankBic,
                                        labelText: PartnerString.enterData,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 50.w,
                                    top: 28.h,
                                    right: 50.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextfield(
                                        controller: _accountController,
                                        title: PartnerString.accountNumber,
                                        labelText: PartnerString.enterData,
                                      ),
                                      AppTextfield(
                                        controller: _corrAccountController,
                                        title: PartnerString.correspondingAccountNumber,
                                        labelText: PartnerString.enterData,
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
                                          title: widget.isNewPartner ? PartnerString.addPartner : PartnerString.save,
                                          onPressed: () async {
                                            if (!widget.isNewPartner) {
                                              await context.read<PartnersTabCubit>().saveChanges(
                                                    partner: widget.partner,
                                                    title: _titleController.text,
                                                    activity: _activityController.text,
                                                    index: int.tryParse(_indexController.text),
                                                    city: _cityController.text,
                                                    street: _streetController.text,
                                                    houseNumber: _houseNumberController.text,
                                                    officeNumber: _officeNumberController.text,
                                                    managerName: _managerNameController.text,
                                                    managerPosition: _managerPositionController.text,
                                                    email: _emailController.text,
                                                    phone: int.tryParse(_phoneController.text.cleanNumber),
                                                    fax: int.tryParse(_faxController.text.cleanNumber),
                                                    bankTitle: _bankTitleController.text,
                                                    bankBic: _bicController.text,
                                                    bankAccount: _accountController.text,
                                                    bankCorrAccount: _corrAccountController.text,
                                                  );
                                              Navigator.of(context).pop();
                                            } else {
                                              if (_titleController.text.isNotEmpty) {
                                                await context.read<PartnersTabCubit>().addPartner(
                                                      title: _titleController.text,
                                                      activity: _activityController.text,
                                                      index: int.tryParse(_indexController.text),
                                                      city: _cityController.text,
                                                      street: _streetController.text,
                                                      houseNumber: _houseNumberController.text,
                                                      officeNumber: _officeNumberController.text,
                                                      managerName: _managerNameController.text,
                                                      managerPosition: _managerPositionController.text,
                                                      email: _emailController.text,
                                                      phone: int.tryParse(_phoneController.text.cleanNumber),
                                                      fax: int.tryParse(_faxController.text.cleanNumber),
                                                      bankTitle: _bankTitleController.text,
                                                      bankBic: _bicController.text,
                                                      bankAccount: _accountController.text,
                                                      bankCorrAccount: _corrAccountController.text,
                                                    );
                                                Navigator.of(context).pop();
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      ErrorText.partnerRequiredFields,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Visibility(
                                        visible: !widget.isNewPartner,
                                        child: SizedBox(
                                          width: 270.w,
                                          height: 57.h,
                                          child: OutlinedButton(
                                            onPressed: () async {
                                              final deleteConfirmed = await showDialog<bool>(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(26.r),
                                                  ),
                                                  title: const Text(
                                                    PartnerString.attention,
                                                  ),
                                                  content: const Text(
                                                    PartnerString.deleteConfirm,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(false),
                                                      child: const Text(
                                                        PartnerString.cancel,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: AppColors.red,
                                                      ),
                                                      onPressed: () => Navigator.of(context).pop(true),
                                                      child: const Text(
                                                        PartnerString.deletePartner,
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
                                                    .read<PartnersTabCubit>()
                                                    .deletePartner(partner: widget.partner);
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
                                              PartnerString.deletePartner,
                                              style: TextStyle(
                                                color: AppColors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Visibility(
                            visible: !widget.isNewPartner,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 580.w,
                                  height: 700.h,
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
                                          PartnerString.staff,
                                          style: AppFonts.heading_4,
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      SizedBox(
                                        height: 500.h,
                                        child: BlocBuilder<StaffCubit, StaffState>(
                                          builder: (context, state) {
                                            if (state is StaffLoading) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            } else if (state is StaffLoaded) {
                                              if (state.list.isEmpty) {
                                                return const Center(
                                                  child: Text(
                                                    PartnerString.notStaffYet,
                                                  ),
                                                );
                                              } else {
                                                return Scrollbar(
                                                  controller: _staffScrollController,
                                                  child: ListView.builder(
                                                    controller: _staffScrollController,
                                                    itemCount: state.list.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) => StaffListItem(
                                                      partner: widget.partner,
                                                      staff: state.list[index],
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else if (state is StaffLoadFailed) {
                                              return Center(
                                                child: Text(
                                                  state.error.toString(),
                                                ),
                                              );
                                            } else if (state is StaffAdded) {
                                              context.read<StaffCubit>().loadStaff();
                                            } else if (state is StaffAddFailed) {
                                              return Center(
                                                child: Text(
                                                  state.error.toString(),
                                                ),
                                              );
                                            } else if (state is StaffUpdated) {
                                              context.read<StaffCubit>().loadStaff();
                                            } else if (state is StaffUpdateFailed) {
                                              return Center(
                                                child: Text(
                                                  state.error.toString(),
                                                ),
                                              );
                                            } else if (state is StaffDeleted) {
                                              context.read<StaffCubit>().loadStaff();
                                            } else if (state is StaffDeleteFailed) {
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
                                      AddStaffButton()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
