// lib/Cars/menu/AddCars/AddCarsView.dart
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../../init/Manager.dart';



/* =============================================================================
  ✅  Glass UI components (same theme) — all-in-one
============================================================================= */

/* ------------------------------- Base Frame -------------------------------- */

class _GlassFieldFrame extends StatelessWidget {
  final bool enabled;
  final bool hasError;
  final double height;
  final EdgeInsets padding;
  final Widget child;

  const _GlassFieldFrame({
    required this.enabled,
    required this.hasError,
    required this.height,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final white = Colors.white;

    final borderColor = !enabled
        ? white.withOpacity(0.15)
        : hasError
        ? Colors.redAccent.withOpacity(0.90)
        : white.withOpacity(0.35);

    final bgColor = enabled ? white.withOpacity(0.18) : white.withOpacity(0.10);

    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: child,
      ),
    );
  }
}

TextStyle _labelStyle(bool hasError) => TextStyle(
  color: hasError ? Colors.redAccent.withOpacity(0.90) : Colors.white.withOpacity(0.92),
  fontSize: 12,
  fontWeight: FontWeight.w600,
  height: 1.0,
);

TextStyle _valueStyle({required bool enabled}) => TextStyle(
  color: enabled ? Colors.white : Colors.white.withOpacity(0.85),
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.15,
);

TextStyle _hintStyle(bool hasError) => TextStyle(
  color: hasError ? Colors.redAccent.withOpacity(0.90) : Colors.white.withOpacity(0.70),
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.15,
);

class _FieldTextLayout extends StatelessWidget {
  final String label;
  final bool hasError;
  final Widget body;

  const _FieldTextLayout({required this.label, required this.hasError, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: _labelStyle(hasError)),
        const SizedBox(height: 4),
        Expanded(child: Align(alignment: Alignment.centerLeft, child: body)),
      ],
    );
  }
}

