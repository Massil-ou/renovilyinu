// lib/Renovily/Admin/Managers/AdminManager.dart

import 'package:flutter/foundation.dart';
import '../../../init/BaseResponse.dart';

import 'AdminModels.dart';
import 'RenovilyAdminService.dart';

class RenovilyAdminManager extends ChangeNotifier {
  static final RenovilyAdminManager _i = RenovilyAdminManager._();
  factory RenovilyAdminManager() => _i;
  RenovilyAdminManager._();

  final RenovilyAdminService _service = RenovilyAdminService();

  bool isLoadingUsers = false;
  bool isLoadingPartners = false;
  bool isLoadingOffers = false;

  String? lastError;

  final List<RenovilyAdminUserItem> users = [];
  final List<RenovilyPartnerProfileItem> partnerPending = [];
  final List<RenovilyPendingOfferItem> offersPending = [];

  int usersLimit = 100;
  int usersOffset = 0;

  int partnersLimit = 100;
  int partnersOffset = 0;

  int offersLimit = 100;
  int offersOffset = 0;

  Future<void> initLoad() async {
    await Future.wait([
      listUsers(limit: 100, offset: 0, append: false),
      listPartnerPending(limit: 100, offset: 0, append: false),
      listOffersPending(limit: 100, offset: 0, append: false),
    ]);
  }

  Future<void> refreshAll() async {
    await initLoad();
  }

  Future<void> listUsers({
    int limit = 100,
    int offset = 0,
    bool append = false,
  }) async {
    if (isLoadingUsers) return;
    isLoadingUsers = true;
    lastError = null;
    usersLimit = limit;
    usersOffset = offset;
    notifyListeners();

    try {
      final r = await _service.listUsers(limit: limit);
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }

      final page = r.data!;
      if (!append) users.clear();
      users.addAll(page.items);
      usersLimit = page.limit;
      usersOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingUsers = false;
      notifyListeners();
    }
  }

  Future<void> listPartnerPending({
    int limit = 100,
    int offset = 0,
    bool append = false,
  }) async {
    if (isLoadingPartners) return;
    isLoadingPartners = true;
    lastError = null;
    partnersLimit = limit;
    partnersOffset = offset;
    notifyListeners();

    try {
      final r = await _service.listPartnerPending(limit: limit);
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }

      final page = r.data!;
      if (!append) partnerPending.clear();
      partnerPending.addAll(page.items);
      partnersLimit = page.limit;
      partnersOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingPartners = false;
      notifyListeners();
    }
  }

  Future<void> listOffersPending({
    int limit = 100,
    int offset = 0,
    bool append = false,
  }) async {
    if (isLoadingOffers) return;
    isLoadingOffers = true;
    lastError = null;
    offersLimit = limit;
    offersOffset = offset;
    notifyListeners();

    try {
      final r = await _service.listOffersPending(limit: limit);
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }

      final page = r.data!;
      if (!append) offersPending.clear();
      offersPending.addAll(page.items);
      offersLimit = page.limit;
      offersOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingOffers = false;
      notifyListeners();
    }
  }

  Future<BaseResponse<void>> setUserStatus(
      RenovilyAdminUserItem it,
      String statusUser,
      ) async {
    final r = await _service.updateUserStatus(
      iduser: it.iduser,
      statusUser: statusUser,
    );

    if (r.success) {
      final idx = users.indexWhere((e) => e.iduser == it.iduser);
      if (idx != -1) {
        users[idx] = RenovilyAdminUserItem(
          iduser: users[idx].iduser,
          prenom: users[idx].prenom,
          email: users[idx].email,
          numero: users[idx].numero,
          statusUser: statusUser,
          roleUser: users[idx].roleUser,
        );
        notifyListeners();
      }
    }

    return r;
  }

  Future<BaseResponse<void>> setUserRole(
      RenovilyAdminUserItem it,
      String roleUser,
      ) async {
    final r = await _service.updateUserRole(
      iduser: it.iduser,
      roleUser: roleUser,
    );

    if (r.success) {
      final idx = users.indexWhere((e) => e.iduser == it.iduser);
      if (idx != -1) {
        users[idx] = RenovilyAdminUserItem(
          iduser: users[idx].iduser,
          prenom: users[idx].prenom,
          email: users[idx].email,
          numero: users[idx].numero,
          statusUser: users[idx].statusUser,
          roleUser: roleUser,
        );
        notifyListeners();
      }
    }

    return r;
  }

  Future<BaseResponse<void>> acceptPartner(
      RenovilyPartnerProfileItem it,
      ) async {
    final r = await _service.updatePartnerDecision(
      iduser: it.iduser,
      action: 'accept',
    );

    if (r.success) {
      partnerPending.removeWhere((e) => e.iduser == it.iduser);

      final idx = users.indexWhere((u) => u.iduser == it.iduser);
      if (idx != -1) {
        users[idx] = RenovilyAdminUserItem(
          iduser: users[idx].iduser,
          prenom: users[idx].prenom,
          email: users[idx].email,
          numero: users[idx].numero,
          statusUser: users[idx].statusUser,
          roleUser: 'partner',
        );
      }
      notifyListeners();
    }

    return r;
  }

  Future<BaseResponse<void>> rejectPartner(
      RenovilyPartnerProfileItem it,
      ) async {
    final r = await _service.updatePartnerDecision(
      iduser: it.iduser,
      action: 'reject',
    );

    if (r.success) {
      partnerPending.removeWhere((e) => e.iduser == it.iduser);
      notifyListeners();
    }

    return r;
  }

  Future<BaseResponse<void>> setOfferStatus(
      RenovilyPendingOfferItem it,
      String status,
      ) async {
    final r = await _service.updateOfferStatus(
      idoffer: it.id,
      status: status,
    );

    if (r.success) {
      final idx = offersPending.indexWhere((e) => e.id == it.id);
      if (idx != -1) {
        if (status == 'pending') {
          offersPending[idx] = RenovilyPendingOfferItem(
            id: offersPending[idx].id,
            iduser: offersPending[idx].iduser,
            titre: offersPending[idx].titre,
            description: offersPending[idx].description,
            wilaya: offersPending[idx].wilaya,
            commune: offersPending[idx].commune,
            metier: offersPending[idx].metier,
            isPro: offersPending[idx].isPro,
            namePro: offersPending[idx].namePro,
            phone: offersPending[idx].phone,
            status: status,
            experienceAnnees: offersPending[idx].experienceAnnees,
            prix: offersPending[idx].prix,
            unitePrix: offersPending[idx].unitePrix,
            score: offersPending[idx].score,
            images: offersPending[idx].images,
            createdAt: offersPending[idx].createdAt,
            updatedAt: offersPending[idx].updatedAt,
          );
        } else {
          offersPending.removeAt(idx);
        }
        notifyListeners();
      }
    }

    return r;
  }

  void invalidateAll() {
    lastError = null;
    users.clear();
    partnerPending.clear();
    offersPending.clear();
    usersLimit = 100;
    usersOffset = 0;
    partnersLimit = 100;
    partnersOffset = 0;
    offersLimit = 100;
    offersOffset = 0;
    notifyListeners();
  }
}