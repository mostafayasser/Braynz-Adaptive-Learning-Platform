import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/preTestDialog.dart';
import 'package:graduation_project/views/conceptPreTestView.dart';
import 'package:graduation_project/views/dashboardView.dart';
import 'package:graduation_project/views/loginView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class ConceptsView extends StatelessWidget {
  final List<Color> _colors = [
    Color(0xFFFFDAB9),
    Color(0xFFFBC4AB),
    Color(0xFFF8AD9D)
  ];
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: BaseWidget<ConceptsViewController>(
          initState: (m) {
            m.getConcepts();
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
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: Container(),
                backgroundColor: Color(0xFF3C096C),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await model.api.endSession(model.auth.user);
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
                                      "Hello ${model.auth.user.name},",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DashboardView(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 110,
                                height: 100,
                                padding: EdgeInsets.all(20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    //borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          offset: Offset(0, 0))
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.dashboard_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Dashboard",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose a concept to study",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
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
                                        child: StartTestDialog(
                                          message: "pre test",
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
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          color: _colors[index],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 3,
                                                offset: Offset(0, 0))
                                          ]),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            child: Image.network(
                                              model.concepts[index].imgUrl,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      model
                                                          .concepts[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${model.concepts[index].topics.length} Topics",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (ConceptsViewController.statuses[
                                            model.concepts[index].id] ==
                                        "completed")
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Completed",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
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
