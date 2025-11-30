import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/restaurant_model.dart';
import '../../../core/config/api_config.dart';
import 'package:client/features/item/data/item_model.dart';
import 'package:client/features/review/data/review_model.dart';

class RestaurantService {
  // List biasa
  Future<List<RestaurantModel>> list({int page = 1, int size = 10}) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/restaurants?page=$page&size=$size"),
    );
    final json = jsonDecode(res.body);
    List data = json["data"];
    return data.map((e) => RestaurantModel.fromJson(e)).toList();
  }

  // Search resto spesifik
  Future<List<RestaurantModel>> search(String keyword) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/restaurants/search?keyword=$keyword"),
    );
    final json = jsonDecode(res.body);
    List data = json["data"];
    return data.map((e) => RestaurantModel.fromJson(e)).toList();
  }

  // Detail
  Future<RestaurantModel> getDetail(int id) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/restaurants/$id"),
    );
    final json = jsonDecode(res.body);
    return RestaurantModel.fromJson(json["data"]);
  }

  // Recommendation matrix
  Future<List<RestaurantModel>> getRecommendations({
    double? lat,
    double? lng,
    double? maxDistanceKm,
    int? limit,
  }) async {
    final String url =
        "${ApiConfig.baseUrl}/restaurants/recommendations?useMatrix=true"
        "${lat != null ? "&lat=$lat" : ""}"
        "${lng != null ? "&lng=$lng" : ""}"
        "${maxDistanceKm != null ? "&maxDistanceKm=$maxDistanceKm" : ""}"
        "${limit != null ? "&limit=$limit" : ""}";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) {
      throw Exception("Failed to load recommendations (${res.statusCode})");
    }

    final json = jsonDecode(res.body);
    final List data = json["data"] ?? [];

    return data.map((e) => RestaurantModel.fromJson(e)).toList();
  }

  // Menu
  Future<List<MenuItemModel>> getMenu(int id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/restaurants/$id/menu");
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to load menu");
    }

    final List data = jsonDecode(res.body)["data"];
    return data.map((m) => MenuItemModel.fromJson(m)).toList();
  }

  // Review
  Future<List<ReviewModel>> getReviews(int id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/restaurants/$id/reviews");
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to load reviews");
    }

    final List data = jsonDecode(res.body)["data"];
    return data.map((r) => ReviewModel.fromJson(r)).toList();
  }

  // Rating
  Future<double> fetchRating(int id) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/restaurants/$id/rating"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load restaurant rating");
    }

    final data = jsonDecode(response.body);
    return (data["rating"] as num).toDouble();
  }
}
