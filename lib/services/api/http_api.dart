import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/dashboard.dart';
import 'package:graduation_project/models/question.dart';
import 'package:graduation_project/models/quiz.dart';
import 'package:graduation_project/models/topic.dart';
import 'package:graduation_project/models/user.dart';

import 'api.dart';

class HttpApi implements Api {
  final fireAuth.FirebaseAuth firebaseAuth = fireAuth.FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  @override
  Future<User> getUser(int userId) async {
    return null;
  }

  @override
  Future<User> login({String email, String password}) async {
    try {
      fireAuth.UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      /* if (credential.user != null) {
        var doc = await store.collection("users").doc(email).get();
        print(doc.get("concepts"));
        List<dynamic> concepts = doc.get("concepts");
        print(concepts[0]["id"]);
        concepts.forEach((element) {
          if (element["id"] == 1)
            element["topics"].forEach((topic) {
              if (topic["id"] == 1) topic["id"] = 2;
            });
        });

        print(concepts);
        store.collection("users").doc(email).update({"concepts": concepts});
        return User();
      } */

      if (credential.user != null) {
        var doc = await store.collection("users").doc(email).get();
        await startSession(User.fromJson(doc.data()));
        return User.fromJson(doc.data());
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  @override
  Future<User> signUp({Map<String, dynamic> param}) async {
    try {
      fireAuth.UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: param['email'], password: param['password']);
      if (credential.user != null) {
        store.collection("users").doc(param['email']).set({
          "email": param['email'],
          "name": param['name'],
          "age": param['age'],
          "currentConcept": 0,
          "currentTopic": 0,
          "knowledgeLevel": "beginner",
          "learningStyle": [],
          "concepts": [],
          "sessions": [],
          "numOfSessions": 0,
        });
        var doc = await store.collection("users").doc(param['email']).get();
        await startSession(User.fromJson(doc.data()));
        return User.fromJson(doc.data());
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  Future<User> addConcept({int conceptID, User user}) async {
    try {
      bool found = false;
      user.concepts.forEach((element) {
        if (element.id == conceptID) found = true;
      });
      var doc = await store.collection("users").doc(user.email).get();
      if (!found) {
        print(doc.get("concepts"));
        List<dynamic> concepts = doc.get("concepts");

        concepts.add({
          "id": conceptID,
          "muddiestPoint": 0,
          "finalTestScore": 0,
          "status": "notCompleted",
          "finalTestAttempts": 0,
          "preTestScore": 0,
          "preTestAttempts": 0,
          "topics": [],
        });
        store
            .collection("users")
            .doc(user.email)
            .update({"concepts": concepts});
      }
      store
          .collection("users")
          .doc(user.email)
          .update({"currentConcept": conceptID});
      doc = await store.collection("users").doc(user.email).get();
      return User.fromJson(doc.data());
    } catch (e) {
      print(e);
      return user;
    }
  }

  changeConceptStatusToCompleted({int conceptID, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID) {
        element["status"] = "completed";
      }
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  Future<User> addTopic({int conceptID, int topicID, User user}) async {
    try {
      bool found = false;
      user.concepts.forEach((element) {
        if (element.id == conceptID)
          element.topics.forEach((topic) {
            if (topic.id == topicID) found = true;
          });
      });
      if (!found) {
        var doc = await store.collection("users").doc(user.email).get();
        List<dynamic> concepts = doc.get("concepts");
        int index = -1;
        for (int i = 0; i < concepts.length; i++) {
          if (concepts[i]["id"] == conceptID) index = i;
        }
        concepts[index]["topics"].add({
          "id": topicID,
          "endDateTime": 0,
          "startDateTime": 0,
          "idleTimeInMinutes": 0,
          "preTestScore": 0,
          "state": "notCompleted",
          "preTestAttempts": 0,
          "postTestScore": 0,
          "postTestAttempts": 0,
          "timesOfStudy": 0,
        });

        store
            .collection("users")
            .doc(user.email)
            .update({"concepts": concepts});
        store
            .collection("users")
            .doc(user.email)
            .update({"currentTopic": topicID});
        doc = await store.collection("users").doc(user.email).get();
        return User.fromJson(doc.data());
      }
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /* {
              "id": 1,
              "muddiestPoint": 2,
              "numOfSessions": 0,
              "sessions": {
                "session1": 3,
                "session2": 4,
              },
              "topics": [
                {
                  "id": 1,
                  "endDateTime": DateTime.now(),
                  "startDateTime": DateTime.now(),
                  "idleTimeInMinutes": 1,
                  "preTestScore": 30,
                  "state": "done",
                  "preTestAttempts": 2,
                  "postTestScore": 90,
                  "postTestAttempts": 1,
                  "timesOfStudy": 2,
                }
              ]
            } */

  selectLearningStyle(List<String> styles, User user) async {
    try {
      store
          .collection("users")
          .doc(user.email)
          .update({"learningStyle": styles});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  startSession(User user) async {
    try {
      var doc = await store.collection("users").doc(user.email).get();

      List<dynamic> sessions = doc.get("sessions");
      sessions.add(
          {"startTime": DateTime.now().millisecondsSinceEpoch, "endTime": 0});

      store.collection("users").doc(user.email).update({
        "sessions": sessions,
        "numOfSessions": sessions.length,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  endSession(User user) async {
    try {
      var doc = await store.collection("users").doc(user.email).get();

      List<dynamic> sessions = doc.get("sessions");
      sessions.last["endTime"] = DateTime.now().millisecondsSinceEpoch;

      store.collection("users").doc(user.email).update({"sessions": sessions});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> userInSession(User user) async {
    try {
      var doc = await store.collection("users").doc(user.email).get();

      List<dynamic> sessions = doc.get("sessions");
      if (sessions.isEmpty) return false;
      if (sessions.last["endTime"] == 0)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<Dashboard> getUserDashboard(User user) async {
    Dashboard dashboard = Dashboard();
    try {
      var doc = await store.collection("users").doc(user.email).get();
      int zeros = 0;
      List<dynamic> concepts = doc.get("concepts");
      if (concepts.isEmpty) return dashboard;
      concepts.forEach((element) {
        dashboard.finalTestsAvg += element["finalTestScore"];
        if (element["finalTestScore"] == 0) zeros++;

        element["topics"].forEach((topic) {
          if (topic["state"] == "completed") dashboard.finishedTopicsNum++;
        });
      });
      if (dashboard.finishedTopicsNum <= 3)
        dashboard.knowledgeLevel = "Beginner";
      else if (dashboard.finishedTopicsNum <= 6)
        dashboard.knowledgeLevel = "Intermediate";
      else
        dashboard.knowledgeLevel = "Advanced";
      List<dynamic> sessions = doc.get("sessions");
      dashboard.studySessionsNum += sessions.length;
      sessions.forEach((element) {
        if (element["endTime"] != 0)
          dashboard.hoursOfStudy += element["endTime"] - element["startTime"];
      });

      dashboard.finalTestsAvg =
          dashboard.finalTestsAvg / (concepts.length - zeros);
      dashboard.hoursOfStudy = dashboard.hoursOfStudy ~/ 3600000;
      print(dashboard.knowledgeLevel);
      return dashboard;
    } catch (e) {
      print(e);
      return dashboard;
    }
  }

  lastSessionStartTime(User user) async {
    try {
      var doc = await store.collection("users").doc(user.email).get();

      List<dynamic> sessions = doc.get("sessions");
      if (sessions.isEmpty) return 0;

      return sessions.last["startTime"];
    } catch (e) {
      print(e);
      return 0;
    }
  }

  increaseTimesOfStudy({int topicID, int conceptID, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID)
        element["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            topic["timesOfStudy"] = topic["timesOfStudy"] + 1;
          }
        });
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  Future<List<Concept>> getConcepts() async {
    try {
      QuerySnapshot query = await store.collection("concepts").get();
      List<Concept> concepts = [];
      query.docs.forEach((element) {
        concepts.add(Concept(
          id: element.data()["id"],
          name: element.data()["name"],
          topics: element.data()["topics"],
          finalTestID: element.data()["finalTestID"],
          imgUrl: element.data()["imgUrl"],
          preTestID: element.data()["preTestID"],
        ));
      });
      return concepts;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Topic>> getTopics({List<dynamic> topicsIDs}) async {
    try {
      List<DocumentSnapshot> docs = [];
      for (int num in topicsIDs) {
        docs.add(await store.collection("topics").doc(num.toString()).get());
      }

      List<Topic> topics = [];
      docs.forEach((element) {
        topics.add(Topic.fromJson(element.data()));
      });
      return topics;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<Quiz> getPreTest({int testID}) async {
    try {
      DocumentSnapshot doc =
          await store.collection("tests").doc(testID.toString()).get();
      int numOfQuestions = doc["numOfQuestions"];
      List<DocumentSnapshot> docs = [];
      for (int i = 1; i <= numOfQuestions; i++) {
        docs.add(await store
            .collection("tests")
            .doc(testID.toString())
            .collection("question$i")
            .doc(i.toString())
            .get());
      }
      List<Question> questions = [];
      docs.forEach((element) {
        questions.add(Question.fromJson(element.data()));
      });
      Quiz quiz = Quiz(numOfQuestions: numOfQuestions, questions: questions);

      return quiz;
    } catch (e) {
      print(e);
    }
    return null;
  }

  setPreTestScore(
      {int topicID, int conceptID, double testScore, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID)
        element["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            topic["preTestAttempts"] = topic["preTestAttempts"] + 1;
            if (topic["preTestScore"] < testScore)
              topic["preTestScore"] = testScore;
          }
        });
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  Future<Quiz> getPostTest({int testID}) async {
    try {
      DocumentSnapshot doc =
          await store.collection("tests").doc(testID.toString()).get();
      int numOfQuestions = doc["numOfQuestions"];
      List<DocumentSnapshot> docs = [];
      for (int i = 1; i <= numOfQuestions; i++) {
        docs.add(await store
            .collection("tests")
            .doc(testID.toString())
            .collection("question$i")
            .doc(i.toString())
            .get());
      }
      List<Question> questions = [];
      docs.forEach((element) {
        questions.add(Question.fromJson(element.data()));
      });
      Quiz quiz = Quiz(numOfQuestions: numOfQuestions, questions: questions);

      return quiz;
    } catch (e) {
      print(e);
    }
    return null;
  }

  setPostTestScore(
      {int topicID, int conceptID, double testScore, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID)
        element["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            topic["postTestAttempts"] = topic["postTestAttempts"] + 1;
            if (topic["postTestScore"] < testScore)
              topic["postTestScore"] = testScore;
          }
        });
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  Future<Quiz> getFinalTest({int testID}) async {
    try {
      DocumentSnapshot doc =
          await store.collection("tests").doc(testID.toString()).get();
      int numOfQuestions = doc["numOfQuestions"];
      List<DocumentSnapshot> docs = [];
      for (int i = 1; i <= numOfQuestions; i++) {
        docs.add(await store
            .collection("tests")
            .doc(testID.toString())
            .collection("question$i")
            .doc(i.toString())
            .get());
      }
      List<Question> questions = [];
      docs.forEach((element) {
        questions.add(Question.fromJson(element.data()));
      });
      Quiz quiz = Quiz(numOfQuestions: numOfQuestions, questions: questions);

      return quiz;
    } catch (e) {
      print(e);
    }
    return null;
  }

  setFinalTestScore({int conceptID, double testScore, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID) {
        element["finalTestAttempts"] = element["finalTestAttempts"] + 1;
        if (element["finalTestScore"] < testScore)
          element["finalTestScore"] = testScore;
      }
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  Future<Quiz> getConceptPreTest({int testID}) async {
    try {
      DocumentSnapshot doc =
          await store.collection("tests").doc(testID.toString()).get();
      int numOfQuestions = doc["numOfQuestions"];
      List<DocumentSnapshot> docs = [];
      for (int i = 1; i <= numOfQuestions; i++) {
        docs.add(await store
            .collection("tests")
            .doc(testID.toString())
            .collection("question$i")
            .doc(i.toString())
            .get());
      }
      List<Question> questions = [];
      docs.forEach((element) {
        questions.add(Question.fromJson(element.data()));
      });
      Quiz quiz = Quiz(numOfQuestions: numOfQuestions, questions: questions);

      return quiz;
    } catch (e) {
      print(e);
    }
    return null;
  }

  setConceptPreTestScore({int conceptID, double testScore, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID) {
        element["preTestAttempts"] = element["preTestAttempts"] + 1;
        if (element["preTestScore"] < testScore)
          element["preTestScore"] = testScore;
      }
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  startTopicTime({int topicID, int conceptID, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID)
        element["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            if (topic["startDateTime"] != 0) return user;
            topic["startDateTime"] = DateTime.now().millisecondsSinceEpoch;
          }
        });
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  endTopicTime({int topicID, int conceptID, User user}) async {
    var doc = await store.collection("users").doc(user.email).get();
    print(doc.get("concepts"));
    List<dynamic> concepts = doc.get("concepts");
    print(concepts[0]["id"]);
    concepts.forEach((element) {
      if (element["id"] == conceptID)
        element["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            if (topic["endDateTime"] != 0) return user;
            topic["endDateTime"] = DateTime.now().millisecondsSinceEpoch;
            topic["idleTimeInMinutes"] =
                ((topic["endDateTime"] - topic["startDateTime"]) / 60000)
                    .ceil();
          }
        });
    });

    print(concepts);
    store.collection("users").doc(user.email).update({"concepts": concepts});
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  completeTopicState(
      {int topicID, int conceptID, User user, bool add = false}) async {
    if (add) {
      await addTopic(topicID: topicID, conceptID: conceptID, user: user);
    }
    var doc = await store.collection("users").doc(user.email).get();
    int completedTopicsNum = 0;
    String knowledgeLevel = "";
    List<dynamic> concepts = doc.get("concepts");
    for (int i = 0; i < concepts.length; i++) {
      if (concepts[i]["id"] == conceptID) {
        concepts[i]["topics"].forEach((topic) {
          if (topic["id"] == topicID) {
            topic["state"] = "completed";
          }
          if (topic["state"] == "completed") {
            completedTopicsNum++;
          }
        });
      }
    }
    if (completedTopicsNum <= 3)
      knowledgeLevel = "Beginner";
    else if (completedTopicsNum <= 6)
      knowledgeLevel = "Intermediate";
    else
      knowledgeLevel = "Advanced";
    print(concepts);
    store.collection("users").doc(user.email).update({
      "concepts": concepts,
      "knowledgeLevel": knowledgeLevel,
    });
    doc = await store.collection("users").doc(user.email).get();
    return User.fromJson(doc.data());
  }

  rateMaterial({int topicID, String type, int index, double rate}) async {
    var doc = await store.collection("topics").doc(topicID.toString()).get();

    var data = doc.data();
    if (data["material"][type][index]["rate"] != 0 && rate != 0)
      data["material"][type][index]["rate"] =
          (data["material"][type][index]["rate"] + rate) / 2;
    else if (data["material"][type][index]["rate"] == 0)
      data["material"][type][index]["rate"] =
          data["material"][type][index]["rate"] + rate;
    store.collection("topics").doc(topicID.toString()).update(data);
  }
}
