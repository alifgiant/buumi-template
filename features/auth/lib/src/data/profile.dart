class Profile {
  final String id;
  final String createdAt;
  final String fullName;
  final String? address;
  final String? phoneNum;

  Profile(this.id, this.createdAt, this.fullName, this.address, this.phoneNum);

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      json['id'] ?? '',
      json['created_at'] ?? '',
      json['full_name'] ?? '',
      json['address'] ?? '',
      json['phone_num'] ?? '',
    );
  }
}
