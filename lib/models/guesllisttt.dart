import 'package:event_planning/models/eventguest.dart';

class Guestlisttt {
  late EventGuest event;

  Guestlisttt.fromJson(Map<String, dynamic> json) {
    event = EventGuest.fromJson(json['event']);
  }
}
