class AppInformationData {
  final int id;
  final String title, description, image;

  AppInformationData(this.id, {this.title, this.description, this.image});
}

List<AppInformationData> appInfo = [
  AppInformationData(
    1,
    title: "Balance",
    description:
        "View your account balance at any time with easy login accessability, and manage your spending",
    image: "assets/images/intro-balance.png",
  ),
  AppInformationData(
    2,
    title: "Payments",
    description:
        "View your account balance at any time with easy login accessability, and manage your spending",
    image: "assets/images/intro-payments.png",
  ),
  AppInformationData(
    3,
    title: "Rewards",
    description:
        "View your account balance at any time with easy login accessability, and manage your spending",
    image: "assets/images/intro-rewards.png",
  ),
  AppInformationData(
    4,
    title: "Accounts",
    description:
        "View your account balance at any time with easy login accessability, and manage your spending",
    image: "assets/images/intro-account.png",
  ),
  AppInformationData(
    5,
    title: "Support",
    description:
        "View your account balance at any time with easy login accessability, and manage your spending",
    image: "assets/images/intro-support.png",
  ),
];
