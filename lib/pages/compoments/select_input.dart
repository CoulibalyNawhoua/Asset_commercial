import 'package:flutter/material.dart';

import '../../constantes/constantes.dart';

class SelectInput extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?)? onChanged;
  final String hint;
  final String? Function(dynamic value) validator;

  const SelectInput({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint, 
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    );

    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: border,
        hintStyle: const TextStyle(color: AppColors.primaryColor),
        enabledBorder: border,
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      hint: Text(hint),
      validator: validator,
    );
  }
}
