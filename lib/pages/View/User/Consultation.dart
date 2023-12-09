import 'package:flutter/material.dart';

import '../component/consultationDetails.dart';
import '../component/custom_card_item.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 10,backgroundColor: Colors.blue),
      body: SingleChildScrollView(

        child:  Column(
          children: [
            CustomCardItem(index: 0, title: ' consultation family  Doctor  ',onPress:(){
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ConsultationScreen(),
                ),
              );
            }),
            CustomCardItem(index: 1, title: 'consultation Doctor AE',
            onPress: (){
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ConsultationScreen(),
                ),
              );
            },
            ),
            CustomCardItem(index: 2, title: 'consultation Doctor AD',),
            CustomCardItem(index: 3, title: 'consultation Doctor AS',),
            CustomCardItem(index: 4, title: 'consultation Doctor AE',),
            CustomCardItem(index: 5, title: 'consultation Doctor AE',),
            CustomCardItem(index: 6, title: 'consultation  Doctor famille ',),
            CustomCardItem(index: 7, title: 'consultation familly Docteur ',),
            CustomCardItem(index: 8, title: 'consultation familly Docteur ',),
          ],

        ),
      ),
    );
  }
}
