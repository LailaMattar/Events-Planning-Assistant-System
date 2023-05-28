import 'package:event_planning/blocs/search_bloc.dart';
import 'package:event_planning/components/filters_popup.dart';
import 'package:event_planning/components/review_popup.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/search.dart';
import 'package:event_planning/models/search_results.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/searchtabs.dart';
import 'package:event_planning/screens/vendor/search_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late SearchBloc _bloc;
  late Search s =
      Search(min_price: '', type: '', city: '', word: '', max_price: '');

  final fieldText = TextEditingController();
  bool send = false;
  void clearText() {
    fieldText.clear();
  }

  late String typeDropDownValue = " ";
  late String locationDropDownValue = " ";

  List<String> vendors = ['mays', 'll', 'feras'];

  showDialog11(BuildContext context, Search ss) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')

          // code on continue comes here
        };
    BlurryDialogFilters alert =
        BlurryDialogFilters("Filters", "", continueCallBack, ss);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    _bloc = SearchBloc();
    searchResults = SearchResults();
  }

  late SearchResults searchResults;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white54.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: TextField(
                textInputAction: TextInputAction.send,
                onSubmitted: (value) {
                  setState(() {
                    send = true;
                  });
                  print(value);
                  print("searcccch");

                  visibleStream = true;
                  updateBloc = true;
                  showError = true;
                  setState(() {});

                  s.word = fieldText.text;
                  print('ss: ${s.word}');
                  _bloc.search(s);
                },
                controller: fieldText,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        clearText();
                        setState(() {
                          send = false;
                        });
                      },
                    ),
                    hintText: 'Search',
                    border: InputBorder.none),
              ))),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.filter_list_sharp,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                showDialog11(context, s);
// do something
              },
            )
          ],
        ),
        body: Visibility(
          visible: visibleStream,
          child: StreamBuilder<ApiResponse<SearchResults>>(
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
                    debugPrint('loading search');
                    return Center(child: spinkitMain);
                  case Status.COMPLETED:
                    debugPrint('complete search');
                    searchResults = snapshot.data!.data;
                    if ('${snapshot.data!.data}' != 'null') {
                      updateBloc = false;
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        print('pushhhhhh');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchAll(searchResults)),
                        );
                      });
                    } else {
                      updateBloc = true;
                      return Container();
                    }
                    break;
                  case Status.ERROR:
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      updateBloc = true;
                      debugPrint('blah');
                      if (showError) {
                        var snackBar = const SnackBar(content: Text('error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        ));
  }
}
//بدي يرجعلي ال ا ب اي اخر كم شغلة بحثن عنن اليوزر واقدر امحين
///
