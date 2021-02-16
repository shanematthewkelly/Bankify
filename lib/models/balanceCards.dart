class BalanceCardsUi {
  final int id;
  final String title, image;

  BalanceCardsUi(this.id, {this.title, this.image});
}

List<BalanceCardsUi> balanceCardUI = [
  BalanceCardsUi(
    1,
    title: "View your\ntransactions.",
    image: "assets/images/tile1.png",
  ),
  BalanceCardsUi(
    2,
    title: "Check\non your vault.",
    image: "assets/images/tile2.png",
  ),
  BalanceCardsUi(
    3,
    title: "This is item #3.",
    image: "assets/images/tile2.png",
  ),
];
