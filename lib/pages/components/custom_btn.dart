import 'package:flutter/material.dart';

import '../../reposetories/constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({Key? key, required this.text, this.onPress, this.primary=true}) : super(key: key);
  final String text;
  final bool primary;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress?.call,
      style: ElevatedButton.styleFrom(
          backgroundColor: primary?elevationBtnColor:Colors.white,
          padding: const EdgeInsets.symmetric(vertical:18, horizontal: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          )

      ),
      child: Text(text, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: primary?null:scaffoldBackgroundColor),),

    );
  }
}