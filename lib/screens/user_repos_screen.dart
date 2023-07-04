import 'package:flutter/material.dart';
import 'package:urban_match_assignment/classes/repository_class.dart';
import 'package:urban_match_assignment/widgets/repository_card.dart';

import 'dart:developer';

import '../utils/api.dart';
import '../widgets/preloader.dart';

class UserReposScreen extends StatefulWidget {
  final String handle;

  const UserReposScreen({super.key, required this.handle});

  @override
  State<UserReposScreen> createState() => _UserReposScreenState();
}

class _UserReposScreenState extends State<UserReposScreen> {
  late Future<List<Repository>?> myFuture;

  @override
  void initState() {
    myFuture = getRepositories(widget.handle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Repos",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              log("snapshot.data is null");
              return const Preloader();
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return RepositoryCard(
                      context: context, repository: snapshot.data[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
