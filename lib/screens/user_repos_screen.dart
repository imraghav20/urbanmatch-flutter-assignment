import 'package:flutter/material.dart';

class UserReposScreen extends StatefulWidget {
  final String handle;

  const UserReposScreen({super.key, required this.handle});

  @override
  State<UserReposScreen> createState() => _UserReposScreenState();
}

class _UserReposScreenState extends State<UserReposScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          widget.handle,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
