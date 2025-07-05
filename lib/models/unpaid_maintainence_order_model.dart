// To parse this JSON data, do
//
//     final unPaidMaintainenceOrderModel = unPaidMaintainenceOrderModelFromJson(jsonString);

class UnPaidMaintainenceOrderModel {
  bool? status;
  String? message;
  String? orderId;
  int? amount;
  String? currency;
  String? razorpayKey;
  FullResponse? fullResponse;

  UnPaidMaintainenceOrderModel({
    this.status,
    this.message,
    this.orderId,
    this.amount,
    this.currency,
    this.razorpayKey,
    this.fullResponse,
  });

  factory UnPaidMaintainenceOrderModel.fromJson(Map<String, dynamic> json) =>
      UnPaidMaintainenceOrderModel(
        status: json["status"],
        message: json["message"],
        orderId: json["order_id"],
        amount: json["amount"],
        currency: json["currency"],
        razorpayKey: json["razorpay_key"],
        fullResponse: json["full_response"] == null
            ? null
            : FullResponse.fromJson(json["full_response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_id": orderId,
        "amount": amount,
        "currency": currency,
        "razorpay_key": razorpayKey,
        "full_response": fullResponse?.toJson(),
      };
}

class FullResponse {
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  List<dynamic>? notes;
  dynamic offerId;
  String? receipt;
  String? status;
  List<Transfer>? transfers;

  FullResponse({
    this.amount,
    this.amountDue,
    this.amountPaid,
    this.attempts,
    this.createdAt,
    this.currency,
    this.entity,
    this.id,
    this.notes,
    this.offerId,
    this.receipt,
    this.status,
    this.transfers,
  });

  factory FullResponse.fromJson(Map<String, dynamic> json) => FullResponse(
        amount: json["amount"],
        amountDue: json["amount_due"],
        amountPaid: json["amount_paid"],
        attempts: json["attempts"],
        createdAt: json["created_at"],
        currency: json["currency"],
        entity: json["entity"],
        id: json["id"],
        notes: json["notes"] == null
            ? []
            : List<dynamic>.from(json["notes"]!.map((x) => x)),
        offerId: json["offer_id"],
        receipt: json["receipt"],
        status: json["status"],
        transfers: json["transfers"] == null
            ? []
            : List<Transfer>.from(
                json["transfers"]!.map((x) => Transfer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount_due": amountDue,
        "amount_paid": amountPaid,
        "attempts": attempts,
        "created_at": createdAt,
        "currency": currency,
        "entity": entity,
        "id": id,
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "offer_id": offerId,
        "receipt": receipt,
        "status": status,
        "transfers": transfers == null
            ? []
            : List<dynamic>.from(transfers!.map((x) => x.toJson())),
      };
}

class Transfer {
  int? amount;
  int? amountReversed;
  int? createdAt;
  String? currency;
  String? entity;
  Error? error;
  String? id;
  List<dynamic>? linkedAccountNotes;
  Notes? notes;
  bool? onHold;
  dynamic onHoldUntil;
  dynamic processedAt;
  String? recipient;
  dynamic recipientSettlementId;
  String? source;
  String? status;

  Transfer({
    this.amount,
    this.amountReversed,
    this.createdAt,
    this.currency,
    this.entity,
    this.error,
    this.id,
    this.linkedAccountNotes,
    this.notes,
    this.onHold,
    this.onHoldUntil,
    this.processedAt,
    this.recipient,
    this.recipientSettlementId,
    this.source,
    this.status,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        amount: json["amount"],
        amountReversed: json["amount_reversed"],
        createdAt: json["created_at"],
        currency: json["currency"],
        entity: json["entity"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
        id: json["id"],
        linkedAccountNotes: json["linked_account_notes"] == null
            ? []
            : List<dynamic>.from(json["linked_account_notes"]!.map((x) => x)),
        notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
        onHold: json["on_hold"],
        onHoldUntil: json["on_hold_until"],
        processedAt: json["processed_at"],
        recipient: json["recipient"],
        recipientSettlementId: json["recipient_settlement_id"],
        source: json["source"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount_reversed": amountReversed,
        "created_at": createdAt,
        "currency": currency,
        "entity": entity,
        "error": error?.toJson(),
        "id": id,
        "linked_account_notes": linkedAccountNotes == null
            ? []
            : List<dynamic>.from(linkedAccountNotes!.map((x) => x)),
        "notes": notes?.toJson(),
        "on_hold": onHold,
        "on_hold_until": onHoldUntil,
        "processed_at": processedAt,
        "recipient": recipient,
        "recipient_settlement_id": recipientSettlementId,
        "source": source,
        "status": status,
      };
}

class Error {
  dynamic code;
  dynamic description;
  dynamic field;
  String? id;
  dynamic metadata;
  dynamic reason;
  dynamic source;
  dynamic step;

  Error({
    this.code,
    this.description,
    this.field,
    this.id,
    this.metadata,
    this.reason,
    this.source,
    this.step,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        description: json["description"],
        field: json["field"],
        id: json["id"],
        metadata: json["metadata"],
        reason: json["reason"],
        source: json["source"],
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "field": field,
        "id": id,
        "metadata": metadata,
        "reason": reason,
        "source": source,
        "step": step,
      };
}

class Notes {
  String? purpose;

  Notes({
    this.purpose,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        purpose: json["purpose"],
      );

  Map<String, dynamic> toJson() => {
        "purpose": purpose,
      };
}
