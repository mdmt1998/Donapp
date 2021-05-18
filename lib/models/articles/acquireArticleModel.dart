class AcquireArticleModel {
  String url;
  String articleName;
  String description;
  String contactUId;
  String uId;

  AcquireArticleModel(
      {this.url,
      this.articleName,
      this.description,
      this.contactUId,
      this.uId});

  AcquireArticleModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    articleName = json['articleName'];
    description = json['description'];
    contactUId = json['contactUId'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['articleName'] = this.articleName;
    data['description'] = this.description;
    data['contactUId'] = this.contactUId;
    data['uId'] = this.uId;
    return data;
  }
}
