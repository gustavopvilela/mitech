class BookmarkedPostsModel {
  late int? id;
  late String? title;
  late String? subtitle;
  late String? imageUrl;
  late String? link;

  BookmarkedPostsModel(
    this.id,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.link
  );

  BookmarkedPostsModel.map(dynamic obj) {
    id = obj["id"];
    title = obj["title"];
    subtitle = obj["subtitle"];
    imageUrl = obj["imageUrl"];
    link = obj["link"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["title"] = title;
    map["subtitle"] = subtitle;
    map["imageUrl"] = imageUrl;
    map["link"] = link;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  BookmarkedPostsModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    subtitle = map["subtitle"];
    imageUrl = map["imageUrl"];
    link = map["link"];
  }
}