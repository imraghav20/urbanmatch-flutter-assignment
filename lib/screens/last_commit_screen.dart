import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_match_assignment/classes/commit_class.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'dart:developer';

import '../widgets/preloader.dart';

class LastCommitScreen extends StatefulWidget {
  final String repoFullName;

  const LastCommitScreen({super.key, required this.repoFullName});

  @override
  State<LastCommitScreen> createState() => _LastCommitScreenState();
}

class _LastCommitScreenState extends State<LastCommitScreen> {
  Future<void> _launchURL(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  Future<Commit?> _getLastCommit() async {
    String url = "https://api.github.com/repos/${widget.repoFullName}/commits";
    var data = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(data.body);

    if (jsonData == null || jsonData.length == 0) {
      return null;
    }

    var lastCommit = jsonData[0];

    Commit commit = Commit(
        commitSha: lastCommit["sha"],
        commitAuthor: lastCommit["commit"]["author"]["name"],
        authorEmail: lastCommit["commit"]["author"]["email"],
        commitDate: lastCommit["commit"]["author"]["date"],
        commitMessage: lastCommit["commit"]["message"],
        commentCount: lastCommit["commit"]["comment_count"],
        htmlUrl: lastCommit["html_url"]);

    return commit;
  }

  late Future<Commit?> myFuture;

  @override
  void initState() {
    myFuture = _getLastCommit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Last Commit",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Last commit details for repository ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "WorkSans",
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: widget.repoFullName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansBold",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: myFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  log("snapshot.data is null");
                  return const Preloader();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Commit sha: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.commitSha,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Author name: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.commitAuthor,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Author email: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.authorEmail,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Commit date: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.commitDate,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Commit message: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.commitMessage,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Number of comments: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSansBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: snapshot.data.commentCount.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "WorkSans",
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _launchURL(snapshot.data.htmlUrl);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              color: Colors.white,
                            ),
                            label: const Text("Browse Commit"),
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
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
