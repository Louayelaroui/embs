import 'package:flutter/material.dart';

import '../component/custom_card_item.dart';



class RealDataPage extends StatefulWidget {
  const RealDataPage({super.key});

  @override
  State<RealDataPage> createState() => _RealDataPageState();
}

class _RealDataPageState extends State<RealDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(backgroundColor: Colors.amber,) ,
      body:  SingleChildScrollView(
        child: Container(
          height:500 ,
          width: 500,
          child: Column(
                children: [
          Expanded(child: Container(

              alignment: Alignment.center,
              child: Row(
                children: [
                  Text('heart',style: TextStyle(fontSize: 50,fontWeight:FontWeight.bold),),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.monitor_heart_outlined),iconSize:50,)
                ],
              ),
            ),
          ), Expanded(
                    child:Container(
                      color: Colors.green[200],
                      alignment: Alignment.center,
                      child: const Text('Hello World'),
                    ),
                  ),
                  Expanded(
                    child:Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: const Text('Hello World'),
                    ),
                  ),
                ],
              ),
        ),
      ),

    );
  }
}
