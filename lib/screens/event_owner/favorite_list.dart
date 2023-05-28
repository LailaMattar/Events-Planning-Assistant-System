import 'package:event_planning/blocs/favoriteListBloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/posts/post_details.dart';
import 'package:event_planning/screens/vendor/profile/posts_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../error_page.dart';
import '../loading_page.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  late FavoriteListBloc _theBloc;
  late Favorites favorites;

  @override
  void initState() {
    _theBloc = FavoriteListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites list'),
      ),
      body: StreamBuilder<ApiResponse<Favorites>>(
          stream: _theBloc.theStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('error');
            } else if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  debugPrint('loading FavoriteList');
                  return const LoadingPage();
                case Status.COMPLETED:
                  debugPrint('complete FavoriteList');
                  return CompletePage(
                    snapshot.data!.data,
                  );
                case Status.ERROR:
                  debugPrint('error FavoriteList');
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(
                    onRetryPressed: () => _theBloc.getFavorite(),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getFavorite();
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  Favorites favoriteList;
  CompletePage(this.favoriteList);

  @override
  _CompletePageState createState() => _CompletePageState(this.favoriteList);
}

class _CompletePageState extends State<CompletePage> {
  late Favorites favorites;

  _CompletePageState(this.favorites);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext, index) {
        return Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
            child: PostCard(favorites.favorites[index]));
      },
      itemCount: favorites.favorites.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
    );
  }
}

class PostCard extends StatefulWidget {
  Post post;

  PostCard(this.post);

  @override
  _PostCardState createState() => _PostCardState(post);
}

class _PostCardState extends State<PostCard> {
  int activePage = 0;
  late String imageLocalUrl = 'http://10.0.2.2:8000';
  late String imageWifiUrl = 'http://192.168.1.152:8000';
  late String imageUrl = imageWifiUrl;
  Post post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 30.0, end: 30.0, top: 15.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: 430.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10.h),
          ),
          child: Column(
            children: [
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.h),
                      topRight: Radius.circular(10.h)),
                  // image: DecorationImage(
                  //     image: NetworkImage('${apiUrl}profiles/${post.imagePost}'),
                  //     fit: BoxFit.fill
                  // ),
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: 1,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (BuildContext context, int imagePosition) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.h),
                                topRight: Radius.circular(10.h)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${apiUrl}profiles/${post.imagePost}'),
                                fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.h),
                            topRight: Radius.circular(10.h)),
                        image: DecorationImage(
                            image: NetworkImage(
                                '${apiUrl}storage/profiles/${post.imagePost}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Image(
                        width: 25.h,
                        height: 25.h,
                        image: const AssetImage('assets/icons/offer.png'),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: indicators(1, activePage)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.h),
                child: SizedBox(
                  height: 30.h,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            width: 32.h,
                            height: 32.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffE6E6E6),
                              border:
                                  Border.all(color: const Color(0xff707070)),
                            ),
                            child: Center(
                              child: post.vendor.profileThumbnail == ' '
                                  ? SvgPicture.asset(
                                      'assets/svg/user.svg',
                                      semanticsLabel: 'user',
                                      width: 20.h,
                                      height: 20.h,
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                          apiUrl +
                                              "storage/UserPhoto/VendorProfile/" +
                                              post.vendor.profileThumbnail,
                                          width: 32.h,
                                          height: 32.h,
                                          fit: BoxFit.fill),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.vendor.name,
                              style: TextStyle(
                                fontSize: 13.r,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              post.vendor.type,
                              style:
                                  TextStyle(fontSize: 10.r, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ReadMoreText(
                    post.description,
                    colorClickableText: Colors.grey,
                    trimMode: TrimMode.Line,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '${post.price} s.p',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.r),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: BigButton(
                  title: 'show more',
                  color: pink,
                  Textcolor: Colors.white,
                  onTap: () {
                    debugPrint("test name vendor: ${post.vendor.name}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostDetails(
                                post: post,
                              )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _PostCardState(this.post);
}
