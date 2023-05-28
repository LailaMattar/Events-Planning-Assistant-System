import 'package:event_planning/blocs/savePostBloc.dart';
import 'package:event_planning/blocs/unsavePostBloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/posts/booking.dart';
import 'package:event_planning/screens/posts/reviews.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

class PostDetails extends StatefulWidget {
  final Post post;
  const PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState(post: this.post);
}

class _PostDetailsState extends State<PostDetails> {
  final Post post;
  late int saved;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late SavePostBloc _bloc;

  // late UnSavePostBloc _bloc2;
  //
  // bool updateBloc2 = false;
  // bool visibleStream2 = false;
  // bool showError2 = false;

  _PostDetailsState({required this.post});

  List<String> images = ["assets/images/test1.jpg", "assets/images/test2.jpg"];

  @override
  void initState() {
    debugPrint("test vendor name2 ${post.vendor.name}");
    _bloc = SavePostBloc();
    //   _bloc2 = UnSavePostBloc();
    saved = post.save;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Post details")),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Container(
                // height: 1300,
                child: Stack(clipBehavior: Clip.none, children: [
                  Column(children: [
                    Stack(children: [
                      Container(
                        height: 320,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${apiUrl}storage/profiles/${post.imagePost}'),
                              fit: BoxFit.fill),
                        ),
                        // child: CarouselSlider
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 28, 20, 25),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: (saved == 0)
                              ? GestureDetector(
                                  onTap: () {
                                    print('not saves');

                                    visibleStream = true;
                                    updateBloc = true;
                                    showError = true;
                                    setState(() {
                                      SavePost post2 = SavePost(post.id);
                                      _bloc.savePost(post2);
                                    });
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: pink,
                                    size: 40,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    // visibleStream2 = true;
                                    // updateBloc2 = true;
                                    // showError2 = true;
                                    // setState(() {
                                    //   SavePost post3 = SavePost(post.id);
                                    //   _bloc2.unsavePost(post3);
                                    // });
                                    // print('saved');
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: pink,
                                    size: 40,
                                  ),
                                ),
                        ),
                      ),
                      Visibility(
                        visible: visibleStream,
                        child: StreamBuilder<ApiResponse<SavePost>>(
                          stream: _bloc.theStream,
                          builder: (context, snapshot) {
                            debugPrint('inside stream builder');
                            // debugPrint('status code: ${snapshot.data!.status}');
                            if (!updateBloc) {
                              return Container();
                            }
                            if (snapshot.hasError) {
                              debugPrint('errror');
                            } else if (snapshot.hasData) {
                              switch (snapshot.data!.status) {
                                case Status.LOADING:
                                  debugPrint('loading save post');
                                  return Center(child: spinkitMain);
                                case Status.COMPLETED:
                                  debugPrint('complete save post');
                                  if ('${snapshot.data!.data}' != 'null') {
                                    updateBloc = false;
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      var snackBar = const SnackBar(
                                          content: Text('Post saved'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                    saved = 1;
                                  } else {
                                    updateBloc = true;
                                    return Container();
                                  }
                                  break;
                                case Status.ERROR:
                                  WidgetsBinding.instance!
                                      .addPostFrameCallback((_) {
                                    updateBloc = true;
                                    debugPrint('blah');
                                    if (showError) {
                                      var snackBar = const SnackBar(
                                          content: Text('error'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      // showToastSNACKBAR(
                                      //     json.decode(snapshot.data!.message)['message'], Colors.red);
                                    }
                                    showError = false;
                                  });
                                  return Container();
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                    ]),
                    // Visibility(
                    //   visible: visibleStream2,
                    //   child: StreamBuilder<ApiResponse<SavePost>>(
                    //     stream: _bloc.theStream,
                    //     builder: (context, snapshot) {
                    //       debugPrint('inside stream builder');
                    //       // debugPrint('status code: ${snapshot.data!.status}');
                    //       if (!updateBloc2) {
                    //         return Container();
                    //       }
                    //       if (snapshot.hasError) {
                    //         debugPrint('errror');
                    //       } else if (snapshot.hasData) {
                    //         switch (snapshot.data!.status) {
                    //           case Status.LOADING:
                    //             debugPrint('loading unsave post');
                    //             return Center(child: spinkitMain);
                    //           case Status.COMPLETED:
                    //             debugPrint('complete unsave post');
                    //             if ('${snapshot.data!.data}' != 'null') {
                    //               updateBloc2 = false;
                    //               WidgetsBinding.instance!
                    //                   .addPostFrameCallback((_) {
                    //                 var snackBar = const SnackBar(
                    //                     content: Text('Post unsaved'));
                    //                 ScaffoldMessenger.of(context)
                    //                     .showSnackBar(snackBar);
                    //               });
                    //               saved = false;
                    //             } else {
                    //               updateBloc2 = true;
                    //               return Container();
                    //             }
                    //             break;
                    //           case Status.ERROR:
                    //             WidgetsBinding.instance!
                    //                 .addPostFrameCallback((_) {
                    //               updateBloc2 = true;
                    //               debugPrint('blah');
                    //               if (showError2) {
                    //                 var snackBar =
                    //                     const SnackBar(content: Text('error'));
                    //                 ScaffoldMessenger.of(context)
                    //                     .showSnackBar(snackBar);
                    //                 // showToastSNACKBAR(
                    //                 //     json.decode(snapshot.data!.message)['message'], Colors.red);
                    //               }
                    //               showError2 = false;
                    //             });
                    //             return Container();
                    //         }
                    //       }
                    //       return Container();
                    //     },
                    //   ),
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(35, 5, 35, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(35, 5, 35, 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: post.vendor.profileThumbnail == ' '
                                          ? const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/svg/user.svg'),
                                              radius: 30,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(apiUrl +
                                                  "storage/UserPhoto/VendorProfile/" +
                                                  post.vendor.profileThumbnail),
                                              radius: 30,
                                            ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            post.vendor.name,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                child: const DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey)),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  child: Text(
                                    post.title,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              // ReadMoreText(
                              //   "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                              //       "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                              //       "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                              //       "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                              //       "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                              //       "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                              //       "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                              //       "8 Description that is too long in text format(Here Data is coming from API)" +
                              //       "9 Description that is too long in text format(Here Data is coming from API)" +
                              //       "10 Description that is too long in text format(Here Data is coming from API)",
                              //   colorClickableText: Colors.black,
                              //   trimMode: TrimMode.Line,
                              //   trimLines: 10,
                              //   style: const TextStyle(
                              //       color: Colors.grey, fontSize: 14),
                              // )
                              Text(
                                post.description,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(5, 12, 0, 20),
                                  child: Text(
                                    'Price : ${post.price} SP',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 12),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star_border,
                                        color: pink,
                                        size: 20,
                                      ),
                                      Text(
                                        ' Reviews',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: pink,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                              //   child: BigButton(
                              //       title: 'Book now',
                              //       color: pink,
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             SlideRightRoute(
                              //                 page: BookService(
                              //                     new reservationData(
                              //                         vendorName: "vendorName",
                              //                         date: "date",
                              //                         status: " status",
                              //                         vendorImage:
                              //                             "vendorImage"),
                              //                     'book')));
                              //       },
                              //       Textcolor: Colors.white),
                              // ),
                            ]),
                      ),
                    ),
                  ]),
                  Positioned(
                    top: 290,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(35, 5, 35, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: post.vendor.profileThumbnail == ' '
                                          ? const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/svg/user.svg'),
                                              radius: 30,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(apiUrl +
                                                  "storage/UserPhoto/VendorProfile/" +
                                                  post.vendor.profileThumbnail),
                                              radius: 30,
                                            ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            post.vendor.name,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                child: const DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey)),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  child: Text(
                                    post.title,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                post.description,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )
                              // ReadMoreText(
                              //   "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                              //       "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                              //       "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                              //       "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                              //       "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                              //       "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                              //       "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                              //       "8 Description that is too long in text format(Here Data is coming from API)" +
                              //       "9 Description that is too long in text format(Here Data is coming from API)" +
                              //       "10 Description that is too long in text format(Here Data is coming from API)",
                              //   colorClickableText: Colors.black,
                              //   trimMode: TrimMode.Line,
                              //   trimLines: 10,
                              //   style: const TextStyle(
                              //       color: Colors.grey, fontSize: 14),
                              // ),
                              ,
                              Padding(
                                  padding: EdgeInsets.fromLTRB(5, 12, 0, 5),
                                  child: Text(
                                    'Price : ${post.price}SP',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 12),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star_border,
                                        color: pink,
                                        size: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print('ff ${post.rating.length}');
                                          Navigator.push(
                                              context,
                                              SlideRightRoute(
                                                  page: ReviewPage(
                                                      post.rating, post.id)));
                                        },
                                        child: Text(
                                          ' Reviews',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: pink,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                child: BigButton(
                                    title: 'Book now',
                                    color: pink,
                                    onTap: () async {
                                      String username =
                                          await getUserNameFromSharedPreferences(
                                              'UserName');
                                      String eventdata =
                                          await getEventDateFromSharedPreferences(
                                              'EventDate');
                                      int eventid =
                                          await getEventIdFromSharedPreferencesint(
                                              'EventId');

                                      DateTime t = DateTime.utc(0, 1, 1);
                                      Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: BookService(
                                            dateTime: t,
                                            Data1: Book(
                                              fullname: username,
                                              event_date: eventdata,
                                              description: '',
                                              event_id: eventid,
                                            ),
                                            from1: 'book',
                                            post1: post,
                                            copoun1: 0,
                                            vendorId: post.vendorId,
                                            totalPrice: 0.0,
                                          )));
                                    },
                                    Textcolor: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                  )
                ]),
              ),
            ])),
      ),
    );
  }
}
