import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../fonctions/fonction.dart';

class CAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  const CAppBarHome({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final AuthenticateController authenticateController = Get.put(AuthenticateController());
    return AppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.white,
       title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Text(
              getInitials(name),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {authenticateController.deconnectUser();},
            icon: const Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            )
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed;

  const CAppBar({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,color: AppColors.primaryColor,),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