/* ------------------------------ CustomTextField ----------------------------- */


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;

  final IconData? prefixIcon;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;

  final bool readOnly;
  final GestureTapCallback? onTap;
  final bool showCursor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.enabled = true,
    this.inputFormatters,
    this.minLines,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.showCursor = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = (maxLines ?? 1) > 1 || (minLines ?? 1) > 1;
    final height = isMultiline ? 120.0 : 56.0;

    return FormField<String>(
      initialValue: controller.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (field) {
        final hasError = field.hasError;

        return _GlassFieldFrame(
          enabled: enabled,
          hasError: hasError,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, color: Colors.white.withOpacity(0.92), size: 20),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: _FieldTextLayout(
                  label: label,
                  hasError: hasError,
                  body: TextField(
                    controller: controller,
                    enabled: enabled,
                    readOnly: readOnly,
                    showCursor: showCursor && !readOnly,
                    onTap: onTap,
                    onChanged: field.didChange,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    textInputAction:
                    isMultiline ? TextInputAction.newline : (textInputAction ?? TextInputAction.next),
                    minLines: minLines ?? 1,
                    maxLines: maxLines ?? 1,
                    maxLength: maxLength,
                    inputFormatters: inputFormatters,
                    style: _valueStyle(enabled: enabled),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: _hintStyle(hasError),
                      contentPadding: EdgeInsets.zero,
                      counterText: '',
                      suffixIcon: suffixIcon,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;

  const CustomTextArea({super.key, required this.controller, required this.label, this.hint, this.validator});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: label,
      hint: hint,
      validator: validator,
      minLines: 4,
      maxLines: 6,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
    );
  }
}

/* ------------------------- GlassAutocomplete (stable) ------------------------ */
class GlassAutocomplete extends StatefulWidget {
  final String label;
  final String? hint;

  final TextEditingController controller;
  final List<String> options;

  final bool enabled;
  final double maxPanelHeight;

  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSelected;

  final IconData? prefixIcon;
  final Color? prefixIconColor;

  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final bool showOnTapEvenIfEmpty;

  const GlassAutocomplete({
    super.key,
    required this.label,
    required this.controller,
    required this.options,
    this.hint,
    this.enabled = true,
    this.maxPanelHeight = 320,
    this.validator,
    this.onChanged,
    this.onSelected,
    this.prefixIcon,
    this.prefixIconColor,
    this.inputFormatters,
    this.keyboardType,
    this.showOnTapEvenIfEmpty = false,
  });

  @override
  State<GlassAutocomplete> createState() => _GlassAutocompleteState();
}

class _GlassAutocompleteState extends State<GlassAutocomplete> {
  final LayerLink _link = LayerLink();
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _entry;
  bool _open = false;

  String _q = '';
  List<String> _items = const [];
  double _targetWidth = 0;

  FormFieldState<String>? _field;

  @override
  void initState() {
    super.initState();
    _q = widget.controller.text;

    _focusNode.addListener(() {
      if (!mounted) return;

      if (!_focusNode.hasFocus) {
        // ✅ IMPORTANT: ne ferme pas direct (sinon le tap sur la liste ne passe pas)
        Future.microtask(() {
          if (!mounted) return;
          if (!_focusNode.hasFocus) _close();
        });
      } else {
        _refresh();
        if (_items.isNotEmpty) _show();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _captureWidthSafe());
  }

  @override
  void didUpdateWidget(covariant GlassAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(oldWidget.options, widget.options)) {
      _refresh();
      _entry?.markNeedsBuild();
    }

    if (oldWidget.enabled != widget.enabled && !widget.enabled) {
      _close();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _captureWidthSafe());
  }

  @override
  void deactivate() {
    _close();
    super.deactivate();
  }

  @override
  void dispose() {
    _close();
    _focusNode.dispose();
    super.dispose();
  }

  void _captureWidthSafe() {
    if (!mounted) return;
    final ro = context.findRenderObject();
    if (ro is RenderBox && ro.attached) {
      final w = ro.size.width;
      if (w > 0 && w != _targetWidth) {
        _targetWidth = w;
        _entry?.markNeedsBuild();
      }
    }
  }

  List<String> _dedupe(List<String> list) {
    final seen = <String>{};
    final out = <String>[];
    for (final s in list) {
      final t = s.trim();
      if (t.isEmpty) continue;
      final k = t.toLowerCase();
      if (seen.add(k)) out.add(t);
    }
    return out;
  }

  List<String> _filtered(String q) {
    final unique = _dedupe(widget.options);

    final qq = q.trim().toLowerCase();
    if (qq.isEmpty) return widget.showOnTapEvenIfEmpty ? unique : const [];

    final res = unique.where((s) => s.toLowerCase().contains(qq)).toList();
    res.sort((a, b) {
      final aS = a.toLowerCase().startsWith(qq);
      final bS = b.toLowerCase().startsWith(qq);
      if (aS != bS) return aS ? -1 : 1;
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    return res;
  }

  void _refresh() {
    _items = _filtered(_q);
    _entry?.markNeedsBuild();
  }

  void _show() {
    if (!mounted || !widget.enabled) return;

    final ro = context.findRenderObject();
    if (ro is! RenderBox || !ro.attached) return;

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;

    if (_open) {
      _entry?.markNeedsBuild();
      return;
    }

    _open = true;

    // ✅ jamais 2 overlays
    _entry?.remove();
    _entry = _buildOverlay();
    overlay.insert(_entry!);

    if (mounted) setState(() {});
  }

  void _close() {
    if (!_open) return;
    _open = false;
    try {
      _entry?.remove();
    } catch (_) {}
    _entry = null;
    if (mounted) setState(() {});
  }

  void _toggle() {
    if (!widget.enabled) return;
    if (_open) {
      _close();
    } else {
      _focusNode.requestFocus();
      _refresh();
      if (_items.isNotEmpty) _show();
    }
  }

  void _select(String value) {
    widget.controller.text = value;
    widget.controller.selection = TextSelection.collapsed(offset: value.length);

    _field?.didChange(value);
    widget.onSelected?.call(value);
    widget.onChanged?.call(value);

    _close();
    // ✅ l’unfocus après sélection
    Future.microtask(() {
      if (mounted) _focusNode.unfocus();
    });
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (overlayContext) {
        if (!_open || _items.isEmpty) return const SizedBox.shrink();

        final w = (_targetWidth > 0) ? _targetWidth : MediaQuery.of(overlayContext).size.width;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _close,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 8),
              child: Material(
                type: MaterialType.transparency,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: w, maxHeight: widget.maxPanelHeight),
                  child: Container(
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black.withOpacity(0.10)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black.withOpacity(0.06),
                      ),
                      itemBuilder: (_, i) {
                        final opt = _items[i];

                        // ✅ FIX SELECTION: onTapDown (plus fiable)
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: (_) => _select(opt),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: Text(
                              opt,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      builder: (field) {
        _field = field;
        final hasError = field.hasError;

        final borderColor = !widget.enabled
            ? Colors.white.withOpacity(0.15)
            : hasError
            ? Colors.redAccent.withOpacity(0.90)
            : Colors.white.withOpacity(0.35);

        final bgColor = widget.enabled ? Colors.white.withOpacity(0.18) : Colors.white.withOpacity(0.10);

        return CompositedTransformTarget(
          link: _link,
          child: Opacity(
            opacity: widget.enabled ? 1.0 : 0.6,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    Icon(widget.prefixIcon, color: widget.prefixIconColor ?? Colors.white.withOpacity(0.92), size: 20),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            color: hasError ? Colors.redAccent.withOpacity(0.90) : Colors.white.withOpacity(0.92),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: widget.controller,
                            enabled: widget.enabled,
                            keyboardType: widget.keyboardType,
                            inputFormatters: widget.inputFormatters,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: widget.hint,
                              hintStyle: TextStyle(
                                color: hasError ? Colors.redAccent.withOpacity(0.90) : Colors.white.withOpacity(0.70),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            onTap: () {
                              _captureWidthSafe();
                              _q = widget.controller.text;
                              _refresh();
                              if (_items.isNotEmpty) _show();
                            },
                            onChanged: (v) {
                              _q = v;
                              field.didChange(v);
                              widget.onChanged?.call(v);

                              _captureWidthSafe();
                              _refresh();

                              if (_focusNode.hasFocus && _items.isNotEmpty) {
                                _show();
                              } else {
                                _close();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _toggle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(_open ? Icons.expand_less : Icons.expand_more, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/* ---------------------- GlassDropdown ✅ form validate ok -------------------- */
class GlassDropdown<T> extends StatefulWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;

  final String? hint;
  final String Function(T value)? displayStringForOption;
  final bool enabled;
  final IconData? prefixIcon;

  const GlassDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.hint,
    this.displayStringForOption,
    this.enabled = true,
    this.prefixIcon,
  });

  @override
  State<GlassDropdown<T>> createState() => _GlassDropdownState<T>();
}

class _GlassDropdownState<T> extends State<GlassDropdown<T>> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _overlay;
  bool _open = false;

  FormFieldState<T>? _field;

  void _syncFieldValueAfterFrame() {
    // ✅ évite: setState/markNeedsBuild pendant build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final f = _field;
      if (f == null) return;
      if (f.value != widget.value) {
        f.didChange(widget.value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _syncFieldValueAfterFrame();
  }

  @override
  void didUpdateWidget(covariant GlassDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncFieldValueAfterFrame();
    }
    if (oldWidget.enabled != widget.enabled && !widget.enabled) {
      _close();
    }
  }

  void _close() {
    if (!_open) return;
    _open = false;
    try {
      _overlay?.remove();
    } catch (_) {}
    _overlay = null;
    if (mounted) setState(() {});
  }

  void _toggle() {
    if (!widget.enabled) return;

    if (_open) {
      _close();
      return;
    }

    _open = true;
    _overlay = _buildOverlay();
    Overlay.of(context, rootOverlay: true).insert(_overlay!);
    if (mounted) setState(() {});
  }

  String _textForValue(T? v) {
    if (v == null) return '';
    if (widget.displayStringForOption != null) return widget.displayStringForOption!(v);
    return '$v';
  }

  void _select(T? v) {
    // ✅ update FormField state + parent state
    _field?.didChange(v);
    widget.onChanged?.call(v);
    _close();
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (_) {
        final box = context.findRenderObject() as RenderBox?;
        final width = box?.size.width ?? MediaQuery.of(context).size.width;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _close,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: const Offset(0, 56 + 8),
              child: Material(
                type: MaterialType.transparency,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width, maxHeight: 380),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black.withOpacity(0.10)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black.withOpacity(0.06),
                      ),
                      itemBuilder: (_, i) {
                        final it = widget.items[i];
                        final v = it.value;
                        return InkWell(
                          onTap: () => _select(v),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              child: it.child,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ sécurité: si parent change la value, on synchronise après frame
    _syncFieldValueAfterFrame();

    return FormField<T>(
      initialValue: widget.value,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        _field = field;

        final hasError = field.hasError;
        final value = widget.value;
        final text = _textForValue(value);
        final showHint = value == null || text.trim().isEmpty;

        return CompositedTransformTarget(
          link: _link,
          child: GestureDetector(
            onTap: widget.enabled ? _toggle : null,
            child: _GlassFieldFrame(
              enabled: widget.enabled,
              hasError: hasError,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    Icon(widget.prefixIcon, color: Colors.white.withOpacity(0.92), size: 20),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: _FieldTextLayout(
                      label: widget.label,
                      hasError: hasError,
                      body: Text(
                        showHint ? (widget.hint ?? '') : text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: showHint ? _hintStyle(hasError) : _valueStyle(enabled: widget.enabled),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      _open ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



class GlassMultiSelect<T> extends StatefulWidget {
  final String label;
  final String? hint;
  final List<T> options;
  final Set<T> selectedValues;
  final String Function(T value) optionLabel;
  final ValueChanged<Set<T>> onChanged;
  final String okText;
  final bool enabled;
  final String? Function(Set<T>?)? validator;
  final AutovalidateMode autovalidateMode;
  final IconData? prefixIcon;

  const GlassMultiSelect({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValues,
    required this.optionLabel,
    required this.onChanged,
    this.hint,
    this.okText = 'OK',
    this.enabled = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.prefixIcon,
  });

  @override
  State<GlassMultiSelect<T>> createState() => _GlassMultiSelectState<T>();
}

class _GlassMultiSelectState<T> extends State<GlassMultiSelect<T>> {
  String _summary(Set<T> values) {
    final s = Manager().winyCarTranslation;
    if (values.isEmpty) return widget.hint ?? s.selectPlaceholder;
    if (values.length <= 2) return values.map(widget.optionLabel).join(', ');
    return '${values.length} sélectionnées';
  }

  Future<void> _openDialog(FormFieldState<Set<T>> field) async {
    if (!widget.enabled) return;

    final result = await showDialog<Set<T>>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (ctx) {
        Set<T> temp = Set<T>.from(widget.selectedValues);
        String q = '';

        List<T> filtered() {
          if (q.trim().isEmpty) return widget.options;
          final qq = q.toLowerCase();
          return widget.options
              .where((o) => widget.optionLabel(o).toLowerCase().contains(qq))
              .toList();
        }

        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              backgroundColor: Colors.white.withOpacity(0.12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: StatefulBuilder(
                builder: (ctx, setS) {
                  final list = filtered();

                  // ✅ pour "tout sélectionner" en respectant la recherche
                  final allFilteredSelected =
                      list.isNotEmpty && list.every((it) => temp.contains(it));

                  return Container(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            // ✅ BOUTON TOUT SÉLECTIONNER / TOUT DÉSÉLECTIONNER
                            TextButton.icon(
                              onPressed: list.isEmpty
                                  ? null
                                  : () {
                                      setS(() {
                                        if (allFilteredSelected) {
                                          // tout désélectionner (uniquement ce qui est affiché)
                                          for (final it in list) {
                                            temp.remove(it);
                                          }
                                        } else {
                                          // tout sélectionner (uniquement ce qui est affiché)
                                          temp.addAll(list);
                                        }
                                      });
                                    },
                              icon: Icon(
                                allFilteredSelected ? Icons.remove_done : Icons.done_all,
                                color: Colors.white,
                                size: 18,
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                minimumSize: const Size(0, 40),
                              ),
                              label: Text(
                                allFilteredSelected
                                    ? Manager().winyCarTranslation.unselectAll
                                    : Manager().winyCarTranslation.selectAll,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () => Navigator.of(ctx).pop(null),
                              icon: const Icon(Icons.close, color: Colors.white, size: 22),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (v) => setS(() => q = v),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: Manager().winyCarTranslation.searchPlaceholder,
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: const Icon(Icons.search, color: Colors.white, size: 18),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          ),
                        ),
                        const SizedBox(height: 10),

                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 360),
                          child: Scrollbar(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (_, i) {
                                final item = list[i];
                                final selected = temp.contains(item);
                                return CheckboxListTile(
                                  dense: true,
                                  value: selected,
                                  onChanged: (v) {
                                    setS(() {
                                      if (v == true) {
                                        temp.add(item);
                                      } else {
                                        temp.remove(item);
                                      }
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  side: const BorderSide(color: Colors.white),
                                  title: Text(
                                    widget.optionLabel(item),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => Navigator.of(ctx).pop(Set<T>.from(temp)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                minimumSize: const Size(120, 44),
                              ),
                              child: Text(
                                widget.okText == 'OK'
                                    ? Manager().winyCarTranslation.ok
                                    : widget.okText,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      field.didChange(result);
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Set<T>>(
      initialValue: widget.selectedValues,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      builder: (field) {
        final hasError = field.hasError;
        final summary = _summary(widget.selectedValues);
        final showHint = widget.selectedValues.isEmpty;

        return GestureDetector(
          onTap: widget.enabled ? () => _openDialog(field) : null,
          child: _GlassFieldFrame(
            enabled: widget.enabled,
            hasError: hasError,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  Icon(widget.prefixIcon, color: Colors.white.withOpacity(0.92), size: 20),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: _FieldTextLayout(
                    label: widget.label,
                    hasError: hasError,
                    body: Text(
                      summary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: showHint ? _hintStyle(hasError) : _valueStyle(enabled: widget.enabled),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.expand_more, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* -------------------------------- Checkbox -------------------------------- */

class GlassCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?>? onChanged;
  final IconData? prefixIcon;
  final bool enabled;

  const GlassCheckbox({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final c = Colors.white;

    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, color: c.withOpacity(0.9), size: 18),
            const SizedBox(width: 8),
          ],
          Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            side: BorderSide(color: c.withOpacity(0.95)),
            activeColor: c,
            checkColor: Colors.black,
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: c.withOpacity(0.95),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* --------------------------------- Cards ---------------------------------- */

class GlassCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  const GlassCard({required this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    final bc = borderColor ?? Colors.white.withOpacity(0.25);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: bc, width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}

class AddPhotoTile extends StatelessWidget {
  final VoidCallback onTap;
  const AddPhotoTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.35)),
        ),
        child: const Center(
          child: Icon(Icons.add_a_photo_outlined, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

class PhotoTile extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onDelete;
  const PhotoTile({super.key, required this.image, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image(image: image, width: 110, height: 110, fit: BoxFit.cover),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onDelete,
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

/* ------------------------------ Formatters --------------------------------- */

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final upper = newValue.text.toUpperCase();
    return newValue.copyWith(text: upper, selection: newValue.selection, composing: TextRange.empty);
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text.replaceAll(' ', '');
    if (raw.isEmpty) return newValue;

    if (!RegExp(r'^\d+$').hasMatch(raw)) return oldValue;

    final chars = raw.split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) out.add(' ');
      out.add(chars[i]);
    }
    final formatted = out.reversed.join();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/* ------------------------------ Validators --------------------------------- */
// ✅ garde tes validators actuels si tu en as déjà ailleurs
String? yearValidator(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Required';
  final y = int.tryParse(t);
  if (y == null) return 'Invalid';
  if (y < 1950 || y > DateTime.now().year + 1) return 'Invalid';
  return null;
}

String? intValidator(String? v, {required bool allowZero}) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Required';
  final n = int.tryParse(t);
  if (n == null) return 'Invalid';
  if (!allowZero && n <= 0) return 'Invalid';
  if (allowZero && n < 0) return 'Invalid';
  return null;
}

String? priceValidator(String? v) {
  final t = (v ?? '').trim().replaceAll(' ', '');
  if (t.isEmpty) return 'Required';
  final n = double.tryParse(t.replaceAll(',', '.'));
  if (n == null) return 'Invalid';
  if (n <= 0) return 'Invalid';
  return null;
}

String? matriculeDzValidator(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return null;
  if (t.length < 5) return 'Invalid';
  return null;
}
