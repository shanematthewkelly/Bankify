import 'package:flutter/cupertino.dart';

enum Type { image }

class Slides {
  final String url, title, description;
  final Type image;
  final Duration duration;

  const Slides({
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.image,
    @required this.duration,
  });
}

final List<Slides> slides = [
  Slides(
      title: "Rest easy when saving with us.",
      description:
          "We understand that money can be hard to save at times. That's why we're here to guide you every step of the way.",
      url: "https://wallpapercave.com/wp/wp6054620.jpg",
      image: Type.image,
      duration: const Duration(
        seconds: 8,
      )),
  Slides(
      title: "View and manage your transactions.",
      description:
          "We pull in all of your transactions and keep everything neat and tidy. Easily manaage and view your expenditure.",
      url:
          "https://images.pexels.com/photos/462030/pexels-photo-462030.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      image: Type.image,
      duration: const Duration(
        seconds: 8,
      )),
  Slides(
      title: "Link multiple accounts with us.",
      description:
          "Everything under one umbrella with us can aid you in keeping things simplified. Just link your accounts and you'll be ready to go.",
      url:
          "https://images.pexels.com/photos/3378993/pexels-photo-3378993.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      image: Type.image,
      duration: const Duration(
        seconds: 8,
      )),
];
