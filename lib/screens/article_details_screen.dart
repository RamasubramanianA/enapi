import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final int articleId;
  final String title;
  final String description;
  final String image;

  const ArticleDetailsScreen({
    super.key,
    required this.articleId,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            Text(description, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
