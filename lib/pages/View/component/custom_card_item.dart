import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({Key? key,
    this.color =  Colors.blue,
    required this.index,
    required this.title,
    this.subtitle,
    this.onPress,
    this.onDelete,
  }) : super(key: key);
  final Color color;
  final int index;
  final String title;
  final String? subtitle;
  final Function()? onPress;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress?.call,
      child: Card(
        color: color,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Row(
            children: [
              if(onDelete != null)
                SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.red),
                                ).tr(),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text("confirme").tr(),
                                onPressed: () async {
                                  Navigator.pop(context);

                                  onDelete?.call();
                                },
                              ),
                            ],
                            title: Text(
                              'Delete_consultation',
                            ).tr(),
                            contentPadding:
                            EdgeInsets.all(20),
                            content:
                            Text('contetent').tr(),
                          ));
                    },
                    icon: const Icon(Icons.delete, size: 30,color: Colors.white,),
                  ),
                ),
              Expanded(
                flex: 2,
                child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex:1 ,
                child: Text(
                    subtitle?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.normal)),
              ),

              CircleAvatar(
                child: Text("${index + 1}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
