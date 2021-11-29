class CommonResponse {
  CommonResponse({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
