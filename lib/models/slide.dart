import 'package:flutter/material.dart';

class slide {
  final String image;
  final Padding title;
  final String desc;

  slide({required this.image, required this.title, required this.desc});

  static List<slide> slideList = [
    slide(
      image: "assets/images/slide1.png",
      title: Padding(
        padding: EdgeInsets.only(top: 80, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Bienvenue sur ",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(1.5, 2, 0, 0),
              child: Text(
                "VIRUS TRACKER",
                style: TextStyle(
                  color: Color.fromRGBO(90, 88, 195, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),

      desc:
          "Contribuez à contenir le virus avec les autres, à l'aide de l'application. Cliquez sur Continuer pour en savoir plus",
    ),
    slide(
      image: "assets/images/slide2.png",
      title: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                "VIRUS TRACKER",
                style: TextStyle(
                  color: Color.fromRGBO(90, 88, 195, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                " vous protège",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      desc:
          "Au cas du contact avec un utilisateur porteur du virus, VIRUS TRACKER vous préviendra et vous fournira des indications pour protéger votre santé et celle des autres.",
    ),
    slide(
      image: "assets/images/slide3.png",
      title: Padding(
        padding: EdgeInsets.only(top: 60, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                "Ensemble, contre le virus",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      desc:
          "L’utilisateur infecté peut s’isoler afin de protéger les autres et ralentir la propagation du virus.",
    ),
    slide(
      image: "assets/images/slide4.png",
      title: Padding(
        padding: EdgeInsets.only(top: 60, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                "Rejoignez nous !",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      desc:
          "Créer votre compte maintenant ou connectez vous pour nous aider dans cette mission.",
    ),
  ];
}
