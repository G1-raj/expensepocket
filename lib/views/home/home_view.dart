import 'package:expensepoket/views/home/profile_view.dart';
import 'package:expensepoket/views/screens/budget_view.dart';
import 'package:expensepoket/views/screens/loans_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0; // Track selected tab

  // List of pages to switch between
  final List<Widget> _pages = [
    BudgetView(),
    LoansView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex], // Display the selected page

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update selected tab
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: "Loans"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
