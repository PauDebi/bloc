import 'package:blocExample/providers/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocExample/models/noticias.dart';

class NewsDetailsPage extends StatelessWidget {
  final Article article;

  const NewsDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Noticia'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              state = state as FavoritesLoaded;
              final isFavorite = state.favoriteArticles.contains(article);
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  final bloc = BlocProvider.of<FavoritesBloc>(context);
                  if (isFavorite) {
                    bloc.add(RemoveFavoriteEvent(article)); // Quitar de favoritos
                  } else {
                    bloc.add(AddFavoriteEvent(article)); // Agregar a favoritos
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title.isNotEmpty ? article.title : "Sin título",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article.source?['name'] ?? "Fuente desconocida",
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (article.description != null)
              Text(
                article.description!,
                style: const TextStyle(fontSize: 18.0),
              ),
            const SizedBox(height: 16),
            if (article.content != null)
              Text(
                article.content!,
                style: const TextStyle(fontSize: 16.0),
              ),
            const SizedBox(height: 16),
            if (article.publishedAt != null)
              Text(
                "Publicado el: ${article.publishedAt!.toLocal()}",
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}