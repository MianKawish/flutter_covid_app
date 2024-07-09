import 'package:flutter/material.dart';
import 'package:flutter_covid_app/view/world_stats.dart';

class DetailsScreen extends StatefulWidget {
  String image, name;
  int totalCase,
      totalDeaths,
      totalRecoverd,
      active,
      critical,
      todayRecoverd,
      test;
  DetailsScreen(
      {super.key,
      required this.active,
      required this.critical,
      required this.image,
      required this.name,
      required this.test,
      required this.todayRecoverd,
      required this.totalCase,
      required this.totalDeaths,
      required this.totalRecoverd});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          ReuseableRow(
                              title: 'Cases',
                              value: widget.totalCase.toString()),
                          ReuseableRow(
                              title: 'Active', value: widget.active.toString()),
                          ReuseableRow(
                              title: 'Critical',
                              value: widget.critical.toString()),
                          ReuseableRow(
                              title: 'TotalCases',
                              value: widget.totalCase.toString()),
                          ReuseableRow(
                              title: 'Today Recovered',
                              value: widget.todayRecoverd.toString()),
                          ReuseableRow(
                              title: 'Total Deaths',
                              value: widget.totalDeaths.toString()),
                          ReuseableRow(
                              title: 'Test', value: widget.test.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
