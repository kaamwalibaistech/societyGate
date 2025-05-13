class CommunityModel {
  final int? status;
  final String? message;
  final List<CommunityPost>? data;
  final Meta? meta;

  CommunityModel({
    this.status,
    this.message,
    this.data,
    this.meta,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((item) => CommunityPost.fromJson(item))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class CommunityPost {
  final int? id;
  final int? societyId;
  final String? societyName;
  final String? adminName;
  final String? title;
  final String? description;
  final String? photo;
  final int? like;
  final int? dislike;
  final String? createdAt;

  CommunityPost({
    this.id,
    this.societyId,
    this.societyName,
    this.adminName,
    this.title,
    this.description,
    this.photo,
    this.like,
    this.dislike,
    this.createdAt,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'],
      societyId: json['society_id'],
      societyName: json['society_name'],
      adminName: json['admin_name'],
      title: json['title'],
      description: json['description'],
      photo: json['photo'],
      like: json['like'],
      dislike: json['dislike'],
      createdAt: json['created_at'],
    );
  }
}

class Meta {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
