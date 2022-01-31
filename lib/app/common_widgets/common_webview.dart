import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  bool isLoading = true;
  var title = '';
  var url = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybgColor,
      appBar: CustomAppBar(
        title: title,
      ),
      body: Stack(

        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(

                child: WebView(

                  initialUrl: ApiEndpoint.privacyApi,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (webViewController) {

                    print("created called");
                  },
                  onPageFinished: (finish) {
                    print("finish called");
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ),
            ],
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                  ),
                )
              : Container(

          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    title = Get.arguments[0];
    url = Get.arguments[1];
  }
}
