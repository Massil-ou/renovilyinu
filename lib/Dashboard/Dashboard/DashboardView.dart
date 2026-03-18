// lib/Dashboard/Dashboard/DashboardView.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../init/Manager.dart';
import '../../../MetaData/Langues/AppLanguage.dart';
import 'RenovilyAdmin/RenovilyAdminView.dart';

class DashboardView extends StatefulWidget {
  final Manager manager;
  final String? initialPath;

  const DashboardView({
    super.key,
    required this.manager,
    this.initialPath,
  });


  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashTab {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  const _DashTab({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });
}

class _DashboardViewState extends State<DashboardView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;

  ModalRoute<dynamic>? _route;
  bool _didAttachPopCallback = false;

  late final VoidCallback _langListener;

  String _appVersion = '';
  final Map<String, Widget> _pageCache = {};

  Future<bool> _preventPop() async => false;

  bool get _isAdmin {
    final role = (widget.manager.currentUser?.role ?? '').toLowerCase().trim();
    return role == 'admin' || role == 'superadmin';
  }

  @override
  void initState() {
    super.initState();

    _langListener = () {
      if (!mounted) return;
      setState(() {});
    };
    widget.manager.languageService.language.addListener(_langListener);

    _loadAppVersion();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _syncIndexWithLocation(context);
      _warmCache();
    });
  }

  Future<void> _loadAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _appVersion = 'v${info.version}');
    } catch (_) {}
  }

  void _warmCache() {
    for (final t in _tabs()) {
      _getOrCreatePage(t.route);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route != null && _route != route) {
      if (_didAttachPopCallback && _route != null) {
        _route!.removeScopedWillPopCallback(_preventPop);
      }
      _route = route;
      _route!.addScopedWillPopCallback(_preventPop);
      _didAttachPopCallback = true;
    }

    _syncIndexWithLocation(context);
  }

  @override
  void dispose() {
    widget.manager.languageService.language.removeListener(_langListener);
    if (_didAttachPopCallback && _route != null) {
      _route!.removeScopedWillPopCallback(_preventPop);
    }
    super.dispose();
  }

  void _openMenu() => _scaffoldKey.currentState?.openEndDrawer();

  void _syncIndexWithLocation(BuildContext context) {
    final tabs = _tabs();
    if (tabs.isEmpty) return;

    final String loc = GoRouterState.of(context).matchedLocation;

    final idx = tabs.indexWhere((t) => loc == t.route);
    if (idx != -1 && idx != _index) {
      if (mounted) setState(() => _index = idx);
      return;
    }

    final ip = (widget.initialPath ?? '').trim();
    if (ip.isNotEmpty) {
      final idx2 = tabs.indexWhere((t) => ip == t.route);
      if (idx2 != -1 && idx2 != _index) {
        if (mounted) setState(() => _index = idx2);
      }
    }
  }

  void _goToTab(int i, List<_DashTab> tabs) {
    if (i < 0 || i >= tabs.length) return;
    context.go(tabs[i].route);
  }

  List<_DashTab> _tabs() {
    if (!_isAdmin) return const [];
    return const [
      _DashTab(
        icon: Icons.admin_panel_settings_outlined,
        selectedIcon: Icons.admin_panel_settings,
        label: 'Admin',
        route: '/dashboard/admin',
      ),
    ];
  }

  Widget _getOrCreatePage(String route) {
    final cached = _pageCache[route];
    if (cached != null) return cached;

    Widget page;
    switch (route) {
      case '/dashboard/admin':
        page = RenovilyAdminPanelView(manager: widget.manager);
        break;
      default:
        page = const SizedBox.shrink();
        break;
    }

    _pageCache[route] = page;
    return page;
  }

  Widget _resolveBody(List<_DashTab> tabs) {
    if (!_isAdmin) {
      return const _NotAdminView();
    }
    if (tabs.isEmpty) return const SizedBox.shrink();
    final page = _getOrCreatePage(tabs[_index].route);
    return KeyedSubtree(key: ValueKey<String>(tabs[_index].route), child: page);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.manager.languageService.language,
      builder: (_, __, ___) {
        final tabs = _tabs();
        if (_index >= tabs.length) _index = 0;

        return WillPopScope(
          onWillPop: _preventPop,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[50],
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(),
            body: _resolveBody(tabs),
            endDrawerEnableOpenDragGesture: true,
            endDrawer: _buildEndDrawer(tabs),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: false,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      title: _GlassTitlePill(
        title: 'WinyCar',
        subtitle: _appVersion,
        onTap: () => context.go('/dashboard/admin'),
      ),
      actions: [
        const SizedBox(width: 8),
        _GlassCircleIconButton(
          tooltip: 'Menu',
          icon: Icons.menu,
          onTap: _openMenu,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildEndDrawer(List<_DashTab> tabs) {
    return Drawer(
      width: 320,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: const SizedBox.expand(),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.55),
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                  width: 0.6,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.9),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.admin_panel_settings, color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'WinyCar',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _appVersion,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Admin dashboard',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: [
                        if (!_isAdmin)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Accès admin requis.', style: TextStyle(color: Colors.black87)),
                          ),
                        for (int i = 0; i < tabs.length; i++) ...[
                          _MenuTile(
                            icon: tabs[i].icon,
                            selectedIcon: tabs[i].selectedIcon,
                            selected: _index == i,
                            label: tabs[i].label,
                            onTap: () {
                              Navigator.of(context).pop();
                              _goToTab(i, tabs);
                            },
                          ),
                        ],
                        const Divider(
                          height: 28,
                          thickness: 0.4,
                          color: Colors.black26,
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.redAccent),
                          title: const Text(
                            'Déconnexion',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () async {
                            Navigator.of(context).pop();
                            try {
                              await widget.manager.logoutManager.logout();
                            } catch (_) {}
                            if (!mounted) return;
                            context.go('/home');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotAdminView extends StatelessWidget {
  const _NotAdminView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.22), width: 1.0),
            ),
            child: const Text(
              'Accès admin requis.',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTitlePill extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  const _GlassTitlePill({required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.38),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withOpacity(0.35),
                  width: 0.8,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  if (subtitle.trim().isNotEmpty) ...[
                    const SizedBox(width: 10),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassCircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  const _GlassCircleIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.38),
          border: Border.all(color: Colors.white.withOpacity(0.32), width: 0.8),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Tooltip(
              message: tooltip ?? '',
              child: Icon(icon, size: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    this.selectedIcon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? Colors.white : Colors.transparent,
          width: selected ? 1.2 : 0,
        ),
      ),
      child: ListTile(
        leading: Icon(
          selected ? (selectedIcon ?? icon) : icon,
          color: Colors.black87,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        selected: selected,
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
    );
  }
}
