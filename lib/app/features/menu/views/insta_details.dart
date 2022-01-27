import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/constant/dimens.dart';
import 'package:fit_beat/app/features/menu/instagram/instagram_profile.dart';
import 'package:fit_beat/app/features/menu/instagram/instagram_user.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InstaDetailsScreen extends StatefulWidget {
  @override
  _InstaDetailsScreenState createState() => _InstaDetailsScreenState();
}

class _InstaDetailsScreenState extends State<InstaDetailsScreen>
    with SingleTickerProviderStateMixin {
  InstagramProfile flutterInsta =
      InstagramProfile(); // create instance of FlutterInsta class
  TextEditingController usernameController = TextEditingController();
  TextEditingController reelController = TextEditingController();
  TabController tabController;

  int followers = 0;
  int following = 0;

  int nofposts = 0;

  String username = "", bio = "", website = "", profileimage = "";
  bool pressed = false;
  bool downloading = false;
  bool isVerified = false;
  bool isPrivate = false;

  @override
  void initState() {
    super.initState();
    printDetails(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodybgColor,
        appBar: CustomAppBar(
          title: "Instagram Profile Details",
        ),
        body: homePage());
  }

//get data from api
  Future printDetails(String username) async {
    flutterInsta = await InstagramUser().getInstagramProfile(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.profileimage = flutterInsta.profilePicUrl;
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.bio = flutterInsta.biography;
      this.nofposts = flutterInsta.numberOfPosts;
      this.isVerified = flutterInsta.isVerified;
      this.isPrivate = flutterInsta.isPrivate;
      pressed = true;

      // this.bio = flutterInsta.biography; // Bio
      // Profile picture URL
    });
  }

  Widget homePage() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
              controller: usernameController,
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              child: Text("Get Details"),
              onPressed: () async {
                printDetails(usernameController.text);

                setState(() {
                  pressed = false;
                });

                //get Data
              },
            ),


            pressed
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                "$profileimage",
                                /* Set width of picture to 30 % of screen width (consider padding!) */
                                width: (MediaQuery.of(context).size.width - 2 * 15) * 0.3,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$username",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                getFormattedNumber(nofposts),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Posts')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                getFormattedNumber(followers),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Followers')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                getFormattedNumber(following),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Following')
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Text('Public: '),
                                          (isPrivate == false)
                                              ? Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  color: Colors.green,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text('Verified: '),
                                          (isVerified)
                                              ? Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  color: Colors.green,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(bio),
                        ),
                        SizedBox(height: 10),
                        if (isPrivate)
                          Center(
                            child: Text(
                                'This user has a private account. No posts are visible.'),
                          ),
                        /*   if (flutterInsta.isPrivate == false)
            ListView.builder(
                itemCount: (flutterInsta.numberOfPosts < 12)
                    ? flutterInsta.numberOfPosts
                    : 12,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return InstagramPostDisplay(
                    instagramPost: flutterInsta.posts[i],
                  );
                }),*/
                      ],
                    ),
                  )
                : Container(),

            /*? SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "$profileimage",
                            width: 120,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          "$username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "$followers\nFollowers",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "$following\nFollowing",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          "$bio",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          "$website",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
                : Container(),*/
          ],
        ),
      ),
    );
  }

  String getFormattedNumber(int inputNumber) {
    String result;

    if (inputNumber >= 1000000) {
      result = (inputNumber / 1000000).toStringAsFixed(1) + "M";
    } else if (inputNumber >= 10000) {
      result = (inputNumber / 1000).toStringAsFixed(1) + "K";
    } else {
      result = inputNumber.toString();
    }

    return result;
  }
}
