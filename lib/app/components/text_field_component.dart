import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  final ValueChanged<String> function;

  const TextFieldComponent({
    super.key,
    required this.label,
    required this.prefix,
    required this.controller,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.indigo),
        floatingLabelStyle: const TextStyle(color: Colors.indigo),
        border: const OutlineInputBorder(),
        prefixText: prefix ,
      ),
      style: const TextStyle(
        fontSize: 26,
        color: Colors.indigo,
      ),
      onChanged: function,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
