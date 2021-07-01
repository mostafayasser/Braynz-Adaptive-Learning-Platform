import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/preTestDialog.dart';
import 'package:graduation_project/views/conceptPreTestView.dart';
import 'package:graduation_project/views/loginView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class ConceptsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: BaseWidget<ConceptsViewController>(
          initState: (m) {
            m.getIntialData(m.auth.user);
          },
          model: ConceptsViewController(
            api: Provider.of<Api>(context),
            auth: Provider.of(context),
          ),
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Concepts View",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                leading: Container(),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        model.auth.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      })
                ],
              ),
              body: model.busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50),
                                    ),
                                    Text(
                                      "${model.auth.user.name},",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text("Dashboard"),
                            if (model.dashboard != null)
                              Column(
                                children: [
                                  Text(
                                    "Sessions Num: ${model.dashboard.studySessionsNum.toString()}",
                                  ),
                                  Text(
                                    "Finals Avg: ${model.dashboard.finalTestsAvg.toString()}",
                                  ),
                                  Text(
                                    "Finished Topics: ${model.dashboard.finishedTopicsNum.toString()}",
                                  ),
                                  Text(
                                      "Knowledge Level: ${model.dashboard.knowledgeLevel}"),
                                  Text(
                                      "HoursOfStudy: ${model.dashboard.hoursOfStudy.toString()}"),
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            ...List.generate(
                              model.concepts.length,
                              (index) => GestureDetector(
                                onTap: () async {
                                  model.setBusy();
                                  User user = await model.api.addConcept(
                                    conceptID: model.concepts[index].id,
                                    user: model.auth.user,
                                  );
                                  model.setIdle();
                                  if (user != null) {
                                    model.auth.setUser(user: user);
                                    ConceptsViewController.currentConcept =
                                        model.concepts[index];
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: PreTestDialog(
                                          yesOnPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ConceptPreTestView(),
                                              ),
                                            );
                                          },
                                          noOnPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TopicsView(
                                                  topicsIDs: model
                                                      .concepts[index].topics,
                                                  concept:
                                                      model.concepts[index],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("assets/Joomla.jpg"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 3,
                                            offset: Offset(0, 0))
                                      ]),
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.concepts[index].name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
            );
          }),
    );
  }
}
