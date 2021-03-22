import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tab;

  ResponsiveLayout({this.mobile, this.tab});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 768) {
        return mobile;
      } else {
        return tab;
      }
    });
  }
}
