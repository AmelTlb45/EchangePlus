
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, required bool value});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _value,
      onChanged: (newValue) {
        setState(() {
          _value = newValue ?? false;
        });
      },
    );
  }
}
