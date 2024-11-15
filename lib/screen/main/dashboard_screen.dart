import 'package:clinicapplication/screen/navigation/home/home_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('History')),
    const Center(child: Text('Inbox')),
    const Center(child: Text('Profile')),
  ];

  final Map<int, Map<String, String>> _navIcons = {
    0: {
      'filled': 'assets/icon/filled/home_filled.png',
      'linear': 'assets/icon/linear/home.png',
    },
    1: {
      'filled': 'assets/icon/filled/history_filled.png',
      'linear': 'assets/icon/linear/history.png',
    },
    2: {
      'filled': 'assets/icon/filled/notif_filled.png',
      'linear': 'assets/icon/linear/notif.png',
    },
    3: {
      'filled': 'assets/icon/filled/profile_circle_filled.png',
      'linear': 'assets/icon/linear/profile.png',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          children: [
            BottomAppBar(
              color: Colors.white,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_outlined, 'Home', 0),
                  _buildNavItem(Icons.history, 'History', 1),
                  const SizedBox(width: 40),
                  _buildNavItem(Icons.notifications_outlined, 'Inbox', 2),
                  _buildNavItem(Icons.person_outline, 'Profile', 3),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 64,
        width: 64,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF617BF4),
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle QR code scan
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index;
    final color = isSelected ? const Color(0xFF617BF4) : Colors.grey;

    final String assetPath = isSelected
        ? _navIcons[index]!['filled']!
        : _navIcons[index]!['linear']!;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 24,
            height: 24,
            color: color,
            errorBuilder: (context, error, stackTrace) {
              return Icon(icon, color: color, size: 24);
            },
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
