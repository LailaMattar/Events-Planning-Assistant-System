import 'package:event_planning/blocs/EventsBloc.dart';
import 'package:event_planning/components/event_card.dart';
import 'package:event_planning/models/all_events.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';
import '../loading_page.dart';

class SelectEvent extends StatefulWidget {
  const SelectEvent({Key? key}) : super(key: key);

  @override
  _SelectEventState createState() => _SelectEventState();
}

class _SelectEventState extends State<SelectEvent> {
  late EventsBloc _theBloc;
  late List<MyEvent> myEvents;
  @override
  void initState() {
    _theBloc = EventsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      body: StreamBuilder<ApiResponse<AllEvents>>(
          stream: _theBloc.theStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('error');
            } else if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  debugPrint('loading my events');
                  return const LoadingPage();
                case Status.COMPLETED:
                  debugPrint('complete myevents');
                  return CompletePage(
                    snapshot.data!.data,
                  );
                case Status.ERROR:
                  debugPrint('error MyEvents');
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(
                    onRetryPressed: () => _theBloc.getMyEvents(),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getMyEvents();
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  AllEvents eventss;

  CompletePage(this.eventss);

  @override
  _CompletePageState createState() => _CompletePageState(this.eventss);
}

class _CompletePageState extends State<CompletePage> {
  late AllEvents events;

  _CompletePageState(this.events);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext, index) {
        return Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
            child: EventCard(events.events[index]));
      },
      itemCount: events.events.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
    );
  }
}
