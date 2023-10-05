import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/features/login/store/login_store.dart';
import 'package:o18_staff/features/requests/store/request_detail_store.dart';
import 'package:o18_staff/features/requests/store/request_store.dart';
import 'package:o18_staff/features/requests/view/view.dart';
import 'package:o18_staff/features/requests/widgets/request_list_item.dart';
import 'package:o18_staff/features/widgets/widgets.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/strings/request_string.dart';
import 'package:provider/provider.dart';

class RequestView extends StatefulWidget {
  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  final _store = RequestStore();
  final _textController = TextEditingController();
  late final Staff? _currentStaff;

  @override
  void initState() {
    _currentStaff = context.read<LoginStore>().currentStaff;

    if (_currentStaff != null) {
      _store.loadUserRequestList(staff: _currentStaff!);
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Observer(
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchField(
                      title: RequestTabString.searchRequest,
                      textController: _textController,
                      onChanged: (query) {
                        _store.searchRequest(query: query);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        switch (_store.currentSorting) {
                          case RequestTabString.sortNewFirst:
                            _store.sortFromOldToNew();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(RequestTabString.sortOldFirst),
                              ),
                            );
                            break;

                          case RequestTabString.sortOldFirst:
                            _store.sortFailureOnly();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(RequestTabString.sortFailureOnly),
                              ),
                            );
                            break;

                          case RequestTabString.sortFailureOnly:
                            _store.sortFromNewToOld();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(RequestTabString.sortNewFirst),
                              ),
                            );
                            break;
                        }
                      },
                      child: Container(
                        height: 46.h,
                        width: 46.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: AppColors.green_0,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: _store.userRequestList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          itemCount: _store.userRequestList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: 11.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child: RequestListItem(
                              request: _store.userRequestList[index],
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Provider<RequestDetailStore>(
                                    create: (_) => RequestDetailStore(),
                                    child: RequestDetailView(
                                      userRequest: _store.userRequestList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
}
