import 'dart:convert';

class DeleteVirtualTicketByIdRequest {
  final int? virtualTicketId;

  DeleteVirtualTicketByIdRequest({this.virtualTicketId});

  factory DeleteVirtualTicketByIdRequest.fromJson(String str) =>
      DeleteVirtualTicketByIdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteVirtualTicketByIdRequest.fromMap(Map<String, dynamic> json) =>
      DeleteVirtualTicketByIdRequest(
        virtualTicketId: json["virtual_ticket_id"],
      );

  Map<String, dynamic> toMap() => {"virtual_ticket_id": virtualTicketId};
}
