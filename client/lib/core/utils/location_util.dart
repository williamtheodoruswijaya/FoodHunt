import 'package:geolocator/geolocator.dart';

class LocationUtil {
  static Future<Position> getCurrentPosition() async {
    //cek apakah service lokasi aktif
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service disabled.');
    }
    //cek izin lokasi
    LocationPermission permission = await Geolocator.checkPermission();
    //jika izin ditolak, minta izin
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //jika izin ditolak lagi, lempar exception
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied.');
    }
    //Jika diizinkan, ambil posisi saat ini
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
