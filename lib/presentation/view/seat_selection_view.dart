import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';

class SeatSelectionView extends StatelessWidget {
  const SeatSelectionView({
    required this.movie,
    super.key,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF6F6FA),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Column(
          children: [
            Text(
              movie.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "In Theaters ${movie.releaseDate} | 12:30 Hall 1",
              style: GoogleFonts.poppins(
                color: const Color(0xff61C3F2),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Gap(10),
          Image.asset("assets/png/screen.png"),
          Column(
            children: [
              buildSeatWidget(
                  text: "Selected",
                  color: Colors.deepOrange,
                  color2: Colors.deepPurple,
                  text2: "Regular(50\$)"),
              const Gap(20),
              buildSeatWidget(
                  text: "Vip(150\$)",
                  color: Colors.blueAccent,
                  color2: Colors.grey,
                  text2: "No selected    "),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Chip(
                  backgroundColor: Colors.grey.shade200,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  label: const Text("4/3 row   X")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.5, horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Price",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )),
                          Text("\$ 50",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xff61C3F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Proceed to pay",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row buildSeatWidget(
      {required Color color,
      required String text,
      required Color color2,
      required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: color2, borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          text2,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
