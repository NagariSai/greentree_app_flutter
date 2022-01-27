
import 'package:fit_beat/app/features/menu/instagram/instagram_post.dart';

class InstagramProfile {
  final int followers;
  final int following;
  final int numberOfPosts;
  final bool isPrivate;
  final bool isVerified;
  final String username;
  final String biography;
  final String fullname;
  final String profilePicUrl;
  final List<InstagramPost> posts;

  /* Constructor */
  InstagramProfile({
    this.followers,
    this.following,
    this.numberOfPosts,
    this.isPrivate,
    this.isVerified,
    this.username,
    this.biography,
    this.fullname,
    this.profilePicUrl,
    this.posts,
  });
}
