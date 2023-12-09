import 'package:flutter/material.dart';

import '../../../../models/consultation.dart';
import '../../../../reposetories/constants.dart';

class ConsultationListView extends StatelessWidget {
  const ConsultationListView({Key? key, this.callBack, required this.itemHeight}) : super(key: key);

  final Function()? callBack;
  final double itemHeight; // Add this parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),

        itemExtent:itemHeight,
        scrollDirection: Axis.horizontal,
        itemCount: Consultation.consultationList.length,
        itemBuilder: (BuildContext context, index) {
          return CategoryView(
            callback: callBack,
            category: Consultation.consultationList[index],
          );
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key, this.category, this.callback}) : super(key: key);

  final VoidCallback? callback;
  final Consultation? category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: callback,
      child: SizedBox(
        width: 200, // Set the width of each item (adjust as needed)
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor('#F8FAFB'),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                      left: 16,
                                      right: 16,
                                    ),
                                    child: Text(
                                      category!.title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        letterSpacing: 0.27,
                                        color: AppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 16,
                                      right: 16,
                                      bottom: 8,
                                    ),
                                    child: Center(
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              color: AppTheme.nearlyBlue,
                                              size: 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              category!.date,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                letterSpacing: 0.27,
                                                color: AppTheme.grey,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(16.0)),
                    child: AspectRatio(
                      aspectRatio: 1.28,
                      child: Image.asset(category!.imagePath),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
