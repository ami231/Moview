import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/features/home/domain/genre_cubit.dart';
import 'package:moview/features/home/domain/page_cubit.dart';
import 'package:moview/common/domain/bloc/movies_bloc.dart';
import 'package:moview/features/home/domain/search_cubit.dart';
import 'package:moview/features/favorites/presentation/pages/favorites_page.dart';
import 'package:moview/features/home/presentation/pages/movie_detail_page.dart';
import 'package:moview/features/home/presentation/pages/search_page.dart';
import 'features/home/domain/scroll_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MoviesBloc()),
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ScrollControllerCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => GenreCubit()),
      ],
      child: MaterialApp(
        title: 'Moview',
        theme: ThemeData.dark(),
        initialRoute: HomePage.title,
        routes: {
          HomePage.title: (context) => const HomePage(),
          MovieDetailPage.title: (context) => const MovieDetailPage(),
          FavoritesPage.title : (context) => const FavoritesPage(),
          SearchPage.title : (context) => const SearchPage(),
        },
      ),
    );
  }
}
