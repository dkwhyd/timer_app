import 'package:flutter/material.dart';

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
      body: Container(
        child: Text('seting'),
      ),
    );
  }
}
