class NetworkResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;

  NetworkResponse({
    this.data,
    this.message,
    this.success = false,
    this.statusCode,
  });

  factory NetworkResponse.success({
    T? data,
    String? message,
    int? statusCode,
  }) {
    return NetworkResponse(
      data: data,
      message: message,
      success: true,
      statusCode: statusCode,
    );
  }

  factory NetworkResponse.error({
    String? message,
    int? statusCode,
  }) {
    return NetworkResponse(
      message: message,
      success: false,
      statusCode: statusCode,
    );
  }
} 