import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wetix/model/event_model.dart';
import 'package:wetix/utils/url.dart';

class HomeScreenServices {
  // Get Upcoming Events============
  Future<List<EventModel>> getUpcomingEvent() async {
    final response = await http.get(Uri.parse(getUpcomingEvents));
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);
      final evenData = result['upcomingEvents'] as List<dynamic>;
      return evenData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // Get Live Events==========
  Future<List<EventModel>> getLiveEvent() async {
    final response = await http.get(Uri.parse(getLiveEvents));
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);

      final eventData = result['liveEvents'] as List<dynamic>;

      return eventData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // Get past events=========
  Future<List<EventModel>> getPastEvent() async {
    final response = await http.get(Uri.parse(getPastEvents));
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);
      final pastEventData = result['pastEvents'] as List<dynamic>;

      return pastEventData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
