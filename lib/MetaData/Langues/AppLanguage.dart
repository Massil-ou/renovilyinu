// lib/MetaData/Langues/AppLanguage.dart
import 'dart:ui';
import '../../init/Manager.dart';

enum AppLanguage {
  fr,
  en,
  ar;

  static AppLanguage fromCode(String? code) {
    if (code == null || code.trim().isEmpty) return AppLanguage.fr;
    final lc = code.toLowerCase();
    if (lc.startsWith('ar')) return AppLanguage.ar;
    if (lc.startsWith('en')) return AppLanguage.en;
    return AppLanguage.fr;
  }
}

extension AppLanguageX on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.fr:
        return 'fr';
      case AppLanguage.en:
        return 'en';
      case AppLanguage.ar:
        return 'ar';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.fr:
        return const Locale('fr');
      case AppLanguage.en:
        return const Locale('en');
      case AppLanguage.ar:
        return const Locale('ar');
    }
  }

  TextDirection get direction {
    switch (this) {
      case AppLanguage.ar:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }
}

class WinyCar {
  final AppLanguage lang;
  WinyCar(this.lang);

  static WinyCar of(Manager m) => WinyCar(m.languageService.appLanguage);

  String _t(String fr, String en, String ar) {
    switch (lang) {
      case AppLanguage.fr:
        return fr;
      case AppLanguage.en:
        return en;
      case AppLanguage.ar:
        return ar;
    }
  }

  String _tp(String fr, String en, String ar, [Map<String, String>? params]) {
    String raw = _t(fr, en, ar);
    if (params == null || params.isEmpty) return raw;
    var out = raw;
    params.forEach((k, v) {
      out = out.replaceAll('{$k}', v);
    });
    return out;
  }


  String get proValidationInvalid => _t(
    'Valeur invalide',
    'Invalid value',
    'قيمة غير صالحة',
  );

  String get proValidationVatRange => _t(
    'La TVA doit être entre 0 et 100 %',
    'VAT must be between 0 and 100%',
    'يجب أن تكون نسبة الضريبة بين 0 و 100٪',
  );

  String get invalidNumber => _t(
    'Nombre invalide',
    'Invalid number',
    'رقم غير صالح',
  );

  String get refresh => _t(
    'Rafraîchir',
    'Refresh',
    'تحديث',
  );
  String get selectAll => _t(
    'Tout sélectionner',
    'Select all',
    'تحديد الكل',
  );

  String get unselectAll => _t(
    'Tout désélectionner',
    'Unselect all',
    'إلغاء تحديد الكل',
  );
  String get status => _t(
    'Statut',
    'Status',
    'الحالة',
  );
  String get forbidden => _t(
    'Action non autorisée',
    'Action not allowed',
    'إجراء غير مسموح',
  );
  String get statusNone => _t(
    'Aucune demande',
    'No request',
    'لا يوجد طلب',
  );

  String get fType => _t(
    'Type de véhicule',
    'Vehicle type',
    'نوع المركبة',
  );
  String get runtimeEndPhotosHint => _t(
    'Ajoutez des photos si nécessaire (état du véhicule, carburant, etc.)',
    'Add photos if needed (vehicle condition, fuel, etc.)',
    'أضف صورًا عند الحاجة (حالة المركبة، الوقود، إلخ)',
  );
  String get runtimeRenterSectionTitle => _t(
    'Informations du locataire',
    'Renter information',
    'معلومات المستأجر',
  );

  String get runtimeMileageSectionTitle => _t(
    'Kilométrage',
    'Mileage',
    'عداد الكيلومترات',
  );

  String get runtimePricingSectionTitle => _t(
    'Tarification',
    'Pricing',
    'التسعير',
  );

  String get runtimeRenterInfoTitle => _t(
    'Informations du locataire',
    'Renter information',
    'معلومات المستأجر',
  );

  String get scanQrOpenCar => _t(
    'Scanner le QR code pour ouvrir cette voiture',
    'Scan the QR code to open this car',
    'امسح رمز QR لفتح هذه السيارة',
  );


  String get share => _t(
    'Partager',
    'Share',
    'مشاركة',
  );
  String get ownerRuntimeDepositLabel => _t(
    'Caution : ',
    'Deposit: ',
    'الضمان: ',
  );

  String get pleaseEnterStartEndDateTime =>
      _t(
        'Veuillez saisir la date et l’heure de début et de fin.',
        'Please enter the start and end date and time.',
        'يرجى إدخال تاريخ ووقت البداية والنهاية.',
      );

  String get myCars => _t('My cars', 'Mes voitures', 'سياراتي');
  String get fSelectStartDate =>
      _t('Select start date', 'Sélectionner la date de début', 'اختر تاريخ البداية');

  // --- Legal / Support buttons
  String get support => _t('Support', 'Support', 'الدعم');
  String get terms => _t('Conditions', 'Terms', 'الشروط');
  String get privacyPolicy =>
      _t('Politique de confidentialité', 'Privacy policy', 'سياسة الخصوصية');

  String get errorRentalDatesRequired => _t(
    'Veuillez saisir la date et l’heure de début et de fin.',
    'Please select the start and end date and time.',
    'يرجى إدخال تاريخ ووقت البدء والانتهاء.',
  );

  String get searchAppliedTapToReset => _t(
    'Recherche appliquée — touchez pour réinitialiser',
    'Search applied — tap to reset',
    'تم تطبيق البحث — اضغط لإعادة التعيين',
  );
  String get communes => _t('Communes', 'Communes', 'البلديات');
  String get pleaseLogin =>
      _t(
        'Veuillez vous connecter pour continuer',
        'Please log in to continue',
        'يرجى تسجيل الدخول للمتابعة',
      );
// --- Generic
  String get info => _t(
    'Information',
    'Information',
    'معلومة',
  );

  String get searchRentals =>
      _t('Rechercher des locations', 'Search rentals', 'ابحث عن كراء السيارات');

  String get searchHint => _t(
    'Rechercher (marque, modèle, ville...)',
    'Search (brand, model, city...)',
    'ابحث (العلامة، الطراز، المدينة...)',
  );

  String get searchCars =>
      _t('Rechercher des voitures', 'Search cars', 'ابحث عن السيارات');

  String get edit => _t('Modifier', 'Edit', 'تعديل');

  String get update => _t('Mettre à jour', 'Update', 'تحديث');

  String get results => _t('Résultats', 'Results', 'النتائج');

  String get renew => _t('Renouveler', 'Renew', 'تجديد');

  String get renewAdMessage => _t(
    'Voulez-vous vraiment renouveler cette annonce ?',
    'Do you really want to renew this ad?',
    'هل تريد حقًا تجديد هذا الإعلان؟',
  );

  String get deleteCarTitle =>
      _t('Supprimer la voiture', 'Delete car', 'حذف السيارة');
  String get deleteCarMessage => _t(
    'Cette action est irréversible.\nVoulez-vous vraiment supprimer cette voiture ?',
    'This action cannot be undone.\nDo you really want to delete this car?',
    'هذا الإجراء لا يمكن التراجع عنه.\nهل تريد حقًا حذف هذه السيارة؟',
  );

  String get noCarsMatchFilters => _t(
    'Aucune voiture ne correspond à ces filtres.',
    'No cars match these filters.',
    'لا توجد سيارات تطابق هذه الفلاتر.',
  );

  String get noCarsAvailableNow => _t(
    'Aucune voiture disponible pour le moment.',
    'No cars available at the moment.',
    'لا توجد سيارات متاحة حالياً.',
  );

  String get da => _t('DA', 'DA', 'دج');

  String get subCategory =>
      _t('Sous-catégorie', 'Sub-category', 'الفئة الفرعية');

  String resetLinkSentTo(String email) => _t(
    'Un lien vous a été envoyé par email ($email) pour changer le mot de passe.',
    'A link has been sent by email ($email) to change your password.',
    'تم إرسال رابط عبر البريد الإلكتروني ($email) لتغيير كلمة المرور.',
  );

  String get resendLink =>
      _t('Renvoyer le lien', 'Resend link', 'إعادة إرسال الرابط');

  // ====== OWNER / RUNTIME BOOKINGS ======
  String get ownerRuntimeTitle =>
      _t('Gérer les locations', 'Manage rentals', 'إدارة الكراء');

  String get ownerRuntimeSubtitle => _t(
    'Liste des réservations confirmées et en cours, regroupées par voiture.',
    'Confirmed and ongoing bookings, grouped by car.',
    'قائمة الحجوزات المؤكدة والجارية مجمعة حسب السيارة.',
  );

  // Filters labels
  String get ownerRuntimeFilterAll => _t('Toutes', 'All', 'الكل');
  String get ownerRuntimeFilterToStart => _t('À démarrer', 'To start', 'لبدء');
  String get ownerRuntimeFilterToStartToday =>
      _t("À démarrer aujourd’hui", "Start today", "يبدأ اليوم");
  String get ownerRuntimeFilterToEndToday =>
      _t("À rendre aujourd’hui", "Return today", "إرجاع اليوم");
  String get ownerRuntimeFilterOngoing => _t('En cours', 'Ongoing', 'جارية');
  String get ownerRuntimeFilterFinished =>
      _t('Terminées', 'Finished', 'منتهية');
  String get ownerRuntimeFilterNoShow =>
      _t('Non venues', 'No-shows', 'لم يأتوا');

  // Empty messages
  String get ownerRuntimeEmptyAll => _t(
    'Aucune réservation confirmée pour le moment.',
    'No confirmed bookings for now.',
    'لا توجد حجوزات مؤكدة حالياً.',
  );
  String get ownerRuntimeEmptyToStart => _t(
    'Aucune location à démarrer pour le moment.',
    'No rentals to start for now.',
    'لا توجد كراءات لبدئها حالياً.',
  );
  String get ownerRuntimeEmptyToStartToday => _t(
    "Aucune location à démarrer aujourd’hui.",
    "No rentals to start today.",
    "لا توجد كراءات لبدئها اليوم.",
  );
  String get ownerRuntimeEmptyToEndToday => _t(
    "Aucune location à rendre aujourd’hui.",
    "No rentals to return today.",
    "لا توجد كراءات لإرجاعها اليوم.",
  );
  String get ownerRuntimeEmptyOngoing => _t(
    "Aucune location en cours pour le moment.",
    "No ongoing rentals for now.",
    "لا توجد كراءات جارية حالياً.",
  );
  String get ownerRuntimeEmptyFinished => _t(
    "Aucune location terminée pour le moment.",
    "No finished rentals for now.",
    "لا توجد كراءات منتهية حالياً.",
  );
  String get ownerRuntimeEmptyNoShow => _t(
    "Aucune location marquée comme non venue.",
    "No rentals marked as no-show.",
    "لا توجد كراءات مُسجلة كعدم حضور.",
  );

  // Global stats chips
  String get ownerRuntimeChipOngoing => _t('En cours', 'Ongoing', 'جارية');
  String get ownerRuntimeChipToStartToday =>
      _t("À démarrer aujourd’hui", "Start today", "يبدأ اليوم");
  String get ownerRuntimeChipToStartTomorrow =>
      _t("À démarrer demain", "Start tomorrow", "يبدأ غداً");
  String get ownerRuntimeChipToEndToday =>
      _t("À rendre aujourd’hui", "Return today", "إرجاع اليوم");
  String get ownerRuntimeChipFinished => _t('Terminées', 'Finished', 'منتهية');

  String get noCarsHereForNow => _t(
    'Aucune voiture ici pour le moment',
    'No cars here for now',
    'لا توجد سيارات هنا حالياً',
  );

  // Dialog no-show
  String get ownerRuntimeNoShowDialogTitle =>
      _t('Marquer comme non venu', 'Mark as no-show', 'تحديد كعدم حضور');
  String get ownerRuntimeNoShowDialogBody => _t(
    'Confirmes-tu que le locataire ne s’est pas présenté ? Cette action marquera la location comme "non venue".',
    'Do you confirm the renter did not show up? This will mark the rental as "no-show".',
    'هل تؤكد أن المستأجر لم يحضر؟ سيتم وضع الكراء كـ "عدم حضور".',
  );

  String get ownerRuntimeNoShowSnackOk => _t(
    'Location marquée comme non venue.',
    'Rental marked as no-show.',
    'تم تحديد الكراء كعدم حضور.',
  );
  String get ownerRuntimeNoShowSnackKo => _t(
    "Impossible de marquer comme non venue.",
    "Unable to mark as no-show.",
    "تعذر تحديدها كعدم حضور.",
  );

  // Generic buttons (si tu n’as pas déjà)
  String get cancel => _t('Annuler', 'Cancel', 'إلغاء');
  String get confirm => _t('Confirmer', 'Confirm', 'تأكيد');

  // Section car
  String get ownerRuntimeNoTitle => _t('Sans titre', 'Untitled', 'بدون عنوان');

  String ownerRuntimeReservationsCount(int n) => _tp(
    '$n réservation${n > 1 ? 's' : ''}',
    '$n booking${n > 1 ? 's' : ''}',
    '${n} حجز',
    {'n': '$n', '_n': '$n'},
  );

  // ====== RUNTIME START / END LOCATION ======
  String get runtimeStartTitle =>
      _t('Démarrer la location', 'Start rental', 'بدء الكراء');
  String get runtimeEndTitle =>
      _t('Clôturer la location', 'End rental', 'إنهاء الكراء');

  String get appName => _t('Winycar', 'Winycar', 'وينى كار');

  // -------- Bookings list (user) --------
  String get myBookingsTitle =>
      _t('Mes réservations', 'My bookings', 'حجوزاتي');

  String get statusAll => _t('Toutes', 'All', 'الكل');
  String get statusPending => _t('En attente', 'Pending', 'قيد الانتظار');
  String get statusConfirmed => _t('Confirmées', 'Confirmed', 'مؤكدة');
  String get statusCanceled => _t('Annulées', 'Canceled', 'ملغاة');
  String get statusNoShow => _t('Non venu(e)', 'No-show', 'لم يحضر');
  String get statusOngoing => _t('En cours', 'Ongoing', 'جارية');
  String get statusFinished => _t('Terminées', 'Finished', 'منتهية');

  String get bookingNotEditable => _t(
    'Cette réservation ne peut plus être modifiée.',
    'This booking can no longer be modified.',
    'لا يمكن تعديل هذا الحجز بعد الآن.',
  );

  String get deleteBookingTitle =>
      _t('Supprimer la réservation', 'Delete booking', 'حذف الحجز');

  String get cancelBookingTitle =>
      _t('Annuler la réservation', 'Cancel booking', 'إلغاء الحجز');

  String get deleteBookingConfirm => _t(
    'Voulez-vous vraiment supprimer cette réservation ?',
    'Do you really want to delete this booking?',
    'هل تريد فعلاً حذف هذا الحجز؟',
  );

  String get cancelBookingConfirm => _t(
    'Voulez-vous vraiment annuler cette réservation ?',
    'Do you really want to cancel this booking?',
    'هل تريد فعلاً إلغاء هذا الحجز؟',
  );

  String get backBtn => _t('Retour', 'Back', 'رجوع');
  String get deleteBtn => _t('Supprimer', 'Delete', 'حذف');
  String get cancelBtn => _t('Annuler', 'Cancel', 'إلغاء');

  String get bookingDeleted =>
      _t('Réservation supprimée.', 'Booking deleted.', 'تم حذف الحجز.');
  String get bookingCanceled =>
      _t('Réservation annulée.', 'Booking canceled.', 'تم إلغاء الحجز.');

  String get noBookingsYet => _t(
    'Aucune réservation pour le moment.',
    'No bookings yet.',
    'لا توجد حجوزات حالياً.',
  );

  String get noBookingsForStatus => _t(
    'Aucune réservation pour ce statut.',
    'No bookings for this status.',
    'لا توجد حجوزات بهذه الحالة.',
  );

  String fromTo(String a, String b) =>
      _t('Du $a au $b', 'From $a to $b', 'من $a إلى $b');

  String get summaryTitle => _t('Récapitulatif', 'Summary', 'ملخص');
  String get placeLabel => _t('Lieu : ', 'Place: ', 'المكان: ');
  String get pricePerDayLabel =>
      _t('Prix / jour : ', 'Price/day: ', 'السعر/يوم: ');
  String get numberOfDaysLabel =>
      _t('Nombre de jours : ', 'Number of days: ', 'عدد الأيام: ');
  String get estimatedTotalLabel =>
      _t('Total estimé : ', 'Estimated total: ', 'الإجمالي التقريبي: ');
  String get phoneNotProvided =>
      _t('Téléphone non renseigné', 'Phone not provided', 'الهاتف غير متوفر');

  String get currencyDay => _t('Da / jour', 'DA / day', 'دج / يوم');
  String get currencyDa => _t('Da', 'DA', 'دج');
  String get currency => _t('M', 'M', 'م');

  // Titres / pages
  String get myFavorites => _t('Mes favoris', 'My favorites', 'مفضلتي');

  String get noFavoritesYet => _t(
    'Aucun favori pour le moment.',
    'No favorites yet.',
    'لا توجد مفضلات حالياً.',
  );

  String get homeNewToday => _t('Nouveautés', 'New today', 'الجديد اليوم');

  String get homeExploreTitle => _t(
    'Découvrez votre prochaine voiture',
    'Discover your next car',
    'اكتشف سيارتك القادمة',
  );

  String get homeExploreSubtitle => _t(
    'Des annonces fraîches, faites pour vous.',
    'Fresh listings picked for you.',
    'إعلانات جديدة تناسبك',
  );

  String get removeFromFavoritesTitle =>
      _t('Retirer des favoris', 'Remove from favorites', 'إزالة من المفضلة');

  String get removeFromFavoritesMsg => _t(
    'Voulez-vous vraiment retirer cette voiture de vos favoris ?',
    'Do you really want to remove this car from your favorites?',
    'هل تريد حقاً إزالة هذه السيارة من المفضلة؟',
  );
  String get addToFavoritesMsg =>
      _t(
        'Voulez-vous ajouter cette voiture à vos favoris ?',
        'Do you want to add this car to your favorites?',
        'هل تريد إضافة هذه السيارة إلى المفضلة؟',
      );


  String get remove => _t('Retirer', 'Remove', 'إزالة');

  // Catégories chips
  String get alle => _t('Toutes', 'All', 'الكل');

  String get cars => _t('Voitures', 'Cars', 'سيارات');

  String get rentals => _t('Locations', 'Rentals', 'كراء');

  // ⚠️ Avec paramètre => méthode (pas get)
  String daPrice(String amount) => _t('$amount DA', '$amount DA', '$amount دج');

  String get actionDelete => _t('Supprimer', 'Delete', 'حذف');
  String get actionCancel => _t('Annuler', 'Cancel', 'إلغاء');

  String get runtimePhotosStartOptional => _t(
    'Photos de départ (optionnel)',
    'Start photos (optional)',
    'صور البداية (اختياري)',
  );
  String get runtimePhotosEndOptional => _t(
    'Photos de fin (optionnel)',
    'End photos (optional)',
    'صور النهاية (اختياري)',
  );

  String get runtimeCarLabel => _t('Voiture', 'Car', 'سيارة');

  String get runtimeRenterFirstName =>
      _t('Prénom du locataire', 'Renter first name', 'اسم المستأجر');
  String get runtimeRenterLastName =>
      _t('Nom du locataire', 'Renter last name', 'لقب المستأجر');
  String get runtimeRenterAddress =>
      _t('Adresse du locataire', 'Renter address', 'عنوان المستأجر');
  String get runtimeRenterPhone =>
      _t('Téléphone du locataire', 'Renter phone', 'هاتف المستأجر');

  String get runtimeBirthdateOptional => _t(
    'Date de naissance (optionnel)',
    'Birthdate (optional)',
    'تاريخ الميلاد (اختياري)',
  );
  String get runtimeSelectDate =>
      _t('Sélectionner une date', 'Select a date', 'اختر تاريخاً');

  String get runtimeKmStart => _t(
    'Kilométrage de départ (km)',
    'Start mileage (km)',
    'عداد البداية (كم)',
  );
  String get runtimeKmEnd =>
      _t('Kilométrage de fin (km)', 'End mileage (km)', 'عداد النهاية (كم)');

  String get requiredField => _t('Obligatoire', 'Required', 'إجباري');
  String get runtimeInvalidMileage =>
      _t('Kilométrage invalide', 'Invalid mileage', 'عداد غير صالح');

  String runtimeMaxPhotosReached(int max) => _tp(
    'Nombre maximum de photos atteint ({max}).',
    'Maximum number of photos reached ({max}).',
    'تم بلوغ الحد الأقصى للصور ({max}).',
    {'max': '$max'},
  );

  String runtimeSomePhotosNotAdded(int max) => _tp(
    'Certaines photos n’ont pas été ajoutées (limite {max}).',
    'Some photos were not added (limit {max}).',
    'لم تتم إضافة بعض الصور (الحد {max}).',
    {'max': '$max'},
  );

  String runtimePickPhotosError(String e) => _tp(
    'Erreur lors de la sélection des photos: {e}',
    'Error selecting photos: {e}',
    'خطأ أثناء اختيار الصور: {e}',
    {'e': e},
  );

  String get runtimeEndKmInvalid => _t(
    'Merci de saisir un kilométrage de fin valide.',
    'Please enter a valid end mileage.',
    'يرجى إدخال عداد نهاية صحيح.',
  );
  String get runtimeEndKmLowerThanStart => _t(
    'Le kilométrage de fin ne peut pas être inférieur au départ.',
    'End mileage cannot be lower than start.',
    'عداد النهاية لا يمكن أن يكون أقل من البداية.',
  );

  String get runtimeStartAllFieldsRequired => _t(
    'Tous les champs (sauf date de naissance) et le kilométrage de départ sont obligatoires.',
    'All fields (except birthdate) and start mileage are required.',
    'جميع الحقول (ما عدا تاريخ الميلاد) وعداد البداية إجبارية.',
  );

  String get runtimeStartFailed => _t(
    'Impossible de démarrer la location.',
    'Unable to start rental.',
    'تعذر بدء الكراء.',
  );
  String get runtimeEndFailed => _t(
    'Impossible de clôturer la location.',
    'Unable to end rental.',
    'تعذر إنهاء الكراء.',
  );

  String get runtimeStartedOk =>
      _t('Location démarrée.', 'Rental started.', 'تم بدء الكراء.');
  String get runtimeEndedOk =>
      _t('Location clôturée.', 'Rental ended.', 'تم إنهاء الكراء.');

  String get timeoutTryAgain => _t(
    'Temps dépassé, réessaie.',
    'Timeout, please try again.',
    'انتهى الوقت، أعد المحاولة.',
  );

  String runtimeGenericError(String e) =>
      _tp('Erreur: {e}', 'Error: {e}', 'خطأ: {e}', {'e': e});

  // Booking status labels
  String get ownerRuntimeStatusConfirmed =>
      _t('Confirmée', 'Confirmed', 'مؤكدة');
  String get ownerRuntimeStatusOngoing => _t('En cours', 'Ongoing', 'جارية');
  String get ownerRuntimeStatusFinished => _t('Terminée', 'Finished', 'منتهية');
  String get ownerRuntimeStatusNoShow => _t('Non venue', 'No-show', 'لم يأت');

  // Contact missing
  String get ownerRuntimePhoneMissing =>
      _t('Téléphone non renseigné', 'Phone not provided', 'الهاتف غير متوفر');
  String get ownerRuntimeEmailMissing =>
      _t('Email non renseigné', 'Email not provided', 'البريد غير متوفر');

  // Photos count
  String ownerRuntimePhotosCount(int start, int end) => _tp(
    '{s} photo(s) départ • {e} photo(s) retour',
    '{s} start photo(s) • {e} end photo(s)',
    '{s} صور البداية • {e} صور النهاية',
    {'s': '$start', 'e': '$end'},
  );

  // Pricing labels
  String get ownerRuntimePricePerDayLabel =>
      _t('Prix / jour : ', 'Price / day: ', 'السعر / يوم: ');
  String get ownerRuntimeTotalLabel => _t('Total : ', 'Total: ', 'المجموع: ');
  String get ownerRuntimeDaysLabel =>
      _t('Nombre de jours : ', 'Days: ', 'عدد الأيام: ');

