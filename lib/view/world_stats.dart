import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Services/stats_services.dart';
import 'package:flutter_covid_app/view/countries_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  StatsServices services = StatsServices();
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xffde5246),
    const Color.fromARGB(255, 3, 221, 61)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
            Expanded(
              child: FutureBuilder(
                future: services.fetchWorldStatsRecords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Colors.white,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recoverd": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.sizeOf(context).width * 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.06),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  ReuseableRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString()),
                                  ReuseableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ReuseableRow(
                                      title: "Recoverd",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReuseableRow(
                                      title: "Active",
                                      value: snapshot.data!.active.toString()),
                                  ReuseableRow(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReuseableRow(
                                      title: "Today Deaths",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReuseableRow(
                                      title: "Today Revoverd",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CountriesList();
                              },
                            ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                const Center(child: Text("Track Counteries")),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)],
        ),
        SizedBox(
          height: 5,
        ),
        Divider()
      ],
    );
  }
}
