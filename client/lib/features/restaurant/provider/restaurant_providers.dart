import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/restaurant_model.dart';
import '../data/restaurant_repository.dart';
import '../data/restaurant_service.dart';
import 'package:client/features/location/location_provider.dart';
import 'package:client/features/item/data/item_model.dart';
import 'package:client/features/review/data/review_model.dart';

// Service dan Provider

final restaurantServiceProvider = Provider((ref) => RestaurantService());

final restaurantRepositoryProvider = Provider(
  (ref) => RestaurantRepository(ref.read(restaurantServiceProvider)),
);

// Recommendation

final restaurantRecommendationProvider = FutureProvider<List<RestaurantModel>>((
  ref,
) async {
  final repo = ref.read(restaurantRepositoryProvider);
  final locationAsync = ref.watch(locationProvider);

  return locationAsync.when(
    loading: () => [],
    error: (e, st) {
      // Permission ditolak / error beneran
      throw Exception("LOCATION_ERROR");
    },
    data: (pos) async {
      return repo.fetchRecommendations(
        lat: pos.latitude,
        lng: pos.longitude,
        maxDistanceKm: 10,
      );
    },
  );
});

// Detail resto

final restaurantDetailProvider = FutureProvider.family<RestaurantModel, int>((
  ref,
  int id,
) async {
  final repo = ref.read(restaurantRepositoryProvider);
  return repo.fetchDetail(id);
});

// Search resto

final restaurantSearchProvider =
    FutureProvider.family<List<RestaurantModel>, String>((
      ref,
      String keyword,
    ) async {
      final repo = ref.read(restaurantRepositoryProvider);
      return repo.search(keyword);
    });

final restaurantMenuProvider = FutureProvider.family<List<MenuItemModel>, int>((
  ref,
  int id,
) async {
  final repo = ref.read(restaurantRepositoryProvider);
  return repo.fetchMenu(id);
});

final restaurantReviewsProvider = FutureProvider.family<List<ReviewModel>, int>(
  (ref, int id) async {
    final repo = ref.read(restaurantRepositoryProvider);
    return repo.fetchReviews(id);
  },
);

final restaurantRatingProvider = FutureProvider.family<double, int>((
  ref,
  id,
) async {
  final repo = ref.watch(restaurantRepositoryProvider);
  return repo.getRating(id);
});
