import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;

  const SettingButton(this.color, this.text, this.value, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      color: this.color,
    );
  }
}
