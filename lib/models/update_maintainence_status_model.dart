class UpdateMaintainenceStatusModel {
  bool? status;
  String? message;
  int? paymentUpdated;
  int? maintenanceUpdated;

  UpdateMaintainenceStatusModel({
    this.status,
    this.message,
    this.paymentUpdated,
    this.maintenanceUpdated,
  });

  factory UpdateMaintainenceStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateMaintainenceStatusModel(
        status: json["status"],
        message: json["message"],
        paymentUpdated: json["payment_updated"],
        maintenanceUpdated: json["maintenance_updated"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payment_updated": paymentUpdated,
        "maintenance_updated": maintenanceUpdated,
      };
}