  String ownerRuntimePricePerDay(String v) =>
      _tp('{v} Da / jour', '{v} DA / day', '{v} دج / يوم', {'v': v});

  String get ownerRuntimePriceOnRequest =>
      _t('Prix sur demande', 'Price on request', 'السعر عند الطلب');

  String ownerRuntimeTotal(String v) =>
      _tp('{v} Da', '{v} DA', '{v} دج', {'v': v});

  String ownerRuntimeDateRange(String start, String end) => _tp(
    'Du {a} au {b}',
    'From {a} to {b}',
    'من {a} إلى {b}',
    {'a': start, 'b': end},
  );

  // Buttons
  String get ownerRuntimeBtnStart =>
      _t('Démarrer la location', 'Start rental', 'بدء الكراء');
  String get ownerRuntimeBtnEnd =>
      _t('Terminer la location', 'End rental', 'إنهاء الكراء');
  String get ownerRuntimeBtnContractPdf =>
      _t('Contrat PDF', 'PDF contract', 'عقد PDF');
  String get ownerRuntimeBtnSummaryPdf =>
      _t('Récapitulatif PDF', 'PDF summary', 'ملخص PDF');
  String get ownerRuntimeBtnNoShow => _t('Pas venu', 'No-show', 'لم يأت');

  // PDF errors
  String ownerRuntimePdfContractError(String e) => _tp(
    'Erreur lors de la génération du contrat : {e}',
    'Error generating contract: {e}',
    'خطأ أثناء إنشاء العقد: {e}',
    {'e': e},
  );

  String ownerRuntimePdfSummaryError(String e) => _tp(
    'Erreur lors de la génération du récapitulatif : {e}',
    'Error generating summary: {e}',
    'خطأ أثناء إنشاء الملخص: {e}',
    {'e': e},
  );

  // ---------- DASHBOARD ----------

  String get dashboard => _t('Tableau de bord', 'Dashboard', 'لوحة التحكم');

  // ---------- COMMON ----------

  String get success => _t('Succès', 'Success', 'نجاح');

  String get selectWilayaCommune => _t(
    'Veuillez sélectionner la wilaya et la commune',
    'Please select the wilaya and the commune',
    'يرجى اختيار الولاية والبلدية',
  );

  String get confirmSignOut => _t(
    'Voulez-vous vraiment vous déconnecter ?',
    'Do you really want to sign out?',
    'هل تريد حقًا تسجيل الخروج؟',
  );

  // ---------- MENU ITEMS ----------

  String get menuHome => _t('Accueil', 'Home', 'الرئيسية');

  String get menuMyCars => _t('Mes voitures', 'My cars', 'سياراتي');

  String get menuFavorites => _t('Mes favoris', 'My favorites', 'المفضلة');

  String get menuBookings => _t('Mes réservations', 'My bookings', 'حجوزاتي');

  String get menuAddCar =>
      _t('Ajouter une voiture', 'Add a car', 'إضافة سيارة');

  String get menuRevenue => _t('Mes revenus', 'My revenue', 'أرباحي');

  String get menuManageBookings =>
      _t('Gérer mes réservations', 'Manage my bookings', 'إدارة الحجوزات');

  String get menuManageRentals =>
      _t('Gérer les locations', 'Manage rentals', 'إدارة التأجير');

  // ---------- TITLES ----------

  String get titleHome => _t('WinyCar', 'WinyCar', 'WinyCar');

  String get titleMyCars => _t('Mes voitures', 'My cars', 'سياراتي');

  String get titleFavorites => _t('Mes favoris', 'My favorites', 'المفضلة');

  String get titleBookings => _t('Mes réservations', 'My bookings', 'حجوزاتي');

  String get titleAddCar =>
      _t('Ajouter une voiture', 'Add a car', 'إضافة سيارة');

  String get titleRevenue => _t('Mes revenus', 'My revenue', 'أرباحي');

  String get titleManageBookings =>
      _t('Gérer mes réservations', 'Manage my bookings', 'إدارة الحجوزات');

  String get titleManageRentals =>
      _t('Gérer les locations', 'Manage rentals', 'إدارة التأجير');

  String get commonDash => '-';
  String get passwordMustContainUppercase => _t(
    'Le mot de passe doit contenir au moins une majuscule',
    'Password must contain at least one uppercase letter',
    'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل',
  );

  String get passwordMustContainNumber => _t(
    'Le mot de passe doit contenir au moins un chiffre',
    'Password must contain at least one number',
    'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل',
  );

  String get startSearch =>
      _t('Démarrer la recherche', 'Start search', 'بدء البحث');

  String get emptyNothingToShow =>
      _t('Rien à afficher', 'Nothing to show', 'لا يوجد ما يُعرض');

  String get emptyNoCarsAvailable => _t(
    'Aucune voiture disponible pour le moment',
    'No cars available at the moment',
    'لا توجد سيارات متاحة في الوقت الحالي',
  );

  // ===== Filters / Drawer =====
  String get fFilters => _t('Filtres', 'Filters', 'الفلاتر');
  String get fRentalFilters =>
      _t('Filtres location', 'Rental filters', 'فلاتر التأجير');
  String get fAdvancedSearch =>
      _t('Recherche avancée', 'Advanced search', 'بحث متقدم');
  String get fAdvancedRental => _t(
    'Recherche avancée location',
    'Advanced rental search',
    'بحث متقدم للتأجير',
  );

  // Reservation / Booking
  String get rLoginRequiredToBook => _t(
    'Veuillez vous connecter pour réserver.',
    'Please sign in to make a booking.',
    'يرجى تسجيل الدخول لإجراء حجز.',
  );

  String get rChooseDates => _t(
    'Choisissez vos dates',
    'Choose your dates',
    'اختر تواريخك',
  );

  String get rContinue => _t(
    'Continuer',
    'Continue',
    'متابعة',
  );

  String get rEndAfterStartError => _t(
    'La date de fin doit être après la date de début.',
    'End date must be after start date.',
    'يجب أن يكون تاريخ الانتهاء بعد تاريخ البدء.',
  );

  String get rConfirmBookingTitle => _t(
    'Confirmer la réservation',
    'Confirm booking',
    'تأكيد الحجز',
  );

  String get rVehicleLabel => _t(
    'Véhicule :',
    'Vehicle:',
    'المركبة:',
  );

  String get rFromLabel => _t(
    'Du :',
    'From:',
    'من:',
  );

  String get rToLabel => _t(
    'Au :',
    'To:',
    'إلى:',
  );

  String get rPendingInfo => _t(
    "Votre demande sera envoyée en 'en attente' au propriétaire.",
    "Your request will be sent to the owner as 'pending'.",
    "سيتم إرسال طلبك إلى المالك بحالة 'قيد الانتظار'.",
  );

  String get rCancel => _t(
    'Annuler',
    'Cancel',
    'إلغاء',
  );

  String get rConfirm => _t(
    'Confirmer',
    'Confirm',
    'تأكيد',
  );

  String get rRequestSent => _t(
    'Demande de réservation envoyée !',
    'Booking request sent!',
    'تم إرسال طلب الحجز!',
  );

  String get rBookingImpossible => _t(
    'Réservation impossible.',
    'Booking failed.',
    'تعذر إتمام الحجز.',
  );

  String rHttpError(int code) => _t(
    'Erreur HTTP $code',
    'HTTP error $code',
    'خطأ HTTP $code',
  );

  String rError(String e) => _t(
    'Erreur: $e',
    'Error: $e',
    'خطأ: $e',
  );

  String get fCategories => _t('Catégories', 'Categories', 'الفئات');
  String get fBrands => _t('Marques', 'Brands', 'العلامات');
  String get fModels => _t('Modèles', 'Models', 'الموديلات');
  String get fSelectBrandFirst =>
      _t('Sélectionnez une marque', 'Select a brand', 'اختر علامة أولاً');

  String get fWilayas => _t('Wilayas', 'Wilayas', 'الولايات');
  String get fEnergies => _t('Énergies', 'Fuel types', 'الوقود');
  String get fTransmission => _t('Transmission', 'Transmission', 'ناقل الحركة');

  String get fRentalPeriod =>
      _t('Période de location', 'Rental period', 'مدة التأجير');
  String get fStart => _t('Début', 'Start', 'البداية');
  String get fEnd => _t('Fin', 'End', 'النهاية');

  String get fPriceDaPerDay =>
      _t('Prix (DA / jour)', 'Price (DA / day)', 'السعر (دج / يوم)');
  String get fPriceMillions =>
      _t('Prix (Millions)', 'Price (Millions)', 'السعر (مليون)');
  String get fMin => _t('Min', 'Min', 'الأدنى');
  String get fMax => _t('Max', 'Max', 'الأقصى');

  String get fPowerCv => _t('Puissance (CV)', 'Power (HP)', 'القوة (حصان)');

  String get fReset => _t('Réinitialiser', 'Reset', 'إعادة ضبط');
  String get fApply => _t('Appliquer', 'Apply', 'تطبيق');

  String get fSearch => _t('Rechercher…', 'Search…', 'بحث…');
  String get fClearAll => _t('Tout effacer', 'Clear all', 'مسح الكل');
  String get fOk => _t('OK', 'OK', 'حسناً');

  String fSelectedCount(int n) =>
      _tp('{n} sélection(s)', '{n} selected', '{n} محدد', {'n': '$n'});

  // ===== Accueil / Search bar / Segments =====
  String get homeTabCars => _t('Voitures', 'Cars', 'سيارات');
  String get homeTabRental => _t('Location', 'Rental', 'كراء');

  String get homeFilters => _t('Filtres', 'Filters', 'الفلاتر');

  String get homeStart => _t('Début', 'Start', 'البداية');
  String get homeEnd => _t('Fin', 'End', 'النهاية');

  String get homeSearchHint => _t(
    'Rechercher un modèle, une marque…',
    'Search a model, a brand…',
    'ابحث عن موديل أو علامة…',
  );

  String get homeSearch => _t('Rechercher', 'Search', 'بحث');

  String get homeClear => _t('Effacer', 'Clear', 'مسح');
  String get menuPartnerProfile =>
      _t('Profil Pro', 'Pro profile', 'الملف المهني');

  String get menuBecomePro =>
      _t('Devenir Pro', 'Become Pro', 'التحول إلى محترف');

  String get menuReferral =>
      _t('Parrainage', 'Referral', 'الإحالة');

  String get menuOffers =>
      _t('Offres', 'Offers', 'العروض');

  // ---------------- Prix / Unités ----------------

  /// Million
  String get unitMillion => _t('M', 'M', 'مليون');

  /// Dinar algérien / jour
  String get unitDinarPerDay => _t('DA / Jour', 'DZD / Day', 'دج / يوم');

  // ================= CAR DETAILS =================
  String get favorites => _t('Favoris', 'Favorites', 'المفضلة');

  // ================= CAR DETAILS MOBILE =================
  String get downloadPdf => _t(
    'Télécharger la fiche technique',
    'Download technical sheet',
    'تحميل البطاقة التقنية',
  );

  String get rent => _t('Louer', 'Rent', 'استئجار');

  // ===== CAR DETAILS CARD / SECTIONS =====
  String get cdInfoTitle => _t('Informations', 'Information', 'معلومات');
  String get cdVerifiedSeller =>
      _t('Vendeur vérifié', 'Verified seller', 'بائع موثوق');
  String get cdTestPossible =>
      _t('Essai possible', 'Test drive possible', 'إمكانية التجربة');

  String get cdSpecsTitle =>
      _t('Caractéristiques', 'Specifications', 'المواصفات');
  String get cdFuel => _t('Carburant', 'Fuel', 'الوقود');
  String get cdGearbox => _t('Boîte', 'Gearbox', 'علبة السرعة');
  String get cdMileage => _t('Kilométrage', 'Mileage', 'عدد الكيلومترات');
  String get cdYear => _t('Année', 'Year', 'السنة');
  String get cdBrand => _t('Marque', 'Brand', 'العلامة');
  String get cdModel => _t('Modèle', 'Model', 'الطراز');
  String get cdPlate => _t('Immatriculation', 'Plate number', 'رقم التسجيل');
  String get cdPhone => _t('Téléphone', 'Phone', 'الهاتف');
  String get cdEngine => _t('Moteur', 'Engine', 'المحرك');
  String get cdPower => _t('Puissance', 'Power', 'القوة');
  String get cdCategory => _t('Catégorie', 'Category', 'الفئة');
  String get cdAddedOn => _t('Ajouté le', 'Added on', 'تاريخ الإضافة');

  String get cdDescriptionTitle => _t('Description', 'Description', 'الوصف');
  String get cdSeeMore => _t('Voir plus', 'See more', 'عرض المزيد');
  String get cdSeeLess => _t('Voir moins', 'See less', 'عرض أقل');

  String get cdOptionsTitle => _t('Options', 'Options', 'الخيارات');
  String get cdSeeAll => _t('Voir tout', 'See all', 'عرض الكل');

  String get cdContactTitle => _t('Contact', 'Contact', 'التواصل');
  String get cdCall => _t('Appeler', 'Call', 'اتصال');
  String get cdMessage => _t('Message', 'Message', 'رسالة');
  String get cdSetDates =>
      _t('Définir les dates', 'Set dates', 'تحديد التواريخ');

  String get cdSetDatesFirst =>
      _t('Réserver', 'Reserve', 'احجز');

  // ===== INFO VALUES (category / ribbons) =====
  String get cdCategoryRental => _t('Location', 'Rental', 'كراء');
  String get cdCategoryNew => _t('Neuf', 'New', 'جديد');
  String get cdCategoryUsed => _t('Occasion', 'Used', 'مستعمل');
  String get cdCategoryLess3 => _t('-3 ans', '<3 years', 'أقل من 3 سنوات');
  String get cdCategoryLess5 => _t('-5 ans', '<5 years', 'أقل من 5 سنوات');
  String get cdCategoryImport => _t('Import', 'Import', 'استيراد');

  String get cdRibbonFixed => _t('Prix fixe', 'Fixed price', 'سعر ثابت');
  String get cdRibbonNegotiable =>
      _t('Négociable', 'Negotiable', 'قابل للتفاوض');
  String get cdRibbonPromo => _t('Promotion', 'Promotion', 'عرض');

  String get favLoginRequired => _t(
    'Veuillez vous connecter pour gérer vos favoris.',
    'Please sign in to manage your favorites.',
    'يرجى تسجيل الدخول لإدارة المفضلة.',
  );

  String get favRemoveNotFound => _t(
    'Impossible de trouver ce favori à supprimer.',
    'Unable to find this favorite to remove.',
    'تعذر العثور على هذا المفضّل لإزالته.',
  );

  String get favRemovedDefault =>
      _t('Favori retiré.', 'Favorite removed.', 'تمت الإزالة من المفضلة.');
  String get favAddedDefault => _t(
    'Ajouté aux favoris.',
    'Added to favorites.',
    'تمت الإضافة إلى المفضلة.',
  );

  // ===== Direction =====
  bool get isRtl => lang == AppLanguage.ar;

  /// Unité kilomètre
  String get unitKm => _t('km', 'km', 'كم');

  // ================= SUPPORT =================
  String get supportTitle => _t('Support', 'Support', 'الدعم');
  String get supportSubtitle => _t(
    'Contactez-nous uniquement par email.',
    'Contact us by email only.',
    'تواصل معنا عبر البريد الإلكتروني فقط.',
  );

  String get supportOpenFail =>
      _t("Impossible d'ouvrir {url}", "Unable to open {url}", "تعذر فتح {url}");

  String get supportMailSubject =>
      _t('Support WinyCar', 'WinyCar Support', 'دعم WinyCar');

  String get supportSnackEmailReady => _t(
    'Votre email est prêt à être envoyé.',
    'Your email is ready to be sent.',
    'رسالتك جاهزة للإرسال.',
  );

  // ================= TERMS =================
  String get termsTitle =>
      _t('Conditions d’utilisation', 'Terms of Use', 'شروط الاستخدام');
  String get termsLastUpdate => _t(
    'Dernière mise à jour : 12/12/2025',
    'Last update: 12/12/2025',
    'آخر تحديث: 12/12/2025',
  );

  String get termsIntro => _t(
    'Les présentes Conditions d’utilisation (ci-après « Conditions ») encadrent l’accès et l’utilisation de l’application WinyCar (ci-après « l’Application ») et des services associés.',
    'These Terms of Use govern access to and use of the WinyCar application (the “App”) and related services.',
    'تنظم شروط الاستخدام هذه الوصول إلى تطبيق WinyCar (يُشار إليه بـ "التطبيق") واستخدامه والخدمات المرتبطة به.',
  );

  String get termsS1Title => _t(
    '1. Objet de l’Application',
    '1. Purpose of the App',
    '1. هدف التطبيق',
  );
  String get termsS1Body => _t(
    'WinyCar est une plateforme permettant aux entreprises (loueurs, vendeurs ou gestionnaires de flotte) de publier des annonces de véhicules, gérer leur parc automobile, gérer les réservations, les clients et les opérations liées à la location/vente. Les utilisateurs clients peuvent consulter les véhicules et effectuer des demandes ou réservations selon les fonctionnalités disponibles.',
    'WinyCar is a platform that enables businesses (rentals, sellers or fleet managers) to publish vehicle listings, manage their fleet, bookings, customers and operations related to rental/sale. Customer users can browse vehicles and submit requests or bookings depending on available features.',
    'WinyCar منصة تُمكّن الشركات (المؤجرين أو البائعين أو مديري الأسطول) من نشر إعلانات المركبات وإدارة الأسطول والحجوزات والعملاء والعمليات المتعلقة بالإيجار/البيع. ويمكن للمستخدمين العملاء تصفح المركبات وتقديم طلبات أو حجوزات حسب الميزات المتاحة.',
  );

  String get termsS2Title => _t(
    '2. Comptes et accès',
    '2. Accounts and access',
    '2. الحسابات والوصول',
  );
  String get termsS2B1 => _t(
    'L’accès à certaines fonctionnalités nécessite la création d’un compte.',
    'Access to certain features requires creating an account.',
    'يتطلب الوصول إلى بعض الميزات إنشاء حساب.',
  );
  String get termsS2B2 => _t(
    'Vous vous engagez à fournir des informations exactes et à les maintenir à jour.',
    'You agree to provide accurate information and keep it up to date.',
    'تتعهد بتقديم معلومات صحيحة وتحديثها.',
  );
  String get termsS2B3 => _t(
    'Vous êtes responsable de la confidentialité de vos identifiants et de toute activité effectuée via votre compte.',
    'You are responsible for keeping your credentials confidential and for all activity under your account.',
    'أنت مسؤول عن سرية بيانات الدخول وعن أي نشاط يتم عبر حسابك.',
  );
  String get termsS2B4 => _t(
    'Les comptes « Entreprise » sont réservés à un usage professionnel.',
    '“Business” accounts are intended for professional use only.',
    'حسابات "الشركات" مخصصة للاستخدام المهني فقط.',
  );

  String get termsS3Title => _t(
    '3. Règles de publication (Entreprises)',
    '3. Posting rules (Businesses)',
    '3. قواعد النشر (للشركات)',
  );
  String get termsS3B1 => _t(
    'Les annonces publiées doivent être exactes, complètes et non trompeuses (prix, disponibilité, description, photos).',
    'Posted listings must be accurate, complete and not misleading (price, availability, description, photos).',
    'يجب أن تكون الإعلانات المنشورة دقيقة وكاملة وغير مضللة (السعر، التوفر، الوصف، الصور).',
  );
  String get termsS3B2 => _t(
    'Vous garantissez disposer des droits nécessaires sur les contenus publiés (photos, textes, logos).',
    'You guarantee you have the necessary rights to the posted content (photos, text, logos).',
    'تضمن امتلاكك الحقوق اللازمة للمحتوى المنشور (صور، نصوص، شعارات).',
  );
  String get termsS3B3 => _t(
    'Il est interdit de publier du contenu illégal, frauduleux, haineux ou portant atteinte aux droits de tiers.',
    'It is forbidden to post illegal, fraudulent, hateful content or content infringing third-party rights.',
    'يُمنع نشر محتوى غير قانوني أو احتيالي أو يحض على الكراهية أو ينتهك حقوق الآخرين.',
  );

  String get termsS4Title => _t(
    '4. Réservations et transactions',
    '4. Bookings and transactions',
    '4. الحجوزات والمعاملات',
  );
  String get termsS4Body => _t(
    'WinyCar peut faciliter la mise en relation entre entreprises et clients. Sauf mention contraire, les contrats de location ou de vente sont conclus directement entre l’entreprise et le client. Chaque partie reste responsable du respect de ses obligations légales et contractuelles.',
    'WinyCar may facilitate connections between businesses and customers. Unless stated otherwise, rental or sales contracts are concluded directly between the business and the customer. Each party remains responsible for complying with its legal and contractual obligations.',
    'قد تسهّل WinyCar التواصل بين الشركات والعملاء. ما لم يُذكر خلاف ذلك، تُبرم عقود الإيجار أو البيع مباشرة بين الشركة والعميل. وتظل كل جهة مسؤولة عن الالتزام بواجباتها القانونية والتعاقدية.',
  );

  String get termsS5Title => _t(
    '5. Comportements interdits',
    '5. Prohibited conduct',
    '5. السلوكيات المحظورة',
  );
  String get termsS5B1 => _t(
    'Créer des comptes ou informations fictifs, usurper l’identité d’un tiers.',
    'Create fake accounts or information, impersonate a third party.',
    'إنشاء حسابات أو معلومات وهمية أو انتحال هوية الغير.',
  );
  String get termsS5B2 => _t(
    'Tenter d’accéder à des comptes ou données sans autorisation.',
    'Attempt to access accounts or data without authorization.',
    'محاولة الوصول إلى حسابات أو بيانات دون إذن.',
  );
  String get termsS5B3 => _t(
    'Perturber, surcharger ou contourner les mesures de sécurité de l’Application.',
    'Disrupt, overload or bypass the App’s security measures.',
    'تعطيل أو إرهاق أو تجاوز إجراءات أمان التطبيق.',
  );
  String get termsS5B4 => _t(
    'Utiliser l’Application à des fins illégales ou non autorisées.',
    'Use the App for illegal or unauthorized purposes.',
    'استخدام التطبيق لأغراض غير قانونية أو غير مصرح بها.',
  );

  String get termsS6Title => _t(
    '6. Données et confidentialité',
    '6. Data and privacy',
    '6. البيانات والخصوصية',
  );
  String get termsS6Body => _t(
    'Le traitement des données personnelles est décrit dans la Politique de confidentialité. En utilisant l’Application, vous acceptez le traitement de vos données conformément à cette politique.',
    'Personal data processing is described in the Privacy Policy. By using the App, you agree to the processing of your data under that policy.',
    'يتم وصف معالجة البيانات الشخصية في سياسة الخصوصية. باستخدامك للتطبيق، فإنك توافق على معالجة بياناتك وفقًا لهذه السياسة.',
  );

  String get termsS7Title => _t(
    '7. Disponibilité et maintenance',
    '7. Availability and maintenance',
    '7. التوفر والصيانة',
  );
  String get termsS7Body => _t(
    'Nous faisons de notre mieux pour assurer la disponibilité de l’Application. Toutefois, des interruptions peuvent survenir (maintenance, mises à jour, incidents techniques).',
    'We do our best to keep the App available. However, interruptions may occur (maintenance, updates, technical incidents).',
    'نبذل قصارى جهدنا لضمان توفر التطبيق، ومع ذلك قد تحدث انقطاعات (صيانة، تحديثات، أعطال تقنية).',
  );

  String get termsS8Title => _t(
    '8. Limitation de responsabilité',
    '8. Limitation of liability',
    '8. تحديد المسؤولية',
  );
  String get termsS8Body => _t(
    'Dans les limites autorisées par la loi, WinyCar ne saurait être tenu responsable des dommages indirects ou des litiges résultant des transactions conclues entre entreprises et clients, ni des informations publiées par les utilisateurs.',
    'To the extent permitted by law, WinyCar is not liable for indirect damages or disputes arising from transactions between businesses and customers, or for information posted by users.',
    'ضمن الحدود التي يسمح بها القانون، لا تتحمل WinyCar مسؤولية الأضرار غير المباشرة أو النزاعات الناتجة عن المعاملات بين الشركات والعملاء، ولا عن المعلومات التي ينشرها المستخدمون.',
  );

