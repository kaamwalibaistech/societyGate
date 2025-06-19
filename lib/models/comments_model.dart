class CommentsModel {
  final int? status;
  final String? message;
  final List<Comment>? data;
  final Meta? meta;

  CommentsModel({
    this.status,
    this.message,
    this.data,
    this.meta,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return CommentsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: rawData != null && rawData is List
          ? List<Comment>.from(rawData
              .map((item) => Comment.fromJson(item as Map<String, dynamic>)))
          : null,
      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}

class Comment {
  final int? id;
  final int? communityPostId;
  final int? societyId;
  final int? memberId;
  final String? memberName;
  final String? profile;
  final String? comment;
  final String? createdAt;

  Comment({
    this.id,
    this.communityPostId,
    this.societyId,
    this.memberId,
    this.memberName,
    this.profile,
    this.comment,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int?,
      communityPostId: json['community_post_id'] as int?,
      societyId: json['society_id'] as int?,
      memberId: json['member_id'] as int?,
      memberName: json['member_name'] as String?,
      profile: json['profile_image'] as String?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'community_post_id': communityPostId,
        'society_id': societyId,
        'member_id': memberId,
        'member_name': memberName,
        'profile_image': profile,
        'comment': comment,
        'created_at': createdAt,
      };
}

class Meta {
  final String? currentPage;
  final String? perPage;
  final int? total;

  Meta({
    this.currentPage,
    this.perPage,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] as String?,
      perPage: json['per_page'] as String?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'per_page': perPage,
        'total': total,
      };
}
