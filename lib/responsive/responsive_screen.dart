import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveScreen({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return mobile; // ✅ Mobile layout
          } else if (constraints.maxWidth < 1200) {
            return tablet; // ✅ Tablet layout
          } else {
            return desktop; // ✅ Desktop layout
          }
        },
      ),
    );
  }
}
