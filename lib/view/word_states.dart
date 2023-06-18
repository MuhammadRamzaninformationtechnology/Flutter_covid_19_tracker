import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker/Models/WorldStatesModels.dart';
import 'package:flutter_covid_19_tracker/Services/states_services.dart';
import 'package:flutter_covid_19_tracker/view/countries_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff8285F4),
    const Color(0xff1aa268),
    const Color(0xffde5266),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future:statesServices.fecthWorldStatesRecords() ,
                  builder:(context, AsyncSnapshot<WorldStatesModels> snapshot){
                if(!snapshot.hasData){
                return Expanded(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller: _controller,
                    ));

                }else{
                return Column(
                  children: [
                     PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recover": double.parse(snapshot.data!.recovered!.toString()),
                        "Death": double.parse(snapshot.data!.deaths!.toString()),
                      },
                       chartValuesOptions: const ChartValuesOptions(
                         showChartValuesInPercentage: true,
                       ),
                      chartRadius: MediaQuery.of(context).size.width / 3.2,

                      animationDuration: const Duration(microseconds: 1200),
                      colorList: colorList,
                      legendOptions:
                      const LegendOptions(legendPosition: LegendPosition.left),
                      chartType: ChartType.ring,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06,),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                            ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                            ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                            ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                            ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                            ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                            ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                            ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                    },
                      child: Container(
                        height: 50,
                        decoration:  BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('Track Countries'),
                        ),
                      ),
                    )
                  ],
                );
                }
              } ),

            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
