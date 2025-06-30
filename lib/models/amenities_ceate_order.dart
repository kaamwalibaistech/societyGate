class CreateOrderForAmenities {
  bool? status;
  String? message;
  String? orderId;
  int? amount;
  String? currency;
  String? key;
  Map<String, dynamic>? fullResponse;

  CreateOrderForAmenities(
      {this.status,
      this.message,
      this.orderId,
      this.amount,
      this.currency,
      this.key,
      this.fullResponse});

  factory CreateOrderForAmenities.fromJson(Map<String, dynamic> json) =>
      CreateOrderForAmenities(
          status: json["status"],
          message: json["message"],
          orderId: json["order_id"],
          amount: json["amount"],
          currency: json["currency"],
          key: json["key"],
          fullResponse: json);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_id": orderId,
        "amount": amount,
        "currency": currency,
        "key": key,
        "fullResponse": toJson()
      };
}
