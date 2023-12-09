import 'package:flutter/material.dart';

import '../../../reposetories/constants.dart';

class UserInfo extends StatelessWidget {
  final String title, text;
  const UserInfo({Key? key, required this.title, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.displayLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
        Text(text, style: textTheme.displayMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
        SizedBox(height: 20,)
      ],
    );
  }
}
