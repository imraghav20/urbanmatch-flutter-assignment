import 'package:flutter/material.dart';
import 'package:urban_match_assignment/screens/github_id_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.blue),
        useMaterial3: true,
      ),
      home: GitHubIdFormScreen(),
    );
  }
}
