import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),

        child: NavigationBar(
          height: 72,

          backgroundColor: Colors.white,

          elevation: 0,

          selectedIndex: currentIndex,

          indicatorColor:
          Colors.brown.withOpacity(0.15),

          labelBehavior:
          NavigationDestinationLabelBehavior.alwaysShow,


          onDestinationSelected: (index) {

            switch (index) {

              case 0:
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                );
                break;


              case 1:
                Navigator.pushReplacementNamed(
                  context,
                  '/favorite',
                );
                break;


              case 2:
                Navigator.pushReplacementNamed(
                  context,
                  '/profile',
                );
                break;
            }
          },


          destinations: const [

            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
              ),

              selectedIcon: Icon(
                Icons.home_rounded,
                color: Colors.brown,
              ),

              label: "Home",
            ),


            NavigationDestination(
              icon: Icon(
                Icons.favorite_border_rounded,
              ),

              selectedIcon: Icon(
                Icons.favorite_rounded,
                color: Colors.redAccent,
              ),

              label: "Favorite",
            ),


            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
              ),

              selectedIcon: Icon(
                Icons.person_rounded,
                color: Colors.brown,
              ),

              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}