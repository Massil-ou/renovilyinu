// lib/data/CarCatalog.dart

import '../MetaData/data/car_catalog_data.dart';

class CarCatalog {
  static final CarCatalog _instance = CarCatalog._internal();
  factory CarCatalog() => _instance;
  CarCatalog._internal() {
    _initFromConstData();
  }

  // ===== State =====
  Map<String, List<String>> _catalog = {};
  bool _loaded = false;

  bool get isLoaded => _loaded;

  void _initFromConstData() {
    final m = <String, List<String>>{};

    kCarCatalogData.forEach((brand, models) {
      final list =
          models
              .map((e) => e.toString().trim())
              .where((e) => e.isNotEmpty)
              .toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

      final key = brand.toString().trim();
      if (key.isNotEmpty) {
        m[key] = List.unmodifiable(list);
      }
    });

    _catalog = Map.unmodifiable(m);
    _loaded = true;
  }

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    _initFromConstData();
  }

  void clear() {
    _catalog = {};
    _loaded = false;
  }

  Future<void> reload() async {
    clear();
    _initFromConstData();
  }

  List<String> get brands {
    final keys = _catalog.keys.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return keys;
  }

  List<String> modelsFor(String? brand) {
    if (brand == null || brand.trim().isEmpty) return const [];
    return _catalog[brand.trim()] ?? const [];
  }

  bool hasBrand(String? brand) {
    if (brand == null) return false;
    return _catalog.containsKey(brand.trim());
  }
}
