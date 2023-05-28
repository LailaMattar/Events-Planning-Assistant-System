import 'package:event_planning/blocs/allVendorBloc.dart';
import 'package:event_planning/components/vendor_profile_card.dart';
import 'package:event_planning/models/all_vendors.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';
import '../loading_page.dart';

class VendorListView extends StatefulWidget {
  final String catg;

  VendorListView(this.catg);

  @override
  _VendorListViewState createState() => _VendorListViewState(catg);
}

class _VendorListViewState extends State<VendorListView> {
  final String catg1;

  _VendorListViewState(this.catg1);

  late allVendorBloc _theBloc;
  late AllVendors allVendors;
  @override
  void initState() {
    _theBloc = allVendorBloc();
  }

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: TextField(
                textInputAction: TextInputAction.send,
                onSubmitted: (value) {
                  print(value);
                  print("searcccch");
                },
                controller: fieldText,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        clearText();
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              )))),
      body: StreamBuilder<ApiResponse<AllVendors>>(
          stream: _theBloc.theStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('error');
            } else if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  debugPrint('loading AllVendors');
                  return const LoadingPage();
                case Status.COMPLETED:
                  debugPrint('complete AllVendors');
                  return CompletePage(
                    snapshot.data!.data,
                  );
                case Status.ERROR:
                  debugPrint('error AllVendors');
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(
                    onRetryPressed: () => _theBloc.getAllVendors(catg1),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getAllVendors(catg1);
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  AllVendors vendors;

  CompletePage(this.vendors);

  @override
  _CompletePageState createState() => _CompletePageState(this.vendors);
}

class _CompletePageState extends State<CompletePage> {
  AllVendors vendors;

  _CompletePageState(this.vendors);

  @override
  Widget build(BuildContext context) {
    return vendors.vendors.isEmpty?const Center(
      child: Text(
        'No items yet',
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
    ):ListView.builder(
      itemBuilder: (BuildContext, index) {
        return Padding(
            padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
            child: VendorProfileCard(vendors.vendors[index]));
      },
      itemCount: vendors.vendors.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
    );
  }
}
