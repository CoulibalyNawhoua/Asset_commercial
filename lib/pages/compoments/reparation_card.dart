import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReparationItem extends StatelessWidget {

  final String title;
  final DateTime date;
  final int status;
  final VoidCallback onPressed;
  
  const ReparationItem(
    {
      super.key,
      required this.title,
      required this.date,
      required this.status,
      required this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    switch (status) {
      case 0:
        statusText = "Inactif";
        statusColor = Colors.yellow.shade900;
        break;
      case 1:
        statusText = "En cours ";
        statusColor = Colors.yellow.shade900;
        break;
      case 2:
        statusText = "Annulée";
        statusColor = Colors.red;
        break;
      case 3:
        statusText = "Terminée";
        statusColor = Colors.green;
        break;
      default:
        statusText = "intervention supprimer";
        statusColor = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[400],
                child: const Icon(
                  Icons.home_work,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(title,style: const TextStyle(fontSize: 14.0),),
              subtitle: Text(DateFormat('dd MMMM yyyy: HH\'h\'mm','fr_FR').format(date),style: const TextStyle(fontSize: 12.0),),
              trailing: Text(statusText, style: TextStyle(color: statusColor),),
            ),
            const Divider(height: 1, thickness: 1,),
          ],
        ),
      ),
    );
  }
}
