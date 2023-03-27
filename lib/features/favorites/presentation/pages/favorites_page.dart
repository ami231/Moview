import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/common/domain/bloc/movies_bloc.dart';
import 'package:moview/common/domain/bloc/movies_state.dart';
import 'package:moview/features/bottom_navigation_bar/bottom_navigation.dart';
import 'package:moview/features/home/presentation/widgets/movie_listview_widget.dart';

class FavoritesPage extends StatefulWidget {
  static const String title = 'FavoritesPage';

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
        return favoritesBloc.state.favoritesList.isEmpty
            ? const Center(
                child: Text('No favorites yet'),
              )
            : buildMovieListView(
                state: state,
                list: favoritesBloc.state.favoritesList,
                length: favoritesBloc.state.favoritesList.length,
                isHomePage: isHomePage,
                context: context);
      }),
      bottomNavigationBar: bottomNavBar(context, isHomePage),
    );
  }
}