  String get termsS9Title =>
      _t('9. Résiliation', '9. Termination', '9. الإنهاء');
  String get termsS9Body => _t(
    'Nous pouvons suspendre ou supprimer un compte en cas de violation des présentes Conditions ou d’usage abusif de l’Application. Vous pouvez demander la suppression de votre compte via le Support.',
    'We may suspend or delete an account in case of violation of these Terms or abusive use of the App. You may request account deletion via Support.',
    'قد نقوم بتعليق الحساب أو حذفه في حال انتهاك هذه الشروط أو سوء استخدام التطبيق. يمكنك طلب حذف حسابك عبر الدعم.',
  );

  String get termsS10Title => _t('10. Contact', '10. Contact', '10. التواصل');
  String get termsS10Body => _t(
    'Pour toute question, réclamation ou demande d’assistance :',
    'For any question, complaint or support request:',
    'لأي سؤال أو شكوى أو طلب مساعدة:',
  );
  String get termsContactEmail => _t(
    'Email : support@winycar.com',
    'Email: support@winycar.com',
    'البريد الإلكتروني: support@winycar.com',
  );
  String get termsContactSupport => _t(
    'Page Support : https://winycar.com/support',
    'Support page: https://winycar.com/support',
    'صفحة الدعم: https://winycar.com/support',
  );

// ================= PRIVACY POLICY – EXTRAS =================

  String get privacySection10Title =>
      _t('Autorisations de l’application', 'App Permissions', 'أذونات التطبيق');

  String get privacySection10Body =>
      _t(
        'L’application peut demander l’accès à la caméra et aux photos afin de permettre l’ajout d’images. Ces autorisations sont facultatives et peuvent être modifiées dans les réglages du téléphone.',
        'The app may request access to the camera and photos to allow image uploads. These permissions are optional and can be changed in device settings.',
        'قد يطلب التطبيق إذن الوصول إلى الكاميرا والصور من أجل تحميل الصور. هذه الأذونات اختيارية ويمكن تعديلها من إعدادات الهاتف.',
      );

  String get privacySection11Title =>
      _t('Conservation des données', 'Data Retention', 'الاحتفاظ بالبيانات');

  String get privacySection11Body =>
      _t(
        'Les données personnelles sont conservées uniquement le temps nécessaire au fonctionnement du service et au respect des obligations légales.',
        'Personal data is kept only for as long as necessary to operate the service and comply with legal obligations.',
        'يتم الاحتفاظ بالبيانات الشخصية فقط للمدة اللازمة لتشغيل الخدمة والامتثال للالتزامات القانونية.',
      );

  String get privacySection12Title =>
      _t('Vos droits', 'Your Rights', 'حقوقك');

  String get privacySection12Body =>
      _t(
        'Vous pouvez demander l’accès, la modification ou la suppression de vos données personnelles en contactant le support.',
        'You may request access, modification, or deletion of your personal data by contacting support.',
        'يمكنك طلب الوصول إلى بياناتك الشخصية أو تعديلها أو حذفها عن طريق التواصل مع الدعم.',
      );

  String get privacySection13Title =>
      _t('Transfert des données', 'Data Transfer', 'نقل البيانات');

  String get privacySection13Body =>
      _t(
        'Les données peuvent être traitées ou hébergées en dehors de votre pays avec des mesures de protection appropriées.',
        'Data may be processed or hosted outside your country with appropriate safeguards.',
        'قد تتم معالجة أو استضافة البيانات خارج بلدك مع تطبيق إجراءات حماية مناسبة.',
      );

  String get privacySection14Title =>
      _t('Utilisation par les mineurs', 'Use by Minors', 'استخدام القُصّر');

  String get privacySection14Body =>
      _t(
        'L’application est destinée au grand public et peut être utilisée par des mineurs sous la responsabilité d’un parent ou tuteur légal.',
        'The app is intended for the general public and may be used by minors under parental or legal guardian supervision.',
        'التطبيق موجه للجمهور العام ويمكن استخدامه من قبل القُصّر تحت إشراف أحد الوالدين أو الوصي القانوني.',
      );

  // ================= TERMS (ADD THESE KEYS) =================
// 👉 Ajoute ces getters dans WinyCar (AppLanguage.dart)
// Format respecté: String get xxx => _t('FR', 'EN', 'AR');

  String get termsS11Title => _t(
    '11. Éligibilité et utilisation par les mineurs',
    '11. Eligibility and minors',
    '11. الأهلية واستخدام القُصّر',
  );

  String get termsS11Body => _t(
    'L’Application est destinée à un usage général. Si vous êtes mineur, vous devez obtenir l’autorisation de votre parent ou tuteur légal avant de créer un compte ou d’utiliser les Services. L’entreprise ou le parent/tuteur demeure responsable de l’usage effectué via le compte.',
    'The App is intended for general use. If you are a minor, you must obtain permission from a parent or legal guardian before creating an account or using the Services. The business or the parent/guardian remains responsible for usage performed through the account.',
    'التطبيق مخصص للاستخدام العام. إذا كنت قاصرًا، يجب الحصول على إذن من الوالد أو الوصي القانوني قبل إنشاء حساب أو استخدام الخدمات. وتظل الشركة أو الوالد/الوصي مسؤولًا عن الاستخدام الذي يتم عبر الحساب.',
  );

  String get termsS12Title => _t(
    '12. Propriété intellectuelle et contenus',
    '12. Intellectual property and content',
    '12. الملكية الفكرية والمحتوى',
  );

  String get termsS12Body => _t(
    'L’Application, son design, ses marques, logos et contenus (hors contenus publiés par les utilisateurs) sont protégés et appartiennent à WinyCar ou à ses partenaires. Vous conservez vos droits sur les contenus que vous publiez, mais vous accordez à WinyCar une licence non exclusive, mondiale et gratuite pour héberger, afficher, reproduire et diffuser ces contenus uniquement aux fins de fonctionnement et de promotion de l’Application. Vous garantissez disposer des droits nécessaires sur les contenus publiés.',
    'The App, its design, trademarks, logos and content (excluding user-posted content) are protected and belong to WinyCar or its partners. You keep your rights to the content you post, but you grant WinyCar a non-exclusive, worldwide, royalty-free license to host, display, reproduce and distribute such content solely for operating and promoting the App. You warrant you have the necessary rights to the posted content.',
    'التطبيق وتصميمه وعلاماته التجارية وشعاراته ومحتواه (باستثناء محتوى المستخدم) محمية وتعود ملكيتها إلى WinyCar أو شركائها. تحتفظ بحقوقك في المحتوى الذي تنشره، لكنك تمنح WinyCar ترخيصًا غير حصري وعالميًا ومجانيًا لاستضافة هذا المحتوى وعرضه ونسخه ونشره فقط لأغراض تشغيل التطبيق والترويج له. وتضمن امتلاكك الحقوق اللازمة للمحتوى المنشور.',
  );

  String get termsS13Title => _t(
    '13. Modération, signalement et retrait',
    '13. Moderation, reporting and removal',
    '13. الإشراف والإبلاغ والإزالة',
  );

  String get termsS13Body => _t(
    'WinyCar peut, sans obligation, modérer et retirer tout contenu ou suspendre un compte en cas de non-respect des Conditions, de signalement crédible, d’activité suspecte ou de contenu illégal. Vous pouvez signaler un contenu ou un utilisateur via le Support. Nous pouvons demander des informations complémentaires pour traiter un signalement.',
    'WinyCar may, without obligation, moderate and remove content or suspend an account in case of breach of the Terms, credible reports, suspicious activity or illegal content. You can report content or a user via Support. We may request additional information to process a report.',
    'قد تقوم WinyCar، دون التزام، بالإشراف على المحتوى وإزالته أو تعليق الحساب عند مخالفة الشروط، أو وجود بلاغ موثوق، أو نشاط مشبوه، أو محتوى غير قانوني. يمكنك الإبلاغ عن محتوى أو مستخدم عبر الدعم. قد نطلب معلومات إضافية لمعالجة البلاغ.',
  );

  String get termsS14Title => _t(
    '14. Droit applicable et modifications des Conditions',
    '14. Governing law and changes to the Terms',
    '14. القانون المطبق وتعديلات الشروط',
  );

  String get termsS14Body => _t(
    'Les présentes Conditions peuvent être mises à jour à tout moment. La date de “Dernière mise à jour” indique la version en vigueur. En continuant à utiliser l’Application après une mise à jour, vous acceptez la version révisée. Sauf dispositions impératives contraires, les Conditions sont régies par le droit applicable au siège de l’éditeur. En cas de litige, les parties chercheront d’abord une solution amiable via le Support.',
    'These Terms may be updated at any time. The “Last update” date indicates the current version. By continuing to use the App after an update, you accept the revised version. Unless mandatory rules provide otherwise, the Terms are governed by the law applicable to the publisher’s registered office. In case of dispute, the parties will first seek an amicable solution via Support.',
    'يمكن تحديث هذه الشروط في أي وقت. يشير تاريخ “آخر تحديث” إلى النسخة المعمول بها. من خلال الاستمرار في استخدام التطبيق بعد التحديث، فإنك توافق على النسخة المعدلة. ما لم تنص القوانين الإلزامية على خلاف ذلك، تخضع الشروط للقانون المطبق على مقر الناشر. في حال النزاع، يسعى الطرفان أولاً إلى حل ودي عبر الدعم.',
  );


  // Chips (utilisés en bas)
  String get chipSupport => _t('Support', 'Support', 'الدعم');
  String get chipPrivacy => _t('Confidentialité', 'Privacy', 'الخصوصية');
  String get chipHome => _t('Accueil', 'Home', 'الرئيسية');

  String get supportInfoTitle =>
      _t('Contact support', 'Support contact', 'الاتصال بالدعم');
  String get supportSendEmail =>
      _t('Envoyer un email', 'Send an email', 'إرسال بريد إلكتروني');

  String get supportNameLabel => _t('Nom', 'Name', 'الاسم');
  String get supportNameHint => _t('Votre nom', 'Your name', 'اسمك');
  String get supportNameRequired =>
      _t('Le nom est requis', 'Name is required', 'الاسم مطلوب');

  String get supportEmailLabel => _t('Email', 'Email', 'البريد الإلكتروني');
  String get supportEmailHint => _t(
    'ex: client@winycar.com',
    'e.g. client@winycar.com',
    'مثال: client@winycar.com',
  );
  String get supportEmailRequired =>
      _t('Email requis', 'Email required', 'البريد الإلكتروني مطلوب');
  String get supportEmailInvalid =>
      _t('Email invalide', 'Invalid email', 'بريد إلكتروني غير صالح');

  String get supportMessageLabel => _t('Message', 'Message', 'الرسالة');
  String get supportMessageHint =>
      _t('Expliquez votre problème…', 'Describe your issue…', 'اشرح مشكلتك…');
  String get supportMessageRequired =>
      _t('Message requis', 'Message is required', 'الرسالة مطلوبة');

  String get supportPrepareEmail =>
      _t('Préparer l’email', 'Prepare email', 'تحضير البريد');

  String get supportChipWebsite =>
      _t('Support (site)', 'Support (website)', 'الدعم (الموقع)');
  String get supportChipTerms =>
      _t('Règles d’utilisation', 'Terms of use', 'شروط الاستخدام');
  String get supportChipPrivacy => _t('Confidentialité', 'Privacy', 'الخصوصية');

  // ===== COMMON NAV LABELS =====
  String get home => _t('Accueil', 'Home', 'الرئيسية');
  String get signInLabel => _t('Se connecter', 'Sign in', 'تسجيل الدخول');
  String get signInOrCreateAccount =>
      _t('Connexion / Inscription', 'Sign in / Sign up', 'تسجيل الدخول / إنشاء حساب');


  String get signUpLabel => _t('Créer un compte', 'Sign up', 'إنشاء حساب');
  // ================= PRIVACY POLICY =================

  String get privacyTitle =>
      _t('Politique de confidentialité', 'Privacy Policy', 'سياسة الخصوصية');

  String get privacyLastUpdate => _t(
    'Dernière mise à jour : 12/12/2025',
    'Last update: 12/12/2025',
    'آخر تحديث: 12/12/2025',
  );

  String get privacyIntro => _t(
    'La présente Politique de confidentialité décrit la manière dont WinyCar collecte, utilise et protège les données personnelles des utilisateurs de l’application.',
    'This Privacy Policy describes how WinyCar collects, uses and protects users personal data.',
    'توضح سياسة الخصوصية هذه كيفية جمع واستخدام وحماية البيانات الشخصية لمستخدمي تطبيق WinyCar.',
  );

  // -------- Section 1
  String get privacySection1Title => _t(
    '1. Données collectées',
    '1. Collected data',
    '1. البيانات التي يتم جمعها',
  );

  String get privacySection1Bullet1 => _t(
    'Informations d’identification : nom, email, numéro de téléphone.',
    'Identification information: name, email, phone number.',
    'معلومات التعريف: الاسم، البريد الإلكتروني، رقم الهاتف.',
  );

  String get privacySection1Bullet2 => _t(
    'Informations liées aux comptes entreprise et client.',
    'Business and customer account information.',
    'معلومات حسابات الشركات والعملاء.',
  );

  String get privacySection1Bullet3 => _t(
    'Données relatives aux véhicules, réservations et transactions.',
    'Data related to vehicles, bookings and transactions.',
    'البيانات المتعلقة بالمركبات والحجوزات والمعاملات.',
  );

  String get privacySection1Bullet4 => _t(
    'Données techniques : type d’appareil, système d’exploitation (à des fins de sécurité et de performance).',
    'Technical data: device type, operating system (for security and performance purposes).',
    'البيانات التقنية: نوع الجهاز ونظام التشغيل (لأغراض الأمان والأداء).',
  );

  // -------- Section 2
  String get privacySection2Title =>
      _t('2. Utilisation des données', '2. Use of data', '2. استخدام البيانات');

  String get privacySection2Bullet1 => _t(
    'Fournir et améliorer les fonctionnalités de l’application.',
    'Provide and improve application features.',
    'تقديم وتحسين ميزات التطبيق.',
  );

  String get privacySection2Bullet2 => _t(
    'Gérer les comptes, réservations et relations entre entreprises et clients.',
    'Manage accounts, bookings and relationships between businesses and customers.',
    'إدارة الحسابات والحجوزات والعلاقات بين الشركات والعملاء.',
  );

  String get privacySection2Bullet3 => _t(
    'Communiquer avec les utilisateurs (support, notifications importantes).',
    'Communicate with users (support, important notifications).',
    'التواصل مع المستخدمين (الدعم، الإشعارات المهمة).',
  );

  String get privacySection2Bullet4 => _t(
    'Respecter les obligations légales et réglementaires.',
    'Comply with legal and regulatory obligations.',
    'الامتثال للالتزامات القانونية والتنظيمية.',
  );

  // -------- Section 3
  String get privacySection3Title =>
      _t('3. Partage des données', '3. Data sharing', '3. مشاركة البيانات');

  String get privacySection3Intro => _t(
    'Les données personnelles ne sont jamais vendues. Elles peuvent être partagées uniquement avec :',
    'Personal data is never sold. It may only be shared with:',
    'لا يتم بيع البيانات الشخصية أبدًا. وقد تتم مشاركتها فقط مع:',
  );

  String get privacySection3Bullet1 => _t(
    'Les entreprises concernées dans le cadre des réservations.',
    'Concerned companies within the scope of bookings.',
    'الشركات المعنية في إطار الحجوزات.',
  );

  String get privacySection3Bullet2 => _t(
    'Les prestataires techniques nécessaires au fonctionnement du service.',
    'Technical service providers required to operate the service.',
    'مقدمي الخدمات التقنية اللازمة لتشغيل الخدمة.',
  );

  String get privacySection3Bullet3 => _t(
    'Les autorités légales lorsque la loi l’exige.',
    'Legal authorities when required by law.',
    'السلطات القانونية عندما يفرض القانون ذلك.',
  );

  // -------- Section 4
  String get privacySection4Title =>
      _t('4. Sécurité', '4. Security', '4. الأمان');

  String get privacySection4Body => _t(
    'WinyCar met en œuvre des mesures techniques et organisationnelles raisonnables afin de protéger les données contre l’accès non autorisé, la perte ou l’altération.',
    'WinyCar implements reasonable technical and organizational measures to protect data against unauthorized access, loss or alteration.',
    'تطبق WinyCar تدابير تقنية وتنظيمية معقولة لحماية البيانات من الوصول غير المصرح به أو الفقدان أو التغيير.',
  );

  // -------- Section 5
  String get privacySection5Title => _t(
    '5. Durée de conservation',
    '5. Data retention',
    '5. مدة الاحتفاظ بالبيانات',
  );

  String get privacySection5Body => _t(
    'Les données sont conservées uniquement pendant la durée nécessaire à la fourniture du service et au respect des obligations légales.',
    'Data is kept only for the time necessary to provide the service and comply with legal obligations.',
    'يتم الاحتفاظ بالبيانات فقط للمدة اللازمة لتقديم الخدمة والامتثال للالتزامات القانونية.',
  );

  // -------- Section 6
  String get privacySection6Title =>
      _t('6. Droits des utilisateurs', '6. User rights', '6. حقوق المستخدمين');

  String get privacySection6Bullet1 => _t(
    'Accéder à leurs données personnelles.',
    'Access their personal data.',
    'الوصول إلى بياناتهم الشخصية.',
  );

  String get privacySection6Bullet2 => _t(
    'Demander la rectification ou la suppression de leurs données.',
    'Request correction or deletion of their data.',
    'طلب تصحيح أو حذف بياناتهم.',
  );

  String get privacySection6Bullet3 => _t(
    'S’opposer ou limiter certains traitements, conformément à la loi applicable.',
    'Object to or limit certain processing, in accordance with applicable law.',
    'الاعتراض على بعض المعالجات أو تقييدها وفقًا للقانون المعمول به.',
  );

  // -------- Section 7
  String get privacySection7Title => _t(
    '7. Cookies et technologies similaires',
    '7. Cookies and similar technologies',
    '7. ملفات تعريف الارتباط والتقنيات المشابهة',
  );

  String get privacySection7Body => _t(
    'L’application peut utiliser des technologies similaires aux cookies pour améliorer l’expérience utilisateur et assurer la sécurité.',
    'The application may use technologies similar to cookies to improve user experience and ensure security.',
    'قد يستخدم التطبيق تقنيات مشابهة لملفات تعريف الارتباط لتحسين تجربة المستخدم وضمان الأمان.',
  );

  // -------- Section 8
  String get privacySection8Title =>
      _t('8. Modifications', '8. Changes', '8. التعديلات');

  String get privacySection8Body => _t(
    'Cette Politique de confidentialité peut être mise à jour. Les utilisateurs seront informés en cas de modification substantielle.',
    'This Privacy Policy may be updated. Users will be informed in case of significant changes.',
    'قد يتم تحديث سياسة الخصوصية هذه. وسيتم إخطار المستخدمين في حال حدوث تغييرات جوهرية.',
  );

  // -------- Section 9
  String get privacySection9Title =>
      _t('9. Contact', '9. Contact', '9. التواصل');

  String get privacySection9Body => _t(
    'Pour toute question concernant la protection des données :',
    'For any questions regarding data protection:',
    'لأي استفسار بخصوص حماية البيانات:',
  );

  String get privacyContactEmail => _t(
    'Email : winycar.contact@gmail.com',
    'Email: winycar.contact@gmail.com',
    'البريد الإلكتروني: winycar.contact@gmail.com',
  );

  String get privacyContactSupport => _t(
    'Page support : https://winycar.com/support',
    'Support page: https://winycar.com/support',
    'صفحة الدعم: https://winycar.com/support',
  );

  // ===== OFFERS PAGE =====

  String get offersLastUpdate => _t(
    'Mise à jour : 12/12/2025',
    'Last update: 12/12/2025',
    'آخر تحديث: 12/12/2025',
  );

  String get offersIntro => _t(
    'Retrouvez ici le détail de nos offres. Choisissez l’offre adaptée à votre besoin : visibilité, mise en avant et accompagnement.',
    'Find here the details of our offers. Choose the plan that fits your needs: visibility, promotion and support.',
    'اعثر هنا على تفاصيل عروضنا. اختر العرض المناسب لاحتياجاتك: الظهور، الترويج، والدعم.',
  );

  // ----- FREE -----
  String get offerFreeBullet1 => _t(
    'Publication d’annonces selon les conditions en vigueur.',
    'Ad publication according to current conditions.',
    'نشر الإعلانات وفق الشروط المعمول بها.',
  );

  String get offerFreeBullet2 => _t(
    'Visibilité standard dans les résultats.',
    'Standard visibility in search results.',
    'ظهور عادي في نتائج البحث.',
  );

  String get offerFreeBullet3 => _t(
    'Accès aux fonctionnalités de base.',
    'Access to basic features.',
    'الوصول إلى الميزات الأساسية.',
  );

  // ----- STANDARD -----
  String get offerStandardBullet1 =>
      _t('Visibilité améliorée.', 'Enhanced visibility.', 'ظهور محسّن.');

  String get offerStandardBullet2 => _t(
    'Mise en avant sur certaines sections.',
    'Highlighted in selected sections.',
    'تمييز في بعض الأقسام.',
  );

  String get offerStandardBullet3 => _t(
    'Support prioritaire selon disponibilité.',
    'Priority support subject to availability.',
    'دعم أولوية حسب التوفر.',
  );

  // ----- PREMIUM -----
  String get offerPremiumBullet1 =>
      _t('Visibilité maximale.', 'Maximum visibility.', 'أقصى درجة من الظهور.');

  String get offerPremiumBullet2 =>
      _t('Mise en avant premium.', 'Premium highlighting.', 'تمييز مميز.');

  String get offerPremiumBullet3 => _t(
    'Accompagnement personnalisé.',
    'Personalized support.',
    'مرافقة مخصصة.',
  );

  String get menu => _t('Menu', 'Menu', 'القائمة');

  // ===== Offres (GRATUITE / STANDARD / PREMIUM) =====
  String get offerFreeTitle => _t('GRATUITE', 'FREE', 'مجانية');
  String get myAccount => _t('Mon compte', 'My account', 'حسابي');
  String get offerFreeSubtitle => _t(
    '3 annonces incluses.\nIdéal pour démarrer sans frais.',
    '3 listings included.\nPerfect to start with no cost.',
    '3 إعلانات مشمولة.\nمثالية للبدء بدون تكاليف.',
  );
  String get offerStandardTitle => _t('STANDARD', 'STANDARD', 'ستاندرد');
  String get offerStandardSubtitle => _t(
    '20 annonces.\nExcellent rapport qualité/prix.',
    '20 listings.\nGreat value for money.',
    '20 إعلانًا.\nقيمة ممتازة مقابل السعر.',
  );
  String get offerPremiumTitle => _t('PREMIUM', 'PREMIUM', 'بريميوم');
  String get offerPremiumSubtitle => _t(
    'Annonces illimitées.\nVisibilité maximale.',
    'Unlimited listings.\nMaximum visibility.',
    'إعلانات غير محدودة.\nأقصى قدر من الظهور.',
  );

  String get signOut => _t('Déconnexion', 'Sign out', 'تسجيل الخروج');
  // AppBar / Auth
  String get signIn => _t('Connexion', 'Sign in', 'تسجيل الدخول');
  String get signUp => _t('Inscription', 'Sign up', 'إنشاء حساب');
  String get signInSignUpTooltip => _t(
    'Connexion / Inscription',
    'Sign in / Sign up',
    'تسجيل الدخول / التسجيل',
  );

  // Language labels
  String get french => _t('Français', 'French', 'الفرنسية');
  String get english => _t('Anglais', 'English', 'الإنجليزية');
  String get arabic => _t('Arabe', 'Arabic', 'العربية');

  // Dates shortcuts
  String get date => _t('Date', 'Date', 'التاريخ');
  String get today => _t('Aujourd’hui', 'Today', 'اليوم');
  String get thisWeekend =>
      _t('Ce week-end', 'This weekend', 'نهاية هذا الأسبوع');
  String get next7days =>
      _t('Prochains 7 jours', 'Next 7 days', 'الأيام السبعة القادمة');

