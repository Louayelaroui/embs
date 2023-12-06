import 'package:flutter/material.dart';

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
            CustomCardItem(index: 0, title: 'consulation blal',),
            CustomCardItem(index: 1, title: 'blaaa',),
            CustomCardItem(index: 2, title: 'blaa',),
            CustomCardItem(index: 3, title: 'consulation blal',),
            CustomCardItem(index: 4, title: 'blaaa',),
            CustomCardItem(index: 5, title: 'blaa',),
            CustomCardItem(index: 6, title: 'consulation blal',),
            CustomCardItem(index: 7, title: 'blaaa',),
            CustomCardItem(index: 8, title: 'blaa',),
          ],

        ),
      ),
    );
  }
}
