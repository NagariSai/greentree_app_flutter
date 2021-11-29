import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FeedTransformationWidget extends StatelessWidget {
  final Feed feedData;

  const FeedTransformationWidget({Key key, this.feedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feedData.descriptions,
          maxLines: 3,
          style: TextStyle(
            color: titleBlackColor,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
            height: 243,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appNameColor)),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10,
                          ),
                          bottomLeft: Radius.circular(
                            10,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: feedData.userMedia[0].mediaUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              10,
                            ),
                            bottomRight: Radius.circular(
                              10,
                            )),
                        child: CachedNetworkImage(
                          imageUrl: feedData.userMedia[0]?.mediaUrl2 ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 32,
                    decoration: BoxDecoration(
                        color: bgTextColor.withOpacity(0.85),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        "Lost ${feedData.lostKgs.toString()} kg in ${feedData.duration} months",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
