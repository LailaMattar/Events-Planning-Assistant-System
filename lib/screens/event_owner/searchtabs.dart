import 'package:event_planning/models/search_results.dart';
import 'package:event_planning/models/vendor_card.dart';
import 'package:event_planning/screens/vendor/search_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAll extends StatefulWidget {
  SearchResults searchResults;

  @override
  _SearchAllState createState() => _SearchAllState(searchResults);

  SearchAll(this.searchResults);
}

class _SearchAllState extends State<SearchAll> {
  SearchResults searchResults;

  _SearchAllState(this.searchResults);

  @override
  Widget build(BuildContext context) {
    VendorCard vendorCard;
    return Scaffold(
      appBar: AppBar(),
      body: MaterialApp(
          home: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Container(
                    height: 50.0,
                    child: TabBar(
                        tabs: [
                          Tab(text: 'Vendors'),
                          Tab(text: 'Venues'),
                          Tab(text: 'Services'),
                        ],
                        indicatorColor: pink,
                        unselectedLabelColor: Colors.blueGrey,
                        labelColor: pink),
                  ),
                ),
                body: TabBarView(children: [
                  SearchView(
                      Dataa: searchResults.filteredvendor, type: 'Vendors'),
                  SearchView(Dataa: searchResults.filteredhall, type: 'Venues'),
                  SearchView(
                      Dataa: searchResults.filteredposts, type: 'Services')
                ]),
              ))),
    );
  }
}
