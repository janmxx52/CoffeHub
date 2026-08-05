import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';
import '../widgets/guest_login_card.dart';
import '../providers/home_provider.dart';
import '../widgets/category_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_bottom_navigation.dart';
import '../widgets/product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: homeProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: homeProvider.refreshProducts,
        child: ListView(
          children: [

            if (!authProvider.isLoggedIn) ...[
              const GuestLoginCard(),
              const SizedBox(height: 20),
            ],

            const HomeBanner(),

            const SizedBox(height: 24),

            const CategorySection(),

            const SizedBox(height: 24),

            ProductSection(
              products: homeProvider.products,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigation(
        currentIndex: 0,
      ),
    );
  }
}