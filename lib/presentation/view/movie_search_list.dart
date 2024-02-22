import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/presentation/bloc/search_movie_bloc.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/widget/search_textfield.dart';

class MovieSearchList extends StatefulWidget {
  const MovieSearchList({super.key});

  @override
  State<MovieSearchList> createState() => _MovieSearchListState();
}

class _MovieSearchListState extends State<MovieSearchList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1F27),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back)),
          ),
          SearchTextField(
            hintText: "Search Movie...",
            controller: _searchController,
            onChanged: (movie) {
              context.read<SearchMovieBloc>().add(SearchMovie(movie));
            },
          ),
          BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state is SearchMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchMovieError) {
                return Center(
                  child: Text(
                    state.error,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                );
              } else if (state is SearchMovieLoaded) {
                List<MovieEntity> movies = state.movies;
                return Expanded(
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      MovieEntity movie = movies[index];
                      return Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "$image_base_url${movie.image}",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            const Gap(30),
                            Expanded(
                              child: Text(
                                movie.title,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      )),
    );
  }
}
