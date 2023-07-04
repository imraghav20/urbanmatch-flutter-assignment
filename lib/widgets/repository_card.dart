import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../classes/repository_class.dart';
import '../screens/last_commit_screen.dart';
import '../utils/api.dart';

class RepositoryCard extends StatelessWidget {
  final BuildContext context;
  final Repository repository;

  const RepositoryCard(
      {super.key, required this.context, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
      color: Colors.deepPurple[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              repository.fullName,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "WorkSansBold",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          repository.description != ""
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 10.0, right: 10.0),
                  child: Text(
                    repository.description,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 14.0),
                  ),
                )
              : const SizedBox(),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
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
                    text: repository.updatedAt,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "WorkSans",
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          repository.languages.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 10.0, right: 10.0),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List<Widget>.generate(repository.languages.length,
                        (int i) {
                      return Chip(
                        label: Text(repository.languages[i]),
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
                    const Padding(padding: EdgeInsets.only(left: 10.0)),
                    const FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amberAccent,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 5.0)),
                    Text(repository.stars.toString()),
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
                    const Padding(padding: EdgeInsets.only(right: 5.0)),
                    Text(repository.forks.toString()),
                    const Padding(padding: EdgeInsets.only(right: 10.0)),
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
                        repoFullName: repository.fullName,
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
                  launchURL(repository.htmlUrl);
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
  }
}
