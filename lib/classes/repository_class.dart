class Repository {
  final String fullName;
  final String htmlUrl;
  final String description;
  final List<String> languages;
  final String updatedAt;
  final int stars;
  final int forks;

  Repository(
      {required this.fullName,
      required this.htmlUrl,
      required this.description,
      required this.languages,
      required this.updatedAt,
      required this.stars,
      required this.forks}
      );
}
