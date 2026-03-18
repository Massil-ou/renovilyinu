// lib/Renovily/Admin/Services/AdminService.dart
import '../../../init/BaseResponse.dart';
import '../../../init/HelperService.dart';
import '../../../init/Manager.dart';
import 'RenovilyUsersPage.dart';

class RenovilyAdminService {
  static final RenovilyAdminService _i = RenovilyAdminService._();
  factory RenovilyAdminService() => _i;
  RenovilyAdminService._();

  HelperService get _api => Manager().helperService;

  static const String _usersList = '/renovily/admin/users/list';
  static const String _usersUpdateStatus = '/renovily/admin/users/update_status_user';
  static const String _usersUpdateRole = '/renovily/admin/users/update_role_user';

  static const String _partnerList = '/renovily/admin/partner/list';
  static const String _partnerUpdate = '/renovily/admin/partner/update';

  static const String _offersListPending = '/renovily/admin/offers/list_pending';
  static const String _offersUpdateStatus = '/renovily/admin/offers/update_status';

  Future<BaseResponse<RenovilyUsersPage>> listUsers({
    int limit = 100,
  }) async {
    return _api.postTyped<RenovilyUsersPage>(
      _usersList,
      data: {
        'limit': limit,
      },
      parse: (j) => RenovilyUsersPage.fromJson(j),
    );
  }

  Future<BaseResponse<void>> updateUserStatus({
    required String iduser,
    required String statusUser,
  }) async {
    final r = await _api.postTyped<dynamic>(
      _usersUpdateStatus,
      data: {
        'iduser': iduser,
        'status_user': statusUser,
      },
      parse: null,
    );

    return BaseResponse<void>(
      success: r.success,
      message: r.message,
      code: r.code,
      data: null,
    );
  }

  Future<BaseResponse<void>> updateUserRole({
    required String iduser,
    required String roleUser,
  }) async {
    final r = await _api.postTyped<dynamic>(
      _usersUpdateRole,
      data: {
        'iduser': iduser,
        'role_user': roleUser,
      },
      parse: null,
    );

    return BaseResponse<void>(
      success: r.success,
      message: r.message,
      code: r.code,
      data: null,
    );
  }

  Future<BaseResponse<RenovilyPartnerProfilesPage>> listPartnerPending({
    int limit = 100,
  }) async {
    return _api.postTyped<RenovilyPartnerProfilesPage>(
      _partnerList,
      data: {
        'limit': limit,
      },
      parse: (j) => RenovilyPartnerProfilesPage.fromJson(j),
    );
  }

  Future<BaseResponse<void>> updatePartnerDecision({
    required String iduser,
    required String action,
  }) async {
    final r = await _api.postTyped<dynamic>(
      _partnerUpdate,
      data: {
        'iduser': iduser,
        'action': action,
      },
      parse: null,
    );

    return BaseResponse<void>(
      success: r.success,
      message: r.message,
      code: r.code,
      data: null,
    );
  }

  Future<BaseResponse<RenovilyOffersPage>> listOffersPending({
    int limit = 100,
  }) async {
    return _api.postTyped<RenovilyOffersPage>(
      _offersListPending,
      data: {
        'limit': limit,
      },
      parse: (j) => RenovilyOffersPage.fromJson(j),
    );
  }

  Future<BaseResponse<void>> updateOfferStatus({
    required String idoffer,
    required String status,
  }) async {
    final r = await _api.postTyped<dynamic>(
      _offersUpdateStatus,
      data: {
        'idoffer': idoffer,
        'status': status,
      },
      parse: null,
    );

    return BaseResponse<void>(
      success: r.success,
      message: r.message,
      code: r.code,
      data: null,
    );
  }
}