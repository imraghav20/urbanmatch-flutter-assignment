class Commit {
  final String commitSha;
  final String commitAuthor;
  final String authorEmail;
  final String commitDate;
  final String commitMessage;
  final int commentCount;
  final String htmlUrl;

  Commit(
      {required this.commitSha,
      required this.commitAuthor,
      required this.authorEmail,
      required this.commitDate,
      required this.commitMessage,
      required this.commentCount,
      required this.htmlUrl}
      );
}
