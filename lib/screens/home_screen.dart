import 'package:flutter/material.dart';
import 'package:htag_directory/components/add_hashtag_component.dart';
import 'package:htag_directory/screens/views/hashtag_list_view.dart';
import 'package:htag_directory/screens/views/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  int _currentIdex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(
      initialPage: _currentIdex,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hashtag Directory")),
      body: PageView(
        onPageChanged: (index) {
          setState(() => _currentIdex = index);
        },
        controller: _pageController,
        children: const <Widget>[
          HomeView(),
          HashtagListView(),
        ],
      ),
      floatingActionButton: const AddHashtagComponent(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIdex,
          onTap: (index) {
            setState(() => _currentIdex = index);
            _pageController.jumpToPage(_currentIdex);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "HashTags",
            )
          ]),
    );
  }
}
