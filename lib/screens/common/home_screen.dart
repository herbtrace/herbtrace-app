import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/constants/app_constants.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/screens/profiles/farmer/dashboard/farmer_dashboard_screen.dart';
import 'package:herbtrace_app/screens/profiles/farmer/status/status_screen.dart';
import 'package:herbtrace_app/screens/profiles/farmer/transaction/transaction_screen.dart';
import 'package:herbtrace_app/widgets/common/app_bar/custom_app_bar.dart';
import 'package:herbtrace_app/widgets/common/navigation/app_drawer.dart';
import 'package:herbtrace_app/widgets/common/navigation/bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  Widget _buildBody() {
    final profileType = ref.watch(profileTypeProvider) ?? ProfileType.farmer;
    print(profileType);
    // Return appropriate body based on profile type and current index
    switch (profileType) {
      case ProfileType.farmer:
        return _buildFarmerBody();
      case ProfileType.processor:
        // TODO: Implement processor body
        return const Center(child: Text('Processor View'));
      case ProfileType.transport:
        // TODO: Implement transport body
        return const Center(child: Text('Transport View'));
      case ProfileType.testing:
        // TODO: Implement testing body
        return const Center(child: Text('Testing View'));
      default:
        return const Center(child: Text('Select a Profile Type')); // Fallback
    }
  }

  Widget _buildFarmerBody() {
    switch (_currentIndex) {
      case 0:
        return const StatusScreen();
      case 1:
        debugPrint('Navigating to Status Screen');
        return const FarmerProfileScreen();
      // return const Center(child: Text('Unknown Page'));
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    final profileType = ref.watch(profileTypeProvider);

    switch (profileType) {
      case ProfileType.farmer:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
      // Add other profile types' navigation items here
      default:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(currentProfileProvider);

    return Scaffold(
      appBar: CustomAppBar(title: profile?.profileTitle ?? 'HerbTrace'),
      drawer: const AppDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,

        items: _buildNavItems(),
        onTap: _onNavItemTapped,
      ),
    );
  }
}
