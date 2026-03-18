// lib/Renovily/Admin/View/AdminPanelView.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../init/Manager.dart';
import 'AdminModels.dart';
import 'RenovilyAdminManager.dart';

class RenovilyAdminPanelView extends StatefulWidget {
  final Manager manager;
  const RenovilyAdminPanelView({super.key, required this.manager});

  @override
  State<RenovilyAdminPanelView> createState() => _RenovilyAdminPanelViewState();
}

class _RenovilyAdminPanelViewState extends State<RenovilyAdminPanelView>
    with SingleTickerProviderStateMixin {
  late final RenovilyAdminManager m = RenovilyAdminManager();
  late final TabController _tabs = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await m.initLoad();
    });
  }

  Future<void> _refresh() => m.refreshAll();

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) {
        final isMobile = c.maxWidth < 700;
        final pad = isMobile ? 6.0 : 14.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_admin.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.black),
              ),
            ),
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.35))),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: const SizedBox.expand(),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(pad, pad, pad, isMobile ? 6 : 10),
                child: Column(
                  children: [
                    _GlassHeader(
                      title: 'Admin',
                      subtitle: 'Renovily',
                      onRefresh: _refresh,
                      isMobile: isMobile,
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.white.withOpacity(0.22), width: 1.0),
                          ),
                          child: TabBar(
                            controller: _tabs,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white70,
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            tabs: const [
                              Tab(icon: Icon(Icons.build_circle_outlined), text: 'PRO'),
                              Tab(icon: Icon(Icons.people_alt_outlined), text: 'Users'),
                              Tab(icon: Icon(Icons.campaign_outlined), text: 'Offres'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: m,
                        builder: (_, __) {
                          return TabBarView(
                            controller: _tabs,
                            children: [
                              _ProTab(m: m, isMobile: isMobile),
                              _UsersTab(m: m, isMobile: isMobile),
                              _OffersTab(m: m, isMobile: isMobile),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GlassHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Future<void> Function() onRefresh;
  final bool isMobile;

  const _GlassHeader({
    required this.title,
    required this.subtitle,
    required this.onRefresh,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final pad = isMobile ? 10.0 : 14.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: EdgeInsets.fromLTRB(pad, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.22), width: 1.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.admin_panel_settings_outlined, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              InkWell(
                onTap: () => onRefresh(),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('Refresh', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  final Widget child;
  const _PanelCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.22), width: 1.0),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ProTab extends StatelessWidget {
  final RenovilyAdminManager m;
  final bool isMobile;
  const _ProTab({required this.m, required this.isMobile});

  static void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.black.withOpacity(0.75)),
    );
  }

  Future<void> _accept(BuildContext context, RenovilyPartnerProfileItem it) async {
    final ok = await _confirmDialog(
      context,
      title: 'Accepter profil pro',
      message: '${it.companyName}\n${it.email}',
      confirmText: 'Accepter',
      confirmColor: Colors.greenAccent,
      icon: Icons.check_circle_outline,
    );
    if (ok != true) return;
    final r = await m.acceptPartner(it);
    if (!context.mounted) return;
    if (!r.success) _toast(context, r.message.isNotEmpty ? r.message : 'error_${r.code}');
  }

  Future<void> _reject(BuildContext context, RenovilyPartnerProfileItem it) async {
    final ok = await _confirmDialog(
      context,
      title: 'Rejeter profil pro',
      message: '${it.companyName}\n${it.email}',
      confirmText: 'Rejeter',
      confirmColor: Colors.redAccent,
      icon: Icons.block_outlined,
    );
    if (ok != true) return;
    final r = await m.rejectPartner(it);
    if (!context.mounted) return;
    if (!r.success) _toast(context, r.message.isNotEmpty ? r.message : 'error_${r.code}');
  }

  static Future<bool?> _confirmDialog(
      BuildContext context, {
        required String title,
        required String message,
        required String confirmText,
        required Color confirmColor,
        required IconData icon,
      }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (ctx) {
        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Dialog(
              backgroundColor: Colors.white.withOpacity(0.92),
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white.withOpacity(0.9), width: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: confirmColor.withOpacity(0.15), shape: BoxShape.circle),
                          child: Icon(icon, color: confirmColor, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(message, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black.withOpacity(0.15)),
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Annuler'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: confirmColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(confirmText),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = m.partnerPending;
    final pad = isMobile ? 10.0 : 12.0;

    return _PanelCard(
      child: m.isLoadingPartners && items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => m.listPartnerPending(limit: 100),
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            if (items.isEmpty && !m.isLoadingPartners)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text('Aucune demande en attente', style: TextStyle(color: Colors.white70))),
              ),
            for (final it in items) ...[
              _PartnerTile(
                it: it,
                onAccept: () => _accept(context, it),
                onReject: () => _reject(context, it),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _PartnerTile extends StatelessWidget {
  final RenovilyPartnerProfileItem it;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _PartnerTile({
    required this.it,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final title = it.companyName.trim().isNotEmpty ? it.companyName : it.fullName;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(
            '${it.tradeName} • ${it.companyType}'.trim(),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '${it.email} • ${it.numero}'.trim(),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '${it.wilaya} • ${it.commune}'.trim(),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'SIRET: ${it.siretUser} • RC: ${it.rcNumber}',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReject,
                  icon: const Icon(Icons.close),
                  label: const Text('Rejeter'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.22)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onAccept,
                  icon: const Icon(Icons.check),
                  label: const Text('Accepter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.22),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UsersTab extends StatelessWidget {
  final RenovilyAdminManager m;
  final bool isMobile;
  const _UsersTab({required this.m, required this.isMobile});

  static void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.black.withOpacity(0.75)),
    );
  }

  Future<void> _setStatus(BuildContext context, RenovilyAdminUserItem it) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetPick(
        title: 'Status',
        items: const [
          ('active', 'Active', Icons.check_circle_outline),
          ('pending', 'Pending', Icons.hourglass_bottom),
          ('suspended', 'Suspended', Icons.pause_circle_outline),
          ('inactive', 'Inactive', Icons.block_outlined),
        ],
      ),
    );
    if (picked == null) return;
    final r = await m.setUserStatus(it, picked);
    if (!context.mounted) return;
    if (!r.success) _toast(context, r.message.isNotEmpty ? r.message : 'error_${r.code}');
  }

  Future<void> _setRole(BuildContext context, RenovilyAdminUserItem it) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetPick(
        title: 'Role',
        items: const [
          ('client', 'Client', Icons.person_outline),
          ('partner', 'Partner', Icons.business_outlined),
        ],
      ),
    );
    if (picked == null) return;
    final r = await m.setUserRole(it, picked);
    if (!context.mounted) return;
    if (!r.success) _toast(context, r.message.isNotEmpty ? r.message : 'error_${r.code}');
  }

  @override
  Widget build(BuildContext context) {
    final items = m.users;
    final pad = isMobile ? 10.0 : 12.0;

    return _PanelCard(
      child: m.isLoadingUsers && items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => m.listUsers(limit: 100),
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            if (items.isEmpty && !m.isLoadingUsers)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text('Aucun utilisateur', style: TextStyle(color: Colors.white70))),
              ),
            for (final it in items) ...[
              _UserTile(
                it: it,
                onSetStatus: () => _setStatus(context, it),
                onSetRole: () => _setRole(context, it),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final RenovilyAdminUserItem it;
  final VoidCallback onSetStatus;
  final VoidCallback onSetRole;

  const _UserTile({
    required this.it,
    required this.onSetStatus,
    required this.onSetRole,
  });

  static ({Color c, String label}) _statusMeta(String status) {
    final s = status.trim().toLowerCase();
    if (s == 'active') return (c: Colors.greenAccent, label: 'active');
    if (s == 'pending') return (c: Colors.amberAccent, label: 'pending');
    if (s == 'suspended') return (c: Colors.lightBlueAccent, label: 'suspended');
    if (s == 'inactive') return (c: Colors.redAccent, label: 'inactive');
    return (c: Colors.white, label: s.isEmpty ? '-' : s);
  }

  static ({Color c, String label}) _roleMeta(String role) {
    final r = role.trim().toLowerCase();
    if (r == 'partner') return (c: Colors.orangeAccent, label: 'partner');
    if (r == 'client') return (c: Colors.white70, label: 'client');
    return (c: Colors.white, label: r.isEmpty ? '-' : r);
  }

  @override
  Widget build(BuildContext context) {
    final sm = _statusMeta(it.statusUser);
    final rm = _roleMeta(it.roleUser);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white.withOpacity(0.10),
            child: Icon(Icons.person, color: sm.c.withOpacity(0.95), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  it.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                Text(
                  '${it.email} • ${it.numero}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _Pill(icon: Icons.badge_outlined, label: rm.label, color: rm.c),
                    _Pill(icon: Icons.circle, label: sm.label, color: sm.c),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              _IconBtn(icon: Icons.tune, onTap: onSetStatus),
              const SizedBox(height: 8),
              _IconBtn(icon: Icons.swap_horiz, onTap: onSetRole),
            ],
          ),
        ],
      ),
    );
  }
}

class _OffersTab extends StatelessWidget {
  final RenovilyAdminManager m;
  final bool isMobile;
  const _OffersTab({required this.m, required this.isMobile});

  static void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.black.withOpacity(0.75)),
    );
  }

  Future<void> _setOfferStatus(BuildContext context, RenovilyPendingOfferItem it) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetPick(
        title: 'Status offre',
        items: const [
          ('visible', 'Visible', Icons.visibility_outlined),
          ('deleted', 'Deleted', Icons.delete_outline),
          ('pending', 'Pending', Icons.hourglass_bottom),
        ],
      ),
    );
    if (picked == null) return;
    final r = await m.setOfferStatus(it, picked);
    if (!context.mounted) return;
    if (!r.success) _toast(context, r.message.isNotEmpty ? r.message : 'error_${r.code}');
  }

  @override
  Widget build(BuildContext context) {
    final items = m.offersPending;
    final pad = isMobile ? 10.0 : 12.0;

    return _PanelCard(
      child: m.isLoadingOffers && items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => m.listOffersPending(limit: 100),
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            if (items.isEmpty && !m.isLoadingOffers)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text('Aucune offre en attente', style: TextStyle(color: Colors.white70))),
              ),
            for (final it in items) ...[
              _OfferTile(it: it, onSetStatus: () => _setOfferStatus(context, it)),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _OfferTile extends StatelessWidget {
  final RenovilyPendingOfferItem it;
  final VoidCallback onSetStatus;

  const _OfferTile({
    required this.it,
    required this.onSetStatus,
  });

  @override
  Widget build(BuildContext context) {
    final img = it.images.isNotEmpty ? it.images.first.url : '';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: img.isNotEmpty
                ? Image.network(
              img,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 72,
                color: Colors.white12,
                child: const Icon(Icons.image_not_supported_outlined, color: Colors.white70),
              ),
            )
                : Container(
              width: 72,
              height: 72,
              color: Colors.white12,
              child: const Icon(Icons.home_repair_service_outlined, color: Colors.white70),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  it.titre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '${it.metier} • ${it.wilaya} • ${it.commune}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  '${it.phone} • ${it.prix ?? 0} / ${it.unitePrix}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  it.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _IconBtn(icon: Icons.tune, onTap: onSetStatus),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Pill({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.38), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color.withOpacity(0.95), size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.95), fontWeight: FontWeight.w900, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _BottomSheetPick extends StatelessWidget {
  final String title;
  final List<(String value, String label, IconData icon)> items;

  const _BottomSheetPick({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            color: Colors.black.withOpacity(0.45),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 44, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(99))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16))),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 6),
                for (final it in items)
                  ListTile(
                    leading: Icon(it.$3, color: Colors.white),
                    title: Text(it.$2, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    onTap: () => Navigator.pop(context, it.$1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}