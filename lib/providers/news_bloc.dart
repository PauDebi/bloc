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

  NewsBloc() : super(NewsLoading()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=animal&language=es&apiKey=c0c93013cb7246ba82c55ca1626fbc3e',
        ));
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


//Eventos
abstract class FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final Article article;

  AddFavoriteEvent(this.article);
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final Article article;

  RemoveFavoriteEvent(this.article);
}

//Estados
abstract class FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Article> favoriteArticles;

  FavoritesLoaded(this.favoriteArticles);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}



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