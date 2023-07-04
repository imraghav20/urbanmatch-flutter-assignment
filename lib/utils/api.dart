import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import '../classes/commit_class.dart';
import '../classes/repository_class.dart';

Future<String?> checkUserExists(String username) async {
  String url = "https://api.github.com/users/$username";
  var data = await http.get(Uri.parse(url));
  var jsonData = jsonDecode(data.body);
  return jsonData["message"];
}

Future<void> launchURL(String url) async {
  final Uri url0 = Uri.parse(url);
  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

Future<List<String>> generateLanguages(String languagesUrl) async {
  List<String> languages = [];
  var data = await http.get(Uri.parse(languagesUrl));
  final Map<String, dynamic> jsonData = jsonDecode(data.body);
  final Iterable<String> langs = jsonData.keys;
  for (final lang in langs) {
    languages.add(lang);
  }
  return languages;
}

Future<List<Repository>?> getRepositories(String handle) async {
  String url = "https://api.github.com/users/$handle/repos";
  var data = await http.get(Uri.parse(url));
  var jsonData = jsonDecode(data.body);

  if (jsonData == null) {
    return null;
  }

  List<Repository> repositories = [];
  for (final repository in jsonData) {
    Repository repo = Repository(
        fullName: repository["full_name"],
        htmlUrl: repository["html_url"],
        description: repository["description"] ?? "",
        languages: await generateLanguages(repository["languages_url"]),
        updatedAt: repository["updated_at"].substring(0, 10),
        stars: repository["stargazers_count"],
        forks: repository["forks_count"]);
    repositories.add(repo);
  }
  return repositories;
}

Future<Commit?> getLastCommit(String repoFullName) async {
  String url = "https://api.github.com/repos/$repoFullName/commits";
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
