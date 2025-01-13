import 'package:blocExample/pages/news_page.dart';
import 'package:blocExample/providers/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc()..add(LoadNewsEvent()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(), // Inicializa tu FavoriteBloc aquí
        ),
      ],
      child: MaterialApp(
        title: 'Noticias de Animales',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewsPage(),
      ),
    );
  }
}