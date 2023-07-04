import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:urban_match_assignment/classes/repository_class.dart';
import 'package:urban_match_assignment/screens/last_commit_screen.dart';

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
                  return Card(
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                    color: Colors.deepPurple[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            snapshot.data[index].fullName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "WorkSansBold",
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        snapshot.data[index].description != ""
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0, right: 10.0),
                                child: Text(
                                  snapshot.data[index].description,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 14.0),
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "last updated: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "WorkSansBold",
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: snapshot.data[index].updatedAt,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "WorkSans",
                                      fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        snapshot.data[index].languages.length != 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0, right: 10.0),
                                child: Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: List<Widget>.generate(
                                      snapshot.data[index].languages.length,
                                      (int i) {
                                    return Chip(
                                      label: Text(
                                          snapshot.data[index].languages[i]),
                                    );
                                  }),
                                ),
                              )
                            : const SizedBox(),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  const FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amberAccent,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5.0)),
                                  Text(snapshot.data[index].stars.toString()),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.codeFork,
                                    color: Colors.black45,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5.0)),
                                  Text(snapshot.data[index].forks.toString()),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 10.0)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LastCommitScreen(
                                      repoFullName:
                                          snapshot.data[index].fullName,
                                    ),
                                  ),
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.codeCommit,
                                color: Colors.white,
                              ),
                              label: const Text("Last Commit"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                launchURL(snapshot.data[index].htmlUrl);
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                color: Colors.white,
                              ),
                              label: const Text("Browse Repo"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
