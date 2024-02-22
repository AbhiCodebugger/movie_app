import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/network_repository.dart';
import 'package:movie_app/core/network/network_repository_impl.dart';
import 'package:movie_app/data/repository/movie_repository_impl.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/usecase/movie_usecase.dart';
import 'package:movie_app/domain/usecase/search_movie_usecase.dart';
import 'package:movie_app/domain/usecase/trailer_usecase.dart';
import 'package:movie_app/presentation/bloc/movie_trailer_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movie_bloc.dart';
import 'package:movie_app/presentation/view/bottom_navigation_view.dart';
import 'package:movie_app/presentation/view/movie_list_view.dart';
import 'package:movie_app/utils/constants.dart';

import 'presentation/bloc/movie_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    NetworkRepository repository = NetworkRepositoryImpl(dio, base_url);
    MovieRepository movieRepository = MovieRepositoryImpl(repository);
    MovieUseCase movieUseCase = MovieUseCase(movieRepository);
    TrailerUseCase trailerUseCase = TrailerUseCase(movieRepository);
    SearchMovieUseCase searchMovieUseCase = SearchMovieUseCase(movieRepository);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieBloc(movieUseCase)),
        BlocProvider(create: (context) => SearchMovieBloc(searchMovieUseCase)),
        BlocProvider(create: (context) => MovieTrailerBloc(trailerUseCase)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const BottomNavigationView(),
      ),
    );
  }
}
