import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Services/stats_services.dart';
import 'package:flutter_covid_app/view/details_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatsServices services = StatsServices();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: "Search with country name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20)),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: services.fetchCountriesStatsRecords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsScreen(
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecoverd: snapshot.data![index]
                                              ['todayRecovered'],
                                          totalCase: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecoverd: snapshot.data![index]
                                              ['recovered']);
                                    },
                                  ));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsScreen(
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecoverd: snapshot.data![index]
                                              ['todayRecovered'],
                                          totalCase: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecoverd: snapshot.data![index]
                                              ['recovered']);
                                    },
                                  ));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ))
            ],
          ),
        ));
  }
}
