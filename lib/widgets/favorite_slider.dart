import 'package:blocExample/pages/news_details_page.dart';
import 'package:blocExample/providers/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardSliderFavorite extends StatelessWidget {
  const CardSliderFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        print('Building CardSliderFavorite with state: $state'); // Debug print
        if (state is FavoritesLoaded) {
          if (state.favoriteArticles.isEmpty) {
            return const Center(child: Text('No tienes favoritos.'));
          }
          return Center(
            child: Column(
              children: [
                const Text(
                  'Noticias favoritas',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 250, // Altura del slider
                  child: PageView.builder(
                    itemCount: state.favoriteArticles.length,
                    controller: PageController(viewportFraction: 0.85),
                    itemBuilder: (context, index) {
                      final article = state.favoriteArticles[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Navega a la página de detalles
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: BlocProvider.of<NewsBloc>(context),
                                  child: NewsDetailsPage(article: article),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                    child: Image.network(
                                      article.urlToImage ?? '',
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article.title.isNotEmpty ? article.title : "Sin título",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is FavoritesError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('No tienes favoritos.'));
      },
    );
  }
}