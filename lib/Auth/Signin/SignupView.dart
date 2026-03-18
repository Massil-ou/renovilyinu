import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Shared/Forms/GlassFormKit.dart';
import '../../init/Manager.dart';
import '../../MetaData/Langues/AppLanguage.dart';

import '../Shared/AuthModels.dart';
import '../Shared/auth_scaffold.dart';
import '../Shared/banners.dart';
import '../Shared/validators.dart';
import '../Shared/steps_bar.dart';
import '../Shared/nav.dart';

enum _SignStep { info, otp }

const Duration otpCooldown = Duration(seconds: 120);

class SignupView extends StatefulWidget {
  final Manager manager;
  final String? referralCode;

  const SignupView({
    super.key,
    required this.manager,
    this.referralCode,
  });

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  _SignStep _step = _SignStep.info;

  final _infoKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();

  final _refCtrl = TextEditingController();
  bool _hasReferral = false;

  final _otpCtrl = TextEditingController();

  final _firstNameFieldKey = GlobalKey();
  final _lastNameFieldKey = GlobalKey();
  final _emailFieldKey = GlobalKey();
  final _passFieldKey = GlobalKey();
  final _numberFieldKey = GlobalKey();
  final _wilayaFieldKey = GlobalKey();
  final _communeFieldKey = GlobalKey();
  final _refFieldKey = GlobalKey();
  final _otpFieldKey = GlobalKey();

  bool _loading = false;
  bool _obscurePwd = true;
  bool _agreeCGU = false;

  Timer? _cooldownTimer;
  int _cooldownLeft = 0;

  String? _inlineError;

  String? _wilaya;
  String? _commune;
  late List<String> _wilayasFR;
  List<String> _communesFR = const [];

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

    _wilayasFR = widget.manager.dzLookupService.wilayas(arabic: false).toList();
    _wilaya = _wilayasFR.isNotEmpty ? _wilayasFR.first : null;
    _communesFR = _wilaya == null
        ? const []
        : widget.manager.dzLookupService.getCommunes(_wilaya!, arabic: false);
    _commune = _communesFR.isNotEmpty ? _communesFR.first : null;

    final preset = (widget.referralCode ?? '').trim();
    if (preset.isNotEmpty) {
      _hasReferral = true;
      _refCtrl.text = preset;
    } else {
      _hasReferral = false;
      _refCtrl.text = '';
    }
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _numberCtrl.dispose();
    _refCtrl.dispose();
    _otpCtrl.dispose();
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

