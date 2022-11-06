import 'package:flutter/material.dart';

class ButtonElevated extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const ButtonElevated({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 40),
      ),
      child: loading
          ? const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
    );
  }
}
