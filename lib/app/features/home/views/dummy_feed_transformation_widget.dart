import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DummyFeedTransformationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My 60 days Transformation",
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                "https://static.boredpanda.com/blog/wp-content/uploads/2017/05/591c679228648__700-png.jpg",
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            height: 32,
            decoration: BoxDecoration(
                color: bgTextColor.withOpacity(0.85),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            width: double.infinity,
            child: Center(
              child: Text(
                "Gained 6kg in 2 months",
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
    );
  }
}
