// lib/Admin/Models/AdminModels.dart
class AdminStats {
  final int usersTotal;
  final int usersActive;
  final int usersPending;
  final int usersSuspended;

  final int carsTotal;
  final int carsActive;
  final int carsLocationActive;
  final int carsAchatsActive;

  final int proPending;
  final int proVerified;

  final int bookingsTotal;
  final int bookingsPending;
  final int bookingsConfirmed;
  final int bookingsOngoing;
  final int bookingsFinished;
  final int bookingsNoShow;

  const AdminStats({
    required this.usersTotal,
    required this.usersActive,
    required this.usersPending,
    required this.usersSuspended,
    required this.carsTotal,
    required this.carsActive,
    required this.carsLocationActive,
    required this.carsAchatsActive,
    required this.proPending,
    required this.proVerified,
    required this.bookingsTotal,
    required this.bookingsPending,
    required this.bookingsConfirmed,
    required this.bookingsOngoing,
    required this.bookingsFinished,
    required this.bookingsNoShow,
  });

  factory AdminStats.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    final u = (j['users'] is Map) ? Map<String, dynamic>.from(j['users']) : <String, dynamic>{};
    final c = (j['cars'] is Map) ? Map<String, dynamic>.from(j['cars']) : <String, dynamic>{};
    final p = (j['pro'] is Map) ? Map<String, dynamic>.from(j['pro']) : <String, dynamic>{};
    final b = (j['bookings'] is Map) ? Map<String, dynamic>.from(j['bookings']) : <String, dynamic>{};

    return AdminStats(
      usersTotal: i(u['total']),
      usersActive: i(u['active']),
      usersPending: i(u['pending']),
      usersSuspended: i(u['suspended'] ?? u['restricted']),
      carsTotal: i(c['total']),
      carsActive: i(c['active']),
      carsLocationActive: i(c['location_active']),
      carsAchatsActive: i(c['achats_active']),
      proPending: i(p['pending']),
      proVerified: i(p['verified']),
      bookingsTotal: i(b['total']),
      bookingsPending: i(b['pending']),
      bookingsConfirmed: i(b['confirmed']),
      bookingsOngoing: i(b['ongoing']),
      bookingsFinished: i(b['finished']),
      bookingsNoShow: i(b['no_show']),
    );
  }
}

class AdminUserItem {
  final String iduser;
  final String email;
  final String role;
  final String status;
  final String updatedAt;

  final String firstName;
  final String lastName;
  final String phone;
  final String wilaya;
  final String commune;
  final int solde;

  const AdminUserItem({
    required this.iduser,
    required this.email,
    required this.role,
    required this.status,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.wilaya,
    required this.commune,
    required this.solde,
  });

  factory AdminUserItem.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    String s(dynamic v) => (v ?? '').toString();
    return AdminUserItem(
      iduser: s(j['iduser']),
      email: s(j['email_user']),
      role: s(j['role_user']),
      status: s(j['status_user']),
      updatedAt: s(j['updated_at']),
      firstName: s(j['first_name_user']),
      lastName: s(j['last_name_user']),
      phone: s(j['number_user']),
      wilaya: s(j['wilaya_user']),
      commune: s(j['commune_user']),
      solde: i(j['solde_user']),
    );
  }

  String get fullName => '${firstName.trim()} ${lastName.trim()}'.trim();
}

class AdminUsersPage {
  final List<AdminUserItem> items;
  final int limit;
  final int offset;

  const AdminUsersPage({required this.items, required this.limit, required this.offset});

  factory AdminUsersPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    final raw = j['items'];
    final list = <AdminUserItem>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(AdminUserItem.fromJson(e));
        } else if (e is Map) {
          list.add(AdminUserItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }
    return AdminUsersPage(items: list, limit: i(j['limit']), offset: i(j['offset']));
  }
}

class AdminBookingItem {
  final String id;
  final String idcars;
  final String renterId;
  final String ownerId;
  final String start;
  final String end;
  final String status;
  final String createdAt;
  final double price;
  final double caution;

