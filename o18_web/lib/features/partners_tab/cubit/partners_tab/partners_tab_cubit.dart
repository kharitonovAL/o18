import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'partners_tab_state.dart';

class PartnersTabCubit extends Cubit<PartnersTabState> {
  PartnersTabCubit() : super(PartnersTabInitial()) {
    loadPartnerList();
  }

  List<Partner> partnerList = [];
  final _partnerRepository = PartnerRepository();

  Future<void> loadPartnerList() async {
    emit(PartnersLoading());

    final list = await _partnerRepository.getPartnerList();
    partnerList = list;

    emit(PartnersLoaded(list));
  }

  void searchPartner(
    String query,
  ) {
    final list = partnerList;
    list.sort((a, b) => a.title!.compareTo(b.title!));

    final searchResultList = <Partner>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((p) {
      if (p.title!.toLowerCase().contains(query.toLowerCase()) ||
          p.managerName!.toLowerCase().contains(query.toLowerCase()) ||
          p.fullAddress.toLowerCase().contains(query.toLowerCase())) {
        searchResultList.add(p);
      }
    });

    emit(SearchingPartner(
      searchResultList,
    ));
  }

  Future<void> addPartner({
    required String title,
    required String? activity,
    required int? index,
    required String? city,
    required String? street,
    required String? houseNumber,
    required String? officeNumber,
    required String? managerName,
    required String? managerPosition,
    required String? email,
    required int? phone,
    required int? fax,
    required String? bankTitle,
    required String? bankBic,
    required String? bankAccount,
    required String? bankCorrAccount,
  }) async {
    final partner = Partner()
      ..title = title
      ..fieldOfActivity = activity
      ..postIndex = index
      ..city = city
      ..street = street
      ..houseNumber = houseNumber
      ..officeNumber = officeNumber
      ..managerName = managerName
      ..managerPosition = managerPosition
      ..email = email
      ..phoneNumber = phone
      ..fax = fax
      ..bankTitle = bankTitle
      ..bankBic = bankBic
      ..bankAccount = bankAccount
      ..bankCorrespondingAccount = bankCorrAccount;

    await partner.save();
    await loadPartnerList();
  }

  Future<void> saveChanges({
    required Partner? partner,
    required String title,
    required String? activity,
    required int? index,
    required String? city,
    required String? street,
    required String? houseNumber,
    required String? officeNumber,
    required String? managerName,
    required String? managerPosition,
    required String? email,
    required int? phone,
    required int? fax,
    required String? bankTitle,
    required String? bankBic,
    required String? bankAccount,
    required String? bankCorrAccount,
  }) async {
    partner!
      ..title = title
      ..fieldOfActivity = activity
      ..postIndex = index
      ..city = city
      ..street = street
      ..houseNumber = houseNumber
      ..officeNumber = officeNumber
      ..managerName = managerName
      ..managerPosition = managerPosition
      ..email = email
      ..phoneNumber = phone
      ..fax = fax
      ..bankTitle = bankTitle
      ..bankBic = bankBic
      ..bankAccount = bankAccount
      ..bankCorrespondingAccount = bankCorrAccount;

    await partner.update();
    await loadPartnerList();
  }

  Future<void> deletePartner({
    required Partner? partner,
  }) async {
    await partner!.delete();
    await loadPartnerList();
  }
}
