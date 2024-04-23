import 'package:covid_tracker/model/worldStateModel.dart';
import 'package:covid_tracker/services/state_service.dart';
import 'package:covid_tracker/view/countries_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: Duration(seconds: 4), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  final colorList = <Color>[
    Color(0xff157926),
    Color(0xff181579),
    Color(0xffEA0B0F)
  ];

  @override
  Widget build(BuildContext context) {
    StateSevices stateSevices = StateSevices();
    return Scaffold(
      // backgroundColor: Colors.black45.withOpacity(0.3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                  future: stateSevices.getWorldRecord(),
                  builder: (context,AsyncSnapshot<WorldStateModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            controller: _animationController,
                            size: 50,
                          )
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap:  {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recover": double.parse(snapshot.data!.recovered!.toString()),
                              "Death": double.parse(snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.06),
                            child: Card(
                              // color: Colors.greenAccent,
                              child: Column(
                                children: [
                                  ReusableWidget(title: "Total", value: snapshot.data!.cases.toString()),
                                  ReusableWidget(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                  ReusableWidget(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                  ReusableWidget(title: "Active", value: snapshot.data!.active.toString()),
                                  ReusableWidget(title: "Critical", value: snapshot.data!.critical.toString()),
                                  ReusableWidget(title: "Today Death", value: snapshot.data!.todayDeaths.toString()),
                                  ReusableWidget(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesSearch()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff157926),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                    "Track Countries",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          )
                        ],
                      );
                    }
                  }
              ),



            ],
          ),
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  String title, value;
  ReusableWidget({Key? key, required this.title, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(fontSize: 16,),),
              Text(value),
            ],
          ),
          Divider(
            color: Colors.grey.shade100,
            thickness: 0.01,
          )
        ],
      ),
    );
  }
}
