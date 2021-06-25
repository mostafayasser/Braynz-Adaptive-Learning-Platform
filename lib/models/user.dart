// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:graduation_project/models/dashboard.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.age,
    this.currentConcept,
    this.currentTopic,
    this.knowledgeLevel,
    this.learningStyle,
    this.concepts,
    this.dashboard,
  });

  int id;
  String name;
  String email;
  int age;
  int currentConcept;
  int currentTopic;
  String knowledgeLevel;
  List<String> learningStyle;
  List<UserConcept> concepts;
  Dashboard dashboard;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        currentConcept: json["currentConcept"],
        currentTopic: json["currentTopic"],
        knowledgeLevel: json["knowledgeLevel"],
        learningStyle: List<String>.from(json["learningStyle"].map((x) => x)),
        concepts: List<UserConcept>.from(
            json["concepts"].map((x) => UserConcept.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "age": age,
        "currentConcept": currentConcept,
        "currentTopic": currentTopic,
        "knowledgeLevel": knowledgeLevel,
        "learningStyle": List<dynamic>.from(learningStyle.map((x) => x)),
        "concepts": List<dynamic>.from(concepts.map((x) => x.toJson())),
      };
}

class UserConcept {
  UserConcept({
    this.id,
    this.muddiestPoint,
    this.topics,
  });

  int id;
  int muddiestPoint;
  List<UserTopic> topics;

  factory UserConcept.fromJson(Map<String, dynamic> json) => UserConcept(
        id: json["id"],
        muddiestPoint: json["muddiestPoint"],
        topics: json["topics"] == null
            ? []
            : List<UserTopic>.from(
                json["topics"].map((x) => UserTopic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "muddiestPoint": muddiestPoint,
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
      };
}

class UserTopic {
  UserTopic({
    this.id,
    this.endDateTime,
    this.startDateTime,
    this.idleTimeInMinutes,
    this.preTestScore,
    this.preTestAttempts,
    this.postTestScore,
    this.postTestAttempts,
    this.timesOfStudy,
  });

  int id;
  DateTime endDateTime;
  DateTime startDateTime;
  int idleTimeInMinutes;
  int preTestScore;
  int preTestAttempts;
  int postTestScore;
  int postTestAttempts;
  int timesOfStudy;

  factory UserTopic.fromJson(Map<String, dynamic> json) => UserTopic(
        id: json["id"],
        endDateTime:
            new DateTime.fromMicrosecondsSinceEpoch(json["endDateTime"]),
        startDateTime:
            new DateTime.fromMicrosecondsSinceEpoch(json["startDateTime"]),
        idleTimeInMinutes: json["idleTimeInMinutes"].toInt(),
        preTestScore: json["preTestScore"],
        preTestAttempts: json["preTestAttempts"],
        postTestScore: json["postTestScore"],
        postTestAttempts: json["postTestAttempts"],
        timesOfStudy: json["timesOfStudy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "endDateTime": endDateTime.millisecondsSinceEpoch,
        "startDateTime": startDateTime.millisecondsSinceEpoch,
        "idleTimeInMinutes": idleTimeInMinutes,
        "preTestScore": preTestScore,
        "preTestAttempts": preTestAttempts,
        "postTestScore": postTestScore,
        "postTestAttempts": postTestAttempts,
        "timesOfStudy": timesOfStudy,
      };
}
