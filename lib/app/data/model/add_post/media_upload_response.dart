// To parse this JSON data, do
//
//     final mediaUploadResponse = mediaUploadResponseFromJson(jsonString);

import 'dart:convert';

MediaUploadResponse mediaUploadResponseFromJson(String str) =>
    MediaUploadResponse.fromJson(json.decode(str));

String mediaUploadResponseToJson(MediaUploadResponse data) =>
    json.encode(data.toJson());

class MediaUploadResponse {
  MediaUploadResponse({
    this.status,
    this.message,
    this.url,
  });

  bool status;
  String message;
  List<MediaUrl> url;

  factory MediaUploadResponse.fromJson(Map<String, dynamic> json) =>
      MediaUploadResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        url: json["url"] == null
            ? null
            : List<MediaUrl>.from(json["url"].map((x) => MediaUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "url":
            url == null ? null : List<dynamic>.from(url.map((x) => x.toJson())),
      };
}

class MediaUrl {
  MediaUrl({
    this.mediaType,
    this.mediaUrl,
    this.userMediaId,
  });

  int mediaType;
  int userMediaId;
  String mediaUrl;

  factory MediaUrl.fromJson(Map<String, dynamic> json) => MediaUrl(
        mediaType: json["media_type"] == null ? null : json["media_type"],
        mediaUrl: json["media_url"] == null ? null : json["media_url"],
        userMediaId: json["user_media_id"] == null ? 0 : json["user_media_id"],
      );

  Map<String, dynamic> toJson() => {
        "media_type": mediaType == null ? null : mediaType,
        "media_url": mediaUrl == null ? null : mediaUrl,
        "user_media_id": userMediaId == null ? null : userMediaId,
      };
}

class VideoUrl {
  VideoUrl({
    this.videoUrl,
  });

  String videoUrl;

  factory VideoUrl.fromJson(Map<String, dynamic> json) => VideoUrl(
        videoUrl: json["video_url"] == null ? null : json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "video_url": videoUrl == null ? null : videoUrl,
      };
}
