import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/presentation/view/seat_selection_view.dart';

class BookTicketView extends StatefulWidget {
  const BookTicketView({
    required this.movie,
    super.key,
  });
  final MovieEntity movie;

  @override
  State<BookTicketView> createState() => _BookTicketViewState();
}

class _BookTicketViewState extends State<BookTicketView> {
  int selectedDate = 0;
  int selectedThreater = 0;
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
                widget.movie.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "In Theaters ${widget.movie.releaseDate}",
                style: GoogleFonts.poppins(
                  color: const Color(0xff61C3F2),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(120),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text("Date",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(
                  10,
                  (index) => GestureDetector(
                    onTap: () {
                      selectedDate = index;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        padding: const EdgeInsets.all(10),
                        label: Text("${index + 1} Mar",
                            style: GoogleFonts.poppins(
                              color: (index == selectedDate)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                        backgroundColor: (index == selectedDate)
                            ? const Color(0xff61C3F2)
                            : Colors.grey.shade300,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () {
                      selectedThreater = index;
                      setState(() {});
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 300,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (index == selectedThreater)
                                  ? const Color(0xff61C3F2)
                                  : Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/png/seat.png',
                            fit: BoxFit.contain,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SeatSelectionView(movie: widget.movie),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: 323,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff61C3F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Select Seats",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
            const Gap(20)
          ],
        ));
  }
}
