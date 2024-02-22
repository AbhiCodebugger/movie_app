import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: const Color(0XFFF6F6FA),
      appBar: AppBar(
        title: Text(
          'Watch',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MovieSearchView()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
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
                  return ListView.builder(
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
                      });
                }
              })),
    );
  }
}
