import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/cubit.dart';
import 'package:moview/bloc/movies_bloc.dart';
import 'package:moview/screens/favorites_page.dart';
import 'package:moview/screens/movie_detail_page.dart';
import 'screens/home_page.dart';

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
        BlocProvider(create: (context) => MaxPageCubit()),
      ],
      child: MaterialApp(
        title: 'Moview',
        theme: ThemeData.dark(),
        initialRoute: '/HomePage',
        routes: {
          '/HomePage': (context) => const HomePage(),
          '/MovieDetailPage': (context) => const MovieDetailPage(),
          '/FavoritesPage' : (context) => const FavoritesPage(),
        },
      ),
    );
  }
}
