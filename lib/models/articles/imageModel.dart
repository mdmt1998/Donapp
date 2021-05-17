import 'dart:io';

class ImageModel {
  File file;
  String description;
  String imageName;

  ImageModel({this.file, this.imageName, this.description});

  ImageModel.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    description = json['description'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['imageName'] = this.imageName;
    data['description'] = this.description;
    return data;
  }
}
