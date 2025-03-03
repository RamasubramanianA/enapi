class Article {
  final int id;
  final String title;
  final String description;
  final String image;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
