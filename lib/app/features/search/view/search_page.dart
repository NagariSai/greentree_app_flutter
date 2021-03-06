import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/normal_text_field.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/home/views/media_slidable_widget.dart';
import 'package:fit_beat/app/features/home/views/video_widget.dart';
import 'package:fit_beat/app/features/search/view/search_feed.dart';

import 'package:fit_beat/app/features/search/controller/search_controller.dart';
import 'package:fit_beat/app/routes/app_pages.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:after_layout/after_layout.dart';
import 'inview_video_widget.dart';
class SearchPage extends StatefulWidget  {


  @override
  _ItemGridViewState createState() => _ItemGridViewState();
         }




   class _ItemGridViewState extends State<SearchPage> with AfterLayoutMixin<SearchPage>{
   ScrollController scrollController = ScrollController();
   bool isInView=false;
   GlobalKey _keyRed = GlobalKey();

   @override
   void afterFirstLayout(BuildContext context) {
     //showHelloWorld();
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
   }

   @override
   void initState() {
       super.initState();


       scrollController.addListener(() {

         if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
           Get.find<SearchController>().searchData("test");
           setState(() {
           });
       //  if (scrollController.position.maxScrollExtent == scrollController.offset && Get.find<SearchController>().feedList.length % 10 == 0) {
            // Get.find<SearchController>().addItem(Get.find<SearchController>().feedList.length);
         }


       });
   }
   _afterLayout(_) {

     _getPositions();
   }
   _getPositions() {
     final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
     final positionRed = renderBoxRed.localToGlobal(Offset.zero);
     print("POSITION of Red: $positionRed ");
   }

   @override
   Widget build(BuildContext context) {

     return Scaffold(
          backgroundColor: bodybgColor,
       appBar: AppBar(
           backgroundColor: appbgColor,
           titleSpacing: 0,
           automaticallyImplyLeading: false,
           elevation: 1,
       /*    leading: IconButton(
             icon: Icon(
               Icons.chevron_left,
               size: 28,
               color: Colors.white,
             ),
             onPressed: () => Get.back(),
             color: primaryColor,
           ),*/
           title: GetBuilder<SearchController>(builder: (_) {
             return Padding(
                 padding: const EdgeInsets.only(left: 16,right: 16),
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
                     print("onChanged : "+text);

                     _.updateCloseIcon(text);
                     if (text.length > 2) {
                       _.searchData(text);
                     } else {
                       _.feedList.clear();
                       _.feedList.refresh();
                     }
                   },
                 ));
           })

       ),

       body: GetX<SearchController>(

         init: SearchController(repository: ApiRepository(apiClient: ApiClient())),

         builder: (_) => _.isLoading.value
             ? Center(
           child: CircularProgressIndicator(),
         )
             : LazyLoadScrollView(
           onEndOfPage: () => _.loadNextsearchData("test"),
         //  isLoading: _.feedLastPage,

           child: RefreshIndicator(
             key: _.indicator,
             onRefresh: _.reloadFeeds,
             child: SingleChildScrollView(
             //  controller: scrollController,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Flexible(
                     fit: FlexFit.loose,
                      child : _.feedList.length > 0
                   ? StaggeredGridView.countBuilder(
                       staggeredTileBuilder: (int index) =>
                        //   _.feedList[index].totalLikes == 0 ? StaggeredTile.count(1,1) : StaggeredTile.count(2,1),
                     _.feedList[index].totalLikes > 0 ? StaggeredTile.count(1,1) : StaggeredTile.count(1,1),
                     crossAxisCount: 3,
                     controller: scrollController,
                     itemCount:  _.feedList.length,
                     shrinkWrap: true,



           itemBuilder: (context, index) {


             if(_.feedList[index].userMedia[0].mediaType==1) {
              // return SearchFeedWidget(feedData: _.feedList[index],);
               return searchFeed(_.feedList[index],index);
             }
             else
             {
              print( "mdeia::"+_.feedList[index].userMedia[0].mediaUrl);

               /*  return InViewNotifierList(
                 isInViewPortCondition:
                     (double deltaTop, double deltaBottom, double vpHeight) {
                   return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
                 },
                 itemCount:  1,
                 builder: (BuildContext context, int index) {
                   return InViewNotifierWidget(
                     id: '$index',
                     builder: (BuildContext context, bool isInView, Widget child) {
                       return InViewNotifierWidget(
                         id: '$index',
                         builder:
                             (BuildContext context, bool isInView, Widget child) {
                           return InViewVideoWidget(
                               play: isInView,
                               url:
                               _.feedList[index].userMedia[0].mediaUrl);
                         },
                       );
                     },
                   );
                 },
               );*/
              // return MediaSlidableWidget(mediaList: _.feedList[index].userMedia);

              return InViewVideoWidget(
                  currentPage: 0,
                  totalPage: 1,
                  viewCount: 0,
                  play: isInView,
                  feedData:_.feedList[index]);
               //   feedData:_.feedList[index].userMedia[0].mediaUrl);
              return VideoWidget( url: _.feedList[index].userMedia[0].mediaUrl,
                 currentPage: 0,
                 totalPage: 1,
                 viewCount: 0,
               );
             }
             key: _keyRed;
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
               ),
             ),
           ),
         ),
       ),

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

                       ? StaggeredGridView.countBuilder(

                     staggeredTileBuilder: (int index) =>
                     _.feedList[index].totalLikes == 0 ? StaggeredTile.count(1,1) : StaggeredTile.count(2,1),
                     //_.feedList[index].totalLikes > 0 ? StaggeredTile.count(2,1) : StaggeredTile.count(1,1),
                     crossAxisCount: 3,
                     controller: scrollController,
                     itemCount:  _.feedList.length,
                     shrinkWrap: true,

                 */
/*   itemCount: Get.find<SearchController>().isLoading.value
                         ? Get.find<SearchController>().feedList.length + 10
                         : Get.find<SearchController>().feedList.length + 10,*//*


                     itemBuilder: (context, index) {

                       //print("::index:"+index.toString());
                       //print(_.feedList[index].totalLikes.toString());
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
*/

     );
   }



   Widget searchFeed(Feed feedData ,int index) {

     print("searchFeed:"+feedData.userMedia[0].mediaUrl.toString());

     return InkWell(
         onTap: () {
           Utils.selectedfeedData=feedData;
           print("searchFeed::"+index.toString());
           Get.toNamed(Routes.searchDetailsPage);


         },

         child: Container(


             padding: const EdgeInsets.only(
                 left: 16, right: 16, top: 16, bottom: 4),
             decoration: BoxDecoration(
                 border: Border.all(
                     width: 0, //
                     color: Colors.white//                 <--- border width here
                 ),
                 borderRadius: BorderRadius.circular(2),


                 image: DecorationImage(

                     image: NetworkImage(

                         feedData.userMedia[0].mediaUrl
                         ),

                     fit: BoxFit.cover

                 )
             ),
             child: _buildBody(feedData)

         )
     );

   }


   Widget _buildBody(Feed feedData) {

     return new Container(
         constraints: new BoxConstraints.expand(
           height: 20.0,
         ),
         padding: new EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
         /* decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/more.png'),
              fit: BoxFit.cover,
            ),
          ),*/

         child: new Stack(
           children: <Widget>[
             if (feedData.userMedia.length > 1)


               new Positioned(
                 right: 0.0,
                 top: 0.0,
                 child: Image.asset('assets/images/more.png'),
               ),
           ],
         )
     );

   }
   }



