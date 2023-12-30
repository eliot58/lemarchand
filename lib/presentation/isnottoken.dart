import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IsNotTokenPage extends StatefulWidget {
  const IsNotTokenPage({super.key});

  @override
  State<IsNotTokenPage> createState() => _IsNotTokenPageState();
}

class _IsNotTokenPageState extends State<IsNotTokenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/img/background.png"), fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/img/ny.png", width: 120, height: 120),
                  const Column(
                    children: <Widget>[
                      Text("LeMarchand box", style: TextStyle(fontFamily: 'Addon',fontSize: 36, fontWeight: FontWeight.w600, color: Color(0xffB60A0A)), textAlign: TextAlign.center),
                      Text("Lament Configuration", style: TextStyle(fontFamily: 'Addon',fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xffB60A0A)), textAlign: TextAlign.center)
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("You don't have any of our NFTs yet.\n\nYou can become the owner of several NFTs, thereby increasing your discount on a new gaming NFT and hastening its release.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xffB60A0A)), textAlign: TextAlign.center),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("There are 2 types of token.\n\nThe first one gives a 10% discount. The effect is cumulative: More tokens - more discount. But the maximum discount is 70%.\n\nThe second token will make you an investor: You will receive a small percentage of sales of all subsequent game tokens.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Color(0xffB60A0A)), textAlign: TextAlign.center),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("You can purchase the token in the following stores.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xffB60A0A)), textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff240606),
                          side: const BorderSide(
                            width: 3.0,
                            color: Color(0xffB60A0A)
                          ),
                      ),
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse("https://getgems.io/collection/EQChoISqlSuHcbydwfQsviYolxLOfMzC9P6xhre6l7JS2G4S"))) {
                          throw Exception('Could not launch https://getgems.io/collection/EQChoISqlSuHcbydwfQsviYolxLOfMzC9P6xhre6l7JS2G4S');
                        }
                      },
                      child: const Text("GetGems",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xffB60A0A),
                              fontSize: 18),
                          textAlign: TextAlign.center)),
                ),
              )
            ],
          ),
        )),
      ),
    ));
  }
}