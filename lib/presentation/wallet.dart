import 'dart:developer';

import 'package:darttonconnect/ton_connect.dart';
import 'package:dio/dio.dart';
import 'package:lemarchand/presentation/explorer.dart';
import 'package:lemarchand/presentation/isnottoken.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TonConnect connector = TonConnect(
      'https://raw.githubusercontent.com/eliot58/lemarchand/main/assets/ton-connect.txt');
  Map<String, String>? walletConnectionSource;
  String universalLink = 'https://app.tonkeeper.com/ton-connect';

  dynamic getNFTItems(String address) async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(
          'https://tonapi.io/v2/accounts/$address/nfts?collection=EQChoISqlSuHcbydwfQsviYolxLOfMzC9P6xhre6l7JS2G4S&limit=1000&offset=0&indirect_ownership=false');

      return response.data;
    } catch (e) {
      log('Error: $e');
    }
  }

  void initialConnect() async {
    const walletConnectionSource = {
      "universalUrl": 'https://app.tonkeeper.com/ton-connect',
      "bridgeUrl": 'https://bridge.tonapi.io/bridge'
    };

    final universalLink = await connector.connect(walletConnectionSource);

    if (!await launchUrl(Uri.parse(universalLink))) {
      throw Exception('Could not launch $universalLink');
    }

    connector.onStatusChange((walletInfo) async {
      dynamic nfts = await getNFTItems(walletInfo.account.address);
      if (!mounted) return;
      if (nfts["nft_items"].length == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const IsNotTokenPage()));
      } else {
        var purchase = 0;
        var investor = 0;
        for (int i = 0; i < nfts["nft_items"].length; i++) {
          if (nfts["nft_items"][i]["metadata"]["content_url"] ==
              "https://arweave.net/FY9fWCBo2ec-coYEZ1-p-JujNS_Ny3NiAoP2cuw09cQ") {
            purchase += 1;
          } else {
            investor += 1;
          }
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ExplorerPage(investor: investor, purchase: purchase)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/background.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
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
              ),
              const Text(
                  "Gaming NFT on the TON blockchain\n\nCrowdfunding collection",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB60A0A)),
                  textAlign: TextAlign.center),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset("assets/img/lemarchand.png", width: 300, height: 300)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff240606),
                        side: const BorderSide(
                            width: 3.0, color: Color(0xffB60A0A)),
                      ),
                      onPressed: initialConnect,
                      child: const Text("Connect Tonkeeper",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xffB60A0A),
                              fontSize: 18),
                          textAlign: TextAlign.center)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 200),
                child: Text(
                    "The ancient demons will come to you, and you will shit yourself from the fear, pain and pleasure they will bring you. But to do this you just need to complete the puzzle. What you get depends on what configuration of the box you end up building.",
                    style: TextStyle(
                        color: Color(0xffB60A0A), fontWeight: FontWeight.w300, fontSize: 20),
                    textAlign: TextAlign.center)
              ),
            ],
          ),
        )),
      ),
    ));
  }
}
