import 'dart:convert';

class GetTicketByEeventRequestModel {
  final int? eventId;

  GetTicketByEeventRequestModel({this.eventId});

  factory GetTicketByEeventRequestModel.fromJson(String str) =>
      GetTicketByEeventRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketByEeventRequestModel.fromMap(Map<String, dynamic> json) =>
      GetTicketByEeventRequestModel(eventId: json["event_id"]);

  Map<String, dynamic> toMap() => {"event_id": eventId};
}
