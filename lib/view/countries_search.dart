import 'dart:developer';

import 'package:covid_tracker/view/country_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/state_service.dart';

class CountriesSearch extends StatefulWidget {
  const CountriesSearch({super.key});

  @override
  State<CountriesSearch> createState() => _CountriesSearchState();
}

class _CountriesSearchState extends State<CountriesSearch> {
  
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateSevices serviceState = StateSevices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
              setState(() {

              });
            },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with Country name ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
          ),
          
          Expanded(
            child: FutureBuilder(
              future: serviceState.getCountries(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                    itemBuilder: (context,index){
                      return Shimmer.fromColors(
                        baseColor: Colors.green.shade700,
                        highlightColor: Colors.red.shade100,
                        enabled: true,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.greenAccent,
                              ),
                              title: Container(
                                height: 8,
                                width: double.infinity,
                                color: Colors.green,
                              ),
                              subtitle:Container(
                                height: 8,
                                width: double.infinity,
                                color: Colors.green,
                              ) ,
                            )
                          ],
                        ),

                      );
                    }

                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetail(
                                  countryName: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths:  snapshot.data![index]['todayDeaths'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                test: snapshot.data![index]['tests'],
                                // flag: snapshot.data![index]['country']['flag']
                                flag: snapshot.data![index]['countryInfo']['flag'],
                              )));
                            },
                            child: ListTile(
                                title: Text(snapshot.data![index]['country'],),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                )
                            ),
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetail(
                                countryName: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths:  snapshot.data![index]['todayDeaths'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                test: snapshot.data![index]['tests'],
                                // flag: snapshot.data![index]['country']['flag']
                                flag: snapshot.data![index]['countryInfo']['flag'],
                              )));
                            },
                            child: ListTile(
                                title: Text(snapshot.data![index]['country'],),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                )
                            ),
                          );
                        }else{
                          return Container(
                            // child: Text("no Country found",style: TextStyle(color: Colors.white),),
                          );
                        }



                      }
                  );
                }

              }

            ),
          )
        ],
      ),
    );
  }
}
