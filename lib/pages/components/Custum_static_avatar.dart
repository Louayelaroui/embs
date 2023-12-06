import 'package:flutter/material.dart';

class CustomStaticAvatar extends StatelessWidget {
  const CustomStaticAvatar({Key? key, required this.urlImage}) : super(key: key);
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          width: 100,
          height: 100,
          placeholder: "assets/images/avatar.png",
          image: urlImage ,
          imageErrorBuilder: (context, err, stack){
            return Image.asset("assets/images/avatar.png");
          },
        ),
      ),
    );
  }
}
