import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepo;
  final OwnerRepository ownerRepository;
  final FlatRepository flatRepository;
  final HouseRepository houseRepository;
  final AccountRepository accountRepository;
  final MessagesRepository messagesRepository;

  ProfileCubit({
    required this.authRepo,
    required this.ownerRepository,
    required this.flatRepository,
    required this.houseRepository,
    required this.accountRepository,
    required this.messagesRepository,
  }) : super(ProfileInitial()) {
    profileData();
  }

  Future<void> profileData() async {
    emit(ProfileLoading());

    final user = await authRepo.currentUser();
    final owner = await ownerRepository.getOwnerByEmail(email: user!.emailAddress!);
    final account = await accountRepository.getAccountByOwner(owner: owner!);
    final flat = await flatRepository.getFlatByAccount(accountId: account.objectId!);
    final house = await houseRepository.getHouseByFlat(flat: flat!);

    if (owner.name != null &&
        user.emailAddress != null &&
        owner.phoneNumber != null &&
        house.street != null &&
        house.houseNumber != null &&
        flat.flatNumber != null) {
      final userProfile = UserProfile(
        name: owner.name!,
        email: user.emailAddress!,
        phoneNumber: '${owner.phoneNumber}',
        address: 'ул.${house.street}, д.${house.houseNumber}',
        flatNumber: flat.flatNumber!,
      );

      final list = await accountRepository.getAccountsListByAddress(
        address: userProfile.address,
        flatNumber: flat.flatNumber!,
        houseRepository: houseRepository,
        flatRepository: flatRepository,
      );

      if (!isClosed) {
        emit(ProfileLoaded(
          userProfile: userProfile,
          accountList: list,
          parseUser: user,
          owner: owner,
          account: account,
          flat: flat,
          house: house,
        ));
      }
    } else {
      emit(
        const ProfileLoadFailure(error: 'Ошибка загрузки профиля'),
      );
    }
  }

  Future<bool?> logOut(
    String keyTopic,
    String keyToken,
    FirebaseMessaging firebaseMessagingInstance,
  ) async {
    final user = await authRepo.currentUser();

    if (user != null) {
      final userUnsubscribed = await messagesRepository.unsubscribeFromTopic(
        keyTopic,
        firebaseMessagingInstance,
      );
      final deviceTokenDeleted = await messagesRepository.deleteDeviceToken(
        authRepository: authRepo,
        ownerRepository: ownerRepository,
        keyToken: keyToken,
      );
      final userLoggedOut = await authRepo.logOut();
      StorageRepository.clear();

      if (userUnsubscribed && deviceTokenDeleted != null && deviceTokenDeleted && userLoggedOut) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  Future<bool?> deleteUser(
    String keyTopic,
    String keyToken,
    FirebaseMessaging firebaseMessagingInstance,
  ) async {
    final user = await authRepo.currentUser();

    if (user != null) {
      final userUnsubscribed = await messagesRepository.unsubscribeFromTopic(
        keyTopic,
        firebaseMessagingInstance,
      );
      final deviceTokenDeleted = await messagesRepository.deleteDeviceToken(
        authRepository: authRepo,
        ownerRepository: ownerRepository,
        keyToken: keyToken,
      );

      final response = await user.destroy();

      if (response != null && response.success) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }
}
