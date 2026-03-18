// lib/Admin/Managers/AdminManager.dart
import 'package:flutter/foundation.dart';
import '../../init/BaseResponse.dart';
import 'AdminService.dart';
import 'menu/models.dart';

class AdminManager extends ChangeNotifier {
  static final AdminManager _i = AdminManager._();
  factory AdminManager() => _i;
  AdminManager._();

  final AdminService _service = AdminService();

  bool isLoadingStats = false;
  bool isLoadingUsers = false;
  bool isLoadingBookings = false;
  bool isLoadingPro = false;
  bool isLoadingBlocked = false;

  String? lastError;

  AdminStats? statsData;

  final List<AdminUserItem> users = [];
  int usersLimit = 50;
  int usersOffset = 0;
  String usersQ = '';
  String usersRole = '';
  String usersStatus = '';

  final List<AdminBookingItem> bookings = [];
  int bookingsLimit = 100;
  int bookingsOffset = 0;
  String bookingsStatus = '';
  String bookingsStart = '';
  String bookingsEnd = '';

  final List<AdminProRequestItem> proPending = [];
  int proLimit = 100;
  int proOffset = 0;

  final List<AdminUserItem> blocked = [];
  int blockedLimit = 100;
  int blockedOffset = 0;

  void invalidateAll() {
    lastError = null;
    statsData = null;
    users.clear();
    bookings.clear();
    proPending.clear();
    blocked.clear();
    notifyListeners();
  }

  Future<void> loadStats() async {
    if (isLoadingStats) return;
    isLoadingStats = true;
    lastError = null;
    notifyListeners();

    try {
      final r = await _service.stats();
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }
      statsData = r.data;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingStats = false;
      notifyListeners();
    }
  }

  Future<void> searchUsers({
    String q = '',
    String role = '',
    String status = '',
    int limit = 50,
    int offset = 0,
    bool append = false,
  }) async {
    if (isLoadingUsers) return;
    isLoadingUsers = true;
    lastError = null;

    usersQ = q;
    usersRole = role;
    usersStatus = status;
    usersLimit = limit;
    usersOffset = offset;

    notifyListeners();

    try {
      final r = await _service.usersSearch(q: q, role: role, status: status, limit: limit, offset: offset);
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

  Future<void> listBookings({
    String status = '',
    String startDate = '',
    String endDate = '',
    int limit = 100,
    int offset = 0,
    bool append = false,
  }) async {
    if (isLoadingBookings) return;
    isLoadingBookings = true;
    lastError = null;

    bookingsStatus = status;
    bookingsStart = startDate;
    bookingsEnd = endDate;
    bookingsLimit = limit;
    bookingsOffset = offset;

    notifyListeners();

    try {
      final r = await _service.bookingsList(
        status: status,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
        offset: offset,
      );
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }

      final page = r.data!;
      if (!append) bookings.clear();
      bookings.addAll(page.items);
      bookingsLimit = page.limit;
      bookingsOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingBookings = false;
      notifyListeners();
    }
  }

  Future<void> listProPending({int limit = 100, int offset = 0, bool append = false}) async {
    if (isLoadingPro) return;
    isLoadingPro = true;
    lastError = null;

    proLimit = limit;
    proOffset = offset;

    notifyListeners();

    try {
      final r = await _service.proPendingList(limit: limit, offset: offset);
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }
      final page = r.data!;
      if (!append) proPending.clear();
      proPending.addAll(page.items);
      proLimit = page.limit;
      proOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingPro = false;
      notifyListeners();
    }
  }

  Future<BaseResponse<void>> confirmPro(AdminProRequestItem it) async {
    final r = await _service.proDecide(iduser: it.iduser, decision: 'confirm');
    if (r.success) {
      proPending.removeWhere((e) => e.iduser == it.iduser);
      notifyListeners();
    }
    return r;
  }

  Future<BaseResponse<void>> rejectPro(AdminProRequestItem it) async {
    final r = await _service.proDecide(iduser: it.iduser, decision: 'reject');
    if (r.success) {
      proPending.removeWhere((e) => e.iduser == it.iduser);
      notifyListeners();
    }
    return r;
  }

  Future<BaseResponse<void>> setStatus(AdminUserItem it, String status) async {
    final r = await _service.setUserStatus(iduser: it.iduser, status: status);
    if (r.success) {
      final idx = users.indexWhere((u) => u.iduser == it.iduser);
      if (idx != -1) {
        users[idx] = AdminUserItem(
          iduser: users[idx].iduser,
          email: users[idx].email,
          role: users[idx].role,
          status: status,
          updatedAt: users[idx].updatedAt,
          firstName: users[idx].firstName,
          lastName: users[idx].lastName,
          phone: users[idx].phone,
          wilaya: users[idx].wilaya,
          commune: users[idx].commune,
          solde: users[idx].solde,
        );
      }
      notifyListeners();
    }
    return r;
  }

  Future<void> listBlocked({int limit = 100, int offset = 0, bool append = false}) async {
    if (isLoadingBlocked) return;
    isLoadingBlocked = true;
    lastError = null;

    blockedLimit = limit;
    blockedOffset = offset;

    notifyListeners();

    try {
      final r = await _service.blockedUsers(limit: limit, offset: offset);
      if (!r.success || r.data == null) {
        lastError = r.message.isNotEmpty ? r.message : 'error_${r.code}';
        return;
      }
      final page = r.data!;
      if (!append) blocked.clear();
      blocked.addAll(page.items);
      blockedLimit = page.limit;
      blockedOffset = page.offset;
    } catch (_) {
      lastError = 'exception';
    } finally {
      isLoadingBlocked = false;
      notifyListeners();
    }
  }
}
