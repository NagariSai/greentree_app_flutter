import 'dart:io';

import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_expansion_tile.dart';
import 'package:fit_beat/app/common_widgets/media_widget.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:fit_beat/services/image_picker_service.dart';
import 'package:fit_beat/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_share/instagram_share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
//import 'package:screenshot/screenshot.dart';
//import 'package:social_share/social_share.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

class SocialShare extends StatefulWidget  {


  @override
  _SocialShareState createState() => _SocialShareState();
}




class _SocialShareState extends State<SocialShare> {
  String _platformVersion = 'Unknown';
  List<File> mediaPathList = List();
  bool viewVisible = false;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

//  ScreenshotController screenshotController = ScreenshotController();
  void showWidget() {
    setState(() {
      viewVisible = true;
      print("visibility::"+viewVisible.toString());
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        negativeText: "",
        positiveText: "",

      ),

      body: Container(
        child: Container(
          color: bodybgColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              MaterialButton(child: Text('Add photo or video'),
                  color:appbgColor,
                  textColor: bodybgColor,
                  onPressed: () {
                addMedia(context);

              }),
              SizedBox(
                height: 20,
              ),

             /* Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  child: Container(


                      margin: EdgeInsets.only(top: 5, bottom: 20),
                      child:MediaWidget(
                        mediaFile: File(""),
                        // onRemove: () => _.removeMedia(position),
                      )
                  )
              ),*/
             /* Visibility(

                maintainAnimation: true,
                maintainState: true,
                visible: viewVisible,
                  child: ListView.separated(
                    itemBuilder: (context, position) {
                      return MediaWidget(
                        mediaFile: mediaPathList[position],
                       // onRemove: () => _.removeMedia(position),
                      );
                    },
                    itemCount: mediaPathList.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, position) {
                      return SizedBox(
                        width: 8,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),

              ),*/

              SizedBox(
                height: 20,
              ),
                  MaterialButton(child:
              Text('Share'),
                  color:appbgColor,
                  textColor: bodybgColor,
                  onPressed: () {
                    if (mediaPathList.isNotEmpty) {

                      var imageList = <String>[];
                      for (var asset in mediaPathList) {
                         String path =asset.path;
                         imageList.add(path);
                         print("path::"+path);

                      }


                      final box = context.findRenderObject() as RenderBox;
                      Share.shareFiles(imageList,text: "GreenTree",subject: 'text to share',sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

                   //   ShareExtend.shareMultiple(imageList, "image",subject: "descriptions");
                     /* if(Utils.isFileImage(mediaPathList[0]))
                         InstagramShare.share(mediaPathList[0].path, 'image');
                      else
                        InstagramShare.share(mediaPathList[0].path, 'video');*/
                   }

                    else
                      Utils.showErrorSnackBar("Please select image or video");
                    //InstagramShare.share('hello', 'text');

                  }),




            ],
          ),
        ),


          /*child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SizedBox(
            height: 16,
          ),
     MaterialButton(child: Text('Add photo or video'), onPressed: () {
    addMedia(context);

    }),
    MaterialButton(child:
    Text('Share'),
        onPressed: () {
    InstagramShare.share(mediaPathList[0].path, 'image');
    //InstagramShare.share('hello', 'text');

    }),

          SizedBox(
            height: 16,
          ),

     ]
      ),*/





    )
    );
  }
  void addMedia(BuildContext context) async {
    try {
      PermissionService getPermission = PermissionService.gallery();
      await getPermission.getPermission(context);

      if (getPermission.granted == false) {
        print("permission false");
        //Permission is not granted
        return;
      }

     // mediaPathList.clear();

      var file = Platform.isAndroid
          ? await MediaPickerService().pickImageOrVideo()
          : await MediaPickerService().pickImage(source: ImageSource.gallery);

      if (file != null) {
        if (Utils.isFileImageOrVideo(file)) {
          print("selected path::"+file.path);
          mediaPathList.add(file);
         /* if (viewVisible)
            hideWidget();
          else*/
            showWidget();
        } else {
          Utils.showErrorSnackBar("Please select image or video");
        }
      } else {
        Utils.showErrorSnackBar("Please select image or video");
      }
    } catch (_) {
      Utils.showErrorSnackBar("exception");
    }
  }

}



