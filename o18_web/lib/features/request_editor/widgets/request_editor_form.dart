import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/request_editor/cubit/cubit.dart';
import 'package:o18_web/features/request_editor/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class RequestEditorForm extends StatefulWidget {
  final UserRequest? userRequest;
  final String operatorName;
  final RequestSelection requestSelection;
  final int requestNumber;
  final List<UserRequest> requestList;
  final Address? address;
  final Account? account;
  final Owner? owner;
  final Partner? partner;
  final Staff? master;
  final Staff? staff;

  const RequestEditorForm({
    required this.operatorName,
    required this.requestNumber,
    required this.requestList,
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
    this.account,
    this.address,
    this.master,
    this.owner,
    this.partner,
    this.staff,
  });

  @override
  State<RequestEditorForm> createState() => _RequestEditorFormState();
}

class _RequestEditorFormState extends State<RequestEditorForm> {
  final _requestController = TextEditingController();
  final _flatNumberController = TextEditingController();
  final _noteController = TextEditingController();
  final _responseController = TextEditingController();
  final _cancelReasonController = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );

  String? _selectedJobType;
  String? _selectedRequestType;
  Address? _selectedAddress;
  Account? _selectedAccount;
  Owner? _selectedOwner;
  Partner? _selectedPartner;
  Staff? _selectedMaster;
  Staff? _selectedStaff;
  DateTime? _responseDate;

  /// controls is dropdowns and textFields are enabled
  /// or not
  bool _enabled = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.requestSelection == RequestSelection.existedRequest) {
      _requestController.text = widget.userRequest!.userRequest!;
      _flatNumberController.text = widget.userRequest!.flatNumber!;
      _noteController.text = widget.userRequest!.requestNote ?? '';
      _responseController.text = widget.userRequest!.response ?? '';
      _cancelReasonController.text = widget.userRequest!.cancelReason ?? '';
      _phoneController.text = widget.userRequest!.phoneNumber!;
      _selectedJobType = widget.userRequest!.jobType;
      _selectedRequestType = widget.userRequest!.requestType;
      _responseDate = widget.userRequest!.responseDate;
      _selectedAddress = widget.address;
      _selectedAccount = widget.account;
      _selectedOwner = widget.owner;
      _selectedPartner = widget.partner;
      _selectedMaster = widget.master;
      _selectedStaff = widget.staff;

      // ignore: avoid_bool_literals_in_conditional_expressions
      _enabled = widget.userRequest!.status == RS.canceled || widget.userRequest!.status == RS.closed ? false : true;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                        left: 238.w,
                        top: 55.h,
                      ),

                      /// Row for request number, requets history button
                      /// and request photos button
                      child: Row(
                        children: [
                          Text(
                            '${RequestEditorString.requestNumber} '
                            '${widget.requestNumber}',
                            style: AppFonts.requestNumber,
                          ),
                          SizedBox(width: 210.w),
                          Visibility(
                            visible: widget.requestSelection == RequestSelection.existedRequest,
                            child: RequestShiftHistoryButton(
                              userRequest: widget.userRequest,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Visibility(
                            visible: widget.requestSelection == RequestSelection.existedRequest,
                            child: RequestPhotoButton(
                              userRequestId: widget.userRequest?.objectId,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 26.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 230.w,
                      ),
                      child: Container(
                        width: 1000.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(26.r),
                        ),

                        /// The column that holds all widgets in container
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Row that holds request description and
                            /// request's notes
                            Padding(
                              padding: EdgeInsets.only(
                                left: 50.w,
                                top: 42.h,
                                right: 50.w,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Holds user request's desctiprion
                                  /// and title
                                  AppTextfield(
                                    controller: _requestController,
                                    height: 110,
                                    maxLines: 5,
                                    title: RequestEditorString.requiredRequestDetails,
                                    labelText: RequestEditorString.enterRequest,
                                    enabled: _enabled,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return RequestEditorString.fillField;
                                      }
                                      return null;
                                    },
                                  ),

                                  /// Holds user request's note
                                  /// and title
                                  AppTextfield(
                                    controller: _noteController,
                                    height: 110,
                                    maxLines: 5,
                                    title: RequestEditorString.requestNote,
                                    labelText: RequestEditorString.enterNote,
                                    enabled: _enabled,
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

                              /// Row that holds request type and
                              /// job type
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppDropdown(
                                    title: RequestEditorString.requestType,
                                    list: RequestType.all,
                                    value: _selectedRequestType,
                                    onChanged: (val) => _selectedRequestType = val,
                                    enabled: _enabled,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return RequestEditorString.fillField;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    width: 36.w,
                                  ),
                                  AppDropdown(
                                    title: RequestEditorString.jobType,
                                    list: JobType.all,
                                    value: _selectedJobType,
                                    onChanged: (val) => _selectedJobType = val,
                                    enabled: _enabled,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return RequestEditorString.fillField;
                                      }
                                      return null;
                                    },
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
                                left: 50.w,
                                top: 42.h,
                                right: 50.w,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: BlocBuilder<AddressDropdownCubit, AddressDropdownState>(
                                      builder: (context, state) {
                                        if (state is AddressDataLoading) {
                                          return TextFieldPlug(
                                            title: RequestEditorString.requiredRequestAddress,
                                          );
                                        } else if (state is AddressDataLoaded) {
                                          return AddressDropDown(
                                            houseList: state.houseList,
                                            onAddressSelected: (val) {
                                              context.read<AccountDropdownCubit>().clear();
                                              context.read<OwnerDropdownCubit>().clear();

                                              _selectedAddress = val;
                                              _selectedAccount = null;
                                              _selectedOwner = null;
                                              _flatNumberController.clear();
                                            },
                                            selectedAddress: _selectedAddress,
                                            enabled: _enabled,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return RequestEditorString.fillField;
                                              }
                                              return null;
                                            },
                                          );
                                        } else {
                                          return TextFieldPlug(
                                            title: RequestEditorString.requiredRequestAddress,
                                            label: RequestEditorString.watingForData,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return RequestEditorString.fillField;
                                              }
                                              return null;
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  AppTextfield(
                                    controller: _flatNumberController,
                                    onChanged: (val) {
                                      if (_flatNumberController.text.isEmpty) {
                                        _selectedAccount = null;
                                      }

                                      if (_selectedAddress != null) {
                                        context.read<AccountDropdownCubit>().loadAccountList(
                                              address: _selectedAddress!.addressToString,
                                              flatNumber: val,
                                            );
                                      }
                                    },
                                    labelText: RequestEditorString.enterFlatNumber,
                                    title: RequestEditorString.flatNumber,
                                    enabled: _enabled,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return RequestEditorString.fillField;
                                      }
                                      return null;
                                    },
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
                              child: BlocBuilder<AccountDropdownCubit, AccountDropdownState>(
                                builder: (context, state) {
                                  if (state is AccountDropdownInitial) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.accountNumber,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return RequestEditorString.fillField;
                                        }
                                        return null;
                                      },
                                    );
                                  } else if (state is AccountDataLoading) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.accountNumber,
                                      label: RequestEditorString.loadingData,
                                      width: 900,
                                    );
                                  } else if (state is AccountListLoaded) {
                                    return AccountDropdown(
                                      width: 900,
                                      list: state.accountList,
                                      account: _selectedAccount,
                                      onChanged: (val) async {
                                        _selectedAccount = val;
                                        _selectedOwner = null;
                                        _phoneController.clear();

                                        await context.read<OwnerDropdownCubit>().clear();
                                        await context.read<OwnerDropdownCubit>().loadOwnerData(
                                              accountNumber: _selectedAccount!.accountNumber!,
                                            );
                                      },
                                      enabled: _enabled,
                                      validator: (val) {
                                        if (val == null) {
                                          return RequestEditorString.fillField;
                                        }

                                        return null;
                                      },
                                    );
                                  } else {
                                    // set account to null, otherwise it will be able to save
                                    // user request
                                    _selectedAccount = null;
                                    _selectedOwner = null;
                                    _phoneController.clear();

                                    return TextFieldPlug(
                                      title: RequestEditorString.accountNumber,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return RequestEditorString.fillField;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                },
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
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<OwnerDropdownCubit, OwnerDropdownState>(
                                          builder: (context, state) {
                                            if (state is OwnerDropdownInitial) {
                                              return TextFieldPlug(
                                                title: RequestEditorString.owner,
                                                label: RequestEditorString.noData,
                                                validator: (val) {
                                                  if (val == null || val.isEmpty) {
                                                    return RequestEditorString.fillField;
                                                  }
                                                  return null;
                                                },
                                              );
                                            } else if (state is OwnerDataLoading) {
                                              return TextFieldPlug(
                                                title: RequestEditorString.owner,
                                                label: RequestEditorString.loadingData,
                                              );
                                            } else if (state is OwnerDataLoaded) {
                                              return OwnerDropdown(
                                                owner: _selectedOwner,
                                                list: state.ownerList,
                                                onChanged: (owner) {
                                                  // we need here setSate to update owner,
                                                  // otherwise 'The owner not set' message
                                                  // will appear
                                                  setState(() {
                                                    _selectedOwner = owner;
                                                  });

                                                  if (owner!.phoneNumber != null) {
                                                    _phoneController.text = owner.phoneNumber.toString();
                                                  } else {
                                                    _phoneController.text = '0000000000';
                                                  }
                                                },
                                                enabled: _enabled,
                                                validator: (val) {
                                                  if (val == null) {
                                                    return RequestEditorString.fillField;
                                                  }
                                                  return null;
                                                },
                                              );
                                            } else if (state is OwnerDataError) {
                                              return TextFieldPlug(
                                                title: RequestEditorString.owner,
                                                label: RequestEditorString.noData,
                                              );
                                            }
                                            return TextFieldPlug(
                                              title: RequestEditorString.owner,
                                              label: RequestEditorString.noData,
                                              validator: (val) {
                                                if (val == null || val.isEmpty) {
                                                  return RequestEditorString.fillField;
                                                }
                                                return null;
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(height: 24.h),
                                        ChangeOwnerButton(
                                          owner: _selectedOwner,
                                          buttonTitle: RequestEditorString.changeOwner,
                                          messageTitle: RequestEditorString.changeOwner,
                                          labelText: RequestEditorString.enterOwner,
                                          isNameChanged: (nameChanged) async {
                                            if (nameChanged) {
                                              _selectedOwner = null;
                                              await context.read<OwnerDropdownCubit>().clear();
                                              await context.read<OwnerDropdownCubit>().loadOwnerData(
                                                    accountNumber: _selectedAccount!.accountNumber!,
                                                  );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    RequestEditorString.nameUpdateError,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          enabled: _enabled,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 36.h),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppTextfield(
                                          labelText: RequestEditorString.noData,
                                          title: RequestEditorString.phoneNumber,
                                          controller: _phoneController,
                                          enabled: _enabled,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return RequestEditorString.fillField;
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 24.h),
                                        ChangePhoneButton(
                                          owner: _selectedOwner,
                                          buttonTitle: RequestEditorString.changePhone,
                                          messageTitle: RequestEditorString.changePhone,
                                          labelText: RequestEditorString.enterPhoneNumber,
                                          isPhoneChanged: (phoneChanged) async {
                                            if (phoneChanged) {
                                              _selectedOwner = null;
                                              _phoneController.clear();

                                              await context.read<OwnerDropdownCubit>().clear();
                                              await context.read<OwnerDropdownCubit>().loadOwnerData(
                                                    accountNumber: _selectedAccount!.accountNumber!,
                                                  );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    RequestEditorString.phoneUpdateError,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          enabled: _enabled,
                                        ),
                                      ],
                                    ),
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
                                left: 50.w,
                                top: 24.h,
                                right: 50.w,
                              ),
                              child: BlocBuilder<PartnerDropdownCubit, PartnerDropdownState>(
                                builder: (context, state) {
                                  if (state is PartnerDropdownInitial) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.partner,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  } else if (state is PartnerDataLoading) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.partner,
                                      label: RequestEditorString.loadingData,
                                      width: 900,
                                    );
                                  } else if (state is PartnerDataLoaded) {
                                    return PartnerDropdown(
                                      title: RequestEditorString.partner,
                                      width: 900,
                                      list: state.partnerList,
                                      partner: _selectedPartner,
                                      onChanged: (partner) {
                                        _selectedPartner = partner;
                                        _selectedStaff = null;
                                        context.read<MasterDropdownCubit>().loadMasterData(
                                              partnerId: partner!.objectId!,
                                            );

                                        context.read<StaffDropdownCubit>().loadStaffData(
                                              partnerId: partner.objectId!,
                                            );
                                      },
                                      enabled: _enabled,
                                    );
                                  } else {
                                    return TextFieldPlug(
                                      title: RequestEditorString.partner,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 50.w,
                                top: 24.h,
                                right: 50.w,
                              ),
                              child: BlocBuilder<MasterDropdownCubit, MasterDropdownState>(
                                builder: (context, state) {
                                  if (state is MasterDropdownInitial) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.master,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  } else if (state is MasterDataLoading) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.master,
                                      label: RequestEditorString.loadingData,
                                      width: 900,
                                    );
                                  } else if (state is MasterDataLoaded) {
                                    if (state.masterList.isEmpty) {
                                      return TextFieldPlug(
                                        title: RequestEditorString.master,
                                        label: RequestEditorString.noData,
                                        width: 900,
                                      );
                                    }
                                    return MasterDropdown(
                                      title: RequestEditorString.master,
                                      list: state.masterList
                                        ..retainWhere(
                                          (m) => m.partnerId == _selectedPartner?.objectId,
                                        ),
                                      width: 900,
                                      master: _selectedMaster,
                                      onChanged: (master) => _selectedMaster = master,
                                      enabled: _enabled,
                                    );
                                  } else {
                                    return TextFieldPlug(
                                      title: RequestEditorString.owner,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 50.w,
                                top: 24.h,
                                right: 50.w,
                              ),
                              child: BlocBuilder<StaffDropdownCubit, StaffDropdownState>(
                                builder: (context, state) {
                                  if (state is StaffDropdownInitial) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.staff,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  } else if (state is StaffDataLoading) {
                                    return TextFieldPlug(
                                      title: RequestEditorString.staff,
                                      label: RequestEditorString.loadingData,
                                      width: 900,
                                    );
                                  } else if (state is StaffDataLoaded) {
                                    if (state.staffList.isEmpty) {
                                      return TextFieldPlug(
                                        title: RequestEditorString.staff,
                                        label: RequestEditorString.noData,
                                        width: 900,
                                      );
                                    } else {
                                      return StaffDropdown(
                                        title: RequestEditorString.staff,
                                        list: state.staffList,
                                        staff: _selectedStaff,
                                        width: 900,
                                        onChanged: (staff) => _selectedStaff = staff,
                                        enabled: _enabled,
                                      );
                                    }
                                  } else {
                                    return TextFieldPlug(
                                      title: RequestEditorString.staff,
                                      label: RequestEditorString.noData,
                                      width: 900,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 50.w,
                                top: 46.h,
                              ),
                              child: _enabled
                                  ? SizedBox(
                                      width: 272.w,
                                      height: 57.h,
                                      child: AppElevatedButton(
                                        title: widget.requestSelection == RequestSelection.existedRequest
                                            ? RequestEditorString.saveChanges
                                            : RequestEditorString.createRequest,
                                        onPressed: () async {
                                          if (!_formKey.currentState!.validate()) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 3),
                                                content: Text(
                                                  RequestEditorString.requiredFieldsEmpty,
                                                ),
                                              ),
                                            );
                                          } else {
                                            await context.read<RequestEditorCubit>().saveRequest(
                                                  requestSelection: widget.requestSelection,
                                                  requestNumber: widget.requestNumber,
                                                  requestText: _requestController.text,
                                                  requestType: _selectedRequestType!,
                                                  jobType: _selectedJobType!,
                                                  address: _selectedAddress!,
                                                  responseDate: _responseDate!,
                                                  phoneNumber: _phoneController.text,
                                                  account: _selectedAccount!,
                                                  owner: _selectedOwner!,
                                                  flatNumber: _flatNumberController.text.trim(),
                                                  partner: _selectedPartner,
                                                  masterStaff: _selectedMaster,
                                                  partnerStaff: _selectedStaff,
                                                  requestNote: _noteController.text,
                                                  userRequest: widget.userRequest,
                                                );

                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    )
                                  : widget.userRequest!.status == RS.canceled
                                      ? Text(
                                          '${RequestEditorString.requestIsCancelledByReason} ${widget.userRequest!.cancelReason!}',
                                        )
                                      : widget.userRequest!.status == RS.closed
                                          ? const Text(
                                              RequestEditorString.requestIsClosed,
                                            )
                                          : null,
                            ),
                            SizedBox(height: 34.h),
                            Divider(
                              thickness: 2.h,
                              color: AppColors.grey_3,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 50.w,
                                top: 28.h,
                                right: 50.w,
                              ),
                              child: Wrap(
                                spacing: 16.w,
                                children: [
                                  Visibility(
                                    visible: _enabled && widget.requestSelection == RequestSelection.existedRequest,
                                    child: SubmitToWorkButton(
                                      onPressed: () async {
                                        if (widget.userRequest != null &&
                                            _selectedPartner != null &&
                                            _selectedMaster != null &&
                                            _selectedStaff != null) {
                                          await context.read<RequestEditorCubit>().submitRequestToWork(
                                                userRequest: widget.userRequest!,
                                                partner: _selectedPartner!,
                                                master: _selectedMaster!,
                                                staff: _selectedStaff!,
                                              );
                                          Navigator.of(context).pop();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              duration: Duration(seconds: 3),
                                              content: Text(
                                                RequestEditorString.submitToWorkError,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.requestSelection == RequestSelection.existedRequest,
                                    child: PrintWorkOrderButton(
                                      onPressed: () async {
                                        if (widget.userRequest != null &&
                                            _selectedPartner != null &&
                                            _selectedMaster != null &&
                                            _selectedStaff != null &&
                                            _selectedAccount != null) {
                                          await PrintWorkOrder.printDocument(
                                            request: widget.userRequest!,
                                            partner: _selectedPartner!,
                                            master: _selectedMaster!,
                                            staff: _selectedStaff!,
                                            debt: _selectedAccount!.debt,
                                            operatorName: widget.operatorName,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              duration: Duration(seconds: 3),
                                              content: Text(
                                                RequestEditorString.printWorkOrderError,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.requestSelection == RequestSelection.existedRequest && _enabled,
                                    child: SizedBox(
                                      width: 230.w,
                                      height: 50.h,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          final cancelConfirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              var _isValid = false;

                                              return StatefulBuilder(
                                                builder: (context, setState) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(26.r),
                                                  ),
                                                  title: const Text(
                                                    RequestEditorString.enterCancelReason,
                                                  ),
                                                  content: TextField(
                                                    autofocus: true,
                                                    controller: _cancelReasonController,
                                                    onChanged: (val) {
                                                      if (val != '') {
                                                        setState(() => _isValid = true);
                                                      } else {
                                                        setState(() => _isValid = false);
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: RequestEditorString.cancelReason,
                                                      errorText:
                                                          _isValid ? null : RequestEditorString.enterCancelReason,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _cancelReasonController.clear();
                                                        Navigator.pop(
                                                          context,
                                                          false,
                                                        );
                                                      },
                                                      child: const Text(
                                                        RequestEditorString.cancel,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: _isValid
                                                          ? () {
                                                              _cancelReasonController.clear();
                                                              Navigator.pop(
                                                                context,
                                                                true,
                                                              );
                                                            }
                                                          : null,
                                                      child: const Text(
                                                        RequestEditorString.yes,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          if (cancelConfirmed!) {
                                            await context.read<RequestEditorCubit>().cancelUserRequest(
                                                  userRequest: widget.userRequest!,
                                                  cancelReason: _cancelReasonController.text,
                                                );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          RequestEditorString.cancelRequest,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.requestSelection == RequestSelection.existedRequest && _enabled,
                                    child: SizedBox(
                                      width: 220.w,
                                      height: 50.h,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          final closeConfirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(26.r),
                                              ),
                                              title: const Text(
                                                RequestEditorString.attention,
                                              ),
                                              content: const Text(
                                                RequestEditorString.closeRequestMessage,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                    context,
                                                    false,
                                                  ),
                                                  child: const Text(
                                                    RequestEditorString.cancel,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                    context,
                                                    true,
                                                  ),
                                                  child: const Text(
                                                    RequestEditorString.yes,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (closeConfirmed!) {
                                            await context.read<RequestEditorCubit>().closeUserRequest(
                                                  userRequest: widget.userRequest!,
                                                );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          RequestEditorString.closeRequest,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 46.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24.w),
                Flexible(
                  child: SizedBox(
                    width: 460.w,
                    child: Calendar(
                      responseDate: widget.userRequest?.responseDate,
                      userRequestList: widget.requestList,
                      onDateSelected: (selectedDate) => _responseDate = selectedDate,
                      onCalendarCreated: (date) => _responseDate = date,
                      enabled: _enabled,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
