import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/vendor.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/screens/posts/post_details.dart';
import 'package:event_planning/screens/vendor/profile/posts_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../type_post_page.dart';

class VendorOffersView extends StatefulWidget {
  final bool isHall;
  final VendorProfile vendorProfile;
  final bool isUser;
  const VendorOffersView({Key? key,required this.isHall,required this.vendorProfile,required this.isUser}) : super(key: key);

  @override
  _VendorOffersViewState createState() => _VendorOffersViewState(isHall: isHall,vendorProfile: vendorProfile,isUser:isUser);
}

class _VendorOffersViewState extends State<VendorOffersView> {
  final bool isHall;
  final bool isUser;
  final VendorProfile vendorProfile;
  _VendorOffersViewState({required this.isHall,required this.vendorProfile,required  this.isUser});
  List<String> images = [];
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:!isUser,
          child: SizedBox(
            height: 20.h,
          ),
        ),
        Visibility(
          visible: !isUser,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: BigButton(
              title: 'Post Offers',
              color: Colors.grey,
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: TypePostPage(isHall: isHall,type: 'offer',)));
              },
              Textcolor: Colors.white,
            ),
          ),
        ),
        vendorProfile.offers.isEmpty
            ? Center(
          child: Text(
            'No offers yet',
            style: TextStyle(fontSize: 20.h, color: Colors.grey),
          ),
        )
            : Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: vendorProfile.offers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Post post = vendorProfile.offers[index];
              return Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 30.h, end: 30.h, top: 15.h),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 400.h,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadiusDirectional.circular(10.h),
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
                              // PageView.builder(
                              //   itemCount: 1,
                              //   onPageChanged: (page) {
                              //     setState(() {
                              //       activePage = page;
                              //     });
                              //   },
                              //   itemBuilder: (BuildContext context, int imagePosition){
                              //     return
                              //       Container(
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.only(topLeft: Radius.circular(10.h),topRight: Radius.circular(10.h)),
                              //           image: DecorationImage(
                              //         image: NetworkImage('${apiUrl}profiles/${post.imagePost}'),
                              //         fit: BoxFit.fill
                              //           ),
                              //         ),
                              //       );
                              //     },
                              // ),
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
                                  image: const AssetImage(
                                      'assets/icons/offer.png'),
                                ),
                              ),
                              Align(
                                alignment:
                                AlignmentDirectional.bottomCenter,
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: indicators(
                                        images.length, activePage)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 10.h, start: 20.h),
                          child: SizedBox(
                            height: 30.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment:
                                    AlignmentDirectional.centerStart,
                                    child: Container(
                                      width: 32.h,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xffE6E6E6),
                                        border: Border.all(
                                            color:
                                            const Color(0xff707070)),
                                      ),
                                      child: Center(
                                        child: vendorProfile
                                            .profileThumbnail ==
                                            ' '
                                            ? SvgPicture.asset(
                                          'assets/svg/user.svg',
                                          semanticsLabel: 'user',
                                          width: 20.h,
                                          height: 20.h,
                                        )
                                            : ClipOval(
                                          child: Image.network(
                                              apiUrl +"storage/UserPhoto/VendorProfile/"+
                                                  vendorProfile
                                                      .profileThumbnail,
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vendorProfile.name,
                                        style: TextStyle(
                                          fontSize: 10.r,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        vendorProfile.type,
                                        style: TextStyle(
                                            fontSize: 10.r,
                                            color: Colors.grey),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.r),
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
                              onTap: () {
                                post.vendor = Vendor(name: vendorProfile.name, profileThumbnail: vendorProfile.profileThumbnail, type: vendorProfile.type);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostDetails(post: post,)),
                                );
                              },
                              Textcolor: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
