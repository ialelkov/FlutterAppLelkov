// исключения авторизации
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// исключения регистрации

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// общие исключения

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
