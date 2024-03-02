import 'package:flutter/material.dart';
import 'package:timer/widget/settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Settings',
              style: TextStyle(),
            ),
          ),
        ),
        body: Settings());
  }
}
