import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widgets/category_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_banner.dart';
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

    final provider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: const HomeAppBar(),

      body: provider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: provider.refreshProducts,
        child: ListView(
          children: [

            const SizedBox(height: 16),

            const HomeBanner(),

            const SizedBox(height: 24),

            const CategorySection(),

            const SizedBox(height: 24),

            ProductSection(
              products: provider.products,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}