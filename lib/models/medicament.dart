class medicamentListData {
  medicamentListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.text = '',
  });

  String imagePath;
  String titleTxt;
  String text;

  static List<medicamentListData> tabIconsList = <medicamentListData>[
    medicamentListData(
      imagePath: 'assets/images/gripex.png',
      titleTxt: 'gripex',
      text: '20/05/2023 - 28/05/2023',

    ),
    medicamentListData(
      imagePath: 'assets/images/fervex.png',
      titleTxt: 'fervex',
      text: '20/05/2023 - 28/05/2023',
    ),
    medicamentListData(
      imagePath: 'assets/images/augmentin.png',
      titleTxt: 'augmentin',
      text: '20/05/2023 - 24/05/2023',
    ),

    medicamentListData(
      imagePath: 'assets/images/doliprane.png',
      titleTxt: 'doliprane',
      text: '20/05/2023 - 24/05/2023',
    ),
    medicamentListData(
      imagePath: 'assets/images/efferalgan.png',
      titleTxt: 'efferalgan',
      text: '20/05/2023 - 30/05/2023',
    ),

  ];
}
