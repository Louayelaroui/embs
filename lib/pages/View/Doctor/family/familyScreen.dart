import 'package:flutter/material.dart';

import '../../../../models/family_data.dart';
import '../../../components/category_item.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: recycle_CATEGORIES
          .map(
            (catData) => CategoryItem(
          catData.id,
          catData.title,
          catData.color,
        ),
      )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}