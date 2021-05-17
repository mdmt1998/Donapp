class ArticleModel {
  String url;
  String imageName;
  String description;
  String uId;

  ArticleModel({this.url, this.imageName, this.description, this.uId});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    imageName = json['imageName'];
    description = json['description'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['imageName'] = this.imageName;
    data['description'] = this.description;
    data['uId'] = this.uId;
    return data;
  }
}
