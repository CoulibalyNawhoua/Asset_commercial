import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DemandeItem extends StatelessWidget {

  final String title;
  final DateTime date;
  final int status;
  final VoidCallback onPressed;
  
  const DemandeItem(
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
    if (status == 5) {
      statusText = "Terminée";
      statusColor = Colors.green;
    } else if (status == 6) {
      statusText = "Rejetée";
      statusColor = Colors.red;
    } else {
      statusText = "En cours";
      statusColor = Colors.yellow.shade900;
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
