import 'package:flutter/material.dart';

import 'bluetooth_list_widget.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    this.title,
    this.time,
    this.icon,
    this.people,
    this.color,
    this.nextColor,
    this.iconColor,
    this.textcolor1,
    this.textcolor2,
     this.textFieldController,
    this.titleshowD,
  });

  final String? title;
  final String? titleshowD;
  final String? time;
  final String? people;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final Color? textcolor1;
  final Color? textcolor2;
  final Color? nextColor;
  final TextEditingController? textFieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 80.0,
          bottom: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title!,
                  style: TextStyle(
                    color: textcolor1,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 25),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: iconColor,
                    size: 24,
                  ),
                  onPressed:(){
   showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title:  Text(titleshowD!),
    content: TextField(
    controller: textFieldController,
    decoration: const InputDecoration(hintText: "enter you data"),
    ),
    actions: <Widget>[
    ElevatedButton(
    child: const Text("Cancel"),
    onPressed: () => Navigator.pop(context),
    ),
    ElevatedButton(
    child: const Text('OK'),
    onPressed: () => Navigator.pop(context, textFieldController!.text),
    ),
    ],
    );
    });
                  }


                ),
                IconButton(
                  icon: Icon(
                    Icons.watch_outlined,
                    color: iconColor,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BluetoothListWidget()),
                    );
                    print('Watch Outlined pressed');
                  },
                ),

              ],
            ),
            const SizedBox(height: 2),
            Text(
              time!,
              style: TextStyle(color: textcolor2, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}