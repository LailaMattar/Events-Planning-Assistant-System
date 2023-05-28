import 'package:event_planning/blocs/allViewBloc.dart';
import 'package:event_planning/components/MyOrdersCard.dart';
import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/loading_page.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';

class OrderView extends StatefulWidget {
  String type;

  OrderView(this.type);

  @override
  _OrderViewState createState() => _OrderViewState(this.type);
}

class _OrderViewState extends State<OrderView> {
  late AllViewBloc _theBloc;
  late List<AllBooks> allBooks;
  String type;

  _OrderViewState(this.type);

  @override
  void initState() {
    _theBloc = AllViewBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ApiResponse<AllBooks>>(
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
                    onRetryPressed: () => _theBloc.getAllBooks(type),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getAllBooks(type);
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  AllBooks allBooks;

  CompletePage(this.allBooks);

  @override
  _CompletePageState createState() => _CompletePageState(this.allBooks);
}

class _CompletePageState extends State<CompletePage> {
  AllBooks allBooks;

  _CompletePageState(this.allBooks);

  @override
  Widget build(BuildContext context) {
    return
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ListView.builder(
              itemCount: allBooks.allBooks.length,
              itemBuilder: (context,index){
                return Padding(
                          padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                          child: Container(height: 110,child: MyOrdersCard(allBooks.allBooks[index])));
              },
            ),
          );
      // List<Widget>.generate(allBooks.allBooks.length, (index) {
      //   return Padding(
      //       padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
      //       child: MyOrdersCard(allBooks.allBooks[index]));
      // }),

  }
}

//
//       ListView.builder(
//       itemBuilder: (BuildContext, index) {
//         return Padding(
//             padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
//             child: MyOrdersCard(allBooks.allBooks[index]));
//       },
//       itemCount: allBooks.allBooks.length,
//       shrinkWrap: true,
//       padding: EdgeInsets.all(15),
//       scrollDirection: Axis.vertical,
//     );
//   }
// }
