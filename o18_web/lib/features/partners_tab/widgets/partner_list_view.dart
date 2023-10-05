import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/partners_tab/view/partner_editor.dart';
import 'package:o18_web/features/partners_tab/widgets/widgets.dart';

class PartnerListView extends StatelessWidget {
  final List<Partner> list;

  const PartnerListView({
    required this.list,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => PartnerListItem(
          partner: list[index],
          itemIndex: index,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => StaffCubit(
                  partner: list[index],
                ),
                child: PartnerEditor(
                  partner: list[index],
                ),
              ),
            ),
          ),
        ),
      );
}
