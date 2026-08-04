// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class SeedDatabase {
//   static final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   static Future<void> seedProducts() async {
//     final products = {
//       "espresso": {
//         "category": "Coffee",
//         "description": "Traditional Italian espresso.",
//         "imageUrl": "https://picsum.photos/seed/espresso/400/400",
//         "isAvailable": true,
//         "name": "Espresso",
//         "price": 45000,
//       },
//       "latte": {
//         "category": "Coffee",
//         "description": "Smooth espresso with steamed milk.",
//         "imageUrl": "https://picsum.photos/seed/latte/400/400",
//         "isAvailable": true,
//         "name": "Latte",
//         "price": 55000,
//       },
//       "cappuccino": {
//         "category": "Coffee",
//         "description": "Rich espresso with milk foam.",
//         "imageUrl": "https://picsum.photos/seed/cappuccino/400/400",
//         "isAvailable": true,
//         "name": "Cappuccino",
//         "price": 55000,
//       },
//       "americano": {
//         "category": "Coffee",
//         "description": "Espresso with hot water.",
//         "imageUrl": "https://picsum.photos/seed/americano/400/400",
//         "isAvailable": true,
//         "name": "Americano",
//         "price": 50000,
//       },
//       "mocha": {
//         "category": "Coffee",
//         "description": "Chocolate flavored coffee.",
//         "imageUrl": "https://picsum.photos/seed/mocha/400/400",
//         "isAvailable": true,
//         "name": "Mocha",
//         "price": 60000,
//       },
//       "macchiato": {
//         "category": "Coffee",
//         "description": "Espresso with milk foam.",
//         "imageUrl": "https://picsum.photos/seed/macchiato/400/400",
//         "isAvailable": true,
//         "name": "Macchiato",
//         "price": 55000,
//       },
//       "flat_white": {
//         "category": "Coffee",
//         "description": "Smooth coffee with microfoam.",
//         "imageUrl": "https://picsum.photos/seed/flatwhite/400/400",
//         "isAvailable": true,
//         "name": "Flat White",
//         "price": 60000,
//       },
//       "cold_brew": {
//         "category": "Coffee",
//         "description": "Cold brewed coffee.",
//         "imageUrl": "https://picsum.photos/seed/coldbrew/400/400",
//         "isAvailable": true,
//         "name": "Cold Brew",
//         "price": 60000,
//       },
//       "black_coffee": {
//         "category": "Coffee",
//         "description": "Traditional black coffee.",
//         "imageUrl": "https://picsum.photos/seed/blackcoffee/400/400",
//         "isAvailable": true,
//         "name": "Black Coffee",
//         "price": 40000,
//       },
//       "caramel_latte": {
//         "category": "Coffee",
//         "description": "Latte with caramel syrup.",
//         "imageUrl": "https://picsum.photos/seed/caramellatte/400/400",
//         "isAvailable": true,
//         "name": "Caramel Latte",
//         "price": 65000,
//       },
//       "matcha_latte": {
//         "category": "Tea",
//         "description": "Premium Japanese matcha.",
//         "imageUrl": "https://picsum.photos/seed/matcha/400/400",
//         "isAvailable": true,
//         "name": "Matcha Latte",
//         "price": 65000,
//       },
//       "milk_tea": {
//         "category": "Tea",
//         "description": "Classic milk tea.",
//         "imageUrl": "https://picsum.photos/seed/milktea/400/400",
//         "isAvailable": true,
//         "name": "Milk Tea",
//         "price": 50000,
//       },
//       "peach_tea": {
//         "category": "Tea",
//         "description": "Fresh peach tea.",
//         "imageUrl": "https://picsum.photos/seed/peachtea/400/400",
//         "isAvailable": true,
//         "name": "Peach Tea",
//         "price": 55000,
//       },
//       "cheesecake": {
//         "category": "Cake",
//         "description": "Creamy cheesecake.",
//         "imageUrl": "https://picsum.photos/seed/cheesecake/400/400",
//         "isAvailable": true,
//         "name": "Cheesecake",
//         "price": 65000,
//       },
//       "tiramisu": {
//         "category": "Cake",
//         "description": "Italian tiramisu cake.",
//         "imageUrl": "https://picsum.photos/seed/tiramisu/400/400",
//         "isAvailable": true,
//         "name": "Tiramisu",
//         "price": 70000,
//       },
//     };
//
//     for (final entry in products.entries) {
//       await db.collection("products").doc(entry.key).set(entry.value);
//     }
//
//     print("Products imported!");
//   }
// }