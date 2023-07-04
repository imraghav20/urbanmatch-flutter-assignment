import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/api.dart';
import '../utils/error_handle.dart';
import 'user_repos_screen.dart';

class GitHubIdFormScreen extends StatefulWidget {
  const GitHubIdFormScreen({super.key});

  @override
  State<GitHubIdFormScreen> createState() => _GitHubIdFormScreenState();
}

class _GitHubIdFormScreenState extends State<GitHubIdFormScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const FaIcon(FontAwesomeIcons.github, size: 80.0),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _usernameController,
              style:
                  const TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 20),
              decoration: const InputDecoration(
                hintText: "Enter the GitHub username",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: MaterialButton(
                onPressed: () async {
                  var username = _usernameController.text;
                  if (username == '') {
                    displayDialog(context, "An Error Occurred",
                        "Username cannot be empty");
                  } else {
                    String? userCheckMessage = await checkUserExists(username);
                    if (userCheckMessage == null) {
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: UserReposScreen(
                            handle: username,
                          ),
                        ),
                      );
                    } else if (userCheckMessage
                        .startsWith("API rate limit exceeded")) {
                      displayDialog(context, "An Error Occurred",
                          "API rate limit exceeded");
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username");
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Search Profile Repos",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
