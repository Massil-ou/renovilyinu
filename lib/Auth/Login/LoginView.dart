import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Shared/Forms/GlassFormKit.dart';
import '../../init/Manager.dart';
import '../../MetaData/Langues/AppLanguage.dart';

import 'LoginManager.dart';

import '../Shared/auth_scaffold.dart';
import '../Shared/banners.dart';
import '../Shared/validators.dart';
import '../Shared/nav.dart';

enum _LoginStep { form, otp }
enum _ForgotStep { form, sent }

class LoginView extends StatefulWidget {
  final Manager manager;
  const LoginView({super.key, required this.manager});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  _LoginStep _step = _LoginStep.form;

  bool _showForgot = false;
  _ForgotStep _forgotStep = _ForgotStep.form;

  final _loginKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _forgotKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _forgotEmailCtrl = TextEditingController();

  final _emailFieldKey = GlobalKey();
  final _passFieldKey = GlobalKey();
  final _otpFieldKey = GlobalKey();
  final _forgotEmailFieldKey = GlobalKey();

  bool _obscure = true;
  bool _rememberMe = false;

  bool _loading = false;
  String? _inlineError;

  String _normalizedEmail(String raw) => raw.trim().toLowerCase();

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
  void initState() {
    super.initState();
    _prefillRemembered();
  }

