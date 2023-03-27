import 'package:flutter/material.dart';
import 'package:moview/common/domain/bloc/movies_state.dart';
import 'package:moview/common/data/models/movie_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/features/home/presentation/pages/search_page.dart';
import 'package:moview/common/data/models/load_favorites.dart';
import '../../../../common/domain/bloc/movies_bloc.dart';
import '../../../../common/domain/bloc/movies_event.dart';
import '../../../bottom_navigation_bar/bottom_navigation.dart';
import '../widgets/movie_listview_widget.dart';

class HomePage extends StatefulWidget {
  static const String title = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isHomepage = true;

  @override
  void initState() {
    loadFavorites(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc.add(LoadMoviesEvent(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.title);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesInitial) {
          return const Center(
            child: Text('No data'),
          );
        } else if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesLoaded) {
          List<MovieModel> movieList = moviesBloc.state.allMoviesList.toList();
          return Column(
            children: [
              Expanded(
                child: buildMovieListView(
                    state: moviesBloc.state,
                    length: movieList.length,
                    list: movieList,
                    isHomePage: isHomepage,
                    context: context),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      }),
      bottomNavigationBar: bottomNavBar(context, isHomepage),
    );
  }
}
