import 'package:blocExample/widgets/favorite_slider.dart';
import 'package:blocExample/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocExample/providers/news_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de Animales'),
      ),
      body: BlocProvider(
        create: (context) => NewsBloc()..add(LoadNewsEvent()),
        child: Column(
          children: [
            CardSlider(),
            CardSliderFavorite(),
          ],
        ),
      ),
    );
  }
}