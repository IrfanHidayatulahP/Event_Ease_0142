import 'dart:convert';

class GetTicketByIdRequest {
  final int? ticketId;

  GetTicketByIdRequest({this.ticketId});

  factory GetTicketByIdRequest.fromJson(String str) =>
      GetTicketByIdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketByIdRequest.fromMap(Map<String, dynamic> json) =>
      GetTicketByIdRequest(ticketId: json["ticket_id"]);

  Map<String, dynamic> toMap() => {"ticket_id": ticketId};
}
