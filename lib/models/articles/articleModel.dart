class ArticleModel {
  String url;
  String articleName;
  String description;
  String uId;

  ArticleModel({this.url, this.articleName, this.description, this.uId});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    articleName = json['articleName'];
    description = json['description'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['articleName'] = this.articleName;
    data['description'] = this.description;
    data['uId'] = this.uId;
    return data;
  }
}
