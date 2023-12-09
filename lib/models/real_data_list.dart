class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.textnbr = '',

    this.meals,
    this.nbr = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int nbr;
  String textnbr;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/heart.png',
      titleTxt: 'heart rate',
      nbr: 70,
      textnbr: 'beats',
      meals: <String>['Recommend:', '70 beats'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/images/Poumons.png',
      titleTxt: 'oxygen lvl',
      nbr: 98,
      textnbr: '%',
      meals: <String>['Recommend :', '96% - 99%'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/images/bloodsugar.png',
      titleTxt: 'sugar',
      nbr: 6,
      textnbr: 'mmol/L',
      meals: <String>['Recommend :', '5.6 - 6.9',],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),

    MealsListData(
      imagePath: 'assets/images/stressLvl.png',
      titleTxt: 'stress Lvl',
      nbr: 6,
      textnbr: 'PSS',
      meals: <String>['Recommend:', '0-13'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    MealsListData(
      imagePath: 'assets/images/activity.png',
      titleTxt: 'activity lvl',
      nbr: 60,
      textnbr: '%',
      meals: <String>['Recommend:', '70%'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/images/kcal.png',
      titleTxt: 'burned kcl',
      nbr: 700,
      textnbr: 'kcal',
      meals: <String>['Recommend:', '1000 kcal'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
  ];
}
