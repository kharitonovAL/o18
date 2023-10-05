import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/request_editor/cubit/cubit.dart';
import 'package:o18_web/features/request_editor/widgets/request_editor_form.dart';
import 'package:o18_web/features/requests_tab/cubit/requests_tab_cubit/requests_tab_cubit.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class RequestEditorPage extends StatelessWidget {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;

  const RequestEditorPage({
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: requestSelection == RequestSelection.newReques
              ? Text(
                  RequestEditorString.newRequestTitle,
                  style: AppFonts.requestTitle,
                )
              : Text(
                  RequestEditorString.editingRequest,
                  style: AppFonts.requestTitle,
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AccountDropdownCubit(
                requestSelection: requestSelection,
                userRequest: userRequest,
              ),
            ),
            BlocProvider(
              create: (context) => AddressDropdownCubit(),
            ),
            BlocProvider(
              create: (context) => PartnerDropdownCubit(),
            ),
            BlocProvider(
              create: (context) => MasterDropdownCubit(
                requestSelection: requestSelection,
                userRequest: userRequest,
              ),
            ),
            BlocProvider(
              create: (context) => StaffDropdownCubit(
                requestSelection: requestSelection,
                userRequest: userRequest,
              ),
            ),
            BlocProvider(
              create: (context) => OwnerDropdownCubit(
                requestSelection: requestSelection,
                userRequest: userRequest,
              ),
            ),
          ],
          child: BlocBuilder<RequestEditorCubit, RequestEditorState>(
            builder: (context, state) {
              if (state is RequestDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CreateNewRequest) {
                return RequestEditorForm(
                  operatorName: state.operatorName,
                  requestSelection: requestSelection,
                  requestNumber: state.requestNumber,
                  requestList: state.requestList,
                );
              } else if (state is RequestDataLoaded) {
                return RequestEditorForm(
                  operatorName: state.operatorName,
                  requestSelection: requestSelection,
                  requestNumber: state.userRequest.requestNumber!,
                  requestList: state.requestList,
                  userRequest: state.userRequest,
                  account: state.account,
                  address: state.address,
                  master: state.master,
                  owner: state.owner,
                  partner: state.partner,
                  staff: state.staff,
                );
              } else if (state is RequestDataLoadFailed) {
                return Center(
                  child: Text(
                    state.error.toString(),
                  ),
                );
              } else if (state is RequestOperationSuccess) {
                context.read<RequestsTabCubit>().loadUserRequestList();
              } else if (state is RequestOperationFailed) {
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
      );
}