  Future<void> _prefillRemembered() async {
    final creds = await widget.manager.getRememberedCredentials();
    if (!mounted) return;

    setState(() {
      _rememberMe = creds.remember;
      if (_rememberMe) {
        _emailCtrl.text = creds.email;
        _passCtrl.text = creds.password;
      }
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _otpCtrl.dispose();
    _forgotEmailCtrl.dispose();
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

  Future<void> _submitLoginStep1() async {
    if (!(_loginKey.currentState?.validate() ?? false)) return;

    WinyCar s = WinyCar.of(widget.manager);
    _clearError();
    _setLoading(true);

    try {
      final email = _normalizedEmail(_emailCtrl.text);
      final password = _passCtrl.text;

      final resp = await widget.manager.loginManager.authLogin(email, password);

      if (!mounted) return;

      if (!resp.success) {
        final msg = widget.manager.readableMessage(resp);
        _setError(msg.isNotEmpty ? msg : s.invalidCredentials);
        return;
      }

      setState(() => _step = _LoginStep.otp);
      WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_otpFieldKey));
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.loginError : msg);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _submitLoginStep2() async {
    if (!(_otpKey.currentState?.validate() ?? false)) return;

    WinyCar s = WinyCar.of(widget.manager);
    _clearError();
    _setLoading(true);

    try {
      final email = _normalizedEmail(_emailCtrl.text);
      final otp = _otpCtrl.text.trim();
      final password = _passCtrl.text;

      final resp = await widget.manager.loginManager.authLoginOtp(email, otp, password);

      if (!mounted) return;

      if (!resp.success) {
        final msg = widget.manager.readableMessage(resp);
        _setError(msg.isNotEmpty ? msg : s.invalidOtp);
        return;
      }

      await widget.manager.setRememberedCredentials(
        remember: _rememberMe,
        email: email,
        password: password,
      );

      if (!mounted) return;
      goAfterFrame(context, '/dashboard');
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.otpValidationError : msg);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _submitForgotByLink() async {
    if (!(_forgotKey.currentState?.validate() ?? false)) return;

    WinyCar s = WinyCar.of(widget.manager);
    _clearError();
    _setLoading(true);

    try {
      final email = _normalizedEmail(_forgotEmailCtrl.text);
      await LoginManager().sendPasswordResetLink(email);

      if (!mounted) return;

      setState(() {
        _forgotStep = _ForgotStep.sent;
        _showForgot = true;
        _forgotEmailCtrl.text = email;
      });
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.cannotSendLink : msg);
    } finally {
      _setLoading(false);
    }
  }

  void _openForgot() {
    if (_loading) return;
    setState(() {
      _showForgot = true;
      _forgotStep = _ForgotStep.form;
      _forgotEmailCtrl.text = _normalizedEmail(_emailCtrl.text);
      _clearError();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_forgotEmailFieldKey));
  }

  void _backToLogin() {
    if (_loading) return;
    setState(() {
      _showForgot = false;
      _forgotStep = _ForgotStep.form;
      _clearError();
    });
  }

  void _backToStep1() {
    if (_loading) return;
    setState(() {
      _step = _LoginStep.form;
      _otpCtrl.clear();
      _clearError();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_emailFieldKey));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.manager.languageService.language,
      builder: (_, __, ___) {
        final mq = MediaQuery.of(context);
        final extraBottom = mq.viewInsets.bottom > 0 ? 16.0 : 0.0;

        final card = ConstrainedBox(
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
                  data: Theme.of(context).copyWith(visualDensity: VisualDensity.compact),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: _showForgot
                        ? (_forgotStep == _ForgotStep.form ? _buildForgotByLinkCard() : _buildForgotSentCard())
                        : (_step == _LoginStep.form ? _buildLoginFormCard() : _buildOtpFormCard()),
                  ),
                ),
              ),
            ),
          ),
        );

        return AuthScaffold(
          manager: widget.manager,
          title: 'Winycar',
          child: Padding(
            padding: EdgeInsets.only(bottom: 24 + extraBottom),
            child: Center(child: card),
          ),
        );
      },
    );
  }

  Widget _buildLoginFormCard() {
    WinyCar s = WinyCar.of(widget.manager);

    return Column(
      key: const ValueKey('login_form_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.welcomeBack,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.signInToContinue,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        _buildLoginForm(),
      ],
    );
  }

  Widget _buildOtpFormCard() {
    WinyCar s = WinyCar.of(widget.manager);

    return Column(
      key: const ValueKey('login_otp_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.codeVerification,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.step2EnterOtpPwd,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        _buildOtpForm(),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: _loading ? null : _backToStep1,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: Text(s.backToEmailPwd, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildForgotByLinkCard() {
    WinyCar s = WinyCar.of(widget.manager);

    return Column(
      key: const ValueKey('forgot_link_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.forgotPassword,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.enterEmailResetLink,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        _buildForgotByLinkForm(),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: _loading ? null : _backToLogin,
          icon: const Icon(Icons.login, color: Colors.white),
          label: Text(WinyCar.of(widget.manager).signIn, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildForgotSentCard() {
    WinyCar s = WinyCar.of(widget.manager);
    final email = _normalizedEmail(_forgotEmailCtrl.text);

    return Column(
      key: const ValueKey('forgot_sent_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Icon(Icons.mark_email_read_outlined, size: 64, color: Colors.white.withOpacity(0.95)),
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
          s.resetLinkSentTo(email),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _loading ? null : _backToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(s.signIn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: _loading
              ? null
              : () {
            setState(() {
              _forgotStep = _ForgotStep.form;
              _clearError();
            });
            WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_forgotEmailFieldKey));
          },
          child: Text(s.resendLink, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    WinyCar s = WinyCar.of(widget.manager);

    return Form(
      key: _loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassInputField(
            key: _emailFieldKey,
            controller: _emailCtrl,
            label: s.email,
            hint: s.emailHint,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            onTap: () => _ensureVisible(_emailFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            validator: (v) => emailValidator(
              v,
              msgRequired: s.emailRequired,
              msgInvalid: s.emailInvalid,
            ),
          ),
          const SizedBox(height: 14),
          GlassInputField(
            key: _passFieldKey,
            controller: _passCtrl,
            label: s.password,
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscureText: _obscure,
            onTap: () => _ensureVisible(_passFieldKey),
            validator: (v) => passwordValidator(v, min: 8, msgRequired: s.passwordRequired),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white),
              onPressed: () => setState(() => _obscure = !_obscure),
              tooltip: s.showHidePassword,
            ),
          ),
          const SizedBox(height: 8),
          Theme(
            data: Theme.of(context).copyWith(
              checkboxTheme: CheckboxThemeData(
                side: const BorderSide(color: Colors.white70),
                fillColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.selected) ? Colors.blue : Colors.transparent;
                }),
                checkColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            child: CheckboxListTile(
              value: _rememberMe,
              onChanged: (v) => setState(() => _rememberMe = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(s.rememberMe, style: const TextStyle(color: Colors.white)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _loading ? null : _openForgot,
              child: Text(s.forgotPasswordQuestion),
            ),
          ),
          const SizedBox(height: 12),
          if (_inlineError != null) ...[
            ErrorBanner(message: _inlineError!, onClose: _clearError),
            const SizedBox(height: 12),
          ],
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _submitLoginStep1,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _loading ? _btnLoader() : Text(s.signIn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _loading ? null : () => goNamedAfterFrame(context, 'signup'),
            child: Text(s.createAccount, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpForm() {
    WinyCar s = WinyCar.of(widget.manager);

    return Form(
      key: _otpKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            s.codeSentTo(_normalizedEmail(_emailCtrl.text)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 12),
          GlassInputField(
            key: _otpFieldKey,
            controller: _otpCtrl,
            label: s.otpCode,
            hint: s.otpHint,
            icon: Icons.verified_outlined,
            keyboardType: TextInputType.text,
            onTap: () => _ensureVisible(_otpFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
            ],
            maxLength: 6,
            validator: (v) => otpValidator(v, len: 6, msg: s.codeInvalid),
          ),
          const SizedBox(height: 12),
          if (_inlineError != null) ...[
            ErrorBanner(message: _inlineError!, onClose: _clearError),
            const SizedBox(height: 12),
          ],
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _submitLoginStep2,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _loading ? _btnLoader() : Text(s.validateAndLogin, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotByLinkForm() {
    WinyCar s = WinyCar.of(widget.manager);

    return Form(
      key: _forgotKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassInputField(
            key: _forgotEmailFieldKey,
            controller: _forgotEmailCtrl,
            label: s.email,
            hint: s.emailHint,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            onTap: () => _ensureVisible(_forgotEmailFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            validator: (v) => emailValidator(
              v,
              msgRequired: s.emailRequired,
              msgInvalid: s.emailInvalid,
            ),
          ),
          const SizedBox(height: 12),
          if (_inlineError != null) ...[
            ErrorBanner(message: _inlineError!, onClose: _clearError),
            const SizedBox(height: 12),
          ],
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _submitForgotByLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _loading ? _btnLoader() : Text(s.sendLink, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
