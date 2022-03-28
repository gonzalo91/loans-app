class HttpError extends Error {
  final int code;
  final String message;

  HttpError(this.code, this.message);
}

class TooManyAttemptsError extends HttpError {
  TooManyAttemptsError()
      : super(429, 'Demasiados intentos, intente de nuevo mas tarde');
}

class ValidationError extends HttpError {
  Map<String, dynamic> failedValidations;

  ValidationError(
    this.failedValidations,
  ) : super(422, 'Los siguientes campos son requeridos');
}
