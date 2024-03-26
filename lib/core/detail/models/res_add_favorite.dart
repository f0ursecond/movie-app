class ResAddFavorite {
  final String? mediaType;
  final int? mediaId;
  final bool? favorite;

  ResAddFavorite({required this.mediaType, required this.mediaId, required this.favorite});

  factory ResAddFavorite.fromJson(Map<String, dynamic> json) => ResAddFavorite(
        mediaType: json['media_type'],
        mediaId: json['media_id'],
        favorite: json['favorite'],
      );
}
