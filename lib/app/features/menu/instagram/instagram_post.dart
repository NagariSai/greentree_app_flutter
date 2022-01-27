import 'package:flutter/foundation.dart';

class InstagramPost {
  final String caption;
  final String location;
  final String url;
  final int numberOfComments;
  final int numberOfLikes;

  /* Constructor */
  InstagramPost({
    @required this.caption,
    @required this.location,
    @required this.url,
    @required this.numberOfComments,
    @required this.numberOfLikes,
  });
}
