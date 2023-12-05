import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/user_request_cubit/user_request_cubit.dart';
import 'package:o18_client/ui/requests/add_request_page.dart';
import 'package:o18_client/ui/requests/request_detail_page.dart';
import 'package:o18_client/utils/utils.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsController createState() => _RequestsController();
}

class _RequestsController extends State<RequestsPage> {
  AuthRepository authRepo = AuthRepository();
  UserRequestRepository userRequestRepository = UserRequestRepository();
  OwnerRepository ownerRepository = OwnerRepository();
  FlatRepository flatRepository = FlatRepository();
  HouseRepository houseRepository = HouseRepository();
  AccountRepository accountRepository = AccountRepository();
  RequestNumberRepository requestNumberRepository = RequestNumberRepository();
  ImageRepository imageFileRepository = ImageRepository();

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddRequestPage,
          child: const Icon(Icons.add),
        ),
      );

  Widget _buildBody(
    BuildContext context,
  ) =>
      BlocBuilder<UserRequestCubit, UserRequestState>(
        builder: (context, state) {
          if (state is UserRequestLoading) {
            return const LinearProgressIndicator();
          } else if (state is UserRequestLoadFailure) {
            return Center(
              child: Text('Ошибка: ${state.error}'),
            );
          } else if (state is UserRequestLoaded) {
            if (state.userRequestList.isEmpty) {
              return const Center(child: Text('Заявок пока не было...'));
            }

            return ListView.builder(
              itemCount: state.userRequestList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                request: state.userRequestList[index],
              ),
            );
          } else if (state is UserRequestAdded) {
            return ListView.builder(
              itemCount: state.userRequestList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                request: state.userRequestList[index],
              ),
            );
          }

          return const Center(child: Text('Сообщений пока не поступало...'));
        },
      );

  Widget _buildListItem({
    required BuildContext context,
    required UserRequest request,
  }) =>
      ListTile(
        leading: request.requestStatusIcon,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Заявка № ${request.requestNumber}'),
            Text(request.userRequest!, maxLines: 1),
          ],
        ),
        subtitle: Text(request.status!),
        onTap: () => _navigateToDetailRequestPage(request),
      );

  Future<void> _navigateToAddRequestPage() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => AddRequestPage(
          authRepo: authRepo,
          userRequestRepository: userRequestRepository,
          ownerRepository: ownerRepository,
          flatRepository: flatRepository,
          houseRepository: houseRepository,
          accountRepository: accountRepository,
          requestNumberRepository: requestNumberRepository,
          imageFileRepository: imageFileRepository,
        ),
      ),
    ).then(
      (value) {
        context.read<UserRequestCubit>().loadUserRequestList(
              accountRepository: accountRepository,
              authRepo: authRepo,
              ownerRepository: ownerRepository,
            );
      },
    );
  }

  void _navigateToDetailRequestPage(
    UserRequest request,
  ) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => RequestDetailPage(request: request),
      ),
    );
  }
}
