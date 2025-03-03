import 'package:flutter/material.dart';
import '../components/responsive_app_bar.dart';
import '../components/app_drawer.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import '../core/api/api_client.dart';
import 'article_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ArticleService _articleService;
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _articleService = ArticleService(ApiClient());
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    try {
      final articles = await _articleService.getArticles();
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading articles: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(
        title: 'Articles',
        onProfileTap: () {
          // Add profile action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile tapped')),
          );
        },
      ),
      endDrawer: const AppDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Side menu for larger screens
              if (constraints.maxWidth >= 600)
                const SizedBox(
                  width: 250,
                  child: AppDrawer(),
                ),
              // Main content
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: _loadArticles,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _articles.length,
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ArticleDetailsScreen(
                                        articleId: article.id,
                                        title: article.title,
                                        description: article.description,
                                        image: article.image,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        article.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArticleDetailsScreen(
                                                    articleId: article.id,
                                                    title: article.title,
                                                    description:
                                                        article.description,
                                                    image: article.image,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Read More'),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.bookmark_border),
                                            onPressed: () {
                                              // Add bookmark action
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
