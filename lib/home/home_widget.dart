import 'package:flutter/material.dart';
import 'package:my_voice_app/models/background_image.dart';
import 'package:my_voice_app/models/user.dart';
import 'package:my_voice_app/services/wp.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../welcome/splashscreen.dart';
import '../models/appbar.dart';
import './homepage.dart';
import './read.dart';
import './watch.dart';
import './just_ask.dart';
import './get_involved.dart';

class MVHome extends StatefulWidget {
  @override
  _MVHomeState createState() => _MVHomeState();
}

class _MVHomeState extends State<MVHome> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onBottomNavChange(int i) {
    setState(() {
      _currentIndex = i;

      _pageController.animateToPage(i,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  Color? _selectedIcon(int i) {
    return _currentIndex == i ? Colors.white : Colors.grey[800];
  }

  void changePage(int i) {
    _pageController.animateToPage(i,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final MVUser? user = Provider.of<MVUser?>(context);

    return user == null
        ? SizedBox.shrink()
        : FutureBuilder<MVWPContent>(
            future: MVWP.getContent(),
            builder: (context, snapshot) => MVBackground(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: getMVAppBar(context),
                    bottomNavigationBar: BottomNavigationBar(
                      onTap: _onBottomNavChange,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Theme.of(context).primaryColor,
                      //selectedLabelStyle: TextStyle(color: Colors.white),
                      currentIndex: _currentIndex,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                              color: _selectedIcon(0),
                            ),
                            label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.menu_book_rounded,
                              color: _selectedIcon(1),
                            ),
                            label: "Read"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.ondemand_video_rounded,
                              color: _selectedIcon(2),
                            ),
                            label: "Watch"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.textsms_rounded,
                              color: _selectedIcon(3),
                            ),
                            label: "Ask"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: _selectedIcon(4),
                            ),
                            label: "Join"),
                      ],
                    ),
                    body: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        setState(() => _currentIndex = i);
                      },
                      children: [
                        HomePage(
                          snapshot: snapshot,
                          changePage: changePage,
                        ),
                        ReadPage(
                          snapshot: snapshot,
                        ),
                        WatchPage(
                          snapshot: snapshot,
                        ),
                        GIPage(
                          snapshot: snapshot,
                        ),
                        JAPage(
                          snapshot: snapshot,
                        ),
                      ],
                    ),
                  ),
                ));
  }
}
