// To parse this JSON data, do
//
//     final topic = topicFromJson(jsonString);

import 'dart:convert';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

String topicToJson(Topic data) => json.encode(data.toJson());

class Topic {
  Topic({
    this.id,
    this.name,
    this.preTestId,
    this.postTestId,
    this.material,
    this.imgUrl,
  });

  int id;
  String name, imgUrl;
  int preTestId;
  int postTestId;
  Material material;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        preTestId: json["preTestID"],
        postTestId: json["postTestID"],
        imgUrl: json["imgUrl"],
        material: Material.fromJson(json["material"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preTestID": preTestId,
        "postTestID": postTestId,
        "imgUrl": imgUrl,
        "material": material.toJson(),
      };
}

class Material {
  Material({
    this.pdfMaterial,
    this.videoMaterial,
  });

  List<MaterialElement> pdfMaterial;
  List<MaterialElement> videoMaterial;

  factory Material.fromJson(Map<String, dynamic> json) {
    List<MaterialElement> pdfs = List<MaterialElement>.from(
        json["pdf"].map((x) => MaterialElement.fromJson(x)));
    pdfs.sort((a, b) => b.rate.compareTo(a.rate));
    List<MaterialElement> videos = List<MaterialElement>.from(
        json["video"].map((x) => MaterialElement.fromJson(x)));
    videos.sort((a, b) => b.rate.compareTo(a.rate));
    return Material(
      pdfMaterial: pdfs,
      videoMaterial: videos,
    );
  }

  Map<String, dynamic> toJson() => {
        "pdf": List<dynamic>.from(pdfMaterial.map((x) => x.toJson())),
        "video": List<dynamic>.from(videoMaterial.map((x) => x.toJson())),
      };
}

class MaterialElement {
  MaterialElement({
    this.url,
    this.rate,
    this.name,
  });

  String url, name;
  double rate;

  factory MaterialElement.fromJson(Map<String, dynamic> json) =>
      MaterialElement(
        name: json["name"],
        url: json["url"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "rate": rate,
      };
}
