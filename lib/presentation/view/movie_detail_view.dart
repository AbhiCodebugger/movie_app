import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.darken,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    imageUrl: "$image_base_url${widget.movieDetail.image}",
                    placeholder: (context, url) => ClipRRect(
                        child: Image.asset('assets/png/download.png')),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Column(
                    children: [
                      Text(
                        "In Theaters ${widget.movieDetail.releaseDate} ",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BookTicketView(movie: widget.movieDetail),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 243,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xff61C3F2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Get Tickets",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviePlayerScreen(
                                    trailerEntity: trailers.first)),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 243,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff61C3F2),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Text(
                                "Watch Trailer",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Genres",
              style: GoogleFonts.poppins(
                color: const Color(0xff202C43),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  label: Text(
                    "Action",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.tealAccent,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                Chip(
                  label: Text(
                    "Thriller",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.pink,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                Chip(
                  label: Text("Science",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  backgroundColor: Colors.deepPurpleAccent,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                Chip(
                  label: Text("Fiction",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  backgroundColor: Colors.yellow,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
          const Gap(10),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black.withOpacity(0.2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Overview",
              style: GoogleFonts.poppins(
                color: const Color(0xff202C43),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                Text(
                  widget.movieDetail.description,
                  style: GoogleFonts.poppins(
                    color: const Color(0xff8F8F8F),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
