import '../core/api/api_client.dart';
import '../models/article.dart';

class ArticleService {
  final ApiClient _apiClient;

  ArticleService(this._apiClient);

  Future<List<Article>> getArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      Article(
        id: 1,
        title: 'Flutter Best Practices',
        description:
            'Learn the best practices for building Flutter applications with clean architecture and responsive design.',
        image: 'https://picsum.photos/800/400?random=1',
      ),
      Article(
        id: 2,
        title: 'Dart Null Safety',
        description:
            'A comprehensive guide to understanding and implementing null safety in Dart and Flutter applications.',
        image: 'https://picsum.photos/800/400?random=2',
      ),
      Article(
        id: 3,
        title: 'State Management',
        description:
            'Compare different state management solutions in Flutter and learn when to use each approach.',
        image: 'https://picsum.photos/800/400?random=3',
      ),
    ];
  }

  Future<Article> getArticleById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return Article(
      id: id,
      title: 'Article $id Details',
      description:
          'This is a detailed description for article $id. It contains more information about the topic and provides in-depth analysis of the subject matter.',
      image: 'https://picsum.photos/800/400?random=$id',
    );
  }
}