  // Generic labels
  String get discover => _t('Découvrir', 'Discover', 'اكتشف');
  String get newLabel => _t('Neuf', 'New', 'جديد');
  String get usedLabel => _t('Occasion', 'Used', 'مستعمل');
  String get less3Label => _t('-3 ans', '-3 years', '-3 سنوات');
  String get less5Label => _t('-5 ans', '-5 years', '-5 سنوات');
  String get importLabel => _t('Import', 'Imported', 'مستوردة');
  String get rentalLabel => _t('Location', 'Rental', 'كراء');
  String get sponsored => _t('Sponsorisé', 'Sponsored', 'برعاية');
  String get listing => _t('Annonce', 'Listing', 'إعلان');
  String get priceNegotiable =>
      _t('Prix à négocier', 'Price negotiable', 'السعر قابل للتفاوض');

  // Hero
  String get homeHeroHeadline => _t(
    'Trouvez, louez ou vendez votre voiture',
    'Find, rent or sell your car',
    'ابحث، اكترِ أو بِع سيارتك',
  );

  // Sections
  String get exploreByNeed =>
      _t('Explorer par besoin', 'Explore by need', 'استكشف حسب الحاجة');
  String get ourApp => _t('Notre application', 'Our application', 'تطبيقنا');
  String get ourOffers => _t('Nos offres', 'Our offers', 'عروضنا');
  String get trendingNow =>
      _t('Tendances du moment', 'Trending now', 'الأكثر رواجًا الآن');
  String get trendingSubtitle => _t(
    "Nos annonces sponsorisées & les plus récentes. Découvrez en premier.",
    "Our sponsored & latest listings. Discover first.",
    "إعلاناتنا برعاية والأحدث. اكتشف أولاً.",
  );

  // New / See all
  String get newCarsTitle => _t('Voitures neuves', 'New cars', 'سيارات جديدة');
  String get seeAllNew => _t('Voir tout neuf', 'See all new', 'عرض كل الجديد');
  String get seeAll => _t('Voir tout', 'See all', 'عرض الكل');
  String get noNewOffers => _t(
    "Pas d'offres neuves pour l’instant.",
    "No new offers for now.",
    "لا توجد عروض جديدة حاليًا.",
  );

  // Used
  String get usedCarsTitle =>
      _t('Voitures d’occasion', 'Used cars', 'سيارات مستعملة');
  String get usedCarsSubtitle => _t(
    "Sélection fiable et transparente : kilométrage, historique et contrôles. Trouvez le meilleur rapport qualité/prix.",
    "Reliable, transparent selection: mileage, history and checks. Find the best value.",
    "اختيار موثوق وشفاف: كيلومترات، تاريخ وفحوصات. اعثر على أفضل قيمة.",
  );
  String get seeAllUsed =>
      _t('Voir tout l’occasion', 'See all used', 'عرض كل المستعمل');
  String get noUsedOffers => _t(
    "Aucune occasion disponible pour le moment.",
    "No used cars available for now.",
    "لا توجد سيارات مستعملة حاليًا.",
  );

  // Rental
  String get rentalTitle =>
      _t('Location de voitures', 'Car rental', 'كراء السيارات');
  String get rentalSubtitle => _t(
    "Réservez pour un week-end, un déplacement pro ou des vacances. Disponible immédiatement selon wilaya et période.",
    "Book for a weekend, business trip or holiday. Availability by wilaya and dates.",
    "احجز لعطلة نهاية الأسبوع أو رحلة عمل أو إجازة. التوفر حسب الولاية والفترة.",
  );
  String get seeAllRental =>
      _t('Voir la location', 'See all rentals', 'عرض الكراء');
  String get noRentalOffers => _t(
    "Pas d’offres de location pour le moment.",
    "No rental offers for now.",
    "لا توجد عروض كراء حاليًا.",
  );

  // Featured / Empty
  String get nothingHeadline => _t(
    'Rien à la Une… pour l’instant',
    'Nothing featured… for now',
    'لا شيء في الواجهة حاليًا',
  );
  String get nothingSubtitle => _t(
    'Revenez bientôt : de nouvelles offres sponsorisées arrivent chaque jour.',
    'Check back soon: new sponsored deals land every day.',
    'عاود الزيارة قريبًا: عروض برعاية تصل يوميًا.',
  );
  String get noListingTitle =>
      _t('Aucune annonce', 'No listing', 'لا توجد إعلانات');

  // Small helpers used by views
  String get back => _t('Retour', 'Back', 'رجوع');
  String get clear => _t('Effacer', 'Clear', 'مسح');
  String get searchAppliedHint => _t(
    'Recherche appliquée — touchez pour réinitialiser',
    'Search applied — tap to reset',
    'تم تطبيق البحث — اضغط لإعادة التعيين',
  );

  // Shared UI
  String get rememberMe => _t('Se souvenir de moi', 'Remember me', 'تذكرني');

  // Ajouts manquants demandés
  String get findYourCar => _t(
    'Trouvez, louez ou vendez votre voiture',
    'Find, rent or sell your car',
    'ابحث، اكترِ أو بِع سيارتك',
  );
  String get cannotSendLink => _t(
    'Impossible d\'envoyer le lien.',
    'Unable to send the link.',
    'تعذر إرسال الرابط.',
  );
  String get resetLinkGeneric => _t(
    'Si un compte existe, un lien de réinitialisation a été envoyé.',
    'If an account exists, a reset link has been sent.',
    'إذا كان الحساب موجودًا، فقد تم إرسال رابط إعادة التعيين.',
  );
  String get validateAndLogin => _t(
    'Valider et se connecter',
    'Validate and sign in',
    'تأكيد وتسجيل الدخول',
  );
  String get sendLink => _t('Envoyer le lien', 'Send link', 'إرسال الرابط');

  // Retour vers saisie e-mail / mot de passe
  String get backToEmailPwd => _t(
    'Revenir à la saisie e-mail / mot de passe',
    'Back to email / password',
    'العودة إلى البريد / كلمة المرور',
  );

  String resultsCount(int n) => _tp(
    'Résultats: {$n}',
    'Results: {$n}',
    'النتائج: {$n}',
    {'n': n.toString()},
  );

  // Services
  String get servicesTitle => _t('Services', 'Services', 'الخدمات');
  String get servicesSubtitle => _t(
    "Une expérience complète : estimation, assurance, livraison, cartes grises. On s’occupe de tout, vous prenez la route.",
    "A complete experience: valuation, insurance, delivery, registration. We handle it, you hit the road.",
    "تجربة متكاملة: تقييم، تأمين، توصيل، بطاقات رمادية. نحن نتكفل، وأنت تنطلق.",
  );
  String get service1Title =>
      _t('Estimation & Reprise', 'Valuation & Trade-in', 'تقييم & استبدال');
  String get service1Text => _t(
    'Obtenez un prix juste pour votre voiture en 24h. Reprise rapide et sécurisée.',
    'Get a fair price in 24h. Fast & secure trade-in.',
    'احصل على سعر عادل خلال 24 ساعة. استبدال سريع وآمن.',
  );
  String get service2Title =>
      _t('Garanties & Financement', 'Warranty & Financing', 'ضمان & تمويل');
  String get service2Text => _t(
    'Profitez d’extensions de garantie et d’options de crédit adaptées.',
    'Extended warranty and flexible financing.',
    'ضمانات ممتدة وخيارات تمويل مرنة.',
  );
  String get service3Title =>
      _t('Assurance & Assistance', 'Insurance & Assistance', 'تأمين & مساعدة');
  String get service3Text => _t(
    'Souscrivez une assurance auto en quelques clics, assistance incluse.',
    'Get car insurance in a few clicks, assistance included.',
    'اشترك في تأمين السيارة ببضع نقرات، مع المساعدة.',
  );
  String get service4Title => _t(
    'Livraison & Carte grise',
    'Delivery & Registration',
    'التوصيل & البطاقة الرمادية',
  );
  String get service4Text => _t(
    'On s’occupe de la paperasse et de la livraison jusqu’à votre wilaya.',
    'We handle paperwork and delivery to your wilaya.',
    'نتكفل بالإجراءات والتوصيل إلى ولايتك.',
  );

  // Why us
  String get whyUsTitle =>
      _t('Pourquoi nous choisir ?', 'Why choose us?', 'لماذا تختارنا؟');
  String get whyUsSubtitle => _t(
    'Sécurité, transparence et simplicité : notre ADN au service de votre prochaine voiture.',
    'Security, transparency and simplicity: our DNA for your next car.',
    'الأمان والشفافية والبساطة: نهجنا لسيارتك القادمة.',
  );
  String get whyUs1Title =>
      _t('Annonces contrôlées', 'Verified listings', 'إعلانات مُتحقق منها');
  String get whyUs1Text => _t(
    'Chaque annonce est vérifiée pour limiter les arnaques et garantir la qualité.',
    'Every listing is checked to reduce scams and ensure quality.',
    'يتم التحقق من كل إعلان للحد من الاحتيال وضمان الجودة.',
  );
  String get whyUs2Title => _t('Paiement serein', 'Safe payment', 'دفع آمن');
  String get whyUs2Text => _t(
    'Solutions de paiement sécurisées et options de financement.',
    'Secure payment solutions and financing options.',
    'حلول دفع آمنة وخيارات تمويل.',
  );
  String get whyUs3Title =>
      _t('Support dédié', 'Dedicated support', 'دعم مخصص');
  String get whyUs3Text => _t(
    'Une équipe disponible pour vous accompagner à chaque étape.',
    'A team to assist you at every step.',
    'فريق متاح لمساعدتك في كل خطوة.',
  );

  // FAQ
  String get faqSubtitle => _t(
    'Les réponses aux questions les plus fréquentes.',
    'Answers to the most common questions.',
    'إجابات على الأسئلة الشائعة.',
  );
  String get faqQ1 => _t(
    'Comment publier une annonce ?',
    'How to post a listing?',
    'كيف أنشر إعلانًا؟',
  );
  String get faqA1 => _t(
    'Créez un compte, cliquez sur “Vendre ma voiture” et suivez les étapes pour renseigner votre véhicule et vos photos.',
    'Create an account, tap “Sell my car”, then follow the steps to enter details and photos.',
    'أنشئ حسابًا، اضغط "بيع سيارتي"، ثم اتبع الخطوات لإدخال التفاصيل والصور.',
  );
  String get faqQ2 => _t(
    'Puis-je réserver une voiture en ligne ?',
    'Can I reserve a car online?',
    'هل يمكنني حجز سيارة عبر الإنترنت؟',
  );
  String get faqA2 => _t(
    'Oui, pour la location et certains véhicules neufs. La disponibilité dépend de la wilaya et des dates choisies.',
    'Yes, for rentals and some new cars. Availability depends on wilaya and dates.',
    'نعم، للكراء وبعض السيارات الجديدة. التوفر يعتمد على الولاية والتواريخ.',
  );
  String get faqQ3 => _t(
    'Proposez-vous un accompagnement carte grise ?',
    'Do you help with registration (carte grise)?',
    'هل توفرون المساعدة في البطاقة الرمادية؟',
  );
  String get faqA3 => _t(
    'Oui, sur demande : nous pouvons vous guider ou prendre en charge la démarche selon la wilaya.',
    'Yes, on request: we can guide or handle the process depending on the wilaya.',
    'نعم، عند الطلب: يمكننا إرشادك أو التكفل بالإجراء حسب الولاية.',
  );

  // Footer
  String copyright(int year) => _t(
    '© $year WinyCar • Tous droits réservés',
    '© $year WinyCar • All rights reserved',
    '© $year WinyCar • جميع الحقوق محفوظة',
  );

  // Hero cards
  String get heroRentTitle =>
      _t('Louer une voiture.', 'Rent a car.', 'استئجار سيارة.');
  String get heroRentSubtitle => _t(
    'Dates + wilaya, dispo immédiate.',
    'Dates + wilaya, instant availability.',
    'تواريخ + ولاية، توفر فوري.',
  );
  String get heroNewTitle =>
      _t('Neuf — Offres du moment.', 'New — Hot offers.', 'جديد — عروض مميزة.');
  String get heroNewSubtitle => _t(
    'Stocks disponibles et remises.',
    'Available stock and discounts.',
    'مخزون متاح وتخفيضات.',
  );
  String get heroUsedTitle => _t(
    'Occasion — Bons plans.',
    'Used — Good deals.',
    'مستعمل — صفقات جيدة.',
  );
  String get heroUsedSubtitle => _t(
    'Sélection fiable & transparente.',
    'Reliable & transparent selection.',
    'اختيار موثوق وشفاف.',
  );

  // Language / Account / Signup helpers
  String get language => _t('Langue', 'Language', 'اللغة');
  String get createAccount =>
      _t('Créer un compte', 'Create an account', 'إنشاء حساب');
  String get step1of2Info => _t(
    'Étape 1 sur 2 : informations',
    'Step 1 of 2: information',
    'الخطوة 1 من 2: المعلومات',
  );
  String get accountVerification =>
      _t('Vérification du compte', 'Account verification', 'تأكيد الحساب');
  String get step2of2Otp => _t(
    'Étape 2 sur 2 : code OTP',
    'Step 2 of 2: OTP code',
    'الخطوة 2 من 2: رمز التحقق',
  );

  String get firstName => _t('Prénom', 'First name', 'الاسم');
  String get firstNameRequired =>
      _t('Prénom requis', 'First name required', 'الاسم مطلوب');
  String get lastName => _t('Nom', 'Last name', 'اللقب');
  String get lastNameRequired =>
      _t('Nom requis', 'Last name required', 'اللقب مطلوب');

  String get email => _t('Email', 'Email', 'البريد الإلكتروني');
  String get emailHint =>
      _t('exemple@mail.com', 'example@mail.com', 'example@mail.com');
  String get emailRequired =>
      _t('Email requis', 'Email required', 'البريد الإلكتروني مطلوب');
  String get emailInvalid =>
      _t('Email invalide', 'Invalid email', 'بريد إلكتروني غير صالح');

  String get password => _t('Mot de passe', 'Password', 'كلمة المرور');
  String get passwordRequired =>
      _t('Mot de passe requis', 'Password required', 'كلمة المرور مطلوبة');
  String get password6chars =>
      _t('Au moins 6 caractères', 'At least 6 characters', 'على الأقل 6 أحرف');
  String get showHidePassword => _t(
    'Afficher/masquer le mot de passe',
    'Show/hide password',
    'إظهار/إخفاء كلمة المرور',
  );

  String get phoneNumber => _t('Numéro', 'Phone number', 'رقم الهاتف');
  String get phoneHint =>
      _t('07 xx xx xx xx', '07 xx xx xx xx', '07 xx xx xx xx');
  String get phoneRequired =>
      _t('Numéro requis', 'Phone required', 'رقم الهاتف مطلوب');

  String get location => _t('Localisation', 'Location', 'الموقع');
  String get wilaya => _t('Wilaya', 'Wilaya', 'الولاية');
  String get commune => _t('Commune', 'Commune', 'البلدية');
  String get wilayaRequired =>
      _t('Wilaya requise', 'Wilaya required', 'الولاية مطلوبة');
  String get communeRequired =>
      _t('Commune requise', 'Commune required', 'البلدية مطلوبة');

  String get areYouPro => _t(
    'Vous êtes professionnel ?',
    'Are you a professional?',
    'هل أنت محترف؟',
  );
  String get siret => _t('SIRET', 'SIRET', 'سجل الشركة (SIRET)');
  String get siretRequired =>
      _t('SIRET requis', 'SIRET required', 'رقم SIRET مطلوب');
  String get siret14digits => _t(
    'Le SIRET doit contenir 14 chiffres',
    'SIRET must be 14 digits',
    'يجب أن يتكون SIRET من 14 رقمًا',
  );

  String get acceptCGU => _t(
    'J’accepte les Conditions Générales d’Utilisation',
    'I accept the Terms of Use',
    'أوافق على شروط الاستخدام',
  );
  String get acceptCGUError => _t(
    'Veuillez accepter les CGU pour continuer.',
    'Please accept the Terms to continue.',
    'يرجى قبول الشروط للمتابعة.',
  );

  String get createMyAccount =>
      _t('Créer mon compte', 'Create my account', 'إنشاء حسابي');
  String get signupFailed =>
      _t('Échec de l’inscription.', 'Sign up failed.', 'فشل التسجيل.');
  String get codeSentCheckEmail => _t(
    'Code envoyé. Consultez votre e-mail.',
    'Code sent. Check your email.',
    'تم إرسال الرمز. تحقق من بريدك الإلكتروني.',
  );

  String get accountVerifiedWelcome => _t(
    'Compte vérifié. Bienvenue !',
    'Account verified. Welcome!',
    'تم التحقق من الحساب. أهلاً بك!',
  );
  String get otpValidationFailed => _t(
    'Validation OTP impossible.',
    'OTP validation failed.',
    'فشل التحقق من الرمز.',
  );
  String codeSentTo(String email) => _tp(
    'Un code a été envoyé à {$email}.',
    'A code was sent to {$email}.',
    'تم إرسال رمز إلى {$email}.',
    {'email': email},
  );

  String get otpCode => _t('Code OTP', 'OTP Code', 'رمز التحقق');
  String get otpHint => _t('6 caractères', '6 characters', '8 أحرف');
  String get codeRequired => _t('Code requis', 'Code required', 'الرمز مطلوب');
  String get codeInvalid => _t('Code invalide', 'Invalid code', 'رمز غير صالح');

  String get validate => _t('Valider', 'Validate', 'تأكيد');
  String get resendCode =>
      _t('Renvoyer le code', 'Resend code', 'إعادة إرسال الرمز');
  String resendIn(int s) => _tp(
    'Renvoyer ({$s}s)',
    'Resend in {$s}s',
    'إعادة الإرسال خلال {$s}ث',
    {'s': s.toString()},
  );
  String get cannotResendCode => _t(
    'Impossible de renvoyer le code.',
    'Unable to resend the code.',
    'تعذر إعادة إرسال الرمز.',
  );
  String get codeResent =>
      _t('Code renvoyé.', 'Code resent.', 'تمت إعادة إرسال الرمز.');

  String get editMyInfo =>
      _t('Modifier mes informations', 'Edit my information', 'تعديل معلوماتي');

  // Screens / Titles
  String get welcomeBack =>
      _t('Heureux de vous revoir', 'Welcome back', 'مرحباً بعودتك');
  String get signInToContinue => _t(
    'Connectez-vous pour continuer',
    'Sign in to continue',
    'سجّل الدخول للمتابعة',
  );

  String get codeVerification =>
      _t('Vérification par code', 'Code verification', 'التحقق بواسطة الرمز');
  String get step2EnterOtpPwd => _t(
    'Étape 2 sur 2 : saisissez le code OTP et votre mot de passe',
    'Step 2 of 2: enter the OTP code and your password',
    'الخطوة 2 من 2: أدخل رمز التحقق وكلمة المرور',
  );

  String get forgotPassword =>
      _t('Mot de passe oublié', 'Forgot password', 'نسيت كلمة المرور');
  String get enterEmailResetLink => _t(
    'Saisissez votre e-mail. Un lien de réinitialisation vous sera envoyé.',
    'Enter your email. A reset link will be sent to you.',
    'أدخل بريدك الإلكتروني وسيصلك رابط لإعادة التعيين.',
  );

  String get invalidCredentials => _t(
    'Identifiants invalides.',
    'Invalid credentials.',
    'بيانات اعتماد غير صحيحة.',
  );
  String get otpSentCheckEmail => _t(
    'Code OTP envoyé, vérifiez votre e-mail.',
    'OTP code sent, check your email.',
    'تم إرسال رمز التحقق، تحقق بريدك.',
  );
  String get loginError =>
      _t('Erreur de connexion.', 'Login error.', 'خطأ في تسجيل الدخول.');
  String get invalidOtp =>
      _t('Code OTP invalide.', 'Invalid OTP code.', 'رمز التحقق غير صالح.');
  String get loginSuccess => _t(
    'Connexion réussie.',
    'Logged in successfully.',
    'تم تسجيل الدخول بنجاح.',
  );
  String get otpValidationError => _t(
    'Erreur pendant la validation du code.',
    'Error while validating the code.',
    'حدث خطأ أثناء التحقق من الرمز.',
  );

  // Actions / CTAs
  String get forgotPasswordQuestion =>
      _t('Mot de passe oublié ?', 'Forgot password?', 'هل نسيت كلمة المرور؟');

  String get search => _t('Recherche', 'Search', 'بحث');
  String get filters => _t('Filtres', 'Filters', 'فلاتر');
  String get filter => _t('Filtrer', 'Filter', 'تصفية');
  String get select => _t('Sélectionner', 'Select', 'اختر');
  String get brands => _t('Marques', 'Brands', 'العلامات');
  String get models => _t('Modèles', 'Models', 'الطرازات');
  String get maxPrice => _t('Prix max', 'Max price', 'أقصى سعر');
  String get reset => _t('Réinitialiser', 'Reset', 'إعادة ضبط');
  String get apply => _t('Appliquer', 'Apply', 'تطبيق');
  String get allWilayas => _t('Toutes wilayas', 'All wilayas', 'كل الولايات');

  // Cars (rental)
  String get choosePeriod =>
      _t('Choisir la période', 'Choose period', 'اختر المدة');
  String get dateStartEnd => _t(
    'Date début – Date fin',
    'Start date – End date',
    'تاريخ البداية – تاريخ النهاية',
  );
  String get pickDatesFirst => _t(
    'Choisissez la date de début et de fin.',
    'Pick start and end dates.',
    'يرجى اختيار تاريخ البداية والنهاية.',
  );

  // Reset Password
  String get resetPassword => _t(
    'Réinitialiser le mot de passe',
    'Reset password',
    'إعادة تعيين كلمة المرور',
  );
  String resetForEmail(String email) =>
      _tp('Pour {$email}', 'For {$email}', 'لـ {$email}', {'email': email});
  String get newPassword =>
      _t('Nouveau mot de passe', 'New password', 'كلمة المرور الجديدة');
  String get confirmPassword =>
      _t('Confirmer le mot de passe', 'Confirm password', 'تأكيد كلمة المرور');
  String get changePassword =>
      _t('Changer le mot de passe', 'Change password', 'تغيير كلمة المرور');

  String get securityNoteResetLinkOrigin => _t(
    'Par sécurité, le lien doit provenir de https://winycar.com.',
    'For security, the link must come from https://winycar.com.',
    'لأسباب أمنية، يجب أن يكون الرابط من https://winycar.com.',
  );
  String get passwordRules8MajMinDigitSpecial => _t(
    '8+ caractères, majuscule, minuscule, chiffre et caractère spécial.',
    '8+ chars, uppercase, lowercase, digit and special character.',
    '٨+ أحرف، حرف كبير وصغير ورقم ورمز خاص.',
  );
  String get passwordsDontMatch => _t(
    'Les mots de passe ne correspondent pas.',
    'Passwords do not match.',
    'كلمتا المرور غير متطابقتين.',
  );
  String get passwordChangedPleaseLogin => _t(
    'Mot de passe modifié. Veuillez vous reconnecter.',
    'Password changed. Please sign in again.',
    'تم تغيير كلمة المرور. يُرجى تسجيل الدخول مجددًا.',
  );
  String get cannotChangePassword => _t(
    'Impossible de changer le mot de passe.',
    'Unable to change password.',
    'تعذّر تغيير كلمة المرور.',
  );
  String get error => _t('Erreur', 'Error', 'خطأ');

  // Banner (app)
  String get appBannerTitle => _t(
    'Réservez et gérez vos réservations, tout en un seul endroit !',
    'Book and manage your reservations, all in one place!',
    'احجز وأدِر حجوزاتك في مكان واحد!',
  );
  String get appBannerSubtitle => _t(
    'Découvrez le meilleur de WinyCar avec notre application.',
    'Experience the best of WinyCar with our app.',
    'اكتشف أفضل ما في WinyCar مع تطبيقنا.',
  );
  String get appBannerCta =>
      _t('Télécharger WinyCar', 'Download WinyCar', 'حمّل WinyCar');

