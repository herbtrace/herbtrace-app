// import 'package:flutter/material.dart';
// import '../models/batch_transfer_model.dart';
// import '../models/crop_model.dart';
// import '../services/batch_transfer_service.dart';
// import '../widgets/batch_transfers_list.dart';

// class DashboardScreen extends StatefulWidget {
//   final String profileId;
//   final String role;

//   const DashboardScreen({
//     super.key,
//     required this.profileId,
//     required this.role,
//   });

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final _batchTransferService = BatchTransferService();
//   List<BatchTransfer>? _transfers;
//   Map<String, CropModel> _crops = {};
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _loadTransfers();
//   }

//   Future<void> _loadTransfers() async {
//     try {
//       final transfers = await _batchTransferService.getBatchTransfers(
//         profileId: widget.profileId,
//         role: widget.role,
//       );

//       setState(() {
//         _transfers = transfers;

//         _error = null;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_error != null) {
//       return Center(child: Text('Error: $_error'));
//     }

//     if (_transfers == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_transfers!.isEmpty) {
//       return const Center(child: Text('No transfers found'));
//     }

//     return RefreshIndicator(
//       onRefresh: _loadTransfers,
//       child: BatchTransfersList(transfers: _transfers!, crops: _crops),
//     );
//   }
// }
