import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:embs/pages/View/component/user_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/User.dart';
import '../../../../reposetories/auth_repository.dart';
import '../../../../reposetories/constants.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(""),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/firstAnalyse");
            },
            icon: Icon(
              Icons.analytics_outlined,
              size: 35,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: PlayerBody(),
    );
  }
}

class PlayerBody extends StatefulWidget {
  const PlayerBody({Key? key}) : super(key: key);

  @override
  State<PlayerBody> createState() => _PlayerBodyState();
}

class _PlayerBodyState extends State<PlayerBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        AuthRepo.getAllUsers().then((value) {
          context.read<Users>().setUsers(value.users);
        }).onError((error, stackTrace) {
          print(error);
        });
      },
      child: ListView(
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Consumer<Users>(
              builder: (context, users, child) {
                final userList = [
                  "Test User 1",
                  "Test User 2",
                  "Test User 3",
                  "Test User 4",
                  "Test User 5",
                ];

                return userList.isNotEmpty
                    ? Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 10,
                  children: [
                    ...userList.map((e) => UserItem(user: User(name: e))).toList(),
                    Opacity(
                      opacity: 0,
                      child: UserItem(user: User()),
                    ),
                  ],
                )
                    : Center(
                  child: Text(
                    "NO Player had been added",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
                  ).tr(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final User user;
  final String role;

  const UserList({Key? key, required this.user, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("User: ${user.name}, Role: $role");
  }
}