  // --- Ajouts pour composants / validateurs ---
  String get selectPlaceholder => _t('Sélectionner...', 'Select...', 'اختر...');
  String get searchPlaceholder => _t('Rechercher…', 'Search…', 'ابحث…');
  String get all => _t('Tout', 'All', 'الكل');
  String get none => _t('Aucun', 'None', 'لا شيء');
  String get ok => _t('OK', 'OK', 'حسناً');
  String get required => _t('Obligatoire', 'Required', 'مطلوب');
  String get numberInvalid =>
      _t('Nombre invalide', 'Invalid number', 'رقم غير صالح');
  String get priceInvalid =>
      _t('Prix invalide', 'Invalid price', 'سعر غير صالح');
  String get phoneFrInvalid => _t(
    'Commence par 0 et 10 chiffres',
    'Starts with 0 and 10 digits',
    'يبدأ بصفر ويحتوي على 10 أرقام',
  );
  String get phoneDzInvalid => _t(
    'Téléphone DZ invalide',
    'Invalid DZ phone',
    'رقم هاتف جزائري غير صالح',
  );
  String get yearInvalid =>
      _t('Année invalide', 'Invalid year', 'سنة غير صالحة');
  String passwordMinChars(int n) => _tp(
    'Au moins {$n} caractères',
    'At least {$n} characters',
    'على الأقل {$n} أحرف',
    {'n': n.toString()},
  );

  // Dashboard / menu / pages
  String get dashboardHome => _t('Accueil', 'Home', 'الصفحة الرئيسية');
  String get dashboardListCars =>
      _t('Liste des voitures', 'List cars', 'قائمة السيارات');
  String get dashboardAddCar =>
      _t('Ajouter une voiture', 'Add a car', 'أضف سيارة');

  // AddCars / publication
  String get depositAd => _t('Déposer une annonce', 'Post an ad', 'نشر إعلان');
  String get next => _t('Suivant', 'Next', 'التالي');
  String get publish => _t('Publier', 'Publish', 'نشر');
  String get photoMaxReached => _t(
    'Limite atteinte, les autres ont été ignorées.',
    'Max reached, others ignored.',
    'تم بلوغ الحد، تم تجاهل الباقي.',
  );
  String get addAtLeastOnePhoto => _t(
    'Ajoute au moins une photo.',
    'Add at least one photo.',
    'أضف صورة واحدة على الأقل.',
  );

  // ListCars / actions
  String get renewAdTitle =>
      _t('Renouveler l\'annonce', 'Renew ad', 'تجديد الإعلان');
  String get renewAdConfirm => _t(
    'Voulez-vous vraiment renouveler cette annonce ?',
    'Do you really want to renew this ad?',
    'هل تريد حقًا تجديد هذا الإعلان؟',
  );
  String get deleteCarConfirm => _t(
    'Cette action est irréversible.\nVoulez-vous vraiment supprimer cette voiture ?',
    'This action is irreversible.\nDo you really want to delete this car?',
    'هذا الإجراء لا رجعة فيه.\nهل تريد حقًا حذف هذه السيارة؟',
  );
  String get delete => _t('Supprimer', 'Delete', 'حذف');
  String get untitled => _t('Sans titre', 'Untitled', 'بدون عنوان');
  String get priceOnRequest =>
      _t('Prix sur demande', 'Price on request', 'السعر عند الطلب');
  String get chooseDates =>
      _t('Choisir les dates', 'Choose dates', 'اختر التواريخ');

  String get ownerRevenueTitle =>
      _t('Revenus des locations', 'Rental revenue', 'إيرادات التأجير');

  String get ownerRevenueSubtitle => _t(
    'Visualise ton chiffre d’affaires global, par période, par voiture et par mois.',
    'View your total revenue by period, by car, and by month.',
    'شاهد إجمالي الإيرادات حسب الفترة وحسب السيارة وحسب الشهر.',
  );

  String get turnover => _t('Chiffre d’affaires', 'Turnover', 'رقم الأعمال');

  String get sinceBeginning => _t('Depuis le début', 'All time', 'منذ البداية');

  String get thisYear => _t('Cette année', 'This year', 'هذه السنة');
  String get thisMonth => _t('Ce mois-ci', 'This month', 'هذا الشهر');
  String get thisWeek => _t('Cette semaine', 'This week', 'هذا الأسبوع');

  String get revenueByMonth =>
      _t('Revenus par mois', 'Revenue by month', 'الإيرادات حسب الشهر');

  String get noMonthlyRevenueYet => _t(
    'Pas encore de chiffre d’affaires mensuel.',
    'No monthly revenue yet.',
    'لا توجد إيرادات شهرية بعد.',
  );

  String get revenueByCar =>
      _t('Revenus par voiture', 'Revenue by car', 'الإيرادات حسب السيارة');

  String get noFinishedRentalsYet => _t(
    'Aucune location terminée pour le moment.',
    'No finished rentals yet.',
    'لا توجد تأجيرات منتهية بعد.',
  );

  String get finishedRentals =>
      _t('Locations terminées', 'Finished rentals', 'التأجيرات المنتهية');

  String get noFinishedRentalsForNow => _t(
    'Aucune location terminée pour l’instant.',
    'No finished rentals for now.',
    'لا توجد تأجيرات منتهية حالياً.',
  );

  String get rentalsShort => _t('loc.', 'rentals', 'تأجير');

  String carIdTitle(String id) => _t('Voiture $id', 'Car $id', 'سيارة $id');

  String get car => _t('Voiture', 'Car', 'سيارة');

  String bookingRevenueLine(String start, String end, String realEnd) => _t(
    'Du $start au $end • Fin réelle : $realEnd',
    'From $start to $end • Actual end: $realEnd',
    'من $start إلى $end • النهاية الفعلية: $realEnd',
  );

  String daysCount(int n) => _t('$n jour(s)', '$n day(s)', '$n يوم');

  // OwnerBookingsCarsView
  String get ownerBookingsTitle =>
      _t('Gestionnaire des locations', 'Rental manager', 'مدير التأجير');

  String get ownerBookingsSubtitle => _t(
    'Activez les suggestions IA pour remplir un maximum de journées de location sur vos véhicules.',
    'Enable AI suggestions to fill as many rental days as possible for your vehicles.',
    'فعّل اقتراحات الذكاء الاصطناعي لملء أكبر عدد ممكن من أيام التأجير على مركباتك.',
  );

  String get ownerBookingsIaLabel => _t(
    'Suggestions IA (remplir le maximum de jours par voiture)',
    'AI suggestions (fill maximum days per car)',
    'اقتراحات الذكاء الاصطناعي (ملء أكبر عدد ممكن من الأيام لكل سيارة)',
  );

  String get ownerBookingsEmptyAll => _t(
    'Aucune demande de location pour le moment.',
    'No rental requests for now.',
    'لا توجد طلبات تأجير حالياً.',
  );

  String get ownerBookingsEmptyForStatus => _t(
    'Aucune demande pour ce statut.',
    'No requests for this status.',
    'لا توجد طلبات لهذه الحالة.',
  );

  String ownerBookingsCarLine({
    required int total,
    required int pending,
    required int confirmed,
  }) => _t(
    '$total demande(s) • $pending en attente, $confirmed confirmée(s)',
    '$total request(s) • $pending pending, $confirmed confirmed',
    '$total طلب(ات) • $pending قيد الانتظار، $confirmed مؤكدة',
  );

  String ownerBookingsIaToValidate(int n) => _t(
    'IA : $n demande(s) à valider',
    'AI: $n request(s) to validate',
    'الذكاء الاصطناعي: $n طلب(ات) للتأكيد',
  );

  String get ownerBookingsConfirmTitle =>
      _t('Confirmer la réservation', 'Confirm booking', 'تأكيد الحجز');

  String get ownerBookingsCancelTitle =>
      _t('Annuler la réservation', 'Cancel booking', 'إلغاء الحجز');

  String get ownerBookingsConfirmMessage => _t(
    'Confirmer cette réservation ?\nLes autres demandes qui se chevauchent sur cette voiture pourront être automatiquement refusées.',
    'Confirm this booking?\nOther overlapping requests for this car may be automatically rejected.',
    'تأكيد هذا الحجز؟\nقد يتم رفض الطلبات المتداخلة تلقائياً لهذه السيارة.',
  );

  String get ownerBookingsCancelMessage => _t(
    'Voulez-vous vraiment annuler cette réservation ?',
    'Do you really want to cancel this booking?',
    'هل تريد فعلاً إلغاء هذا الحجز؟',
  );

  // Common generic keys (si pas déjà)

  String get actionDone =>
      _t('Action effectuée.', 'Action completed.', 'تم تنفيذ العملية.');
  String get genericError =>
      _t('Une erreur est survenue.', 'An error occurred.', 'حدث خطأ.');

  String get pending => _t('En attente', 'Pending', 'قيد الانتظار');
  String get confirmed => _t('Confirmée', 'Confirmed', 'مؤكدة');
  String get pendingPlural => _t('En attente', 'Pending', 'قيد الانتظار');
  String get confirmedPlural => _t('Confirmées', 'Confirmed', 'مؤكدة');

  String get noShow => _t('Non venue', 'No-show', 'لم يحضر');
  String get canceled => _t('Annulée', 'Canceled', 'ملغاة');
  String get ongoing => _t('En cours', 'Ongoing', 'جارية');
  String get finished => _t('Terminée', 'Finished', 'منتهية');

  String get accept => _t('Accepter', 'Accept', 'قبول');
  String get reject => _t('Refuser', 'Reject', 'رفض');
  String get cancelBooking => _t('Annuler', 'Cancel', 'إلغاء');

  String get summary => _t('Récapitulatif', 'Summary', 'ملخص');
  String get requester => _t('Demandeur', 'Requester', 'صاحب الطلب');
  String get nameNotProvided =>
      _t('Nom non renseigné', 'Name not provided', 'الاسم غير متوفر');

  String get iaSuggestionValidate => _t(
    'Suggestion IA : à valider',
    'AI suggestion: validate',
    'اقتراح الذكاء الاصطناعي: تأكيد',
  );
  String get iaSuggestionCancel => _t(
    'Suggestion IA : à annuler',
    'AI suggestion: cancel',
    'اقتراح الذكاء الاصطناعي: إلغاء',
  );

  String iaRecommendedAction(bool shouldConfirm) => _t(
    'Action recommandée par l’IA : ${shouldConfirm ? 'VALIDER' : 'ANNULER'}',
    'AI recommended action: ${shouldConfirm ? 'VALIDATE' : 'CANCEL'}',
    'الإجراء الموصى به: ${shouldConfirm ? 'تأكيد' : 'إلغاء'}',
  );

  // Utilitaires déjà utilisés ailleurs :
  String get perDay => _t('jour', 'day', 'يوم');

  String get locationLabel => _t('Lieu : ', 'Location: ', 'المكان: ');
  String get daysCountLabel =>
      _t('Nombre de jours : ', 'Days: ', 'عدد الأيام: ');

  // --- CarDetailsViewLocation ---

  String get loginToManageFavorites => _t(
    'Veuillez vous connecter pour gérer vos favoris.',
    'Please log in to manage your favorites.',
    'يرجى تسجيل الدخول لإدارة المفضلة.',
  );

  String get cannotFindFavoriteToRemove => _t(
    'Impossible de trouver ce favori à supprimer.',
    'Unable to find this favorite to remove.',
    'تعذر العثور على هذا المفضل لإزالته.',
  );

  String get favoriteRemoved =>
      _t('Favori retiré.', 'Favorite removed.', 'تمت إزالة المفضل.');

  String get addedToFavorites => _t(
    'Ajouté aux favoris.',
    'Added to favorites.',
    'تمت الإضافة إلى المفضلة.',
  );

  String get chooseStartDateFirst => _t(
    'Choisissez d’abord la date de début.',
    'Please choose the start date first.',
    'يرجى اختيار تاريخ البداية أولاً.',
  );

  String get chooseRentalDates => _t(
    'Merci de choisir les dates de location.',
    'Please select the rental dates.',
    'يرجى اختيار تواريخ الإيجار.',
  );

  String get invalidSelectedDates => _t(
    'Les dates sélectionnées sont invalides.',
    'Selected dates are invalid.',
    'التواريخ المحددة غير صالحة.',
  );

  String get mustBeLoggedInToBook => _t(
    'Vous devez être connecté pour réserver.',
    'You must be logged in to book.',
    'يجب تسجيل الدخول لإتمام الحجز.',
  );

  String get bookingSaved =>
      _t('Réservation enregistrée.', 'Booking saved.', 'تم تسجيل الحجز.');

  String get chooseYourDates =>
      _t('Choisissez vos dates', 'Choose your dates', 'اختر تواريخك');

  String get datesLabel => _t('Dates : ', 'Dates: ', 'التواريخ: ');

  String get startPrefix => _t('Début : ', 'Start: ', 'البداية: ');
  String get endPrefix => _t('Fin : ', 'End: ', 'النهاية: ');

  String get saving => _t('Enregistrement...', 'Saving...', 'جارٍ الحفظ...');
  String get confirmBooking =>
      _t('Confirmer la réservation', 'Confirm booking', 'تأكيد الحجز');

  // helpers monnaie/format
  String daPerDay(num amount) => _t(
    '${amount.toStringAsFixed(0)} Da / jour',
    '${amount.toStringAsFixed(0)} Da / day',
    '${amount.toStringAsFixed(0)} دج / يوم',
  );

  String daTotal(num amount) => _t(
    '${amount.toStringAsFixed(0)} Da',
    '${amount.toStringAsFixed(0)} Da',
    '${amount.toStringAsFixed(0)} دج',
  );

  // --- AddCarsView ---
  String get postAd => _t('Déposer une annonce', 'Post an ad', 'نشر إعلان');

  String get stepSellerTitle =>
      _t('Infos vendeur', 'Seller info', 'معلومات البائع');
  String get stepCarTitle => _t('Infos voiture', 'Car info', 'معلومات السيارة');
  String get stepOptionsTitle => _t('Options', 'Options', 'الخيارات');
  String get stepPhotosTitle =>
      _t('Photos & CGU', 'Photos & Terms', 'الصور والشروط');

  String get stepSellerSubtitle => _t(
    'Confirme tes infos pour qu’on puisse te contacter.',
    'Confirm your info so we can contact you.',
    'أكّد معلوماتك حتى نتمكن من التواصل معك.',
  );
  String get stepCarSubtitle => _t(
    'Décris la voiture (marque, modèle, moteur, prix...).',
    'Describe the car (brand, model, engine, price...).',
    'صف السيارة (العلامة، الموديل، المحرك، السعر...).',
  );
  String get stepOptionsSubtitle => _t(
    'Choisis la catégorie et les équipements.',
    'Choose the category and equipment.',
    'اختر الفئة والتجهيزات.',
  );
  String get stepPhotosSubtitle => _t(
    'Ajoute de belles photos + accepte les CGU pour publier.',
    'Add nice photos + accept the terms to publish.',
    'أضف صورًا جيدة + وافق على الشروط للنشر.',
  );

  String get stepLabelSeller => _t('Vendeur', 'Seller', 'البائع');
  String get stepLabelCar => _t('Voiture', 'Car', 'السيارة');
  String get stepLabelOptions => _t('Options', 'Options', 'الخيارات');
  String get stepLabelPhotos => _t('Photos', 'Photos', 'الصور');

  String get addCarSuccessTitle => _t(
    'Voiture ajoutée avec succès',
    'Car added successfully',
    'تمت إضافة السيارة بنجاح',
  );
  String get adPublished => _t(
    'Votre annonce a été publiée.',
    'Your ad has been published.',
    'تم نشر إعلانك.',
  );
  String get addAnotherCar =>
      _t('Ajouter une autre voiture', 'Add another car', 'إضافة سيارة أخرى');

  // Champs / labels

  String get chooseWilaya =>
      _t('Choisir une wilaya', 'Choose a wilaya', 'اختر ولاية');
  String get chooseCommune =>
      _t('Choisir une commune', 'Choose a commune', 'اختر بلدية');
  String get selectWilayaFirst =>
      _t('Sélectionnez une wilaya', 'Select a wilaya', 'اختر ولاية أولاً');

  String get phone => _t('Téléphone', 'Phone', 'الهاتف');
  String get plate => _t('Matricule', 'Plate number', 'رقم التسجيل');

  String get brand => _t('Marque', 'Brand', 'العلامة');
  String get model => _t('Modèle', 'Model', 'الموديل');
  String get typeOrChooseBrand => _t(
    'Saisir ou choisir une marque',
    'Type or pick a brand',
    'اكتب أو اختر علامة',
  );
  String get typeOrChooseModel => _t(
    'Saisir ou choisir un modèle',
    'Type or pick a model',
    'اكتب أو اختر موديل',
  );
  String get chooseBrandFirst =>
      _t('Sélectionnez une marque', 'Select a brand', 'اختر علامة');

  String get year => _t('Année', 'Year', 'السنة');
  String get mileage => _t('Kilométrage', 'Mileage', 'المسافة المقطوعة');
  String get engine => _t('Moteur', 'Engine', 'المحرك');
  String get horsepower => _t('Chevaux', 'Horsepower', 'القوة');

  String get fuel => _t('Carburant', 'Fuel', 'الوقود');
  String get fuelGasoline => _t('Essence', 'Gasoline', 'بنزين');
  String get fuelDiesel => _t('Diesel', 'Diesel', 'ديزل');
  String get fuelHybrid => _t('Hybride', 'Hybrid', 'هجين');
  String get fuelElectric => _t('Électrique', 'Electric', 'كهربائي');

  String get gearbox => _t('Boîte de vitesses', 'Gearbox', 'ناقل الحركة');
  String get gearboxManual => _t('Manuelle', 'Manual', 'يدوي');
  String get gearboxAuto => _t('Automatique', 'Automatic', 'أوتوماتيك');

  String get priceDA => _t('Prix', 'Price', 'السعر');
  String get description => _t('Description', 'Description', 'الوصف');
  String get descriptionHint => _t(
    'État, options, entretien, remarques…',
    'Condition, options, maintenance, notes…',
    'الحالة، الخيارات، الصيانة، ملاحظات…',
  );

  String get offerType => _t('Type d’offre', 'Offer type', 'نوع العرض');
  String get offerFixed => _t('fixe', 'fixed', 'ثابت');
  String get offerNegotiable => _t('négociable', 'negotiable', 'قابل للتفاوض');
  String get offerPromo => _t('promotion', 'promotion', 'عرض');

  String get category => _t('Catégorie', 'Category', 'الفئة');
  String get categoryHint =>
      _t('Achat ou Location', 'Buy or Rent', 'شراء أو كراء');
  String get categoryBuy => _t('Achat', 'Buy', 'شراء');
  String get categoryRent => _t('Location', 'Rent', 'كراء');

  String get subcategory =>
      _t('Sous-catégorie', 'Subcategory', 'الفئة الفرعية');
  String get subcategoryHint => _t(
    'Neuf, Occasion, -3ans…',
    'New, Used, <3y…',
    'جديدة، مستعملة، أقل من 3 سنوات…',
  );
  String get subNew => _t('Neuf', 'New', 'جديدة');
  String get subUsed => _t('Occasion', 'Used', 'مستعملة');
  String get subLess3 => _t('-3 ans', '<3 years', 'أقل من 3 سنوات');
  String get subLess5 => _t('-5 ans', '<5 years', 'أقل من 5 سنوات');
  String get subImport => _t('Import', 'Import', 'مستوردة');

  String get options => _t('Options', 'Options', 'الخيارات');
  String get chooseOptions =>
      _t('Choisir des options', 'Choose options', 'اختر الخيارات');

  String addUpToPhotos(int max) => _tp(
    'Ajoute jusqu’à {max} photos (au moins 1).',
    'Add up to {max} photos (at least 1).',
    'أضف حتى {max} صور (على الأقل صورة واحدة).',
    {'max': '$max'},
  );

  String get acceptTerms =>
      _t('J’accepte les CGU', 'I accept the Terms', 'أوافق على الشروط');


  String useTyped(String typed) =>
      _tp('Utiliser : {v}', 'Use: {v}', 'استخدم: {v}', {'v': typed});

  // validations / messages
  String get digitsOnly =>
      _t('Chiffres uniquement', 'Digits only', 'أرقام فقط');
  String get nineOrTenDigits =>
      _t('9 ou 10 chiffres', '9 or 10 digits', '9 أو 10 أرقام');
  String get min10Chars => _t(
    'Au moins 10 caractères',
    'At least 10 characters',
    'على الأقل 10 أحرف',
  );

  String idUserMissing() =>
      _t('iduser manquant', 'Missing user id', 'معرّف المستخدم مفقود');

  // (si tu ne les as pas déjà)
  String addPhotosLimit(int max) => _tp(
    'Vous ne pouvez pas dépasser {max} photos.',
    'You can’t exceed {max} photos.',
    'لا يمكنك تجاوز {max} صور.',
    {'max': '$max'},
  );

  String get categoryLocation => _t('Locations', 'Rentals', 'كراء');
  String get categoryAchats => _t('Achats', 'Purchases', 'شراء');

  String get subNeuf => _t('Neuf', 'New', 'جديد');
  String get subOccasion => _t('Occasion', 'Used', 'مستعمل');
  String get subMinus5 => _t('-5 ans', '< 5 years', 'أقل من 5 سنوات');
  String get subMinus3 => _t('-3 ans', '< 3 years', 'أقل من 3 سنوات');
  String kmUnit(int km) => _t('$km km', '$km km', '$km كم');

  String kmLabel(String v) => _t('$v km', '$v km', '$v كم');
  String get dash => '—'; // ou _t('—','—','—')

  // --- Engine / Fuel ---
  String get fuelEssenceAbbrev => _t('ESS', 'GAS', 'بنزين');
  String get fuelDieselAbbrev => _t('DIE', 'DSL', 'ديزل');
  String get fuelHybridAbbrev => _t('HYB', 'HYB', 'هجين');
  String get fuelElectricAbbrev => _t('ELC', 'ELE', 'كهرباء');
  String get activateCarTitle => _t(
    'Activer l’annonce',
    'Activate listing',
    'تفعيل الإعلان',
  );

  String get activateCarMessage => _t(
    'Cette annonce sera visible par tous les utilisateurs.',
    'This listing will be visible to all users.',
    'سيصبح هذا الإعلان مرئيًا لجميع المستخدمين.',
  );

  String get suspendCarTitle => _t(
    'Suspendre l’annonce',
    'Suspend listing',
    'تعليق الإعلان',
  );

  String get suspendCarMessage => _t(
    'Cette annonce ne sera plus visible tant que vous ne la réactivez pas.',
    'This listing will no longer be visible until you reactivate it.',
    'لن يكون هذا الإعلان مرئيًا حتى تقوم بإعادة تفعيله.',
  );

  String get errorTitle => _t('Erreur', 'Error', 'خطأ');
  String get successTitle => _t('Succès', 'Success', 'نجاح');


  // =========================
  // Delete / Sold choices
  // =========================
  String get deleteCarTitlManage =>
      _t('Gérer l’annonce', 'Manage ad', 'إدارة الإعلان');

  String get deleteCarMessageAction => _t(
    'Choisissez une action pour cette voiture.',
    'Choose an action for this car.',
    'اختر إجراءً لهذه السيارة.',
  );

  String get markAsSoldTitle =>
      _t('Marquer comme vendue', 'Mark as sold', 'وضعها كمباعة');

  String get markAsSoldMessage => _t(
    'Voulez-vous marquer cette voiture comme vendue ?',
    'Do you want to mark this car as sold?',
    'هل تريد وضع هذه السيارة كمباعة؟',
  );

  String get sold =>
      _t('Vendu', 'Sold', 'مباعة');

  String get softDelete =>
      _t('Supprimer', 'Delete', 'حذف');

  // Optional: if you want explicit confirmation title/messages for delete
  String get confirmDeleteTitle =>
      _t('Supprimer l’annonce', 'Delete ad', 'حذف الإعلان');

  String get confirmDeleteMessage => _t(
    'Voulez-vous supprimer cette annonce ?',
    'Do you want to delete this ad?',
    'هل تريد حذف هذا الإعلان؟',
  );


  String get noCarsTitle => _t('No cars available', 'Aucune voiture disponible', 'لا توجد سيارات');
  String get noCarsMessage => _t(
    'There are currently no listings. Please try again later.',
    'Il n’y a aucune annonce pour le moment. Réessayez plus tard.',
    'لا توجد إعلانات حاليا. حاول لاحقاً.',
  );

