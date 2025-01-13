import 'dart:math';
import 'package:blocExample/models/noticias.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class NewsEvent {}

// Eventos
class LoadNewsEvent extends NewsEvent {}

// Estados
abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;

  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}

// Bloc
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<Article> favoriteArticles = []; // Lista de favoritos
  List<String> themes = ['animal', 'technology', 'science', 'health', 'sports', 'business', 'entertainment'];

  NewsBloc() : super(NewsLoading()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        var url = Uri.https('newsapi.org', '/v2/everything', {
          'apikey': 'c3f97b933435462b89732274a1c6bcca',
          'q': themes[Random().nextInt(themes.length)],
          'language': 'es',
        });
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final noticias = Noticias.fromJson(response.body);
          emit(NewsLoaded(noticias.articles));
        } else {
          emit(NewsError('Error al cargar noticias: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}

// Eventos de favoritos
abstract class FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final Article article;

  AddFavoriteEvent(this.article);
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final Article article;

  RemoveFavoriteEvent(this.article);
}

// Estados de favoritos
abstract class FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Article> favoriteArticles;

  FavoritesLoaded(this.favoriteArticles);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}

// Bloc de favoritos
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  List<Article> favoriteArticles = []; // Lista de favoritos

  FavoritesBloc() : super(FavoritesLoaded([])) {
    on<AddFavoriteEvent>((event, emit) {
      favoriteArticles.add(event.article);
      emit(FavoritesLoaded(List.from(favoriteArticles))); // Emit a new instance of the list
    });

    on<RemoveFavoriteEvent>((event, emit) {
      favoriteArticles.remove(event.article);
      emit(FavoritesLoaded(List.from(favoriteArticles))); // Emit a new instance of the list
    });
  }
}