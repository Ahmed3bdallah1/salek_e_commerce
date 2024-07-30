class PrivacyPolicyModel {
  final List<Message>? message;
  final String? status;

  PrivacyPolicyModel({
    required this.message,
    required this.status,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      status: json["status"],
      message: json["message"] != null
          ? List<Message>.from(json["message"].map((x) => Message.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message != null
            ? List<dynamic>.from(message!.map((x) => x.toJson()))
            : null,
      };
}

class Message {
  final int? id;
  final String? termsAr;
  final String? termsEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    required this.id,
    required this.termsAr,
    required this.termsEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      termsAr: json["terms_ar"],
      termsEn: json["terms_en"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "terms_ar": termsAr,
        "terms_en": termsEn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
