import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/promo.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  late Coupon promo;

  PromoCard(this.promo);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(promo.code_owner);
        },
        child: Container(
          height: 146,
          width: 175,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0, //shadow
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon(choice.icon, size: 42.0, color: Colors.white),
                      Text(
                        'Evento!',
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Promo code : ',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              )),
                          Text(
                            '${promo.code_owner}     - ${promo.amount}% -',
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Duration : ',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              )),
                          Text(
                            '${promo.period_of_copun} Days',
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Available for : ',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              )),
                          Text(
                            '${promo.type} vendors',
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ])),
          ),
        ));
  }
}
