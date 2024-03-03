import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final Function callback;

  const SettingButton(this.color, this.text, this.size, this.value,
      {super.key, required this.setting, required this.callback});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(this.setting, this.value),
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
