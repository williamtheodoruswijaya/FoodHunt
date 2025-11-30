import '../data/restaurant_model.dart';
import '../data/restaurant_service.dart';
import 'package:client/features/item/data/item_model.dart';
import 'package:client/features/review/data/review_model.dart';

class RestaurantRepository {
  final RestaurantService service;

  RestaurantRepository(this.service);

  //Recommendation
  Future<List<RestaurantModel>> fetchRecommendations({
    double? lat,
    double? lng,
    double? maxDistanceKm,
  }) async {
    return service.getRecommendations(
      lat: lat,
      lng: lng,
      maxDistanceKm: maxDistanceKm,
    );
  }

  // Detail
  Future<RestaurantModel> fetchDetail(int id) async {
    return service.getDetail(id);
  }

  // Search
  Future<List<RestaurantModel>> search(String keyword) async {
    return service.search(keyword);
  }

  // Menu
  Future<List<MenuItemModel>> fetchMenu(int id) async {
    return service.getMenu(id);
  }

  // Review
  Future<List<ReviewModel>> fetchReviews(int id) async {
    return service.getReviews(id);
  }

  Future<double> getRating(int id) async {
    return await service.fetchRating(id);
  }
}
