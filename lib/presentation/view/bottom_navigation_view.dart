import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/presentation/view/movie_list_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Dashboard',
    ),
    MovieListView(),
    Text(
      'Media Library',
    ),
    Text(
      'More',
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBarFloating(
        items: const [
          TabItem(icon: Icons.grid_view_rounded, title: "Dashboard"),
          TabItem(icon: Icons.smart_display, title: "Watch"),
          TabItem(icon: Icons.library_music_sharp, title: "Media Library"),
          TabItem(icon: Icons.menu_rounded, title: "More"),
        ],
        backgroundColor: const Color(0xff2E2739),
        color: Colors.grey,
        borderRadius: BorderRadius.circular(27),
        colorSelected: Colors.white,
        indexSelected: _selectedIndex,
        paddingVertical: 20,
        onTap: _onTap,
      ),
    );
  }
}
