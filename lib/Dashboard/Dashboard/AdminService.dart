// lib/Admin/Services/AdminService.dart
import '../../init/BaseResponse.dart';
import '../../init/HelperService.dart';
import '../../init/Manager.dart';
import 'menu/models.dart';

class AdminService {
  static final AdminService _i = AdminService._();
  factory AdminService() => _i;
  AdminService._();

  HelperService get _api => Manager().helperService;

  // =========================
  // ROUTES ADMIN (8 APIs)
  // =========================
  static const String _stats = '/admin/stats/overview';

  static const String _usersSearch = '/admin/users/search';
  static const String _userSetStatus = '/admin/users/status/set';
  static const String _userSetRole = '/admin/users/role/set';

  static const String _bookingsList = '/admin/bookings/list';

  static const String _proPendingList = '/admin/partner/requests/list';
  static const String _proDecide = '/admin/partner/requests/decide';

  static const String _usersBlockedList = '/admin/users/blocked/list';

  Future<BaseResponse<AdminStats>> stats() async {
    return _api.postTyped<AdminStats>(
      _stats,
      data: const {},
      parse: (j) => AdminStats.fromJson(j),
    );
  }

  Future<BaseResponse<AdminUsersPage>> usersSearch({
    String q = '',
    String role = '',
    String status = '',
    int limit = 50,
    int offset = 0,
  }) async {
    return _api.postTyped<AdminUsersPage>(
      _usersSearch,
      data: {
        'q': q,
        if (role.trim().isNotEmpty) 'role': role.trim(),
        if (status.trim().isNotEmpty) 'status': status.trim(),
        'limit': limit,
        'offset': offset,
      },
      parse: (j) => AdminUsersPage.fromJson(j),
    );
  }

  Future<BaseResponse<void>> setUserStatus({
    required String iduser,
    required String status, // active | suspended | inactive | pending
  }) async {
    final r = await _api.postTyped<dynamic>(
      _userSetStatus,
      data: {'iduser': iduser, 'status': status},
      parse: null,
    );
    return BaseResponse<void>(success: r.success, message: r.message, code: r.code, data: null);
  }

  Future<BaseResponse<void>> setUserRole({
    required String iduser,
    required String role, // client | partner | admin | manager
  }) async {
    final r = await _api.postTyped<dynamic>(
      _userSetRole,
      data: {'iduser': iduser, 'role': role},
      parse: null,
    );
    return BaseResponse<void>(success: r.success, message: r.message, code: r.code, data: null);
  }

  Future<BaseResponse<AdminBookingsPage>> bookingsList({
    String status = '',
    String startDate = '',
    String endDate = '',
    int limit = 100,
    int offset = 0,
  }) async {
    return _api.postTyped<AdminBookingsPage>(
      _bookingsList,
      data: {
        if (status.trim().isNotEmpty) 'status': status.trim(),
        if (startDate.trim().isNotEmpty) 'start_date': startDate.trim(),
        if (endDate.trim().isNotEmpty) 'end_date': endDate.trim(),
        'limit': limit,
        'offset': offset,
      },
      parse: (j) => AdminBookingsPage.fromJson(j),
    );
  }

  Future<BaseResponse<AdminProPage>> proPendingList({int limit = 100, int offset = 0}) async {
    return _api.postTyped<AdminProPage>(
      _proPendingList,
      data: {'limit': limit, 'offset': offset},
      parse: (j) => AdminProPage.fromJson(j),
    );
  }

  // PHP attend action: approve/reject
  Future<BaseResponse<void>> proDecide({
    required String iduser,
    required String decision, // confirm | reject
  }) async {
    final action = decision.toLowerCase() == 'confirm' ? 'approve' : 'reject';

    final r = await _api.postTyped<dynamic>(
      _proDecide,
      data: {'iduser': iduser, 'action': action},
      parse: null,
    );
    return BaseResponse<void>(success: r.success, message: r.message, code: r.code, data: null);
  }

  Future<BaseResponse<AdminUsersPage>> blockedUsers({int limit = 100, int offset = 0}) async {
    return _api.postTyped<AdminUsersPage>(
      _usersBlockedList,
      data: {'limit': limit, 'offset': offset},
      parse: (j) => AdminUsersPage.fromJson(j),
    );
  }
}
