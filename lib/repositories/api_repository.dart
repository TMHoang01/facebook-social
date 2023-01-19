class ApiResponse {
  String? code;
  String? message;
  dynamic data; // Chỉnh lại thành dynamic
  Object? details;
  ApiResponse({
    this.code,
    this.message,
    this.data,
    this.details,
  });
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
      details: json['details'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    data['details'] = this.details;
    return data;
  }

  dynamic getData(String key) {
    if (data == null || data[key] == null) return null;
    return data[key];
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data, details: $details}';
  }
}
