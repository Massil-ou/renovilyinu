import 'AdminModels.dart';

class RenovilyUsersPage {
  final List<RenovilyAdminUserItem> items;
  final int limit;
  final int offset;

  const RenovilyUsersPage({
    required this.items,
    required this.limit,
    required this.offset,
  });

  factory RenovilyUsersPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;

    final raw = j['items'];
    final list = <RenovilyAdminUserItem>[];

    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(RenovilyAdminUserItem.fromJson(e));
        } else if (e is Map) {
          list.add(RenovilyAdminUserItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    return RenovilyUsersPage(
      items: list,
      limit: i(j['limit']),
      offset: i(j['offset']),
    );
  }
}

class RenovilyPartnerProfilesPage {
  final List<RenovilyPartnerProfileItem> items;
  final int limit;
  final int offset;

  const RenovilyPartnerProfilesPage({
    required this.items,
    required this.limit,
    required this.offset,
  });

  factory RenovilyPartnerProfilesPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;

    final raw = j['items'];
    final list = <RenovilyPartnerProfileItem>[];

    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(RenovilyPartnerProfileItem.fromJson(e));
        } else if (e is Map) {
          list.add(RenovilyPartnerProfileItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    return RenovilyPartnerProfilesPage(
      items: list,
      limit: i(j['limit']),
      offset: i(j['offset']),
    );
  }
}

class RenovilyOffersPage {
  final List<RenovilyPendingOfferItem> items;
  final int limit;
  final int offset;

  const RenovilyOffersPage({
    required this.items,
    required this.limit,
    required this.offset,
  });

  factory RenovilyOffersPage.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;

    final raw = j['items'];
    final list = <RenovilyPendingOfferItem>[];

    if (raw is List) {
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          list.add(RenovilyPendingOfferItem.fromJson(e));
        } else if (e is Map) {
          list.add(RenovilyPendingOfferItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    return RenovilyOffersPage(
      items: list,
      limit: i(j['limit']),
      offset: i(j['offset']),
    );
  }
}