import 'dart:ui';

import 'package:event_planning/blocs/rateSerBloc.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/rating.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BlurryDialogReview extends StatefulWidget {
  BlurryDialogReview(this.title, this.content, this.continueCallBack, postid);

  String title;
  late int postid;
  String content;
  VoidCallback continueCallBack;

  @override
  _BlurryDialogReviewState createState() => _BlurryDialogReviewState(
      this.title, this.content, this.continueCallBack, this.postid);
}

class _BlurryDialogReviewState extends State<BlurryDialogReview> {
  String title;
  String content;
  VoidCallback continueCallBack;
  late int postid;
  _BlurryDialogReviewState(
      this.title, this.content, this.continueCallBack, this.postid);

  TextStyle textStyle = TextStyle(color: Colors.black);
  final fieldText = TextEditingController();

  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late RateSerBloc _bloc;
  Rating r = Rating();

  @override
  void initState() {
    _bloc = RateSerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            title,
            style: TextStyle(color: pink),
          ),
          content: Container(
            height: 200,
            width: 250,
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                  child: Visibility(
                    visible: visibleStream,
                    child: StreamBuilder<ApiResponse<Rating>>(
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
                              debugPrint('loading create event');
                              return Center(child: spinkitMain);
                            case Status.COMPLETED:
                              debugPrint('complete create event');
                              if ('${snapshot.data!.data}' != 'null') {
                                updateBloc = false;
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {});
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
                                  var snackBar =
                                      const SnackBar(content: Text('error'));
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
                ),
                SizedBox(
                  height: 20,
                ),
                RatingBar(
                  itemSize: 30,
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: pink),
                      half: Icon(
                        Icons.star_half,
                        color: pink,
                      ),
                      empty: Icon(
                        Icons.star_outline,
                        color: pink,
                      )),
                  onRatingUpdate: (double value) {
                    r.rating = value.toString();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 2,
                  // maxLength: 50,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Write your comment ..',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      )),
                  controller: fieldText,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 14.0, color: pink, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                "Send",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                visibleStream = true;
                updateBloc = true;
                showError = true;
                setState(() {});
                r.rating_text = fieldText.text;

                _bloc.rateSer(r);

                continueCallBack();
              },
            )
          ],
        ));
  }
}
