import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/common/data/constants/genres.dart';
import '../../../../common/domain/bloc/movies_bloc.dart';
import '../widgets/movie_listview_widget.dart';
import '../../domain/genre_cubit.dart';
import '../../domain/search_cubit.dart';
import '../../../../common/data/models/movie_model.dart';

class SearchPage extends StatefulWidget {
  static const String title = 'SearchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bool isHomePage = false;
  final TextEditingController? _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GenreCubit, GenreState>(
        builder: (context, genreState) {
          return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
            final moviesBloc = BlocProvider.of<MoviesBloc>(context);
            final searchCubit = BlocProvider.of<SearchCubit>(context);
            final genreCubit = BlocProvider.of<GenreCubit>(context);

            List<MovieModel> allMovies = moviesBloc.state.allMoviesList;
            List<MovieModel> searchList = allMovies
                .where((element) => element.title.toLowerCase().contains(searchCubit.state.searchText.toLowerCase()))
                .toList();

            int genreId = genres.keys.firstWhere((key) => genres[key] == genreCubit.state.genre);

            List<MovieModel> filteredList = genreId == 0 ? searchList : searchList.where((element)
            =>
            element
                .genreIds
                .contains
              (genreId))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(hintText: 'Type here...', icon: Icon(Icons.search)),
                          onChanged: (value) {
                            searchCubit.updateSearch(newText: value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    DropdownButton(
                          hint: Text(genreCubit.state.genre),
                          items: genres.values.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            genreCubit.updateGenre(newGenre: value.toString());
                          },
                        )
                  ],
                ),
                Expanded(
                  child: searchCubit.state.searchText == ''
                      ? const Center(
                          child: Text('Search for a movie'),
                        )
                      : buildMovieListView(
                          state: moviesBloc.state,
                          length: filteredList.length,
                          list: filteredList,
                          isHomePage: isHomePage,
                          context: context),
                ),
              ],
            );
          });
        }
      ),
    );
  }
}
