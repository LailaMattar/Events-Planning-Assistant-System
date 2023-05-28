import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/review_card.dart';
import 'package:event_planning/components/review_popup.dart';
import 'package:event_planning/models/rating.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  late List<Rating> rating;
  late int postid;
  ReviewPage(this.rating, this.postid);

  @override
  _ReviewPageState createState() => _ReviewPageState(this.rating, this.postid);
}

class _ReviewPageState extends State<ReviewPage> {
  final fieldText = TextEditingController();
  int postid;
  late List<Rating> rating;

  _ReviewPageState(this.rating, this.postid);

  showDialog11(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')

          // code on continue comes here
        };
    BlurryDialogReview alert =
        BlurryDialogReview("Review", "", continueCallBack, this.postid);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('rate ${rating.length}');
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: BigButton(
                color: pink,
                onTap: () {
                  showDialog11(context);
                },
                title: 'Rate service',
                Textcolor: Colors.white),
          ),
          elevation: 0,
        ),
        appBar: AppBar(
          title: Text('Reviews'),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemBuilder: (BuildContext, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                child: ReviewCard(rating[index]));
          },
          itemCount: rating.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
        )));
  }
}

class Review {
  String name;

  Review({required this.name, required this.stars, required this.comment});

  double stars;
  String comment;
}
