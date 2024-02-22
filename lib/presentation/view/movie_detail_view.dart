import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';
import 'package:movie_app/presentation/bloc/movie_trailer_bloc.dart';
import 'package:movie_app/presentation/view/book_ticket_view.dart';
import 'package:movie_app/presentation/view/movie_player_screen.dart';
import 'package:movie_app/utils/constants.dart';

class MovieDetailView extends StatefulWidget {
  final MovieEntity movieDetail;
  const MovieDetailView({required this.movieDetail, super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  List<TrailerEntity> trailers = [];
  @override
  void initState() {
    super.initState();
    context
        .read<MovieTrailerBloc>()
        .trailerUseCase
        .fetchMovieTrailer(widget.movieDetail.movieId)
        .then((response) {
      trailers = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1F27),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.transparent, Colors.black],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "$image_base_url${widget.movieDetail.image}",
                  placeholder: (context, url) =>
                      ClipRRect(child: Image.asset('assets/download.png')),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                top: 30,
                child: GestureDetector(
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
              ),
              Positioned(
                  bottom: 10,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            Text(
                              widget.movieDetail.rating.round().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.movieDetail.isAdult ? "+18" : "+13",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      const Gap(10),
                    ],
                  )),
              Positioned(
                right: 10,
                bottom: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (trailers.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MoviePlayerScreen(trailerEntity: trailers.first),
                        ),
                      );
                    } else {
                      // Handle the case when no trailers are available
                    }
                  },
                  child: const Text('Watch Trailer'),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(8.0), children: [
              Text(
                widget.movieDetail.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ]),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BookTicketView()));
            },
            child: const Text('Book Ticket'),
          ),
          const Gap(10)
        ],
      ),
    );
  }
}
