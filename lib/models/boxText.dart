import 'package:flutter/material.dart';

class textBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPress;
  const textBox(
      {super.key, required this.text, required this.sectionName, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF9fbdc2), borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionName,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15),
            ),
            IconButton(
                onPressed: () => onPress,
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[50],
                ))
          ],
        ),
      ]),
    );
  }
}
