import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/partners_tab/view/view.dart';
import 'package:o18_web/features/partners_tab/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class PartnersTabView extends StatelessWidget {
  final TextEditingController textController;

  const PartnersTabView({
    required this.textController,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 40.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      PartnerString.partners,
                      style: AppFonts.heading_0,
                    ),
                    SizedBox(width: 11.w),
                    SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PartnerEditor(
                              isNewPartner: true,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.add_circle_rounded,
                          color: AppColors.green_0,
                          size: 40.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 11.w),
                    RefreshButton(
                      onPressed:
                          context.read<PartnersTabCubit>().loadPartnerList,
                    ),
                  ],
                ),
                SearchField(
                  title: PartnerString.search,
                  textController: textController,
                  onChanged: context.read<PartnersTabCubit>().searchPartner,
                ),
              ],
            ),
            SizedBox(height: 34.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Column(
                children: [
                  const PartnerHeaderRow(),
                  SizedBox(
                    height: 740.h,
                    width: 1840.w,
                    child: BlocBuilder<PartnersTabCubit, PartnersTabState>(
                      builder: (context, state) {
                        if (state is PartnersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PartnersLoadFailed) {
                          return Center(
                            child:
                                Text('${PartnerString.error}: ${state.error}'),
                          );
                        } else if (state is PartnersLoaded) {
                          if (state.list.isEmpty) {
                            return const Center(
                              child: Text(
                                PartnerString.noPartnersYet,
                              ),
                            );
                          }

                          return PartnerListView(
                            list: state.list,
                          );
                        } else if (state is SearchingPartner) {
                          return PartnerListView(
                            list: state.list,
                          );
                        }

                        return const Center(
                          child: Text(
                            PartnerString.noPartnersYet,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
