import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Switch avec le même rendu "verre"
class GlassSwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;

  const GlassSwitchTile({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.35)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(
          Icons.business_center_outlined,
          color: Colors.white,
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.black,
          activeTrackColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.white38,
        ),
      ),
    );
  }
}

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const ErrorBanner({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white),
            tooltip: 'Fermer',
          ),
        ],
      ),
    );
  }
}
