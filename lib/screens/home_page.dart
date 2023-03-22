import 'package:flutter/material.dart';
import 'package:moview/bloc/movies_state.dart';
import 'package:moview/models/movie_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/services/load_favorites.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_event.dart';
import '../components/bottomNavigationBar_widget.dart';
import '../components/buildMovieListView_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isHomepage = true;
  final TextEditingController? searchController = TextEditingController();
  String searchInput = '';

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
          List<MovieModel> searchList = moviesBloc.state.allMoviesList
              .where((element) => element.title.toLowerCase().contains(searchInput.toLowerCase()))
              .toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: searchController,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    iconColor: Colors.grey,
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchInput = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: buildMovieListView(
                  state: moviesBloc.state,
                  length: searchList.length,
                  list: searchList,
                  isHomePage: isHomepage,
                ),
              ),
            ],
          );
        }

        return Container();
      }),
      bottomNavigationBar: bottomNavBar(context, isHomepage),
    );
  }
}
