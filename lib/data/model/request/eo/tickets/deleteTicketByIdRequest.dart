import 'dart:convert';

class DeleteTicketByIdRequest {
  final int? ticketId;

  DeleteTicketByIdRequest({this.ticketId});

  factory DeleteTicketByIdRequest.fromJson(String str) =>
      DeleteTicketByIdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteTicketByIdRequest.fromMap(Map<String, dynamic> json) =>
      DeleteTicketByIdRequest(ticketId: json["ticket_id"]);

  Map<String, dynamic> toMap() => {"ticket_id": ticketId};
}
