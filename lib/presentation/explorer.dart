import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ExplorerPage extends StatefulWidget {
  final int purchase;
  final int investor;
  const ExplorerPage({super.key, required this.purchase, required this.investor});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    _iFrameElement.style.height = '100%';
    _iFrameElement.style.width = '100%';
    _iFrameElement.src =
        'https://gateway.irys.xyz/XpV8uyCzHxCzqXEGa1prPnC18RtDOYl4rT52abaMksg';
    _iFrameElement.style.border = 'none';

// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
    );

    super.initState();
  }

  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: _iframeWidget,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: widget.investor == 0 || widget.purchase == 0 ? Container() : Column(
                          children: <Widget>[
                            const Text("Your wallet contains:",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffB60A0A)),
                                textAlign: TextAlign.center),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff240606),
                                        side: const BorderSide(
                                            width: 3.0, color: Color(0xffB60A0A)),
                                      ),
                                      onPressed: null,
                                      child: Text("Purchase box – ${widget.purchase}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffB60A0A),
                                              fontSize: 18),
                                          textAlign: TextAlign.center)),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff240606),
                                        side: const BorderSide(
                                            width: 3.0, color: Color(0xffB60A0A)),
                                      ),
                                      onPressed: null,
                                      child: Text("Investor box – ${widget.investor}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffB60A0A),
                                              fontSize: 18),
                                          textAlign: TextAlign.center)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
