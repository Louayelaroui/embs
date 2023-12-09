import 'package:easy_localization/easy_localization.dart';
import 'package:embs/pages/View/Doctor/UserList/UserDetails/UserDetails.dart';
import 'package:flutter/material.dart';
import '../../../models/User.dart';
import '../../components/Custum_static_avatar.dart';
import '../Doctor/UserList/UserDetails/user_screen.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<UserItem> createState() => _UserItemState();
}
class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context)
        .textTheme
        .displayMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    return GestureDetector(
      onTap: () {
        print("tab");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserDetails(),
          ),
        );
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
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
                            child: Text("confirm").tr(),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        title: Text(
                          'Delete_player',
                        ).tr(),
                        contentPadding: const EdgeInsets.all(20),
                        content: Text('alertcontent').tr(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.cancel_outlined, color: Colors.white,),
                )
              ],
            ),
            CustomStaticAvatar(urlImage:  "",),
            const SizedBox(height: 5,),
            Text("${tr(widget.user.name ?? "")}", style: style,),
          ],
        ),
      ),
    );
  }
}
