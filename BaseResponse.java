class BaseResponse<T> {
  final bool success;
  final String message;
  final int code;
  final T? data;

  BaseResponse({
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  static BaseResponse<R> fromJson<R>(
    Map<String, dynamic> json, {
    R Function(Map<String, dynamic>)? parse,
  }) {
    final success = (json['success'] ?? false) == true;
    final message = (json['message'] ?? '') as String;
    final code = (json['code'] is int)
        ? json['code'] as int
        : int.tryParse('${json['code'] ?? -1}') ?? -1;

    R? data;
    final raw = json['data'];
    if (parse != null && raw is Map<String, dynamic>) {
      try {
        data = parse(raw);
      } catch (_) {
        /* ignore */
      }
    } else {
      data = null;
    }

    return BaseResponse<R>(
      success: success,
      message: message,
      code: code,
      data: data,
    );
  }
}