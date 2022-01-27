import 'dart:convert';
import 'package:fit_beat/app/features/menu/instagram/instagram_post.dart';
import 'package:fit_beat/app/features/menu/instagram/instagram_profile.dart';
import 'package:http/http.dart' as http;


class InstagramUser {
  Future<InstagramProfile> getInstagramProfile(String username) async {
    int _followers, _following, _numberOfPosts;
    bool _isPrivate, _isVerified;
    String _username, _biography, _fullname, _profilePicUrl;
    List<InstagramPost> _posts;
    InstagramProfile _instagramProfile;

    /* It was tricky to get profile data of an Instagram user by performing a simple get request. In 2020 is was possible get the json data with url of the format:
    
    "https://www.instagram.com/" + username + "/?__a=1"

    Since 2021 you have to add "/channel" to make it work. The resulting url is:

    "https://www.instagram.com/" + username "/channel/?__a=1"

    But even this is not working as stable as expected. Requesting the json from MacBook with Firefox was no problem, but performing the get request inside Flutter led to complications which occurred sporadically.

    The temporary solution: With network analysis inside Firefox on MacBook, it was possible to see the http get request header from the request. The header was copied and is now used in the flutter application.

    In the header of the response are mentioned different expiration dates:
    30.10.2021, 21.01.2022 and 22.10.2022. I dont know how long the cookie in the header is valid, so this is not a permanent solution. 
    
    Sources for further information:
    - https://stackoverflow.com/questions/49265339/instagram-a-1-url-not-working-anymore-problems-with-graphql-query-to-get-da/49341049#49341049
    - https://stackoverflow.com/questions/48673900/get-json-from-website-instagram 
    
    Also the package flutter_insta 1.0.0 had the some problem, as mentioned here: https://github.com/viralvaghela/flutter_insta/issues/13 */

    String url = "https://www.instagram.com/" + username.trim() + "/?__a=1";
    Map<String, String> _headers = {
      "User-Agent":
          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0) Gecko/20100101 Firefox/93.0",
      "Cookie":
          'csrftoken=KwugFcdUbqWmIw5gafx4XceFqG7lL0iy; mid=YXGdmQAEAAGZ8KAkPxbouItPlKZW;ig_did=B1A4CD44-2BC0-46D6-9EA8-183539CC48D0;rur="ASH\0541626909116\0541666509625:01f790737601ddb28113116c4f532ec31a70ba9eed81c465a824b04048f33062c5ad07d8"; ds_user_id=1626909116; sessionid=1626909116%3ASJKuakuknKMwgK%3A29; shbid="13780\0541626909116\0541666509141:01f7550222f10cb6d3fe921d0365f3c16d488e2b5fa5d8df394a2e22bf77b6e58c651ba9"; shbts="1634973141\0541626909116\0541666509141:01f76d9c1887499197411336f50b5e86b6bd269a7d945cef01282c80c8f395ac42412c0f"'
    };

    try {
      /* Get data from instagram and decode json */
      var _response =
          await http.get(Uri.parse(Uri.encodeFull(url)));
      final _extractedData =
          json.decode(_response.body) as Map<String, dynamic>;

      if (_extractedData.isNotEmpty) {
        var _graphql = _extractedData['graphql'];
        var _user = _graphql['user'];

        /* Get profile information */
        _followers = _user['edge_followed_by']['count'];
        _following = _user['edge_follow']['count'];
        _numberOfPosts = _user['edge_owner_to_timeline_media']['count'];
        _isPrivate = _user['is_private'];
        _isVerified = _user['is_verified'];
        _username = _user['username'];
        _biography = _user['biography'];
        _fullname = _user['full_name'];
        _profilePicUrl = _user['profile_pic_url_hd'];
        _posts = _getInstagramPosts(_user);

        /* Save profile information */
        _instagramProfile = InstagramProfile(
          followers: _followers,
          following: _following,
          numberOfPosts: _numberOfPosts,
          isPrivate: _isPrivate,
          isVerified: _isVerified,
          username: _username,
          biography: _biography,
          fullname: _fullname,
          profilePicUrl: _profilePicUrl,
          posts: _posts,
        );
      }
    } catch (error) {
      throw error;
    }

    return _instagramProfile;
  }

  List<InstagramPost> _getInstagramPosts(Map<String, dynamic> user) {
    List<InstagramPost> _instagramPosts = List.empty(growable: true);

    String _caption;
    String _location;
    String _url;
    int _numberOfComments;
    int _numberOfLikes;
    Map<String, dynamic> _post;

    int _numberOfVisiblePosts =
        (user['edge_owner_to_timeline_media']['edges'] as List<dynamic>).length;

    for (var i = 0; i < _numberOfVisiblePosts; i++) {
      /* Get post number i */
      _post = user['edge_owner_to_timeline_media']['edges'][i]['node'];

      /* Get url */
      _url = _post['display_url'];

      /* Get number of likes and comments */
      _numberOfComments = _post['edge_media_to_comment']['count'];
      _numberOfLikes = _post['edge_liked_by']['count'];

      /* Get caption */
      bool _isCaptionNotEmpty =
          (_post['edge_media_to_caption']['edges'] as List<dynamic>).isNotEmpty;

      if (_isCaptionNotEmpty) {
        _caption = _post['edge_media_to_caption']['edges'][0]['node']['text'];
      } else {
        _caption = "";
      }

      /* Get location */
      if (_post['location'] != null) {
        _location = _post['location']['name'];
      } else {
        _location = "";
      }

      /* Add instagram post to list */
      _instagramPosts.add(InstagramPost(
        caption: _caption,
        location: _location,
        url: _url,
        numberOfComments: _numberOfComments,
        numberOfLikes: _numberOfLikes,
      ));
    }

    return _instagramPosts;
  }
}
