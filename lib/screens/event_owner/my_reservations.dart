import 'package:event_planning/blocs/myResBloc.dart';
import 'package:event_planning/components/my_res_card.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/myres.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/favorite_list.dart';
import 'package:event_planning/screens/vendor/all_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyReservations extends StatefulWidget {
  late int event_id;

  MyReservations(this.event_id);

  @override
  _MyReservationsState createState() => _MyReservationsState(this.event_id);
}

class _MyReservationsState extends State<MyReservations> {
  late int event_id;

  _MyReservationsState(this.event_id);

  final fieldText = TextEditingController();
  bool send = false;
  void clearText() {
    fieldText.clear();
  }

  late MyResBloc _theBloc;
  late Myres myres;
  @override
  void initState() {
    _theBloc = MyResBloc();

    //hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  List<String> vendors = ['mays', 'll', 'feras', 'tt', 'kok'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Container(
        //     width: double.infinity,
        //     height: 40,
        //     decoration: BoxDecoration(
        //         color: Colors.white54.withOpacity(0.4),
        //         borderRadius: BorderRadius.circular(50)),
        //     child: Center(
        //         child: TextField(
        //       textInputAction: TextInputAction.send,
        //       onSubmitted: (value) {
        //         setState(() {
        //           send = true;
        //         });
        //         print(value);
        //         print("searcccch");
        //       },
        //       controller: fieldText,
        //       decoration: InputDecoration(
        //           prefixIcon: Icon(
        //             Icons.search,
        //             color: Colors.white,
        //           ),
        //           suffixIcon: IconButton(
        //             icon: Icon(Icons.clear, color: Colors.white),
        //             onPressed: () {
        //               clearText();
        //               setState(() {
        //                 send = false;
        //               });
        //             },
        //           ),
        //           hintText: 'Search',
        //           border: InputBorder.none),
        //     ))),
        title: Text("My reservations"),
      ),
      body: StreamBuilder<ApiResponse<Myres>>(
          stream: _theBloc.theStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('error');
            } else if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  debugPrint('loading all view ');
                  return const LoadingPage();
                case Status.COMPLETED:
                  debugPrint('complete  all view ');
                  return CompletePage(
                    snapshot.data!.data,
                  );
                case Status.ERROR:
                  debugPrint('error  all view ');
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(
                    onRetryPressed: () => _theBloc.getMyres(16),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getMyres(16);
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  late Myres myres;

  CompletePage(this.myres);

  @override
  _CompletePageState createState() => _CompletePageState(this.myres);
}

class _CompletePageState extends State<CompletePage> {
  late Myres myres;

  _CompletePageState(this.myres);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            itemBuilder: (BuildContext, index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                  child: MyResCard(
                      this.myres.myres[index], this.myres.vendors[index]));
            },
            itemCount: this.myres.myres.length,
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          )
        ]),
      ),
    );
  }
}
