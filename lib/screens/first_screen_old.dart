// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:herbtrace_app/generated/app_localizations.dart';
// import 'package:herbtrace_app/services/language_service.dart';
// import 'package:herbtrace_app/widgets/language_switch_button.dart';
// import 'package:herbtrace_app/config/theme.dart';

// class FirstScreen extends ConsumerWidget {
//   const FirstScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _ = ref.watch(languageServiceProvider);
//     final localizations = AppLocalizations.of(context)!;
    
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               AppTheme.primaryGreen,
//               AppTheme.primaryGreen.withOpacity(0.8),
//               Colors.green.shade600,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 // Header with language selector
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         'HerbTrace',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: LanguageSwitchButton(),
//                     ),
//                   ],
//                 ),
                
//                 // Main content
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Logo/Icon section
//                       Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 20,
//                               offset: Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.eco,
//                           size: 60,
//                           color: AppTheme.primaryGreen,
//                         ),
//                       ),
                      
//                       const SizedBox(height: 40),
                      
//                       // Welcome text
//                       Text(
//                         localizations.welcome_to_herbtrace,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           height: 1.2,
//                         ),
//                       ),
                      
//                       const SizedBox(height: 16),
                      
//                       // Subtitle
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Text(
//                           'Sustainable Medicinal Plant Supply Chain Tracking',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.9),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             height: 1.4,
//                           ),
//                         ),
//                       ),
                      
//                       const SizedBox(height: 60),
                      
//                       // Feature cards
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildFeatureCard(
//                               icon: Icons.track_changes,
//                               title: 'Track',
//                               subtitle: 'Monitor your crops',
//                               color: Colors.blue.shade400,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: _buildFeatureCard(
//                               icon: Icons.verified,
//                               title: 'Verify',
//                               subtitle: 'Ensure authenticity',
//                               color: Colors.orange.shade400,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: _buildFeatureCard(
//                               icon: Icons.nature,
//                               title: 'Sustain',
//                               subtitle: 'Protect nature',
//                               color: Colors.teal.shade400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
                
//                 // Bottom action area
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // TODO: Navigate to login or main app
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: AppTheme.primaryGreen,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           localizations.start,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Icon(Icons.arrow_forward),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.8),
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
