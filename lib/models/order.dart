class CreateOrder {
  int? status;
  String? message;
  String? orderId;
  int? amount;
  String? currency;
  String? key;

  CreateOrder(
      {this.status,
      this.message,
      this.orderId,
      this.amount,
      this.currency,
      this.key});

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
      status: json["status"],
      message: json["message"],
      orderId: json["order_id"],
      amount: json["amount"],
      currency: json["currency"],
      key: json["key"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_id": orderId,
        "amount": amount,
        "currency": currency,
        "key": key
      };
}
