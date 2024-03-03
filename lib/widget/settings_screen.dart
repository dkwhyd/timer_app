import 'package:flutter/material.dart';
import 'package:timer/widget/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        body: const Settings());
  }
}
