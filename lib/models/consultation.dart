class Consultation {
  Consultation({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.date = "",
  });
  String title;
  int lessonCount;
  int money;
  String date;
  String imagePath;

  static List<Consultation> consultationList = <Consultation>[
    Consultation(
      imagePath: 'assets/images/consultation.png',
      title: 'breath Problem',
      lessonCount: 24,
      money: 25,
      date:'20/06/2023',
    ),
    Consultation(
      imagePath: 'assets/images/consultation.png',
      title: 'heart problem',
      lessonCount: 22,
      money: 18,
      date: "20/06/2023",
    ),
    Consultation(
      imagePath: 'assets/images/consultation.png',
      title: 'flu',
      lessonCount: 24,
      money: 25,
      date: "20/06/2023",
    ),
    Consultation(
      imagePath: 'assets/images/consultation.png',
      title: 'hand broken',
      lessonCount: 22,
      money: 18,
      date: "20/06/2023",
    ),
  ];

}