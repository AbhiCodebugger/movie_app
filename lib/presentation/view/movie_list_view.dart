import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/presentation/view/movie_detail_view.dart';
import 'package:movie_app/presentation/view/movie_search_list.dart';
import 'package:movie_app/widget/movie_item.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1F27),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Upcoming Movie",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MovieSearchList()));
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    size: 50,
                    color: Colors.white,
                  ))
            ],
          ),
          FutureBuilder(
              future:
                  context.read<MovieBloc>().movieUseCase.fetchUpComingMovie(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  );
                } else {
                  List<MovieEntity>? movies = snapshot.data;
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: movies?.length,
                        itemBuilder: (context, index) {
                          MovieEntity movie = movies![index];
                          return MovieItem(
                            movie: movie,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailView(movieDetail: movie),
                                ),
                              );
                            },
                          );
                        }),
                  );
                }
              }),
        ],
      )),
    );
  }
}