  // Types véhicules
  String get vehicleTypeLabel =>
      _t('Type', 'Type', 'النوع');

  String get chooseVehicleType =>
      _t('Choisir le type', 'Choose type', 'اختر النوع');

// Valeurs (affichage UI)
  String get typeCitadine => _t('Citadine', 'City car', 'سيارة مدينة');
  String get typeBerline => _t('Berline', 'Sedan', 'سيدان');
  String get typeCompacte => _t('Compacte', 'Compact', 'مدمجة');
  String get typeBreak => _t('Break', 'Station wagon', 'ستيشن / واجن');
  String get typeCoupe => _t('Coupé', 'Coupe', 'كوبيه');
  String get typeCabriolet => _t('Cabriolet', 'Convertible', 'مكشوفة');
  String get typeMonospace => _t('Monospace', 'MPV', 'ميني فان / MPV');
  String get typeMinivan => _t('Minivan', 'Minivan', 'ميني فان');

  String get typeSuv => _t('SUV', 'SUV', 'SUV');
  String get type4x4 => _t('4x4', '4x4', 'دفع رباعي 4x4');
  String get typeCrossover => _t('Crossover', 'Crossover', 'كروس أوفر');

  String get typeUtilitaire => _t('Utilitaire', 'Commercial vehicle', 'مركبة نفعية');
  String get typeFourgon => _t('Fourgon', 'Van', 'فان');
  String get typeFourgonVitre => _t('Fourgon vitré', 'Passenger van', 'فان زجاجي');
  String get typePickUp => _t('Pick-up', 'Pickup', 'بيك آب');
  String get typeCamionnette => _t('Camionnette', 'Small truck', 'شاحنة صغيرة');
  String get typeMinibus => _t('Minibus', 'Minibus', 'حافلة صغيرة');

  String get typeCamion => _t('Camion', 'Truck', 'شاحنة');
  String get typeCamionBenne => _t('Camion benne', 'Dump truck', 'شاحنة قلاب');
  String get typeCamionCiterne => _t('Camion citerne', 'Tanker truck', 'شاحنة صهريج');
  String get typeCamionFrigorifique => _t('Camion frigorifique', 'Refrigerated truck', 'شاحنة مبردة');
  String get typeTracteurRoutier => _t('Tracteur routier', 'Road tractor', 'جرار طريق');
  String get typeSemiRemorque => _t('Semi-remorque', 'Semi-trailer', 'شبه مقطورة');

  String get typeChantier => _t('Chantier', 'Construction vehicle', 'مركبة أشغال');
  String get typeGrue => _t('Grue', 'Crane', 'رافعة');
  String get typeDepanneuse => _t('Dépanneuse', 'Tow truck', 'شاحنة سحب');
  String get typePlateau => _t('Plateau', 'Flatbed', 'سطحة');
  String get typeAmbulance => _t('Ambulance', 'Ambulance', 'إسعاف');
  String get typePompier => _t('Pompier', 'Fire truck', 'إطفاء');
  String get typePolice => _t('Police', 'Police', 'شرطة');
  String get typeMilitaire => _t('Militaire', 'Military', 'عسكري');
  String get webImagesHint =>
      _t(
        'Sur Web: sélectionnez vos images depuis Documents/Fichiers.',
        'On Web: select your images from Documents/Files.',
        'على الويب: اختر صورك من المستندات/الملفات.',
      );

  String get typeMoto => _t('Moto', 'Motorcycle', 'دراجة نارية');
  String get typeScooter => _t('Scooter', 'Scooter', 'سكوتر');
  String get typeTricycle => _t('Tricycle', 'Tricycle', 'ثلاثية العجلات');
  String get typeQuad => _t('Quad', 'ATV / Quad', 'رباعية الدفع');

  String get typeElectrique => _t('Électrique', 'Electric', 'كهربائية');
  String get typeHybride => _t('Hybride', 'Hybrid', 'هجينة');
  String get typeHydrogene => _t('Hydrogène', 'Hydrogen', 'هيدروجين');

  String get typeTracteurAgricole => _t('Tracteur agricole', 'Agricultural tractor', 'جرار فلاحي');
  String get typeMoissonneuse => _t('Moissonneuse', 'Combine harvester', 'حصادة');
  String get typeRemorqueAgricole => _t('Remorque agricole', 'Agricultural trailer', 'مقطورة فلاحية');

  String get typeAutre => _t('Autre', 'Other', 'أخرى');



  // Ajouts de traductions (même style que:  String get myCars => _t('My cars','Mes voitures','سياراتي'); )

  String get addCar => _t('Add a car', 'Ajouter une voiture', 'إضافة سيارة');
  String get addCarSubtitle => _t('Publish your vehicle in a few steps', 'Publiez votre véhicule en quelques étapes', 'انشر سيارتك في خطوات بسيطة');

  String get details => _t('Details', 'Détails', 'تفاصيل');
  String get images => _t('Images', 'Images', 'صور');
  String get addPhotos => _t('Add photos', 'Ajouter des photos', 'أضف صوراً');
  String get photos => _t('photos', 'photos', 'صور');

  String get title => _t('Title', 'Titre', 'العنوان');
  String get titleOptional => _t('Title (optional)', 'Titre (optionnel)', 'العنوان (اختياري)');

  String get type => _t('Type', 'Type', 'النوع');
  String get price => _t('Price', 'Prix', 'السعر');

  String get km => _t('Mileage', 'Kilométrage', 'المسافة');
  String get power => _t('Power (HP)', 'Puissance (CV)', 'القوة (حصان)');




  String get ribbon => _t('Ribbon', 'Ruban', 'شارة');
  String get more => _t('More', 'Plus', 'المزيد');

  String get uploading => _t('Uploading...', 'Téléversement...', 'جارٍ الرفع...');
  String get loading => _t('Loading...', 'Chargement...', 'جارٍ التحميل...');

  String get webUploadHint => _t(
    'Tip: on Web, use compressed images for faster upload.',
    'Astuce : sur Web, utilisez des images compressées pour un envoi plus rapide.',
    'نصيحة: على الويب، استخدم صوراً مضغوطة لرفع أسرع.',
  );

  String get mobileUploadHint => _t(
    'Tip: choose 3–8 clear photos.',
    'Astuce : choisissez 3 à 8 photos nettes.',
    'نصيحة: اختر من 3 إلى 8 صور واضحة.',
  );

// Erreurs / validations
  String get selectImagesHint => _t('You can add images', 'Vous pouvez ajouter des images', 'يمكنك إضافة صور');

  String get userNotLoggedIn => _t(
    'Please sign in to publish a car.',
    'Veuillez vous connecter pour publier une voiture.',
    'يرجى تسجيل الدخول لنشر سيارة.',
  );

  String get createCarSuccess => _t(
    'Your car has been published.',
    'Votre voiture a été publiée.',
    'تم نشر سيارتك.',
  );

  String get createCarFailed => _t(
    'Failed to publish the car.',
    'Échec de publication de la voiture.',
    'فشل نشر السيارة.',
  );
// =======================
// HINTS (exemples de données)
// =======================

  String get enterFirstName => _t(
    'Ex : Ahmed',
    'e.g. Ahmed',
    'مثال: أحمد',
  );

  String get enterLastName => _t(
    'Ex : Benali',
    'e.g. Benali',
    'مثال: بن علي',
  );

  String get enterBirthdate => _t(
    'Ex : 12/05/1995',
    'e.g. 12/05/1995',
    'مثال: 12/05/1995',
  );

  String get enterAddress => _t(
    'Ex : Alger, Hydra',
    'e.g. Algiers, Hydra',
    'مثال: الجزائر، حيدرة',
  );

  String get enterPhone => _t(
    'Ex : +213 555 12 34 56',
    'e.g. +213 555 12 34 56',
    'مثال: ‎+213 555 12 34 56',
  );

  String get enterMileage => _t(
    'Ex : 125000',
    'e.g. 125000',
    'مثال: 125000',
  );

  String get enterKmStart => _t(
    'Ex : 54230',
    'e.g. 54230',
    'مثال: 54230',
  );

  String get enterKmEnd => _t(
    'Ex : 54890',
    'e.g. 54890',
    'مثال: 54890',
  );

  String get enterPrice => _t(
    'Ex : 4500',
    'e.g. 4500',
    'مثال: 4500',
  );

  String get enterDeposit => _t(
    'Ex : 20000',
    'e.g. 20000',
    'مثال: 20000',
  );

  String get enterNumber => _t(
    'Ex : 10',
    'e.g. 10',
    'مثال: 10',
  );

  String get enterValue => _t(
    'Ex : valeur',
    'e.g. value',
    'مثال: قيمة',
  );
// ===== Partner / Pro profile =====

  String get proProfile => _t(
    'Profil Pro',
    'Pro Profile',
    'الملف المهني',
  );


  String get statusVerified => _t(
    'Vérifié',
    'Verified',
    'مُعتمد',
  );

  String get statusRejected => _t(
    'Refusé',
    'Rejected',
    'مرفوض',
  );

  String get verifiedAt => _t(
    'Vérifié le',
    'Verified at',
    'تاريخ التحقق',
  );

  String get sendRequest => _t(
    'Envoyer la demande',
    'Send request',
    'إرسال الطلب',
  );

  String get proAlreadyVerified => _t(
    'Votre profil Pro est déjà vérifié.',
    'Your Pro profile is already verified.',
    'ملفك المهني مُعتمد بالفعل.',
  );

  String get saved => _t(
    'Enregistré.',
    'Saved.',
    'تم الحفظ.',
  );


  String get invalid => _t(
    'Invalide',
    'Invalid',
    'غير صالح',
  );

  String get optional => _t(
    'Optionnel',
    'Optional',
    'اختياري',
  );



  String get pleaseFillAllFields => _t(
    'Veuillez remplir tous les champs requis.',
    'Please fill all required fields.',
    'يرجى ملء جميع الحقول المطلوبة.',
  );

// ===== Company fields =====


  String get companyName => _t(
    'Raison sociale',
    'Company name',
    'الاسم القانوني',
  );

  String get companyNameHint => _t(
    'Nom légal de l’entreprise',
    'Legal company name',
    'الاسم القانوني للشركة',
  );

  String get tradeName => _t(
    'Nom commercial',
    'Trade name',
    'الاسم التجاري',
  );

  String get companyType => _t(
    'Type de société',
    'Company type',
    'نوع الشركة',
  );

  String get taxRegime => _t(
    'Régime fiscal',
    'Tax regime',
    'النظام الضريبي',
  );

  String get rcNumber => _t(
    'RC',
    'RC number',
    'رقم السجل التجاري',
  );

  String get nifNumber => _t(
    'NIF',
    'NIF number',
    'الرقم الجبائي (NIF)',
  );

  String get nisNumber => _t(
    'NIS',
    'NIS number',
    'الرقم الإحصائي (NIS)',
  );

  String get vatNumber => _t(
    'N° TVA',
    'VAT number',
    'رقم الضريبة على القيمة المضافة',
  );

  String get editModeEnabled => _t(
    'Mode édition activé',
    'Edit mode enabled',
    'تم تفعيل وضع التعديل',
  );

  String get save => _t(
    'Enregistrer',
    'Save',
    'حفظ',
  );

// ===== Status messages (optional but useful) =====

  String get proRequestSent => _t(
    'Demande envoyée. Un administrateur va la vérifier.',
    'Request sent. An admin will review it.',
    'تم إرسال الطلب. سيقوم المسؤول بمراجعته.',
  );

  String get proRequestRejected => _t(
    'Votre demande a été refusée.',
    'Your request was rejected.',
    'تم رفض طلبك.',
  );

  String get proRequestPending => _t(
    'Votre demande est en attente de validation.',
    'Your request is pending validation.',
    'طلبك قيد المراجعة.',
  );
// ====== AJOUTE CES CLÉS DANS TA CLASSE WinyCar (FR / EN / AR) ======
// (mets-les à la suite de tes autres getters)

  String get contractTitle => _t(
    'CONTRAT DE LOCATION DE VÉHICULE',
    'VEHICLE RENTAL AGREEMENT',
    'عقد كراء مركبة',
  );

  String contractIssuedAt(String date) => _tp(
    "Date d'édition : {date}",
    'Issued on: {date}',
    'تاريخ الإصدار: {date}',
    {'date': date},
  );

  String get contractBlankLine => _t(
    '__________________',
    '__________________',
    '__________________',
  );

  String get contractPhoneBlank => _t(
    '__________',
    '__________',
    '__________',
  );

  String get contractDaysBlank => _t(
    '________ jour(s)',
    '________ day(s)',
    '________ يوم',
  );

  String get contractNotProvided => _t(
    'Non renseigné',
    'Not provided',
    'غير متوفر',
  );

  String get contractLessorFallback => _t(
    'Loueur',
    'Lessor',
    'المؤجر',
  );

  String get contractSectionPartiesTitle => _t(
    '1. Parties au contrat',
    '1. Parties',
    '1. أطراف العقد',
  );

  String get contractConcludedBetween => _t(
    'Le présent contrat est conclu entre :',
    'This agreement is made between:',
    'تم إبرام هذا العقد بين:',
  );

  String contractLessorLine(String name) => _tp(
    'Le loueur : {name}, ci-après désigné « le Loueur ».',
    'Lessor: {name}, hereinafter referred to as “the Lessor”.',
    'المؤجر: {name}، ويشار إليه فيما يلي بـ "المؤجر".',
    {'name': name},
  );

  String contractCompanyLine(String company) => _tp(
    'Entreprise (Loueur) : {company}',
    'Company (Lessor): {company}',
    'الشركة (المؤجر): {company}',
    {'company': company},
  );

  String contractTradeNameLine(String trade) => _tp(
    'Nom commercial : {trade}',
    'Trade name: {trade}',
    'الاسم التجاري: {trade}',
    {'trade': trade},
  );

  String contractCompanyTypeLine(String type) => _tp(
    'Type : {type}',
    'Type: {type}',
    'النوع: {type}',
    {'type': type},
  );

  String contractSiretLine(String siret) => _tp(
    'SIRET : {siret}',
    'SIRET: {siret}',
    'رقم السجل (SIRET): {siret}',
    {'siret': siret},
  );

  String contractRcNifNisLine(String rc, String nif, String nis) => _tp(
    'RC : {rc}  •  NIF : {nif}  •  NIS : {nis}',
    'RC: {rc}  •  NIF: {nif}  •  NIS: {nis}',
    'RC: {rc}  •  NIF: {nif}  •  NIS: {nis}',
    {'rc': rc, 'nif': nif, 'nis': nis},
  );

  String contractTaxVatLine(String tax, String vat) => _tp(
    'Régime fiscal : {tax}  •  TVA : {vat}',
    'Tax regime: {tax}  •  VAT: {vat}',
    'النظام الجبائي: {tax}  •  الضريبة (TVA): {vat}',
    {'tax': tax, 'vat': vat},
  );

  String contractProStatusLine(String status) => _tp(
    'Statut PRO : {status}',
    'PRO status: {status}',
    'حالة PRO: {status}',
    {'status': status},
  );

  String contractBornOn(String date) => _tp(
    ", né(e) le {date}",
    ", born on {date}",
    "، المولود(ة) في {date}",
    {'date': date},
  );

  String contractRenterLine({
    required String name,
    required String birthSuffix,
    required String address,
    required String phone,
    required String email,
  }) => _tp(
    'Le locataire : {name}{birth}, demeurant {address}, téléphone {phone}, e-mail {email}, ci-après désigné « le Locataire ».',
    'Renter: {name}{birth}, residing at {address}, phone {phone}, email {email}, hereinafter referred to as “the Renter”.',
    'المستأجر: {name}{birth}، القاطن بـ {address}، الهاتف {phone}، البريد {email}، ويشار إليه بـ "المستأجر".',
    {'name': name, 'birth': birthSuffix, 'address': address, 'phone': phone, 'email': email},
  );

  String get contractSectionObjectTitle => _t(
    '2. Objet de la location',
    '2. Purpose of the rental',
    '2. موضوع الكراء',
  );

  String get contractObjectParagraph => _t(
    'Le Loueur met à la disposition du Locataire, à titre de location, le véhicule décrit ci-dessous, pour la durée et aux conditions définies au présent contrat.',
    'The Lessor provides the Renter with the vehicle described below for the duration and under the terms set out in this agreement.',
    'يضع المؤجر رهن إشارة المستأجر المركبة الموصوفة أدناه لمدة ووفق شروط هذا العقد.',
  );

  String get contractSectionVehicleTitle => _t(
    '3. Description du véhicule',
    '3. Vehicle description',
    '3. وصف المركبة',
  );

  String get contractRentedVehicleLabel => _t(
    'Véhicule loué :',
    'Rented vehicle:',
    'المركبة المؤجرة:',
  );

  String contractVehicleBrandModelLine(String v) => _tp(
    'Marque / Modèle : {v}',
    'Make / Model: {v}',
    'النوع / الطراز: {v}',
    {'v': v},
  );

  String contractVehiclePlateLine(String v) => _tp(
    'Immatriculation : {v}',
    'Plate number: {v}',
    'رقم التسجيل: {v}',
    {'v': v},
  );

  String contractFuelLine(String v) => _tp(
    'Carburant : {v}',
    'Fuel: {v}',
    'الوقود: {v}',
    {'v': v},
  );

  String contractGearboxLine(String v) => _tp(
    'Boîte de vitesses : {v}',
    'Gearbox: {v}',
    'ناقل الحركة: {v}',
    {'v': v},
  );

  String contractKmStartLine(String v) => _tp(
    'Kilométrage au départ : {v}',
    'Start mileage: {v}',
    'عداد الانطلاق: {v}',
    {'v': v},
  );

  String contractKmEndLine(String v) => _tp(
    'Kilométrage au retour : {v}',
    'End mileage: {v}',
    'عداد الرجوع: {v}',
    {'v': v},
  );

  String get contractSectionDurationTitle => _t(
    '4. Durée de la location',
    '4. Rental period',
    '4. مدة الكراء',
  );

  String get contractPeriodIntro => _t(
    'La location est consentie pour la période suivante :',
    'The rental is agreed for the following period:',
    'تم الاتفاق على الكراء للفترة التالية:',
  );

  String contractPlannedStartLine(String v) => _tp(
    'Date de début théorique : {v}',
    'Planned start date: {v}',
    'تاريخ البداية المتوقع: {v}',
    {'v': v},
  );

  String contractPlannedEndLine(String v) => _tp(
    'Date de fin théorique : {v}',
    'Planned end date: {v}',
    'تاريخ النهاية المتوقع: {v}',
    {'v': v},
  );

  String contractActualStartLine(String v) => _tp(
    'Date et heure réelles de début : {v}',
    'Actual start date/time: {v}',
    'وقت/تاريخ البداية الفعلي: {v}',
    {'v': v},
  );

  String contractActualEndLine(String v) => _tp(
    'Date et heure réelles de fin : {v}',
    'Actual end date/time: {v}',
    'وقت/تاريخ النهاية الفعلي: {v}',
    {'v': v},
  );

  String contractDaysCount(int n) => _tp(
    '{n} jour(s)',
    '{n} day(s)',
    '{n} يوم',
    {'n': n.toString()},
  );

  String contractEstimatedDurationLine(String v) => _tp(
    'Durée estimée : {v}',
    'Estimated duration: {v}',
    'المدة المتوقعة: {v}',
    {'v': v},
  );

  String get contractSectionPriceTitle => _t(
    '5. Prix de la location et dépôt de garantie',
    '5. Price and security deposit',
    '5. السعر والضمان',
  );

  String contractPerDayForDays(String perDay, String days) => _tp(
    '({perDay} DA / jour pour {days} jour(s))',
    '({perDay} DA / day for {days} day(s))',
    '({perDay} دج / يوم لمدة {days} يوم)',
    {'perDay': perDay, 'days': days},
  );

  String contractBookingAmountLine(String total, String perDaySuffix) => _tp(
    'Montant de la location (booking) : {total} DA {perDay}.',
    'Rental amount (booking): {total} DA {perDay}.',
    'مبلغ الكراء (الحجز): {total} دج {perDay}.',
    {'total': total, 'perDay': perDaySuffix},
  );

  String contractDepositLine(String v) => _tp(
    'Dépôt de garantie : {v} DA',
    'Security deposit: {v} DA',
    'مبلغ الضمان: {v} دج',
    {'v': v},
  );

  String get contractDepositReturnParagraph => _t(
    'Le dépôt de garantie sera restitué au Locataire après restitution du véhicule et vérification de son état, déduction faite le cas échéant des sommes dues au Loueur (réparations, carburant manquant, frais divers…).',
    'The security deposit will be returned to the Renter after the vehicle is returned and its condition verified, minus any amounts due (repairs, missing fuel, fees, etc.).',
    'يتم إرجاع مبلغ الضمان بعد إعادة المركبة والتحقق من حالتها، مع خصم أي مبالغ مستحقة (إصلاحات، نقص الوقود، رسوم...).',
  );

// 6) Use
  String get contractSectionUseTitle => _t(
    '6. Utilisation du véhicule',
    '6. Vehicle use',
    '6. استعمال المركبة',
  );

  String get contractUseIntro => _t(
    "Le Locataire s'engage à utiliser le véhicule en « bon père de famille » et notamment à :",
    'The Renter agrees to use the vehicle responsibly and in particular to:',
    'يلتزم المستأجر باستعمال المركبة بشكل مسؤول وخاصة أن:',
  );

  String get contractUseRule1 => _t(
    'Respecter le Code de la route et l’ensemble des lois et règlements applicables.',
    'Comply with road traffic laws and all applicable regulations.',
    'يحترم قانون المرور وجميع القوانين والأنظمة المعمول بها.',
  );

  String get contractUseRule2 => _t(
    "Ne pas conduire le véhicule sous l'empire d'un état alcoolique ou sous l'influence de stupéfiants ou de médicaments affectant la conduite.",
    'Not drive under the influence of alcohol, drugs, or medication affecting driving.',
    'لا يقود تحت تأثير الكحول أو المخدرات أو الأدوية المؤثرة على القيادة.',
  );

  String get contractUseRule3 => _t(
    "Ne pas utiliser le véhicule pour le transport payant de personnes ou de marchandises, pour la sous-location ou pour toute activité illégale.",
    'Not use the vehicle for paid transport, subletting, or any illegal activity.',
    'لا يستعمل المركبة للنقل المأجور أو التأجير من الباطن أو أي نشاط غير قانوني.',
  );

  String get contractUseRule4 => _t(
    'Ne pas autoriser un tiers non identifié au contrat à conduire le véhicule.',
    'Not allow an unauthorized third party to drive the vehicle.',
    'لا يسمح لشخص غير مذكور في العقد بقيادة المركبة.',
  );

  String get contractUseRule5 => _t(
    'Ne pas participer avec le véhicule à des compétitions, courses ou essais.',
    'Not use the vehicle in races, competitions, or tests.',
    'لا يشارك بالمركبة في سباقات أو مسابقات أو تجارب.',
  );

  String get contractUseRule6 => _t(
    'Ne pas dépasser un kilométrage journalier maximal si prévu par les conditions particulières (à préciser le cas échéant).',
    'Not exceed any daily mileage limit if specified in the special conditions.',
    'لا يتجاوز الحد اليومي للكيلومترات إن وُجد ضمن الشروط الخاصة.',
  );

// 7) Insurance
  String get contractSectionInsuranceTitle => _t(
    '7. Assurance',
    '7. Insurance',
    '7. التأمين',
  );

  String get contractInsuranceParagraph => _t(
    "Le véhicule est couvert par une police d'assurance souscrite par le Loueur (responsabilité civile au minimum). Le Locataire déclare avoir pris connaissance des conditions d’assurance applicables.",
    'The vehicle is covered by an insurance policy taken out by the Lessor (at least third-party liability). The Renter acknowledges having read the applicable insurance terms.',
    'المركبة مؤمَّنة من طرف المؤجر (على الأقل المسؤولية المدنية). يقرّ المستأجر بالاطلاع على شروط التأمين.',
  );

