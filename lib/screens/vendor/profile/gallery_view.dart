import 'dart:convert';
import 'dart:io';

import 'package:event_planning/blocs/upload_gallery_bloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/gallery.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends StatefulWidget {
  final VendorProfile vendorProfile;
  final bool isUser;
  const GalleryView({Key? key,required this.vendorProfile,required this.isUser}) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState(vendorProfile: this.vendorProfile,isUser : isUser);
}

class _GalleryViewState extends State<GalleryView> {
  final VendorProfile vendorProfile;
  final bool isUser;
  _GalleryViewState({required this.vendorProfile,required this.isUser});
  List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();
  late UploadGalleryBloc _bloc ;
  late Gallery gallery;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;

  Future<String> selectImages() async {
    final List<File> tt = [];
    print("Image List Length:" + imageFileList!.length.toString());
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    for(int i = 0 ; i < imageFileList!.length ; i ++){
      tt.add(File(imageFileList![i].path));
    }
    gallery = Gallery(imageFileList: imageFileList!);
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){});
    return " ";
  }


  @override
  void initState() {
    _bloc = UploadGalleryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(visible:!isUser,child: SizedBox(height: 20.h,)),
        Visibility(
          visible: !isUser,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: BigButton(title: 'Upload Image',
                color: Colors.grey,Textcolor:Colors.white,onTap: ()async{
              await selectImages();
              visibleStream = true;
              updateBloc = true;
              showError = true;
              setState(() {});
              debugPrint("testggggggg");
              if(state == 9){
                _bloc.uploadToGallery(gallery);
              }
              if(state == 10){
                _bloc.uploadToGalleryHall(gallery);
              }

                }),
          ),
        ),
        Visibility(
          visible: visibleStream,
          child: StreamBuilder<ApiResponse<Gallery>>(
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
                    debugPrint('loading login');
                    return Center(child: spinkitMain);
                  case Status.COMPLETED:
                    debugPrint('complete upload');
                    if ('${snapshot.data!.data}' != 'null') {
                      WidgetsBinding.instance!
                          .addPostFrameCallback((_) {
                        updateBloc = false;
                        if(state == 9) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) =>
                                  VendorProfilePage(
                                    isHall: false, isUser: false, id: 0,)), (
                              Route<dynamic> route) => false);
                        }
                        if(state == 10){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              VendorProfilePage(isHall: true, isUser: false, id: 0,)), (Route<dynamic> route) => false);
                        }
                      });

                    } else {
                      updateBloc = true;
                      return Container();
                    }
                    break;
                  case Status.ERROR:
                    WidgetsBinding.instance!
                        .addPostFrameCallback((_) {
                      updateBloc = false;
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          VendorProfilePage(isHall: false, isUser: false, id: 0,)), (Route<dynamic> route) => false);
                    });
                    // WidgetsBinding.instance!
                    //     .addPostFrameCallback((_) {
                    //   updateBloc = true;
                    //   debugPrint('blah');
                    //   if (showError) {
                    //     // String error = json.decode(snapshot.data!.message)['message'] ;
                    //     String error = "uploaded failed";
                    //     var snackBar =
                    //     SnackBar(content: Text(error));
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(snackBar);
                    //     // showToastSNACKBAR(
                    //     //     json.decode(snapshot.data!.message)['message'], Colors.red);
                    //   }
                    //   showError = false;
                    // });
                    return Container();
                }
              }
              return Container();
            },
          ),
        ),
        SizedBox(height: 15.h,),
        Expanded(
          child:vendorProfile.images.isEmpty ?Center(
            child: Text(
              'No images yet',
              style: TextStyle(fontSize: 20.h, color: Colors.grey),
            ),
          ) : GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            children: vendorProfile.images.map((e) =>
                Container(
                  // height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(
                            '${apiUrl}storage/profiles/${e.imagePath}'),
                        fit: BoxFit.fill),
                  ),
                )
            ).toList(),
          )
        ),
      ],
    );
  }
}
