import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchFeedWidget extends StatelessWidget {



  final Feed feedData;
  final Function onClickLikeUnLike;
  final Function onClickBookmark;



  const SearchFeedWidget({Key key,
    @required this.feedData,
    this.onClickLikeUnLike,
    this.onClickBookmark})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
  //  print(feedData.userMedia[0].mediaType);

      return InkWell(
          onTap: () {
            if (feedData.type == 1) {


              Get.toNamed(Routes.discussion_detail_page, arguments: [
                feedData.uniqueId,
                feedData.type,
                feedData.triedCount,
                feedData.title
              ]);
            } else if (feedData.type == 2) {

              Get.toNamed(Routes.otherFeedPage, parameters: {
                "count": feedData.triedCount.toString(),
                "title": feedData.title,
                "isChallenge": "true",
                "masterPostId": feedData.uniqueId.toString()
              });
            } else if (feedData.type == 3) {
              Get.toNamed(Routes.transformation_detail_page,
                  arguments: [feedData.uniqueId, feedData.type]);
            } else if (feedData.type == 4) {
              Get.toNamed(Routes.receipe_detail_page,
                  arguments: [feedData.uniqueId, feedData.type]);
            } else if (feedData.type == 5) {
              Get.toNamed(Routes.post_update_detail_page,
                  arguments: [feedData.uniqueId, feedData.type]);
            }
          },

          child: Container(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                    image: NetworkImage(feedData.userMedia[0].mediaUrl),
                    fit: BoxFit.cover
                )
            ),
              child: _buildBody()
          )
      );

  }


  Widget _buildBody() {

  //  if(feedData.userMedia.length>1)
    return new Container(
        constraints: new BoxConstraints.expand(
          height: 200.0,
        ),
        padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[

            new Positioned(
              right: 0.0,
              top: 0.0,
              child: new Icon(Icons.double_arrow),
            ),
          ],
        )
    );
  }
}