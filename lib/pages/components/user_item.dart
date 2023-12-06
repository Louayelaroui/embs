import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Custum_static_avatar.dart';

class PlayerItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold);
    return GestureDetector(
      onTap: (){
        print("tab");

      },
      child: Container(

        width: 150,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color:Colors.white38,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          children: [
            const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ).tr(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text("confirme").tr(),
                              onPressed: () async {
                                Navigator.pop(context);

                              },
                            ),
                          ],
                          title: Text(
                            'Delete_player',
                          ).tr(),
                          contentPadding: const EdgeInsets.all(20),
                          content: Text('alertcontetnt').tr(),
                        ));

                  },
                    icon: const Icon(Icons.cancel_outlined, color: Colors.white,),
                  )
                ],
              ),
            CustomStaticAvatar(urlImage: "",),
            const SizedBox(height: 5,),
            Text("test", style: style,),
            Text("test", style: style,),



          ],
        ),
      ),
    );
  }
}