  void _startCooldown() {
    _cooldownTimer?.cancel();
    setState(() => _cooldownLeft = otpCooldown.inSeconds);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        _cooldownLeft--;
        if (_cooldownLeft <= 0) {
          _cooldownLeft = 0;
          t.cancel();
        }
      });
    });
  }

  void _onWilayaChanged(String v) {
    _clearError();

    setState(() {
      _wilaya = v;
      _commune = null;
      _communesFR = const [];
    });

    final list = widget.manager.dzLookupService.getCommunes(v, arabic: false);

    setState(() {
      _communesFR = list;
      _commune = _communesFR.isNotEmpty ? _communesFR.first : null;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_communeFieldKey));
  }

  Future<void> _signupRegister() async {
    final WinyCar s = WinyCar.of(widget.manager);

    if (!(_infoKey.currentState?.validate() ?? false)) return;

    if (_wilaya == null ||
        _wilaya!.trim().isEmpty ||
        _commune == null ||
        _commune!.trim().isEmpty) {
      _setError(s.selectWilayaCommune);
      return;
    }

    if (!_agreeCGU) {
      _setError(s.acceptCGUError);
      return;
    }

    _clearError();
    _setLoading(true);

    try {
      final referral = _hasReferral ? _refCtrl.text.trim() : '';

      final req = RegisterRequest(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        email: _emailCtrl.text.trim().toLowerCase(),
        password: _passCtrl.text,
        number: _numberCtrl.text.trim(),
        wilaya: _wilaya!.trim(),
        commune: _commune!.trim(),
        siret: '',
        referralCode: referral,
      );

      final resp = await widget.manager.registerManager.register(req);

      if (!mounted) return;

      if (!resp.success) {
        final msg = widget.manager.readableMessage(resp);
        _setError(msg.isNotEmpty ? msg : s.signupFailed);
        return;
      }

      setState(() => _step = _SignStep.otp);
      _startCooldown();
      WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_otpFieldKey));
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.signupFailed : msg);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _signupVerify() async {
    final WinyCar s = WinyCar.of(widget.manager);
    if (!(_otpKey.currentState?.validate() ?? false)) return;

    _clearError();
    _setLoading(true);

    try {
      final resp = await widget.manager.registerManager.verifyRegisterOtp(
        email: _emailCtrl.text.trim().toLowerCase(),
        otp: _otpCtrl.text.trim(),
        password: _passCtrl.text,
      );

      if (!mounted) return;

      if (!resp.success) {
        final msg = widget.manager.readableMessage(resp);
        _setError(msg.isNotEmpty ? msg : s.otpValidationFailed);
        return;
      }

      goAfterFrame(context, '/dashboard');
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.otpValidationFailed : msg);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _resendOtp() async {
    final WinyCar s = WinyCar.of(widget.manager);

    _clearError();
    _setLoading(true);

    try {
      final resp = await widget.manager.registerManager.resendRegisterOtp(
        _emailCtrl.text.trim().toLowerCase(),
      );

      if (!mounted) return;

      if (!resp.success) {
        final msg = widget.manager.readableMessage(resp);
        _setError(msg.isNotEmpty ? msg : s.cannotResendCode);
        return;
      }

      _startCooldown();
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      _setError(msg.isEmpty ? s.cannotResendCode : msg);
    } finally {
      _setLoading(false);
    }
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.manager.languageService.language,
      builder: (_, __, ___) {
        final isMobile = widget.manager.globalSingleton.isMobile(context);
        final topGap = MediaQuery.of(context).padding.top +
            (isMobile ? 16 : 40);

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
                        child: _step == _SignStep.info
                            ? _buildInfoCard()
                            : _buildOtpCard(),
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

  Widget _buildInfoCard() {
    final WinyCar s = WinyCar.of(widget.manager);
    return Column(
      key: const ValueKey('signup_info_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.createAccount,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.step1of2Info,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        StepsBar(steps: 2, activeIndex: 0, loading: _loading),
        const SizedBox(height: 12),
        _buildInfoForm(),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildOtpCard() {
    final WinyCar s = WinyCar.of(widget.manager);
    return Column(
      key: const ValueKey('signup_otp_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        Text(
          s.accountVerification,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s.step2of2Otp,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
        const SizedBox(height: 12),
        StepsBar(steps: 2, activeIndex: 1, loading: _loading),
        const SizedBox(height: 12),
        _buildOtpForm(),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: _loading
              ? null
              : () {
            setState(() {
              _step = _SignStep.info;
              _otpCtrl.clear();
              _cooldownTimer?.cancel();
              _cooldownLeft = 0;
              _clearError();
            });
            WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible(_firstNameFieldKey));
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: Text(s.editMyInfo, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
// =======================
// VUE COMPLETE (corrigée)
// =======================

  Widget _buildInfoForm() {
    final WinyCar s = WinyCar.of(widget.manager);

    final String? communeValue =
    (_commune != null && _communesFR.contains(_commune)) ? _commune : null;

    return Form(
      key: _infoKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassInputField(
            key: _firstNameFieldKey,
            controller: _firstNameCtrl,
            label: s.firstName,
            hint: null,
            icon: Icons.person_outline,
            onTap: () => _ensureVisible(_firstNameFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ\s'-]"),
              ),
            ],
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return s.firstNameRequired;
              if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' \-]{1,30}$").hasMatch(t)) {
                return s.firstNameInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

          GlassInputField(
            key: _lastNameFieldKey,
            controller: _lastNameCtrl,
            label: s.lastName,
            hint: null,
            icon: Icons.person,
            onTap: () => _ensureVisible(_lastNameFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ\s'-]"),
              ),
            ],
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return s.lastNameRequired;
              if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' \-]{1,30}$").hasMatch(t)) {
                return s.lastNameInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

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
          const SizedBox(height: 12),

          GlassInputField(
            key: _passFieldKey,
            controller: _passCtrl,
            label: s.password,
            hint: s.passwordHint,
            icon: Icons.lock_outline,
            obscureText: _obscurePwd,
            onTap: () => _ensureVisible(_passFieldKey),
            validator: (v) => passwordValidator(
              v,
              min: 8,
              msgRequired: s.passwordRequired,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePwd ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
              tooltip: s.showHidePassword,
            ),
          ),
          const SizedBox(height: 12),

          GlassInputField(
            key: _numberFieldKey,
            controller: _numberCtrl,
            label: s.phoneNumber,
            hint: s.phoneHint,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onTap: () => _ensureVisible(_numberFieldKey),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 10,
            validator: (v) => phoneFrValidator(v),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: GlassDropdownField<String>(
                  key: _wilayaFieldKey,
                  label: s.wilaya,
                  value: _wilaya,
                  hint: null,
                  icon: Icons.location_on_outlined,
                  items: _wilayasFR
                      .map(
                        (w) => DropdownMenuItem<String>(
                      value: w,
                      child: Text(
                        w,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: _loading ? null : (v) => v == null ? null : _onWilayaChanged(v),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? s.selectWilayaCommune : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassDropdownField<String>(
                  key: ValueKey('commune_${_wilaya ?? ''}'),
                  label: s.commune,
                  value: communeValue,
                  hint: null,
                  icon: Icons.place_outlined,
                  items: _communesFR
                      .map(
                        (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(
                        c,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: _loading ? null : (v) => setState(() => _commune = v),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? s.selectWilayaCommune : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          SwitchListTile.adaptive(
            value: _hasReferral,
            onChanged: _loading
                ? null
                : (v) {
              setState(() {
                _hasReferral = v;
                if (!_hasReferral) _refCtrl.clear();
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_hasReferral) _ensureVisible(_refFieldKey);
              });
            },
            activeColor: Colors.white,
            title: Text(
              s.hasReferralCode,
              style: const TextStyle(color: Colors.white),
            ),
            contentPadding: EdgeInsets.zero,
          ),

          if (_hasReferral) ...[
            const SizedBox(height: 12),
            GlassInputField(
              key: _refFieldKey,
              controller: _refCtrl,
              label: s.referralCode,
              hint: s.referralCodeHint,
              icon: Icons.card_giftcard_outlined,
              keyboardType: TextInputType.text,
              onTap: () => _ensureVisible(_refFieldKey),
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9\-]')),
              ],
              maxLength: 20,
              validator: (v) {
                if (!_hasReferral) return null;
                final t = (v ?? '').trim().toUpperCase();
                if (t.isEmpty) return s.referralCodeRequired;
                if (!RegExp(r'^[A-Z0-9\-]{4,20}$').hasMatch(t)) {
                  return s.referralCodeInvalid;
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 8),

          Theme(
            data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white),
            child: CheckboxListTile(
              value: _agreeCGU,
              onChanged: _loading ? null : (v) => setState(() => _agreeCGU = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              checkColor: Colors.black,
              activeColor: Colors.white,
              title: Text(
                s.acceptCGU,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),

          if (_inlineError != null) ...[
            ErrorBanner(message: _inlineError!, onClose: _clearError),
            const SizedBox(height: 10),
          ],

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _signupRegister,
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
                s.createMyAccount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpForm() {
    final WinyCar s = WinyCar.of(widget.manager);

    return Form(
      key: _otpKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            s.codeSentTo(_emailCtrl.text.trim().toLowerCase()),
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
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
            ],
            maxLength: 6,
            validator: (v) => otpValidator(v, len: 6, msg: s.codeInvalid),
          ),
          const SizedBox(height: 12),
          if (_inlineError != null) ...[
            ErrorBanner(message: _inlineError!, onClose: _clearError),
            const SizedBox(height: 10),
          ],
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _signupVerify,
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
                s.validate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: (_loading || _cooldownLeft > 0) ? null : _resendOtp,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: Text(
              _cooldownLeft > 0 ? s.resendIn(_cooldownLeft) : s.resendCode,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
