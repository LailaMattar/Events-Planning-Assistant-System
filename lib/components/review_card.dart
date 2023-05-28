import 'package:event_planning/models/rating.dart';
import 'package:event_planning/screens/posts/reviews.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(this.rating);

  Rating rating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(rating.user_name);
        },
        child: Container(
          height: 100,
          width: 175,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0, //shadow
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        rating.user_name,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Icon(Icons.star, color: pink, size: 18),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 20, 0),
                          child: Text(
                            '${rating.rating}/5',
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(rating.rating_text,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      )),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ));
  }
}
