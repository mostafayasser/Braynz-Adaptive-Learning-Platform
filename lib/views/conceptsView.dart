import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/loginView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class ConceptsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: BaseWidget<ConceptsViewController>(
          initState: (m) => m.getConcepts(),
          model: ConceptsViewController(
            api: Provider.of<Api>(context),
            auth: Provider.of(context),
          ),
          builder: (context, model, child) {
            return model.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
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
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            model.concepts.length,
                            (index) => GestureDetector(
                                  onTap: () async {
                                    User user = await model.api.addConcept(
                                      conceptID: model.concepts[index].id,
                                      user: model.auth.user,
                                    );
                                    if (user != null) {
                                      model.auth.setUser(user: user);
                                      ConceptsViewController.currentConcept =
                                          model.concepts[index];
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => TopicsView(
                                            concept: model.concepts[index],
                                            topicsIDs:
                                                model.concepts[index].topics,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 3,
                                              offset: Offset(0, 0))
                                        ]),
                                    child: Text(
                                      model.concepts[index].name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  );
          }),
    );
  }
}
