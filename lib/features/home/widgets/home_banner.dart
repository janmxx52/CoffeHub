import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),

        child: Stack(
          children: [

            // Background
            Positioned.fill(
              child: Image.asset(
                "assets/images/banner2.jpg",
                fit: BoxFit.cover,
              ),
            ),


            // Dark gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.85),
                      Colors.black.withOpacity(0.45),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),


            // Glow circle
            Positioned(
              right: -40,
              top: 20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(0.15),
                ),
              ),
            ),


            // Coffee icon card
            Positioned(
              right: 25,
              bottom: 35,
              child: Container(
                width: 95,
                height: 95,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                  ),
                ),

                child: const Icon(
                  Icons.local_cafe_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),


            // Content
            Padding(
              padding: const EdgeInsets.all(26),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  // Premium badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ),

                    child: const Text(
                      "☕ PREMIUM COLLECTION",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),


                  const SizedBox(height: 16),


                  // Title
                  const Text(
                    "Premium\nCoffee",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),


                  const SizedBox(height: 10),


                  const Text(
                    "Experience the taste\nof freshly brewed coffee",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),


                  const SizedBox(height: 18),


                  // Button
                  Container(
                    height: 44,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      ),

                      borderRadius:
                      BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),


                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),


                      child: const Text(
                        "Order Now  →",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}