import 'package:CovidTracker/screens/maintenance.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';

class fonctScreen extends StatefulWidget {
  const fonctScreen({Key? key}) : super(key: key);

  @override
  State<fonctScreen> createState() => _fonctScreenState();
}

class _fonctScreenState extends State<fonctScreen> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Center(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "À propos de  VIRUS TRACKER",
          style: TextStyle(
            color: ybcolor,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: h * 0.013,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
          color: ybcolor,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: h * 0.04, vertical: 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h*0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/fonct1.png", width: 100),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Text(
                          "Supposons que vous avez rencontré des amis lors d'une sortie ce dernier week-end. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: h * 0.013),
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.00),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/fonct2.png", width: 150),
                        SizedBox(
                          height: h * 0,
                        ),
                        Text(
                          "Vos téléphones vont échanger des codes qui identifient chacun d'entre vous.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: h * 0.013)
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.03),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/fonct3.png", width: 80),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Text(
                          "Deux jours plus tard, l'ami que vous avez rencontré a fait un test de dépistage du virus qui s'est révélé positif et s'est déclaré malade via l'application.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: h * 0.013),
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.03, bottom: h*0.05),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/fonct4.png", width: 80),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Text(
                          "Comme vos téléphones ont échangé les codes, vous serez informé  que vous avez été exposé au virus et vous recevrez des recommandations sur la marche à suivre.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: h * 0.013),
                        ),
                      ]),
                ),

              ]),
        ),
      ),
    ));
  }
}
