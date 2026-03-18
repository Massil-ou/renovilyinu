// lib/Renovily/Admin/Models/AdminModels.dart

class RenovilyAdminUserItem {
  final String iduser;
  final String prenom;
  final String email;
  final String numero;
  final String statusUser;
  final String roleUser;

  const RenovilyAdminUserItem({
    required this.iduser,
    required this.prenom,
    required this.email,
    required this.numero,
    required this.statusUser,
    required this.roleUser,
  });

  factory RenovilyAdminUserItem.fromJson(Map<String, dynamic> j) {
    String s(dynamic v) => (v ?? '').toString();
    return RenovilyAdminUserItem(
      iduser: s(j['iduser']),
      prenom: s(j['prenom']),
      email: s(j['email']),
      numero: s(j['numero']),
      statusUser: s(j['status_user']),
      roleUser: s(j['role_user']),
    );
  }

  String get fullName => prenom.trim().isNotEmpty ? prenom.trim() : email;
}

class RenovilyPartnerProfileItem {
  final String iduser;
  final String prenom;
  final String nom;
  final String email;
  final String numero;
  final String wilaya;
  final String commune;
  final String roleUser;
  final String statusUser;

  final String siretUser;
  final String companyName;
  final String tradeName;
  final String companyType;
  final String rcNumber;
  final String nifNumber;
  final String nisNumber;
  final String taxRegime;
  final String vatNumber;
  final String statusPro;
  final String verifiedAt;
  final String requestedAt;
  final String updatedAt;

  const RenovilyPartnerProfileItem({
    required this.iduser,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.numero,
    required this.wilaya,
    required this.commune,
    required this.roleUser,
    required this.statusUser,
    required this.siretUser,
    required this.companyName,
    required this.tradeName,
    required this.companyType,
    required this.rcNumber,
    required this.nifNumber,
    required this.nisNumber,
    required this.taxRegime,
    required this.vatNumber,
    required this.statusPro,
    required this.verifiedAt,
    required this.requestedAt,
    required this.updatedAt,
  });

  factory RenovilyPartnerProfileItem.fromJson(Map<String, dynamic> j) {
    String s(dynamic v) => (v ?? '').toString();
    final p = (j['profil_partner'] is Map)
        ? Map<String, dynamic>.from(j['profil_partner'])
        : <String, dynamic>{};

    return RenovilyPartnerProfileItem(
      iduser: s(j['iduser']),
      prenom: s(j['prenom']),
      nom: s(j['nom']),
      email: s(j['email']),
      numero: s(j['numero']),
      wilaya: s(j['wilaya']),
      commune: s(j['commune']),
      roleUser: s(j['role_user']),
      statusUser: s(j['status_user']),
      siretUser: s(p['siret_user']),
      companyName: s(p['company_name']),
      tradeName: s(p['trade_name']),
      companyType: s(p['company_type']),
      rcNumber: s(p['rc_number']),
      nifNumber: s(p['nif_number']),
      nisNumber: s(p['nis_number']),
      taxRegime: s(p['tax_regime']),
      vatNumber: s(p['vat_number']),
      statusPro: s(p['status_pro']),
      verifiedAt: s(p['verified_at']),
      requestedAt: s(p['requested_at']),
      updatedAt: s(p['updated_at']),
    );
  }

  String get fullName => '${prenom.trim()} ${nom.trim()}'.trim();
}

class RenovilyOfferImageItem {
  final String url;

  const RenovilyOfferImageItem({required this.url});

  factory RenovilyOfferImageItem.fromJson(Map<String, dynamic> j) {
    return RenovilyOfferImageItem(url: (j['url'] ?? '').toString());
  }
}

class RenovilyPendingOfferItem {
  final String id;
  final String iduser;
  final String titre;
  final String description;
  final String wilaya;
  final String commune;
  final String metier;
  final int isPro;
  final String namePro;
  final String phone;
  final String status;
  final int experienceAnnees;
  final int? prix;
  final String unitePrix;
  final double score;
  final List<RenovilyOfferImageItem> images;
  final String createdAt;
  final String updatedAt;

  const RenovilyPendingOfferItem({
    required this.id,
    required this.iduser,
    required this.titre,
    required this.description,
    required this.wilaya,
    required this.commune,
    required this.metier,
    required this.isPro,
    required this.namePro,
    required this.phone,
    required this.status,
    required this.experienceAnnees,
    required this.prix,
    required this.unitePrix,
    required this.score,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RenovilyPendingOfferItem.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is int ? v : int.tryParse('${v ?? 0}') ?? 0;
    double d(dynamic v) => v is num ? v.toDouble() : double.tryParse('${v ?? 0}') ?? 0.0;
    String s(dynamic v) => (v ?? '').toString();

    final rawImgs = j['images'];
    final imgs = <RenovilyOfferImageItem>[];
    if (rawImgs is List) {
      for (final e in rawImgs) {
        if (e is Map<String, dynamic>) {
          imgs.add(RenovilyOfferImageItem.fromJson(e));
        } else if (e is Map) {
          imgs.add(RenovilyOfferImageItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    return RenovilyPendingOfferItem(
      id: s(j['id']),
      iduser: s(j['iduser']),
      titre: s(j['titre']),
      description: s(j['description']),
      wilaya: s(j['wilaya']),
      commune: s(j['commune']),
      metier: s(j['metier']),
      isPro: i(j['is_pro']),
      namePro: s(j['name_pro']),
      phone: s(j['phone']),
      status: s(j['status']),
      experienceAnnees: i(j['experience_annees']),
      prix: j['prix'] == null ? null : i(j['prix']),
      unitePrix: s(j['unite_prix']),
      score: d(j['score']),
      images: imgs,
      createdAt: s(j['created_at']),
      updatedAt: s(j['updated_at']),
    );
  }
}