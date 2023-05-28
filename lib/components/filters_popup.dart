import 'dart:ui';

import 'package:event_planning/models/search.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BlurryDialogFilters extends StatefulWidget {
  late String title;
  late String content;
  late Search s;
  late VoidCallback continueCallBack;

  @override
  _BlurryDialogFiltersState createState() => _BlurryDialogFiltersState(
      this.title, this.content, this.continueCallBack, this.s);

  BlurryDialogFilters(this.title, this.content, this.continueCallBack, this.s);
}

class _BlurryDialogFiltersState extends State<BlurryDialogFilters> {
  late String typeDropDownValue = " ";
  late String locationDropDownValue = " ";
  late String fromPriceDropDownValue = " ";
  late String toPriceDropDownValue = " ";
  late Search s;

  late String title;
  late String content;
  late VoidCallback continueCallBack;

  _BlurryDialogFiltersState(
      this.title, this.content, this.continueCallBack, this.s);

  TextStyle textStyle = TextStyle(color: Colors.black);
  final fieldText = TextEditingController();
  Future<Search> getSearch() async {
    return s;
  }

  @override
  void initState() {
    typeDropDownValue = types.first;
    locationDropDownValue = locations.first;
    fromPriceDropDownValue = fromPrices.first;
    toPriceDropDownValue = toPrices.first;
    // confirmDropDownValue = confirmTimeList.first;
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
                height: 350,
                width: 250,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xff919191),
                          ),
                          value: typeDropDownValue,
                          items: types.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              typeDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xff919191),
                          ),
                          value: locationDropDownValue,
                          items: locations.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              locationDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xff919191),
                          ),
                          value: fromPriceDropDownValue,
                          items: fromPrices.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              fromPriceDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xff919191),
                          ),
                          value: toPriceDropDownValue,
                          items: toPrices.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              toPriceDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        s.type = typeDropDownValue;
                        s.city = locationDropDownValue;
                        s.max_price = toPriceDropDownValue;
                        s.min_price = fromPriceDropDownValue;
                        continueCallBack();
                      },
                    )
                  ],
                ))));
  }
}
