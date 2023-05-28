import 'package:event_planning/blocs/allViewBloc.dart';
import 'package:event_planning/components/MyOrdersCard.dart';
import 'package:event_planning/components/hallSearchCard.dart';
import 'package:event_planning/components/vendorSearch.dart';
import 'package:event_planning/components/vendor_profile_card.dart';
import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/favorite_list.dart';
import 'package:event_planning/screens/loading_page.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';

class SearchView extends StatefulWidget {
  late String type;
  late List Dataa = [];

  SearchView({required this.Dataa, required this.type});

  @override
  _SearchViewState createState() =>
      _SearchViewState(Dataa: this.Dataa, type: this.type);
}

class _SearchViewState extends State<SearchView> {
  late String type;
  late List Dataa = [];

  _SearchViewState({required this.Dataa, required this.type});

  @override
  Widget build(BuildContext context) {
    print('vendor ${Dataa.length}');

    if (type == 'Vendors') {
      print('vendor ${Dataa.length}');
      return Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Dataa.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                    child: VendorSearcCard(Dataa[index]));
              }));
    } else if (type == 'Services') {
      print('service ${Dataa.length}');

      return Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Dataa.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                    child: PostCard(Dataa[index]));
              }));
    } else if (type == 'Venues') {
      print('Venues ${Dataa.length}');
      return Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Dataa.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                    child: HallSearcCard(Dataa[index]));
              }));
    }
    return Container();
  }
}
