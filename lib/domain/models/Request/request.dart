class PendingRequest {
  final String url;
  final String method;
  final Map<String, String>? headers;
  final String? body;

  PendingRequest({
    required this.url,
    required this.method,
    this.headers,
    this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'method': method,
      'headers': headers,
      'body': body,
    };
  }

  static PendingRequest fromJson(Map<String, dynamic> json) {
    return PendingRequest(
      url: json['url'],
      method: json['method'],
      headers: json['headers']?.cast<String, String>(),
      body: json['body'],
    );
  }
}