  String get contractInsuranceRule1 => _t(
    'En cas de sinistre, le Locataire doit en informer immédiatement le Loueur et respecter les procédures de déclaration d’accident (constat amiable, dépôt de plainte si nécessaire, etc.).',
    'In case of an incident, the Renter must immediately inform the Lessor and follow the accident reporting procedures.',
    'في حالة حادث، يجب إبلاغ المؤجر فورًا واتباع إجراءات التصريح.',
  );

  String get contractInsuranceRule2 => _t(
    "Le Locataire reste responsable du paiement de toute franchise contractuelle prévue par le contrat d'assurance, ainsi que des dommages non couverts, en cas de faute de sa part ou d’usage non conforme.",
    'The Renter remains responsible for any deductible and any uninsured damage due to fault or improper use.',
    'يبقى المستأجر مسؤولًا عن أي تحمّل (Franchise) وأي أضرار غير مغطاة بسبب خطأ أو استعمال غير مطابق.',
  );

// 8) Liability
  String get contractSectionLiabilityTitle => _t(
    '8. Responsabilité – Dommages au véhicule',
    '8. Liability – Damage to the vehicle',
    '8. المسؤولية – أضرار المركبة',
  );

  String get contractLiabilityParagraph => _t(
    'Le Locataire est responsable de tout dommage matériel ou mécanique causé au véhicule pendant la durée de la location, sauf à démontrer qu’il n’en est pas à l’origine.',
    'The Renter is responsible for any material or mechanical damage during the rental period unless they prove they are not at fault.',
    'المستأجر مسؤول عن أي ضرر مادي أو ميكانيكي خلال مدة الكراء إلا إذا أثبت خلاف ذلك.',
  );

  String get contractLiabilityRule1 => _t(
    'En cas de dommage, les réparations seront effectuées par un professionnel choisi par le Loueur, sur la base d’un devis ou d’une expertise.',
    'In case of damage, repairs will be carried out by a professional chosen by the Lessor, based on an estimate or assessment.',
    'في حالة الضرر، تتم الإصلاحات لدى مهني يختاره المؤجر بناءً على تقدير/خبرة.',
  );

  String get contractLiabilityRule2 => _t(
    'Les coûts de réparation et d’immobilisation du véhicule pourront être imputés sur le dépôt de garantie, sans préjudice de toute action complémentaire si le montant du dépôt est insuffisant.',
    'Repair and immobilization costs may be deducted from the deposit; additional action may be taken if insufficient.',
    'يمكن خصم تكاليف الإصلاح وتوقف المركبة من الضمان، مع إمكانية المطالبة بالباقي إن كان غير كافٍ.',
  );

// 9) Maintenance
  String get contractSectionMaintenanceTitle => _t(
    '9. Entretien, carburant et niveau de charge',
    '9. Maintenance, fuel and charge level',
    '9. الصيانة والوقود ومستوى الشحن',
  );

  String get contractMaintenanceRule1 => _t(
    'Le Loueur remet le véhicule en bon état de fonctionnement et d’entretien courant.',
    'The Lessor provides the vehicle in good working order and with standard maintenance.',
    'يسلّم المؤجر المركبة في حالة تشغيل جيدة.',
  );

  String get contractMaintenanceRule2 => _t(
    'Le Locataire s’engage à surveiller les niveaux (huile, liquide de refroidissement, pression des pneus, etc.) et à alerter le Loueur en cas d’anomalie.',
    'The Renter agrees to monitor fluid levels and tire pressure and notify the Lessor in case of issues.',
    'يلتزم المستأجر بمراقبة المستويات والضغط وإبلاغ المؤجر عند وجود خلل.',
  );

  String get contractMaintenanceRule3 => _t(
    'Le véhicule est remis avec un niveau de carburant déterminé ; le Locataire devra le restituer avec le même niveau. À défaut, le Loueur pourra facturer le carburant manquant avec des frais supplémentaires.',
    'The vehicle is provided with a certain fuel level and must be returned with the same level; otherwise missing fuel may be charged with fees.',
    'تُسلّم المركبة بمستوى وقود محدد ويجب إرجاعها بنفس المستوى وإلا قد يتم احتساب النقص مع رسوم.',
  );

// 10) Fines
  String get contractSectionFinesTitle => _t(
    '10. Amendes et infractions',
    '10. Fines and violations',
    '10. الغرامات والمخالفات',
  );

  String get contractFinesParagraph => _t(
    'Le Locataire est entièrement responsable des amendes, contraventions et infractions commises pendant la durée de la location. Le Loueur pourra transmettre aux autorités les coordonnées du Locataire en cas de verbalisation.',
    'The Renter is fully responsible for fines and violations during the rental period. The Lessor may provide the Renter’s details to authorities.',
    'المستأجر مسؤول عن كل الغرامات والمخالفات خلال مدة الكراء ويمكن للمؤجر تقديم بيانات المستأجر للسلطات.',
  );

// 11) Incidents
  String get contractSectionIncidentsTitle => _t(
    '11. Accident, vol, panne',
    '11. Accident, theft, breakdown',
    '11. حادث، سرقة، عطل',
  );

  String get contractIncidentsRule1 => _t(
    'En cas d’accident, le Locataire doit immédiatement prévenir le Loueur, remplir un constat amiable et, le cas échéant, prévenir les forces de l’ordre.',
    'In case of an accident, the Renter must immediately inform the Lessor, complete an accident report and, if necessary, notify authorities.',
    'في حالة حادث، يجب إبلاغ المؤجر فورًا وملء محضر حادث وإبلاغ السلطات عند الحاجة.',
  );

  String get contractIncidentsRule2 => _t(
    'En cas de vol ou de tentative de vol, le Locataire doit déposer plainte auprès des autorités compétentes dans les plus brefs délais et transmettre une copie du procès-verbal au Loueur.',
    'In case of theft or attempted theft, the Renter must file a complaint promptly and provide the report to the Lessor.',
    'في حالة السرقة أو محاولة السرقة، يجب تقديم شكوى بسرعة وإرسال نسخة من المحضر للمؤجر.',
  );

  String get contractIncidentsRule3 => _t(
    'En cas de panne, le Locataire doit suivre les consignes du Loueur et ne pas faire réparer le véhicule sans accord préalable.',
    'In case of breakdown, the Renter must follow the Lessor’s instructions and not repair without prior approval.',
    'في حالة العطل، يجب اتباع تعليمات المؤجر وعدم الإصلاح دون موافقة مسبقة.',
  );

// 12) Return
  String get contractSectionReturnTitle => _t(
    '12. Restitution du véhicule',
    '12. Return of the vehicle',
    '12. إعادة المركبة',
  );

  String get contractReturnIntro => _t(
    'À l’issue de la location, le Locataire s’engage à restituer le véhicule :',
    'At the end of the rental, the Renter agrees to return the vehicle:',
    'عند نهاية الكراء يلتزم المستأجر بإرجاع المركبة:',
  );

  String get contractReturnRule1 => _t(
    'À la date, à l’heure et au lieu convenus avec le Loueur.',
    'At the agreed date, time and place with the Lessor.',
    'في التاريخ والوقت والمكان المتفق عليه مع المؤجر.',
  );

  String get contractReturnRule2 => _t(
    'Dans un état identique à celui constaté lors de la remise du véhicule, sous réserve de l’usure normale.',
    'In the same condition as at handover, allowing for normal wear and tear.',
    'بنفس الحالة عند التسليم مع مراعاة الاستهلاك العادي.',
  );

  String get contractReturnRule3 => _t(
    'Avec tous les accessoires fournis (clés, papiers, triangle, gilet, roue de secours, etc.).',
    'With all provided accessories (keys, documents, warning triangle, vest, spare wheel, etc.).',
    'مع جميع الملحقات (المفاتيح، الوثائق، مثلث التحذير، السترة، العجلة الاحتياطية...).',
  );

  String get contractReturnRule4 => _t(
    'Avec le niveau de carburant prévu (ou à défaut, ce qui pourra donner lieu à facturation).',
    'With the agreed fuel level (otherwise charges may apply).',
    'بمستوى الوقود المتفق عليه (وإلا قد يتم احتساب رسوم).',
  );

// 13) Termination
  String get contractSectionTerminationTitle => _t(
    '13. Résiliation anticipée',
    '13. Early termination',
    '13. فسخ مبكر',
  );

  String get contractTerminationParagraph => _t(
    'En cas de manquement grave du Locataire à l’une de ses obligations (non-paiement, usage non conforme, conduite dangereuse, etc.), le Loueur pourra résilier le contrat de plein droit, exiger la restitution immédiate du véhicule et conserver tout ou partie des sommes versées, sans préjudice de dommages et intérêts.',
    'In case of serious breach by the Renter (non-payment, improper use, dangerous driving, etc.), the Lessor may terminate the agreement, require immediate return of the vehicle and keep all or part of paid amounts, without prejudice to damages.',
    'في حالة إخلال جسيم من المستأجر (عدم الدفع، استعمال غير مطابق، قيادة خطيرة...) يمكن للمؤجر فسخ العقد وطلب الإرجاع الفوري واحتفاظه بجزء/كل المبالغ دون الإخلال بالتعويضات.',
  );

// 14) Privacy
  String get contractSectionPrivacyTitle => _t(
    '14. Données personnelles',
    '14. Personal data',
    '14. البيانات الشخصية',
  );

  String get contractPrivacyParagraph => _t(
    'Les informations concernant le Locataire sont collectées et utilisées aux seules fins de gestion du présent contrat, de facturation et de respect des obligations légales (par exemple, communication aux autorités en cas d’infractions).',
    'The Renter’s information is collected and used solely for managing this agreement, billing and legal compliance.',
    'تُجمع بيانات المستأجر وتُستخدم فقط لإدارة هذا العقد والفوترة والالتزامات القانونية.',
  );

// 15) Law
  String get contractSectionLawTitle => _t(
    '15. Droit applicable et juridiction compétente',
    '15. Governing law and jurisdiction',
    '15. القانون والاختصاص القضائي',
  );

  String get contractLawParagraph => _t(
    'Le présent contrat est régi par le droit applicable dans le pays où est immatriculé le véhicule. Tout litige relatif à sa validité, son interprétation ou son exécution sera soumis aux tribunaux compétents du ressort du siège ou du domicile du Loueur, sauf dispositions d’ordre public contraires.',
    'This agreement is governed by the law of the country where the vehicle is registered. Any dispute will be submitted to the competent courts of the Lessor’s seat or residence, subject to mandatory rules.',
    'يخضع هذا العقد لقانون بلد تسجيل المركبة. أي نزاع يُعرض على محاكم مقر/إقامة المؤجر مع مراعاة القواعد الآمرة.',
  );

// Summary + signatures
  String get contractSummaryTitle => _t(
    'Récapitulatif de la location',
    'Rental summary',
    'ملخص الكراء',
  );

  String contractSummaryVehicle(String v) => _tp(
    'Véhicule : {v}',
    'Vehicle: {v}',
    'المركبة: {v}',
    {'v': v},
  );

  String contractSummaryPeriodValue({required String start, required String end, required int days}) {
    final d = days > 0 ? ' ($days)' : '';
    return _t(
      'du $start au $end$d jour(s)',
      'from $start to $end$d day(s)',
      'من $start إلى $end$d يوم',
    );
  }

  String contractSummaryPeriod(String v) => _tp(
    'Période : {v}',
    'Period: {v}',
    'المدة: {v}',
    {'v': v},
  );

  String contractSummaryAmount({required String total, required String perDay}) => _t(
    perDay.isNotEmpty
        ? 'Montant location (booking) : $total DA • $perDay DA / jour'
        : 'Montant location (booking) : $total DA',
    perDay.isNotEmpty
        ? 'Rental amount (booking): $total DA • $perDay DA / day'
        : 'Rental amount (booking): $total DA',
    perDay.isNotEmpty
        ? 'مبلغ الكراء (الحجز): $total دج • $perDay دج / يوم'
        : 'مبلغ الكراء (الحجز): $total دج',
  );

// ====== RESTE DES CLÉS MANQUANTES (à ajouter dans WinyCar) ======

  String contractSummaryKmFinished(String kmStart, String kmEnd) => _tp(
    'Kilométrage départ : {s} • retour : {e}',
    'Start mileage: {s} • end: {e}',
    'عداد الانطلاق: {s} • عداد الرجوع: {e}',
    {'s': kmStart, 'e': kmEnd},
  );

  String contractSummaryKmStartOnly(String kmStart) => _tp(
    'Kilométrage départ : {s}',
    'Start mileage: {s}',
    'عداد الانطلاق: {s}',
    {'s': kmStart},
  );

  String get contractSignCopies => _t(
    'Fait en deux exemplaires originaux, à signer par le Loueur et le Locataire.',
    'Made in two original copies, to be signed by the Lessor and the Renter.',
    'حرر على نسختين أصليتين، يوقعهما المؤجر والمستأجر.',
  );

  String get contractLessorLabel => _t(
    'Le Loueur',
    'The Lessor',
    'المؤجر',
  );

  String get contractRenterLabel => _t(
    'Le Locataire',
    'The Renter',
    'المستأجر',
  );

  String get contractSignatureLabel => _t(
    'Signature :',
    'Signature:',
    'التوقيع:',
  );

  String get contractSignatureBlank => _t(
    '___________________________',
    '___________________________',
    '___________________________',
  );
// ====== RENTAL SUMMARY PDF (RÉCAPITULATIF) ======

  String get summaryTitleLoc => _t(
    'RÉCAPITULATIF DE LOCATION',
    'RENTAL SUMMARY',
    'ملخص الكراء',
  );

  String summaryIssuedAt(String date) => _tp(
    "Date d'édition : {date}",
    'Issued on: {date}',
    'تاريخ الإصدار: {date}',
    {'date': date},
  );

// Sections
  String get summarySectionParties => _t(
    '1. Parties',
    '1. Parties',
    '1. الأطراف',
  );

  String get summarySectionVehicle => _t(
    '2. Véhicule loué',
    '2. Rented vehicle',
    '2. المركبة المؤجرة',
  );

  String get summarySectionDates => _t(
    '3. Dates de location',
    '3. Rental dates',
    '3. تواريخ الكراء',
  );

  String get summarySectionMileage => _t(
    '4. Kilométrage',
    '4. Mileage',
    '4. العداد',
  );

  String get summarySectionFinance => _t(
    '5. Récapitulatif financier',
    '5. Financial summary',
    '5. الملخص المالي',
  );

  String get summarySectionPhotos => _t(
    '6. Photos (état des lieux)',
    '6. Photos (condition report)',
    '6. الصور (معاينة الحالة)',
  );

// Parties table labels
  String get summaryLessor => _t(
    'Loueur',
    'Lessor',
    'المؤجر',
  );

  String get summaryOwnerFallback => _t(
    'Propriétaire',
    'Owner',
    'المالك',
  );

  String get summaryRenter => _t(
    'Locataire',
    'Renter',
    'المستأجر',
  );

  String summaryEmailLine(String email) => _tp(
    'Email : {email}',
    'Email: {email}',
    'البريد: {email}',
    {'email': email},
  );

  String summaryBornOnLine(String date) => _tp(
    'Né(e) le : {date}',
    'Born on: {date}',
    'تاريخ الميلاد: {date}',
    {'date': date},
  );

  String summaryAddressLine(String address) => _tp(
    'Adresse : {address}',
    'Address: {address}',
    'العنوان: {address}',
    {'address': address},
  );

  String summaryPhoneLine(String phone) => _tp(
    'Téléphone : {phone}',
    'Phone: {phone}',
    'الهاتف: {phone}',
    {'phone': phone},
  );

// Vehicle table labels
  String get summaryVehicleLabel => _t(
    'Véhicule',
    'Vehicle',
    'المركبة',
  );

  String get summaryPlateLabel => _t(
    'Immatriculation',
    'Plate number',
    'رقم التسجيل',
  );

  String get summaryPlateNotProvided => _t(
    'Non renseignée',
    'Not provided',
    'غير متوفر',
  );

  String get summaryFuelLabel => _t(
    'Carburant',
    'Fuel',
    'الوقود',
  );

  String get summaryGearboxLabel => _t(
    'Boîte de vitesses',
    'Gearbox',
    'ناقل الحركة',
  );

// Dates table labels
  String get summaryPlannedStart => _t(
    'Début théorique',
    'Planned start',
    'بداية متوقعة',
  );

  String get summaryPlannedEnd => _t(
    'Fin théorique',
    'Planned end',
    'نهاية متوقعة',
  );

  String get summaryActualStart => _t(
    'Début réel',
    'Actual start',
    'بداية فعلية',
  );

  String get summaryActualEnd => _t(
    'Fin réelle',
    'Actual end',
    'نهاية فعلية',
  );

  String get summaryPlannedDuration => _t(
    'Durée théorique',
    'Planned duration',
    'المدة المتوقعة',
  );

  String get summaryActualDuration => _t(
    'Durée réelle',
    'Actual duration',
    'المدة الفعلية',
  );

  String get summaryDurationNotCalculated => _t(
    'Non calculée',
    'Not calculated',
    'غير محسوبة',
  );

  String get summaryDateNotProvidedF => _t(
    'Non renseignée',
    'Not provided',
    'غير متوفر',
  );

// Mileage table labels
  String get summaryKmStart => _t(
    'Kilométrage au départ',
    'Start mileage',
    'عداد الانطلاق',
  );

  String get summaryKmEnd => _t(
    'Kilométrage au retour',
    'End mileage',
    'عداد الرجوع',
  );

  String get summaryKmDelta => _t(
    'Kilométrage parcouru',
    'Distance traveled',
    'المسافة المقطوعة',
  );

  String get summaryNotProvided => _t(
    'Non renseigné',
    'Not provided',
    'غير متوفر',
  );

// Finance table labels
  String get summaryPricePerDay => _t(
    'Prix / jour',
    'Price / day',
    'السعر / يوم',
  );

  String get summaryTotalPlanned => _t(
    'Total théorique',
    'Planned total',
    'الإجمالي المتوقع',
  );

  String get summaryTotalActual => _t(
    'Total réel',
    'Actual total',
    'الإجمالي الفعلي',
  );

  String moneyDa(String amount) => _tp(
    '{amount} DA',
    '{amount} DA',
    '{amount} دج',
    {'amount': amount},
  );

// Photos
  String get summaryDeparture => _t(
    'Départ',
    'Start',
    'الانطلاق',
  );

  String get summaryReturn => _t(
    'Retour',
    'Return',
    'الرجوع',
  );

  String get summaryNoStartPhotos => _t(
    'Aucune photo de départ.',
    'No start photos.',
    'لا توجد صور عند الانطلاق.',
  );

  String get summaryNoEndPhotos => _t(
    'Aucune photo de retour.',
    'No return photos.',
    'لا توجد صور عند الرجوع.',
  );

// Footer paragraph
  String get summaryFooterParagraph => _t(
    'Le présent récapitulatif reprend les principales informations concernant la location terminée ci-dessus. '
        'Il ne remplace pas le contrat de location signé entre les parties mais en constitue un complément.',
    'This summary includes the main information about the completed rental above. '
        'It does not replace the rental agreement signed by the parties, but complements it.',
    'يتضمن هذا الملخص أهم المعلومات الخاصة بالكراء المنتهي أعلاه. '
        'ولا يعوّض عقد الكراء الموقّع بين الطرفين بل يُعد مكمّلاً له.',
  );

// Signatures
  String get summaryLessorLabel => _t(
    'Le Loueur',
    'The Lessor',
    'المؤجر',
  );

  String get summaryRenterLabel => _t(
    'Le Locataire',
    'The Renter',
    'المستأجر',
  );

  String get summarySignatureLabel => _t(
    'Signature :',
    'Signature:',
    'التوقيع:',
  );

  String get summarySignatureBlank => _t(
    '___________________________',
    '___________________________',
    '___________________________',
  );


  // ---- PROFORMA ----
  String get proformaTitle => _t('PRÉFACTURE (PROFORMA)', 'PROFORMA INVOICE', 'فاتورة مبدئية (بروفورما)');

  String proformaNumber(String no) => _t('N° : $no', 'No: $no', 'رقم: $no');

  String proformaIssuedAt(String date) => _t("Date d'édition : $date", 'Issue date: $date', 'تاريخ الإصدار: $date');

  String get proformaVatBoxTitle => _t('TVA', 'VAT', 'ضريبة القيمة المضافة');

  String proformaVatRate(String ratePercent) => _t('Taux : $ratePercent%', 'Rate: $ratePercent%', 'النسبة: $ratePercent%');

// Mention
  String get proformaDisclaimer => _t(
    "Ce document est une préfacture (proforma) et ne constitue pas une facture définitive.",
    "This document is a proforma invoice and does not constitute a final invoice.",
    "هذه الوثيقة فاتورة مبدئية (بروفورما) ولا تُعد فاتورة نهائية.",
  );

// Sections
  String get proformaSectionParties => _t('1. Parties', '1. Parties', '1. الأطراف');
  String get proformaSectionVehicle => _t('2. Véhicule', '2. Vehicle', '2. المركبة');
  String get proformaSectionPeriod => _t('3. Période & estimation', '3. Period & estimate', '3. المدة والتقدير');
  String get proformaSectionTotal => _t('4. Total estimé', '4. Estimated total', '4. المجموع التقديري');

// Table titles
  String get proformaLessor => _t('Loueur', 'Lessor', 'المؤجِّر');
  String get proformaClient => _t('Client', 'Client', 'الزبون');

  String get proformaVehicleLabel => _t('Véhicule', 'Vehicle', 'المركبة');
  String get proformaPlateLabel => _t('Immatriculation', 'License plate', 'رقم التسجيل');

  String get proformaStartTheoretical => _t('Début (théorique)', 'Start (planned)', 'البداية (مخطط)');
  String get proformaEndTheoretical => _t('Fin (théorique)', 'End (planned)', 'النهاية (مخطط)');
  String get proformaDuration => _t('Durée', 'Duration', 'المدة');
  String get proformaEstimatedDays => _t('Jours estimés', 'Estimated days', 'الأيام المقدرة');

  String get proformaPricePerDayTtc => _t('Prix / jour (TTC)', 'Price / day (incl. tax)', 'السعر / يوم (شامل الضريبة)');

  String get proformaAmountHt => _t('Montant HT', 'Amount (excl. tax)', 'المبلغ دون ضريبة');
  String proformaVatLine(String ratePercent) => _t('TVA $ratePercent%', 'VAT $ratePercent%', 'ضريبة $ratePercent%');
  String get proformaTotalTtc => _t('Total TTC', 'Total (incl. tax)', 'المجموع شامل الضريبة');

// Footer / signatures
  String get proformaThanks => _t('Merci pour votre confiance.', 'Thank you for your trust.', 'شكرًا لثقتكم.');
  String get proformaSignatureLessor => _t('Signature Loueur', 'Lessor signature', 'توقيع المؤجّر');
  String get proformaSignatureClient => _t('Signature Client', 'Client signature', 'توقيع الزبون');

// Generic
  String get proformaNotProvided => _t('Non renseigné', 'Not provided', 'غير متوفر');
  String get proformaDash => _t('—', '—', '—');

// Units formatting (optionnel)
  String proformaMinutes(String m) => _t('$m min', '$m min', '$m دقيقة');
  String proformaHours(String h) => _t('${h}h', '${h}h', '$h ساعة');
  String proformaDaysShort(String d) => _t('${d}j', '${d}d', '$d يوم');
  String get labelEmail => _t(
    'Email',
    'Email',
    'البريد الإلكتروني',
  );

  String get labelPhone => _t(
    'Téléphone',
    'Phone',
    'الهاتف',
  );

  String get labelAddress => _t(
    'Adresse',
    'Address',
    'العنوان',
  );

  String get labelCompanyName => _t(
    'Raison sociale',
    'Company name',
    'الاسم القانوني',
  );

  String get labelTradeName => _t(
    'Nom commercial',
    'Trade name',
    'الاسم التجاري',
  );

  String get labelCompanyType => _t(
    'Type de société',
    'Company type',
    'نوع الشركة',
  );

  String get labelSiret => _t(
    'SIRET / Identifiant',
    'SIRET / Identifier',
    'المعرّف / رقم التسجيل',
  );

  String get labelProStatus => _t(
    'Statut pro',
    'Pro status',
    'حالة الحساب المهني',
  );

