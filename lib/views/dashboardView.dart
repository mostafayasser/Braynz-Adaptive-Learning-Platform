import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:ui_utils/ui_utils.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Dashboard"),
          backgroundColor: Color(0xFF3C096C),
        ),
        body: BaseWidget<ConceptsViewController>(
            initState: (m) {
              m.getDashboard();
            },
            model: ConceptsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: model.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Your Insights",
                                style: Theme.of(context).textTheme.headline4),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Item(
                            color: Colors.blue,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            title: "Finals Average Score",
                            data: CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              percent: model.dashboard.finalTestsAvg / 100,
                              center: new Text(
                                "${model.dashboard.finalTestsAvg.toStringAsFixed(1)}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.white),
                              ),
                              progressColor: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Item(
                                color: Colors.red,
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                title: "Finished Topics",
                                data: Text(
                                  "9",
                                  //model.dashboard.finishedTopicsNum.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Item(
                                color: Colors.green,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.45,
                                title: "Knowledge Level",
                                data: Text(
                                  "Advanced",
                                  // model.dashboard.knowledgeLevel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Item(
                                color: Colors.orange[600],
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.45,
                                title: "Study Sessions",
                                data: Text(
                                  "6",
                                  //model.dashboard.studySessionsNum.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Item(
                                color: Colors.grey[600],
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.45,
                                title: "Hours of study",
                                data: Text(
                                  "5",
                                  //model.dashboard.hoursOfStudy.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              );
            }),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final title, data, color, width, height;

  const Item(
      {Key key, this.title, this.data, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(20),
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 3, offset: Offset(0, 0))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          data,
        ],
      ),
    );
  }
}

/* Text("Dashboard"),
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
                            ), */
