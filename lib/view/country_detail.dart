import 'package:covid_tracker/view/world_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountryDetail extends StatefulWidget {
  String countryName;
  String flag;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
   CountryDetail({
     required this.countryName,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
     required this.flag,

   });

  @override
  State<CountryDetail> createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children:[
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                child: Card(
                  child: Column(
                    children: [
                      ReusableWidget(title: 'totalCases', value: widget.totalCases.toString()),
                      ReusableWidget(title: "TotalDeath", value: widget.totalDeaths.toString()),
                      ReusableWidget(title: "TotalRecovered", value: widget.totalRecovered.toString()),
                      ReusableWidget(title: "ActiveCases", value: widget.active.toString()),
                      ReusableWidget(title: "Critical", value: widget.critical.toString()),
                      ReusableWidget(title: "TotalRecovered", value: widget.todayRecovered.toString()),
                      ReusableWidget(title: "Test", value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.flag),
              )
            ],
          )
        ],
      ),
    );
  }
}
