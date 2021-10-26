class ResultSearchEntitie {
  final int? id;
  final String? uuid;
  final String image;
  final String name;
  final String nickName;
  final String url;

  ResultSearchEntitie({
    required this.image,
    required this.name,
    required this.nickName,
    required this.url,
    this.id,
    this.uuid,
  });
}