  final String title;
  final String brand;
  final String model;
  final String category;

  const AdminBookingItem({
    required this.id,
    required this.idcars,
    required this.renterId,
    required this.ownerId,
    required this.start,
    required this.end,
    required this.status,
    required this.createdAt,
    required this.price,
    required this.caution,
    required this.title,
    required this.brand,
    required this.model,
    required this.category,
  });

  factory AdminBookingItem.fromJson(Map<String, dynamic> j) {
    String s(dynamic v) => (v ?? '').toString();
    double d(dynamic v) => v is num ? v.toDouble() : double.tryParse('${v ?? 0}') ?? 0.0;
    return AdminBookingItem(
      id: s(j['idbookings_cars']),
      idcars: s(j['idcars']),
      renterId: s(j['renter_id']),
      ownerId: s(j['owner_id']),
      start: s(j['startdatebookings_cars']),
      end: s(j['enddatebookings_cars']),
      status: s(j['statusbookings_cars']),
      createdAt: s(j['datebookings_cars']),
      price: d(j['price_bookings_cars']),
      caution: d(j['caution_bookings_cars']),
      title: s(j['title_cars']),
      brand: s(j['brand_cars']),
      model: s(j['model_cars']),
      category: s(j['category_cars']),
    );
  }
}

class AdminBookingsPage {
  final List<AdminBookingItem> items;
  final int limit;
  final int offset;

  const AdminBookingsPage({required this.items, required this.limit, required this.offset});

  factory AdminBookingsPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    final raw = j['items'];
    final list = <AdminBookingItem>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(AdminBookingItem.fromJson(e));
        } else if (e is Map) {
          list.add(AdminBookingItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }
    return AdminBookingsPage(items: list, limit: i(j['limit']), offset: i(j['offset']));
  }
}

class AdminProRequestItem {
  final String iduser;
  final String statusPro;
  final String siret;
  final String companyName;
  final String tradeName;
  final String companyType;
  final String rcNumber;
  final String nifNumber;
  final String nisNumber;
  final String taxRegime;
  final String vatNumber;
  final String requestedAt;
  final String updatedAt;

  final String email;
  final String fullName;
  final String phone;

  const AdminProRequestItem({
    required this.iduser,
    required this.statusPro,
    required this.siret,
    required this.companyName,
    required this.tradeName,
    required this.companyType,
    required this.rcNumber,
    required this.nifNumber,
    required this.nisNumber,
    required this.taxRegime,
    required this.vatNumber,
    required this.requestedAt,
    required this.updatedAt,
    required this.email,
    required this.fullName,
    required this.phone,
  });

  factory AdminProRequestItem.fromJson(Map<String, dynamic> j) {
    String s(dynamic v) => (v ?? '').toString();
    final fn = s(j['first_name_user']);
    final ln = s(j['last_name_user']);
    return AdminProRequestItem(
      iduser: s(j['iduser']),
      statusPro: s(j['status_pro']),
      siret: s(j['siret_user']),
      companyName: s(j['company_name']),
      tradeName: s(j['trade_name']),
      companyType: s(j['company_type']),
      rcNumber: s(j['rc_number']),
      nifNumber: s(j['nif_number']),
      nisNumber: s(j['nis_number']),
      taxRegime: s(j['tax_regime']),
      vatNumber: s(j['vat_number']),
      requestedAt: s(j['requested_at']),
      updatedAt: s(j['updated_at']),
      email: s(j['email_user']),
      fullName: '$fn $ln'.trim(),
      phone: s(j['number_user']),
    );
  }
}

class AdminProPage {
  final List<AdminProRequestItem> items;
  final int limit;
  final int offset;

  const AdminProPage({required this.items, required this.limit, required this.offset});

  factory AdminProPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    final raw = j['items'];
    final list = <AdminProRequestItem>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(AdminProRequestItem.fromJson(e));
        } else if (e is Map) {
          list.add(AdminProRequestItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }
    return AdminProPage(items: list, limit: i(j['limit']), offset: i(j['offset']));
  }
}