  String get invoiceTitle => _t('FACTURE', 'INVOICE', 'فاتورة');
  String invoiceNumber(String no) => _t('N° : $no', 'No: $no', 'رقم: $no');
  String invoiceIssuedAt(String d) =>
      _t("Date d'édition : $d", 'Issue date: $d', 'تاريخ الإصدار: $d');

// TVA
  String get invoiceVatBoxTitle => _t('TVA', 'VAT', 'الضريبة على القيمة المضافة');
  String invoiceVatRate(String p) =>
      _t('Taux : $p%', 'Rate: $p%', 'النسبة: $p%');
  String invoiceVatLine(String p) =>
      _t('TVA $p%', 'VAT $p%', 'ضريبة $p%');

// Sections
  String get invoiceSectionParties => _t('1. Parties', '1. Parties', '1. الأطراف');
  String get invoiceSectionVehicle => _t('2. Véhicule', '2. Vehicle', '2. المركبة');
  String get invoiceSectionPeriod =>
      _t('3. Période & facturation', '3. Period & billing', '3. المدة والفوترة');
  String get invoiceSectionTotal => _t('4. Total', '4. Total', '4. المجموع');

// Parties
  String get invoiceLessor => _t('Loueur', 'Lessor', 'المؤجر');
  String get invoiceClient => _t('Client', 'Client', 'الزبون');

// Véhicule
  String get invoiceVehicleLabel => _t('Véhicule', 'Vehicle', 'المركبة');
  String get invoicePlateLabel =>
      _t('Immatriculation', 'Registration', 'رقم التسجيل');

// Période
  String get invoiceStartUsed =>
      _t('Début (utilisé)', 'Start (used)', 'بداية الاستعمال');
  String get invoiceEndUsed =>
      _t('Fin (utilisée)', 'End (used)', 'نهاية الاستعمال');
  String get invoiceDuration => _t('Durée', 'Duration', 'المدة');
  String get invoiceBilledDays =>
      _t('Jours facturés', 'Billed days', 'الأيام المفوترة');
  String get invoicePricePerDayTtc =>
      _t('Prix / jour (TTC)', 'Price / day (incl. tax)', 'السعر لليوم (شامل الضريبة)');

// Totaux
  String get invoiceAmountHt =>
      _t('Montant HT', 'Amount excl. tax', 'المبلغ دون ضريبة');
  String get invoiceTotalTtc =>
      _t('Total TTC', 'Total incl. tax', 'المجموع شامل الضريبة');

// Footer
  String get invoiceThanks =>
      _t('Merci pour votre confiance.', 'Thank you for your trust.', 'شكرًا لثقتكم');
  String get invoiceSignatureLessor =>
      _t('Signature Loueur', 'Lessor signature', 'توقيع المؤجر');
  String get invoiceSignatureClient =>
      _t('Signature Client', 'Client signature', 'توقيع الزبون');

// Temps / Durée
  String invoiceMinutes(String m) => _t('$m min', '$m min', '$m دقيقة');
  String invoiceHours(String h) => _t('${h}h', '${h}h', '$h ساعة');
  String invoiceDaysShort(String d) => _t('${d}j', '${d}d', '$d يوم');

// Fallbacks
  String get invoiceDash => _t('—', '—', '—');
  String get invoiceNotProvided =>
      _t('Non renseigné', 'Not provided', 'غير متوفر');


  String get offersLoadError =>
      _t('Erreur de chargement des offres.', 'Error loading offers.', 'خطأ في تحميل العروض');

  String get offersEurOnlyInfo =>
      _t(
        'Paiement disponible actuellement uniquement en EUR.',
        'Payment currently available only in EUR.',
        'الدفع متاح حالياً باليورو فقط',
      );

  String get offersMyCurrent =>
      _t('Mon offre actuelle', 'My current plan', 'عرضي الحالي');

  String get offersCancelBtn =>
      _t('Annuler l’abonnement', 'Cancel subscription', 'إلغاء الاشتراك');

  String get offersCancelTitle =>
      _t('Annuler l’abonnement', 'Cancel subscription', 'إلغاء الاشتراك');

  String get offersCancelDesc =>
      _t(
        'Tu peux annuler à tout moment.\n'
            'L’accès reste actif jusqu’à la fin de la période payée, puis tu repasses en offre gratuite automatiquement.',
        'You can cancel anytime.\n'
            'Access remains active until the end of the paid period, then you return automatically to the free plan.',
        'يمكنك الإلغاء في أي وقت.\n'
            'يبقى الوصول نشطاً حتى نهاية الفترة المدفوعة ثم تعود تلقائياً إلى العرض المجاني.',
      );

  String get offersCancelPlanned =>
      _t(
        'Annulation programmée.',
        'Cancellation scheduled.',
        'تمت جدولة الإلغاء.',
      );

  String get offersFreeLabel =>
      _t('Offre gratuite', 'Free plan', 'عرض مجاني');

  String get offersSubtitleFree =>
      _t('Offre gratuite', 'Free plan', 'عرض مجاني');

  String get offersSubtitleClient =>
      _t('Pour particuliers', 'For individuals', 'للأفراد');

  String get offersSubtitlePro =>
      _t('Pour professionnels', 'For professionals', 'للمهنيين');

  String get offersSubtitleDefault =>
      _t('Offre', 'Plan', 'عرض');

  String get offersPriceFreeDa =>
      _t('0 DA', '0 DA', '0 دج');

  String offersPriceDa(String price) =>
      _t('$price DA', '$price DA', '$price دج');

  String offersPricePerMonthDa(String price) =>
      _t('$price DA / mois', '$price DA / month', '$price دج / شهر');

  String offersPricePerYearDa(String price) =>
      _t('$price DA / an', '$price DA / year', '$price دج / سنة');

  String get offersPriceFreeEur =>
      _t('0 €', '0 €', '0 €');

  String offersPriceEur(String price) =>
      _t('$price €', '$price €', '$price €');

  String offersPricePerMonthEur(String price) =>
      _t('$price € / mois', '$price € / month', '$price € / شهر');

  String offersPricePerYearEur(String price) =>
      _t('$price € / an', '$price € / year', '$price € / سنة');

  String get offersBadgeCurrent =>
      _t('ACTUELLE', 'CURRENT', 'الحالية');

  String get offersBadgePro =>
      _t('PRO', 'PRO', 'مهني');

  String get offersBadgeClient =>
      _t('CLIENT', 'CLIENT', 'عميل');

  String get offersBadgeAll =>
      _t('ALL', 'ALL', 'الكل');

  String get offersAlreadyActive =>
      _t('Déjà active', 'Already active', 'مفعلة بالفعل');

  String get offersAlreadyOnThis =>
      _t(
        'Tu es déjà sur cette offre.',
        'You are already on this plan.',
        'أنت مشترك بالفعل في هذا العرض.',
      );

  String get offersCancelToChange =>
      _t(
        'Annule pour changer',
        'Cancel to change',
        'قم بالإلغاء للتغيير',
      );

  String get offersCancelToChangeMsg =>
      _t(
        'Annule ton abonnement actuel pour changer d’offre.',
        'Cancel your current subscription to change plan.',
        'قم بإلغاء اشتراكك الحالي لتغيير العرض.',
      );

  String get offersFreeMsg =>
      _t(
        'Offre gratuite.',
        'Free plan.',
        'عرض مجاني.',
      );

  List<String> get offersFreePerks => [
    _t('Accès à l’app', 'App access', 'الوصول إلى التطبيق'),
    _t('Réservation de base', 'Basic booking', 'حجز أساسي'),
  ];

  List<String> get offersComingSoonPerks => [
    _t('Avantages à venir', 'Benefits coming soon', 'مزايا قادمة'),
  ];

  String get commonChoose =>
      _t('Choisir', 'Choose', 'اختيار');

  String get commonBack =>
      _t('Retour', 'Back', 'رجوع');

  String get commonCancel =>
      _t('Annuler', 'Cancel', 'إلغاء');

  String commonError(String e) =>
      _t('Erreur : $e', 'Error: $e', 'خطأ: $e');

  String commonPaymentError(String e) =>
      _t('Paiement : $e', 'Payment: $e', 'الدفع: $e');
  String get proProfileTitle =>
      _t('Profil professionnel', 'Professional profile', 'الملف المهني');

  String get proProfileBecome =>
      _t('Devenir PRO', 'Become PRO', 'التحول إلى محترف');

  String get proProfileMyProfile =>
      _t('Mon profil PRO', 'My PRO profile', 'ملفي المهني');

  String get proProfileInfoNotPro =>
      _t(
        'Passe en PRO pour publier tes voitures et gérer tes offres.',
        'Switch to PRO to publish your cars and manage your offers.',
        'انتقل إلى الوضع المهني لنشر سياراتك وإدارة عروضك.',
      );

  String get proProfileInfoPending =>
      _t(
        'Demande PRO en cours de validation.',
        'PRO request under review.',
        'طلب الاحتراف قيد المراجعة.',
      );

  String get proProfileInfoRejected =>
      _t(
        'Demande PRO rejetée. Modifie et renvoie.',
        'PRO request rejected. Edit and resend.',
        'تم رفض طلب الاحتراف. عدّل وأعد الإرسال.',
      );

  String get proProfileInfoVerified =>
      _t(
        'Compte PRO validé.',
        'PRO account approved.',
        'تمت الموافقة على الحساب المهني.',
      );

  String get proProfileStatusPro =>
      _t('PRO', 'PRO', 'محترف');

  String get proFieldCompanyName =>
      _t('Raison sociale', 'Company name', 'الاسم القانوني');

  String get proFieldTradeName =>
      _t('Nom commercial', 'Trade name', 'الاسم التجاري');

  String get proFieldCompanyType =>
      _t('Type société', 'Company type', 'نوع الشركة');

  String get proFieldSiret =>
      _t('SIRET', 'SIRET', 'رقم SIRET');

  String get proFieldRc =>
      _t('RC', 'Trade register', 'السجل التجاري');

  String get proFieldNif =>
      _t('NIF', 'Tax ID (NIF)', 'الرقم الجبائي');

  String get proFieldNis =>
      _t('NIS', 'Statistical ID (NIS)', 'الرقم الإحصائي');

  String get proFieldTax =>
      _t('Régime fiscal', 'Tax regime', 'النظام الجبائي');

  String get proFieldVat =>
      _t('TVA', 'VAT', 'الضريبة على القيمة المضافة');

  String get proActionSendRequest =>
      _t('Envoyer la demande', 'Send request', 'إرسال الطلب');

  String get proActionEdit =>
      _t('Modifier', 'Edit', 'تعديل');

  String get proActionSave =>
      _t('Enregistrer', 'Save', 'حفظ');

  String get proValidationRequired =>
      _t('Requis', 'Required', 'مطلوب');

  String get proValidationSiret =>
      _t('14 chiffres', '14 digits', '14 رقم');
  String get referralTitle =>
      _t('Parrainage', 'Referral', 'الإحالة');

  String get referralActive =>
      _t('Parrainage actif', 'Referral active', 'الإحالة مفعّلة');

  String get referralDisabled =>
      _t('Parrainage désactivé', 'Referral disabled', 'الإحالة معطّلة');

  String get referralBlockedDefault =>
      _t(
        'Système de parrainage non disponible (protection anti-usurpation / multi-comptes).',
        'Referral system unavailable (anti-fraud / multi-account protection).',
        'نظام الإحالة غير متاح حالياً (حماية من الاحتيال وتعدد الحسابات).',
      );

  String get referralCopiedTitle =>
      _t('Copié', 'Copied', 'تم النسخ');

  String get referralCopiedMessage =>
      _t(
        'Le texte a été copié dans le presse-papiers.',
        'The text has been copied to the clipboard.',
        'تم نسخ النص إلى الحافظة.',
      );

  String get referralUnavailable =>
      _t(
        'Code parrain indisponible pour le moment.',
        'Referral code unavailable at the moment.',
        'رمز الإحالة غير متوفر حالياً.',
      );

  String referralShareText(String code, String url) =>
      _t(
        'Rejoins WinyCar avec mon code $code\n$url',
        'Join WinyCar with my code $code\n$url',
        'انضم إلى WinyCar باستخدام الرمز $code\n$url',
      );

  String get referralInviteSubject =>
      _t('Invitation WinyCar', 'WinyCar Invitation', 'دعوة WinyCar');

  String get referralBudgetTotal =>
      _t('Budget total', 'Total budget', 'الميزانية الإجمالية');

  String get referralBudgetUsed =>
      _t('Utilisé', 'Used', 'المستخدم');

  String get referralBudgetRemaining =>
      _t('Reste', 'Remaining', 'المتبقي');

  String get referralMyCode =>
      _t('Mon code parrain', 'My referral code', 'رمز الإحالة الخاص بي');

  String get referralShareLink =>
      _t('Lien de partage', 'Share link', 'رابط المشاركة');

  String get referralShare =>
      _t('Partager', 'Share', 'مشاركة');

  String get referralInvited =>
      _t('Invités', 'Invited', 'المدعوون');

  String get referralValidated =>
      _t('Validés', 'Validated', 'تم التحقق');

  String get referralBalance =>
      _t('Solde', 'Balance', 'الرصيد');

  String get referralMyReferrals =>
      _t('Mes filleuls', 'My referrals', 'المحالون');

  String get referralEmpty =>
      _t(
        'Aucun parrainage pour le moment.',
        'No referrals yet.',
        'لا توجد إحالات حالياً.',
      );

  String get referralUser =>
      _t('Utilisateur', 'User', 'مستخدم');

  String get referralPending =>
      _t('En attente', 'Pending', 'قيد الانتظار');

  String referralItemPending(String created) =>
      _t(
        'Inscrit le $created',
        'Registered on $created',
        'تم التسجيل في $created',
      );

  String referralItemValidated(String created, String validated) =>
      _t(
        'Inscrit le $created • Validé le $validated',
        'Registered on $created • Validated on $validated',
        'تم التسجيل في $created • تم التحقق في $validated',
      );

  String get loadingg =>
      _t('Chargement...', 'Loading...', 'جارٍ التحميل...');

  String get retry =>
      _t('Réessayer', 'Retry', 'إعادة المحاولة');


  String referralInfo(int youPoints, int friendPoints) =>
      _t(
        'Invite tes amis avec ton code. Ils doivent terminer une location pour valider.\n\n'
            'Récompense: $youPoints points pour toi + $friendPoints points pour ton ami (après validation).',
        'Invite your friends with your code. They must complete a rental to validate.\n\n'
            'Reward: $youPoints points for you + $friendPoints points for your friend (after validation).',
        'ادعُ أصدقاءك باستخدام رمزك. يجب عليهم إكمال عملية كراء للتأكيد.\n\n'
            'المكافأة: $youPoints نقطة لك + $friendPoints نقطة لصديقك (بعد التحقق).',
      );



  // ===== DetailsCarsView translations =====

  String get editCar => _t(
    'Modifier la voiture',
    'Edit car',
    'تعديل السيارة',
  );

  String get cannotSave => _t(
    'Impossible d’enregistrer',
    'Unable to save',
    'تعذر الحفظ',
  );


  String get suspend => _t(
    'Suspendre',
    'Suspend',
    'تعليق',
  );

  String get activate => _t(
    'Activer',
    'Activate',
    'تفعيل',
  );


// ---- Fields labels / hints used in DetailsCarsView ----



  String get enterTitle => _t(
    'Saisir un titre',
    'Enter a title',
    'أدخل عنوانًا',
  );


  String get enterBrand => _t(
    'Saisir la marque',
    'Enter brand',
    'أدخل الماركة',
  );

  String get enterModel => _t(
    'Saisir le modèle',
    'Enter model',
    'أدخل الموديل',
  );


  String get plateNumber => _t(
    'Matricule',
    'Plate number',
    'رقم اللوحة',
  );

  String get enterPlateNumber => _t(
    'Saisir le matricule',
    'Enter plate number',
    'أدخل رقم اللوحة',
  );


  String get vehicleType => _t(
    'Type de véhicule',
    'Vehicle type',
    'نوع المركبة',
  );


  String get selectWilaya => _t(
    'Choisir une wilaya',
    'Select a wilaya',
    'اختر ولاية',
  );

  String get selectCommune => _t(
    'Choisir une commune',
    'Select a commune',
    'اختر بلدية',
  );


  String get enterDescription => _t(
    'Ajouter une description…',
    'Add a description…',
    'أضف وصفًا…',
  );

  String get generalInfo => _t(
    'Informations générales',
    'General information',
    'معلومات عامة',
  );

  String get characteristics => _t(
    'Caractéristiques',
    'Characteristics',
    'الخصائص',
  );


  String get active => _t(
    'Active',
    'Active',
    'نشطة',
  );

  String get characteristicsShort => _t(
    'Infos techniques',
    'Technical info',
    'معلومات تقنية',
  );

  String get add => _t(
    'Ajouter',
    'Add',
    'إضافة',
  );


  String get missingCarId => _t(
    'Identifiant de voiture manquant.',
    'Missing car id.',
    'معرّف السيارة مفقود.',
  );

  String get carNotFound => _t(
    'Voiture introuvable.',
    'Car not found.',
    'السيارة غير موجودة.',
  );

  String get firstNameInvalid => _t('Prénom invalide', 'Invalid first name', 'اسم غير صالح');
  String get lastNameInvalid => _t('Nom invalide', 'Invalid last name', 'لقب غير صالح');
  String get hasReferralCode =>
      _t('Avez-vous un code de parrainage ?', 'Do you have a referral code?', 'هل لديك رمز إحالة؟');

  String get referralCode => _t('Code de parrainage', 'Referral code', 'رمز الإحالة');
  String get referralCodeHint => 'WINY-ABC123';
  String get referralCodeRequired =>
      _t('Code de parrainage requis', 'Referral code required', 'رمز الإحالة مطلوب');
  String get referralCodeInvalid =>
      _t('Code invalide', 'Invalid code', 'رمز غير صالح');
  String get passwordHint => '••••••••';

  String get chooseImagesDocs => _t(
    'Choisir des images (Documents)',
    'Choose images (Files)',
    'اختر الصور (الملفات)',
  );

  String get chooseFromGallery => _t(
    'Choisir depuis la galerie',
    'Choose from gallery',
    'اختر من المعرض',
  );

  String remainingPhotosLabel(int remaining, int max) => _tp(
    'Restant: {r} / {m}',
    'Remaining: {r} / {m}',
    'المتبقي: {r} / {m}',
    {'r': '$remaining', 'm': '$max'},
  );

  String get takePhoto => _t(
    'Prendre une photo',
    'Take a photo',
    'التقاط صورة',
  );

  String get close => _t(
    'Fermer',
    'Close',
    'إغلاق',
  );

  String get ownerRuntimeBtnInvoice => _t('Facture', 'Invoice', 'فاتورة');
  String get ownerRuntimeBtnProforma => _t('Proforma', 'Proforma', 'عرض سعر');
  String ownerRuntimePdfInvoiceError(String e) => _tp(
    'Erreur génération facture: {e}',
    'Invoice generation error: {e}',
    'خطأ في إنشاء الفاتورة: {e}',
    {'e': e},
  );
  String ownerRuntimePdfProformaError(String e) => _tp(
    'Erreur génération proforma: {e}',
    'Proforma generation error: {e}',
    'خطأ في إنشاء عرض السعر: {e}',
    {'e': e},
  );

  // ✅ Owner booking details page

  String get ownerBookingDetailsTitle =>
      _t('Détails', 'Details', 'التفاصيل');

  String ownerBookingDetailsId(String id) =>
      _tp('ID: {id}', 'ID: {id}', 'المعرف: {id}', {'id': id});

  String get ownerBookingDetailsNotFoundTitle =>
      _t('Réservation introuvable', 'Booking not found', 'الحجز غير موجود');

  String get ownerBookingDetailsRetry =>
      _t('Ré-essayer', 'Retry', 'إعادة المحاولة');

  String get ownerBookingDetailsCreatedAtLabel =>
      _t('Créée', 'Created', 'تم الإنشاء');

  String get ownerBookingDetailsDatesSection =>
      _t('Dates', 'Dates', 'التواريخ');

  String get ownerBookingDetailsExpectedStart =>
      _t('Début prévu', 'Expected start', 'بداية متوقعة');

  String get ownerBookingDetailsExpectedEnd =>
      _t('Fin prévue', 'Expected end', 'نهاية متوقعة');

  String get ownerBookingDetailsRealStart =>
      _t('Début réel', 'Actual start', 'بداية فعلية');

  String get ownerBookingDetailsRealEnd =>
      _t('Fin réelle', 'Actual end', 'نهاية فعلية');

  String get ownerBookingDetailsRenterSection =>
      _t('Locataire (runtime)', 'Renter (runtime)', 'المستأجر (أثناء التشغيل)');

  String get ownerBookingDetailsRuntimeSection =>
      _t('Runtime', 'Runtime', 'التشغيل');

  String get ownerBookingDetailsKmStart =>
      _t('KM départ', 'Start km', 'كيلومتر البداية');

  String get ownerBookingDetailsKmEnd =>
      _t('KM retour', 'End km', 'كيلومتر النهاية');

  String get ownerBookingDetailsNoImages =>
      _t('Aucune image', 'No images', 'لا توجد صور');

  String get ownerBookingDetailsActionsSection =>
      _t('Actions', 'Actions', 'إجراءات');

  String ownerBookingDetailsNoActionForStatus(String st) => _tp(
    'Aucune action disponible pour status: {st}',
    'No action available for status: {st}',
    'لا توجد إجراءات للحالة: {st}',
    {'st': st},
  );

  String ownerBookingDetailsInvalidActionForStatus(String st) => _tp(
    'Action impossible pour status: {st}',
    'Action not allowed for status: {st}',
    'الإجراء غير مسموح للحالة: {st}',
    {'st': st},
  );
  String get birthdate =>
      _t('Date de naissance', 'Birthdate', 'تاريخ الميلاد');

  String get address =>
      _t('Adresse', 'Address', 'العنوان');

  String get name =>
      _t('Nom', 'Name', 'الاسم');

// ================== ParrainageView – clés + traductions ==================

  String get referralHeroLine => _t(
    'Invitez vos amis et gagnez 10 pts à chaque parrainage.',
    'Invite your friends and earn 10 points for each referral.',
    'ادعُ أصدقاءك واحصل على 10 نقاط مقابل كل إحالة.',
  );

  String get referralInfoDialogMessage => _t(
    'Chaque parrainage validé vous donne 10 pts. Ces points vous donnent des avantages : priorité, nouveautés, actualités, tendances et autres avantages dans l’application.',
    'Each validated referral gives you 10 points. These points unlock benefits such as priority access, new features, news, trends, and more.',
    'كل إحالة مؤكدة تمنحك 10 نقاط. هذه النقاط تمنحك مزايا مثل الأولوية، الميزات الجديدة، الأخبار، الاتجاهات، ومزايا أخرى داخل التطبيق.',
  );

// ------------------ Avantages ------------------

  String get referralAdvPriorityTitle => _t(
    'Priorité',
    'Priority',
    'الأولوية',
  );

  String get referralAdvPrioritySubtitle => _t(
    'Passez en priorité sur certaines fonctionnalités.',
    'Get priority access to certain features.',
    'احصل على أولوية الوصول إلى بعض الميزات.',
  );

  String get referralAdvNewTitle => _t(
    'Nouveautés',
    'New features',
    'الميزات الجديدة',
  );

  String get referralAdvNewSubtitle => _t(
    'Accès anticipé aux nouveautés de l’application.',
    'Early access to new app features.',
    'وصول مبكر إلى ميزات التطبيق الجديدة.',
  );

  String get referralAdvNewsTitle => _t(
    'Actualités',
    'News',
    'الأخبار',
  );

  String get referralAdvNewsSubtitle => _t(
    'Recevez les actualités importantes en avant-première.',
    'Receive important news ahead of time.',
    'تلقَّ الأخبار المهمة قبل الجميع.',
  );

  String get referralAdvTrendsTitle => _t(
    'Tendances',
    'Trends',
    'الاتجاهات',
  );

  String get referralAdvTrendsSubtitle => _t(
    'Découvrez les tendances du moment en premier.',
    'Discover current trends first.',
    'اكتشف الاتجاهات الحالية أولاً.',
  );

}
