import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/utils/location_util.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = FutureProvider<Position>((ref) async {
  return await LocationUtil.getCurrentPosition();
});