import 'dart:ui';
import 'package:flutter/material.dart';

import '../../Shared/Forms/GlassFormKit.dart';
import '../../init/Manager.dart';
import '../../MetaData/Langues/AppLanguage.dart';

import '../Shared/auth_scaffold.dart';
import '../Shared/banners.dart';
import '../Shared/validators.dart';
import '../Shared/nav.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({
    super.key,
    required this.manager,
    required this.email,
    required this.token,
  });

  final Manager manager;
  final String email;
  final String token;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _pwdCtrl = TextEditingController();
  final _pwd2Ctrl = TextEditingController();

  final _pwdFieldKey = GlobalKey();
  final _pwd2FieldKey = GlobalKey();

  bool _obscure = true;
  bool _loading = false;
  bool _success = false;

  String? _inlineError;

  void _setError(String msg) {
    if (!mounted) return;
    setState(() => _inlineError = msg);
  }

  void _clearError() {
    if (!mounted) return;
    setState(() => _inlineError = null);
  }

  void _setLoading(bool v) {
    if (!mounted) return;
    setState(() => _loading = v);
  }

  @override
  void dispose() {
    _pwdCtrl.dispose();
    _pwd2Ctrl.dispose();
    super.dispose();
  }

  Future<void> _ensureVisible(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 30));
    if (!mounted) return;
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: 0.18,
    );
  }

  String? _validatePwd(String? v) {
    WinyCar s = WinyCar.of(widget.manager);
    return passwordValidator(v, min: 8, msgRequired: s.passwordRequired);
  }

  String? _validatePwd2(String? v) {
    WinyCar s = WinyCar.of(widget.manager);
    final base = _validatePwd(v);
    if (base != null) return base;
    if ((v ?? '').trim() != _pwdCtrl.text.trim()) return s.passwordsDontMatch;
    return null;
  }

  Widget _btnLoader() {
    return const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
      ),
    );
  }

  Future<void> _submit() async {
    WinyCar s = WinyCar.of(widget.manager);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _clearError();
    _setLoading(true);

    try {
      final res = await widget.manager.passwordManager.changePassword(
        email: widget.email.trim().toLowerCase(),
        token: widget.token,
        newPassword: _pwdCtrl.text.trim(),
      );

      if (!mounted) return;

      if (res.success) {
        setState(() => _success = true);
      } else {
        final msg = widget.manager.readableMessage(res);
        _setError(msg.isNotEmpty ? msg : s.cannotChangePassword);
      }
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.cannotChangePassword : msg);
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.manager.languageService.language,
      builder: (_, __, ___) {
        final isMobile = widget.manager.globalSingleton.isMobile(context);
        final topGap = MediaQuery.of(context).padding.top +
            kToolbarHeight +
            (isMobile ? 16 : 40);

        final WinyCar s = WinyCar.of(widget.manager);

        final content = Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        visualDensity: VisualDensity.compact,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        child: _success ? _buildSuccessCard(s) : _buildFormCard(s),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        return AuthScaffold(
          manager: widget.manager,
          title: 'Winycar',
          padding: EdgeInsets.fromLTRB(6, topGap, 6, 24),
          child: content,
        );
      },
    );
  }

  Widget _buildFormCard(WinyCar s) {
    return Column(
      key: const ValueKey('new_pwd_form_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.resetPassword,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.resetForEmail(widget.email),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        if (_inlineError != null) ...[
          ErrorBanner(message: _inlineError!, onClose: _clearError),
          const SizedBox(height: 12),
        ],
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlassInputField(
                key: _pwdFieldKey,
                controller: _pwdCtrl,
                label: s.newPassword,
                hint: '••••••••',
                icon: Icons.lock_reset_outlined,
                obscureText: _obscure,
                validator: _validatePwd,
                onTap: () => _ensureVisible(_pwdFieldKey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              const SizedBox(height: 14),
              GlassInputField(
                key: _pwd2FieldKey,
                controller: _pwd2Ctrl,
                label: s.confirmPassword,
                hint: '••••••••',
                icon: Icons.verified_user_outlined,
                obscureText: _obscure,
                validator: _validatePwd2,
                onTap: () => _ensureVisible(_pwd2FieldKey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _loading
                      ? _btnLoader()
                      : Text(
                    s.changePassword,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessCard(WinyCar s) {
    return Column(
      key: const ValueKey('new_pwd_success_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Icon(
          Icons.check_circle_outline,
          size: 64,
          color: Colors.white.withOpacity(0.95),
        ),
        const SizedBox(height: 10),
        Text(
          s.success,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.passwordChangedPleaseLogin,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () => goNamedAfterFrame(context, 'login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              s.signIn,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
