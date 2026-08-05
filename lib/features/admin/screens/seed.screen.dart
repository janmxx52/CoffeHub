// import 'package:flutter/material.dart';
// import '../../../data/seed/seed_database.dart';
//
// class SeedScreen extends StatelessWidget {
//   const SeedScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Seed Database"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             try {
//               await SeedDatabase.seedProducts();
//
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Import Products thành công!"),
//                   ),
//                 );
//               }
//             } catch (e) {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text("Lỗi: $e"),
//                   ),
//                 );
//               }
//             }
//           },
//           child: const Text("Import Products"),
//         ),
//       ),
//     );
//   }
// }