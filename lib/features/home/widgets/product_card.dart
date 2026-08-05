import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 350,

      margin: const EdgeInsets.only(right: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(26),

        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // IMAGE SECTION
          SizedBox(
            height: 160,

            child: Stack(
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(26),
                  ),

                  child: Image.network(
                    product.imageUrl,

                    width: double.infinity,

                    height: 160,

                    fit: BoxFit.cover,
                  ),
                ),


                // Favorite button
                Positioned(
                  top: 12,
                  right: 12,

                  child: Container(
                    width: 34,
                    height: 34,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),

                    child: IconButton(
                      padding: EdgeInsets.zero,

                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        size: 19,
                        color: Colors.brown,
                      ),

                      onPressed: () {},
                    ),
                  ),
                ),


                // Discount badge
                Positioned(
                  left: 12,
                  bottom: 12,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Text(
                      "HOT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



          // CONTENT
          Padding(
            padding: const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [


                Text(
                  product.name,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),



                const SizedBox(height: 6),



                // Category chip
                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color:
                    Colors.brown.withOpacity(0.08),

                    borderRadius:
                    BorderRadius.circular(20),
                  ),

                  child: Text(
                    product.category,

                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 11,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),



                const SizedBox(height: 14),



                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [


                    Text(
                      "${product.price.toStringAsFixed(0)} vnđ",

                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w900,
                      ),
                    ),



                    Container(
                      width: 51,
                      height: 51,

                      decoration: BoxDecoration(
                        gradient:
                        const LinearGradient(
                          colors: [
                            Colors.brown,
                            Colors.deepOrange,
                          ],
                        ),

                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown
                                .withOpacity(0.35),

                            blurRadius: 10,

                            offset:
                            const Offset(0, 5),
                          ),
                        ],
                      ),


                      child: IconButton(
                        padding: EdgeInsets.zero,

                        icon: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 25,
                        ),

                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}