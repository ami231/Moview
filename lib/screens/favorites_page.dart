import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/movies_bloc.dart';
import 'package:moview/bloc/movies_state.dart';
import 'package:moview/components/bottomNavigationBar_widget.dart';
import 'package:moview/components/buildMovieListView_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isHomePage = false;

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<MoviesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        return buildMovieListView(
          state: state,
          list: favoritesBloc.state.favoritesList,
          length: favoritesBloc.state.favoritesList.length,
          isHomePage: isHomePage,
        );
      }),
      bottomNavigationBar: bottomNavBar(context, isHomePage),
    );
  }
}
