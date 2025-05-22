class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {}

class LocationException implements Exception {
  final String message;

  LocationException(this.message);
}
