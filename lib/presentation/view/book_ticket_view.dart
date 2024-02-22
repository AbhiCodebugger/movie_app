import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookTicketView extends StatefulWidget {
  const BookTicketView({super.key});

  @override
  State<BookTicketView> createState() => _BookTicketViewState();
}

class _BookTicketViewState extends State<BookTicketView> {
  Set<SeatNumber> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1E1F27),
        body: SafeArea(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Screen",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Gap(50),
              SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, seatState) {
                  if (seatState == SeatState.selected) {
                    selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                  } else {
                    selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                  }
                },
                stateModel: const SeatLayoutStateModel(
                  rows: 10,
                  cols: 7,
                  seatSvgSize: 50,
                  pathSelectedSeat: 'assets/svg/seat_selected.svg',
                  pathDisabledSeat: 'assets/svg/seat_disabled.svg',
                  pathSoldSeat: 'assets/svg/seat_sold.svg',
                  pathUnSelectedSeat: 'assets/svg/seat_unselected.svg',
                  currentSeatsState: [
                    [
                      SeatState.disabled,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.sold,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.sold,
                      SeatState.sold,
                      SeatState.sold,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.sold,
                      SeatState.sold,
                    ],
                    [
                      SeatState.sold,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.sold,
                      SeatState.sold,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.empty,
                      SeatState.empty,
                      SeatState.empty,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.sold,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.sold,
                      SeatState.sold,
                      SeatState.sold,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Disabled',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.lightBlueAccent,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Sold',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff0FFF50))),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Available',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          color: const Color(0xff0FFF50),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Selected by you',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  'Show my selected seat numbers',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                selectedSeats.join(" , "),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              )
            ],
          ),
        ));
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
