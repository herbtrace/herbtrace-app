import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/screens/profiles/farmer/dashboard/farmer_dashboard_screen.dart';
import 'package:herbtrace_app/screens/profiles/farmer/status/status_screen.dart';
import 'package:herbtrace_app/screens/qr_scanner_screen.dart';
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
    print(ref.watch(currentProfileProvider)?.type);
    final ProfileType profileType =
        ref.watch(currentProfileProvider)?.type ?? ProfileType.transport;

    switch (profileType) {
      case ProfileType.farmer:
        return _buildTransportBody();
      case ProfileType.processor:
        // TODO: Implement processor body
        return const Center(child: Text('Processor View'));
      case ProfileType.transport:
        return _buildTransportBody();
      // TODO: Implement transport body
      case ProfileType.wildCollector:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProfileType.laboratory:
        return _buildTransportBody();
      // TODO: Handle this case.
      // throw UnimplementedError();
      case ProfileType.manufacturer:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProfileType.packer:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProfileType.storage:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  // ignore: unused_element
  Widget _buildFarmerBody() {
    switch (_currentIndex) {
      case 0:
        return const StatusScreen();
      case 1:
        debugPrint('Navigating to Status Screen');
        return const FarmerProfileScreen();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }

  Widget _buildTransportBody() {
    switch (_currentIndex) {
      case 0:
        return const StatusScreen();
      case 1:
        return const QRScannerScreen();
      case 2:
        debugPrint('Navigating to Status Screen');
        return const FarmerProfileScreen();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    final profile = ref.watch(currentProfileProvider);
    final localizations = AppLocalizations.of(context)!;

    switch (profile?.type) {
      case ProfileType.farmer:
        return [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code_scanner, size: 30),
            label: localizations.scan,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.profile,
          ),
        ];
      case ProfileType.transport:
        return [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code_scanner, size: 30),
            label: localizations.scan,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.profile,
          ),
        ];
      default:
        return [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code_scanner, size: 30),
            label: localizations.scan,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.profile,
          ),
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
