import 'package:asset_managmant_mobile/fonctions/fonction.dart';
import 'package:flutter/material.dart';

import '../../constantes/constantes.dart';

class CButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const CButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    var border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: border,
        // backgroundColor: AppColors.secondaryColor,
        backgroundColor: isLoading ? AppColors.secondaryColor : AppColors.secondaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: SizedBox(
        width: width(context),
        child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white,))
          : Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
      ),
      // child: SizedBox(
      //   width: width(context),
      //   child: Text(
      //       title,
      //       textAlign: TextAlign.center,
      //       style: const TextStyle(fontSize: 20, color: Colors.white),
      //     ),
      // ),
    );
  }
}

class CTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CTextButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
