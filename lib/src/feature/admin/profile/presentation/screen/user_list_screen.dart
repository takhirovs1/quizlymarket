import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    body: const SafeArea(
      child: Column(
        children: [
          Text('User List'),
        ],
      ),
    ),
  );
}