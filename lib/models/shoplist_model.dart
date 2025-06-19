class ShopListModel {
  final int? status;
  final List<Shop>? data;

  ShopListModel({this.status, this.data});

  factory ShopListModel.fromJson(Map<String, dynamic> json) {
    return ShopListModel(
      status: json['status'] as int?,
      data: (json['data'] as List?)?.map((e) => Shop.fromJson(e)).toList(),
    );
  }
}

class Shop {
  final int? shopId;
  final int? societyId;
  final String? shopName;
  final String? shopType;
  final String? name;
  final String? phone;
  final String? address;
  final String? createdAt;
  final String? updatedAt;
  final String? image;

  Shop({
    this.shopId,
    this.societyId,
    this.shopName,
    this.shopType,
    this.name,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shop_id'] as int?,
      societyId: json['society_id'] as int?,
      shopName: json['shop_name'] as String?,
      shopType: json['shop_type'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
    );
  }
}
