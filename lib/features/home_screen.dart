import 'package:atomic_habits/features/dashboard_feature/presentation/pages/dashboard_screen.dart';
import 'package:atomic_habits/features/food_feature/presentation/pages/food_screen.dart';
import 'package:atomic_habits/features/habits_feature/presentation/pages/habits_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          DashBoardScreen(),
          HabitsScreen(),
          FoodScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 150),
            curve: Curves.bounceIn,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Habits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: "Food",
          ),
        ],
      ),
    );
  }
}
