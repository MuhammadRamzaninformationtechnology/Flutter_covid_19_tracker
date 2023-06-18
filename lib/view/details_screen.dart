import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker/view/word_states.dart';
class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered ,active, critical,todayRecovered,test;
   DetailScreen({required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,

   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.068),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(height:MediaQuery.of(context).size.height*.092 ,),
                    ReusableRow(title: 'cases', value: widget.totalCases.toString()),
                    ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                    ReusableRow(title: 'Critical', value: widget.critical.toString()),
                    ReusableRow(title: 'Active', value: widget.active.toString()),
                    ReusableRow(title: 'Test', value: widget.test.toString()),
                    ReusableRow(title: 'Total Death', value: widget.totalDeaths.toString()),
                    ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                  ],
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
    );
  }
}
