import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/restaurant/data/restaurant_model.dart';
import 'package:client/features/restaurant/provider/restaurant_providers.dart';
import 'package:client/widgets/review_item.dart';

class RestaurantDetailPage extends ConsumerStatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  ConsumerState<RestaurantDetailPage> createState() =>
      _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends ConsumerState<RestaurantDetailPage> {
  bool expanded = false;
  int userRating = 0;

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;
    print("DETAIL PAGE PRICE: ${restaurant.price}");
    print("DETAIL PAGE RATING: ${restaurant.averageRating}");

    //final menuAsync = ref.watch(
    //restaurantMenuProvider(restaurant.restaurantId),
    //);

    //final ratingAsync = ref.watch(
    // restaurantRatingProvider(restaurant.restaurantId),
    //);
    final reviewsAsync = ref.watch(
      restaurantReviewsProvider(restaurant.restaurantId),
    );
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar restoran
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            top: expanded ? -screenHeight * 0.15 : 0,
            left: 0,
            right: 0,
            height: expanded ? screenHeight * 0.75 : screenHeight * 0.9,
            child: Hero(
              tag: restaurant.restaurantId,
              child: Image.network(
                restaurant.imageUrl ??
                    "https://via.placeholder.com/800?text=No+Image",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Tombol back
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Expendable card
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              height: expanded ? screenHeight * 0.62 : screenHeight * 0.22,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // scrollview buat isi resto
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${restaurant.name}!",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Deskripsi
                          Text(
                            restaurant.description,
                            style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.4,
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Konten tambahan (expand)
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 250),
                            crossFadeState:
                                expanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            firstChild: const SizedBox.shrink(),
                            secondChild: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Rating / Harga / Kategori
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Rating
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            restaurant.averageRating != null
                                                ? restaurant.averageRating!
                                                    .toStringAsFixed(1)
                                                : "-",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),

                                          const SizedBox(width: 120),
                                          //price
                                          const Icon(
                                            Icons.attach_money,
                                            size: 18,
                                            color: Colors.green,
                                          ),

                                          Text(
                                            restaurant.price?.toString() ?? "-",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Category
                                      Text(
                                        "-",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Lokasi
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.redAccent,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        restaurant.address,
                                        style: const TextStyle(fontSize: 13.5),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Review & RATING",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // ===================
                                // REVIEW FORM USER
                                // ===================
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Rating Anda",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      // ⭐⭐⭐⭐⭐ - BINTANG TAP
                                      Row(
                                        children: List.generate(5, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(
                                                () => userRating = index + 1,
                                              );
                                            },
                                            child: Icon(
                                              index < userRating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 28,
                                            ),
                                          );
                                        }),
                                      ),

                                      const SizedBox(height: 14),

                                      const Text(
                                        "Review",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      // TEXTAREA
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF7EFD8),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const TextField(
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "Ceritakan Pengalaman Anda...",
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      // KIRIM REVIEW
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print("User Rating: $userRating");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.pink,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                          ),
                                          child: const Text(
                                            "Kirim Review",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                reviewsAsync.when(
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  error:
                                      (e, _) => Text("Gagal memuat review: $e"),
                                  data: (reviews) {
                                    if (reviews.isEmpty) {
                                      return const Text(
                                        "Belum ada review.",
                                        style: TextStyle(color: Colors.grey),
                                      );
                                    }

                                    return Column(
                                      children:
                                          reviews.map((r) {
                                            return ReviewItem(
                                              name:
                                                  "User ${r.userId}", // atau ambil dari Users table nanti
                                              review: r.comment ?? "-",
                                              rating: r.rating,
                                            );
                                          }).toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expand button
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => setState(() => expanded = !expanded),
                        icon: Icon(
                          expanded
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: Colors.pinkAccent,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
