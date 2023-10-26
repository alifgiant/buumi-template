import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String actionText;
  final void Function() onTap;

  const EmptyScreen({
    super.key,
    required this.title,
    required this.actionText,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              onPressed: onTap,
              child: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }
}
