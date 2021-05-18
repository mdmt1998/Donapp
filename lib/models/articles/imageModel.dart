import 'dart:io';

class ImageModel {
  File file;
  String description;
  String articleName;

  ImageModel({this.file, this.articleName, this.description});

  ImageModel.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    description = json['description'];
    articleName = json['articleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['imageName'] = this.articleName;
    data['description'] = this.description;
    return data;
  }
}
