import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker/view/word_states.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math'as math;




class splashcreen extends StatefulWidget {
  const splashcreen({Key? key}) : super(key: key);

  @override
  State<splashcreen> createState() => _splashcreenState();
}

class _splashcreenState extends State<splashcreen>with TickerProviderStateMixin  {
  late final AnimationController _controller= AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (contex)=>WorldStatesScreen()))

    );
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          AnimatedBuilder(
              animation: _controller ,
              child: Container(
                height: 200,
                width:200,
                child: const Center(
                  child: Image(image:AssetImage('images/virus.png') ),
                )

                ,
              ),
              builder:(BuildContext,Widget? child) {
                 return Transform.rotate(
                     angle: _controller.value*2.0*math.pi,
                 child:child
                 );
              } ),
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
            const Align(
              child: Text('Covid-19\nTracker app',textAlign: TextAlign.center,style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
