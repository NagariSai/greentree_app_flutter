import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/media_url_widget.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/feed_widget.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/features/search/view/search_feed.dart';

import 'package:fit_beat/app/features/search/controller/search_controller.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchPage extends StatelessWidget {

/*
       ScrollController   _controller = new ScrollController(initialScrollOffset: 5.0)
     ..addListener(_scrollListener);*/

   //..addListener(SearchController.searchData("test"));
  final List<String> _listItem = [
    'assets/images/food1.jpg',
    'assets/images/food2.jpg',
    'assets/images/food3.jpg',
    'assets/images/food4.jpg',
    'assets/images/food5.jpg',
    'assets/images/food6.jpg',

    'assets/images/food8.jpg',
    'assets/images/food9.jpg',
    'assets/images/food8.jpg',
    'assets/images/food10.jpg',
    'assets/images/food3.jpg',
    'assets/images/food4.jpg',
    'assets/images/food5.jpg',
    'assets/images/food12.jpg',
    'assets/images/food11.jpg',
    'assets/images/food7.jpg',
  ];

/*       _scrollListener() {
   if (_controller.offset >=
   _controller.position.maxScrollExtent &&
   !_controller.position.outOfRange) {
   }
   }*/
   @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 28,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
            color: primaryColor,
          ),
         title: GetBuilder<SearchController>(builder: (_) {
            return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: NormalTextField(
                  controller: _.searchController,
                  bgColor: settingBgColor,
                  showPrefixIcon: true,
                  hintColor: descriptionColor,
                  hintText: "Search",
                  endIcon: Icons.close,
                  showIcon: _.showIcon,
                  onIconTap: () {
                    _.clearSearch();
                  },
                  onChanged: (String text) {
                    _.updateCloseIcon(text);
                    if (text.length > 2) {
                      print("if search");
                      _.searchData(text);
                    } else {
                      print("else search");
                      _.feedList.clear();
                      _.feedList.refresh();
                    }
                  },
                ));
          })
        /*title:
           Padding(
              padding: const EdgeInsets.only(right: 16),
              child: NormalTextField(



                bgColor: Colors.white60,



                showPrefixIcon: true,


                hintColor: Colors.white,
                hintText: "Search",
                endIcon: Icons.close,
                onIconTap: () {
                },
                onChanged: (String text) {

                  if (text.length > 2) {
                    print("if search");

                  } else {
                    print("else search");

                  }
                },
              ))
        ),*/
      ),


      body: GetX<SearchController>(init: SearchController(repository: ApiRepository(apiClient: ApiClient())),

          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: _.isLoading.value
                      ? Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()),
                  )

                      : _.feedList.length > 0

                  ? StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (int index) =>
                     _.feedList[index].totalLikes > 0 ? StaggeredTile.count(2,1) : StaggeredTile.count(1,1),
                  crossAxisCount: 3,
                  //controller: _controller,
                  itemCount:  _.feedList.length,
                    itemBuilder: (context, index) {
                      print(_.feedList[index].totalLikes.toString()+":::"+index.toString());
                      if(_.feedList[index].userMedia[0].mediaType==1) {
                        return SearchFeedWidget(
                          feedData: _.feedList[index],
                        );
                      }
                      else
                      {
                        return VideoWidget( url: _.feedList[index].userMedia[0].mediaUrl,
                          currentPage: 0,
                          totalPage: 1,
                          viewCount: 0,
                        );
                      }
                    },


                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
            )
                   : Container(
                    height: Get.height * 0.4,
                    child: Center(
                      child: CustomText(
                        text: "No data found",
                      ),
                    ),
                  ),
            ),

              ],
            );
          }),

/*
      body: GetX<SearchController>(init: SearchController(repository: ApiRepository(apiClient: ApiClient())),

          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: _.isLoading.value
                      ? Center(
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                        )

                      : _.feedList.length > 0
                       ?  GridView.builder(
                        itemCount: _.feedList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),

                          itemBuilder: (context, index) {
                          if(_.feedList[index].userMedia[0].mediaType==1) {
                            return SearchFeedWidget(
                              feedData: _.feedList[index],
                            );
                          }
                          else
                            {
                              return MediaUrlWidget(
                                mediaUrl: _.feedList[index].userMedia[0].mediaUrl,
                              );
                            }
                          },
                        )



                          : Container(
                              height: Get.height * 0.4,
                              child: Center(
                                child: CustomText(
                                  text: "No data found",
                                ),
                              ),
                            ),
                )
              ],
            );
          }),
*/


    /*  body: SafeArea(

        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: _listItem.map((item) => Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                              //image:NetworkImage(item),
                                image: AssetImage(item),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Transform.translate(
                          offset: Offset(50, -50),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                           *//* decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),*//*
                           // child: Icon(Icons.bookmark_border, size: 15,),
                          ),
                        ),
                      ),
                    )).toList(),
                  )
              )
            ],
          ),
        ),
      ),*/

    );
  }
}
