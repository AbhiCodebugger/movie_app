import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/presentation/bloc/search_movie_bloc.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/widget/search_textfield.dart';

class MovieSearchView extends StatefulWidget {
  const MovieSearchView({super.key});

  @override
  State<MovieSearchView> createState() => _MovieSearchViewState();
}

class _MovieSearchViewState extends State<MovieSearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF6F6FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          leading: const SizedBox(),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 30),
            child: SearchTextField(
                hintText: 'Tv shows, movies, and more',
                controller: _searchController,
                onChanged: (movie) {
                  _searchController.text = movie;
                  context.read<SearchMovieBloc>().add(SearchMovie(movie));
                  setState(() {});
                }),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchController.text.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        "Top Result",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
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
                      return Container(
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "$image_base_url${movie.image}",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 130,
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text("Fantasy"),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.more_horiz,
                              color: Colors.lightBlueAccent,
                            )
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
