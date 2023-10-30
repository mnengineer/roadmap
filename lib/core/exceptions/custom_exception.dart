// カスタムの認証エラー
class AuthException implements Exception {
  AuthException(this.message);
  final String? message;
}

// サーバーエラー
class ServerException implements Exception {
  ServerException(this.message);
  final String message;
}

// ネットワークエラー
class NetworkException implements Exception {
  NetworkException(this.message);
  final String message;
}

// その他のカスタムエラー
class CustomException implements Exception {
  CustomException(this.message);
  final String message;
}
