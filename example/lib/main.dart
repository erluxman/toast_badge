import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast_badge/toast_badge.dart';

StreamController<bool> isLightTheme = StreamController();

main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: isLightTheme.stream,
        builder: (context, snapshot) {
          return MaterialApp(
              theme: snapshot.data ? ThemeData.light() : ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  appBar: AppBar(title: Text("Toast Badge Example")),
                  body: ToastBadge(child: SettingPage())));
        });
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String userName = "Press Fetch User Button";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 1),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.blue,
                        child: Text("Light Theme",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          ToastBadge.show("Light Theme Applied",
                              mode: ToastMode.DEBUG);
                          isLightTheme.add(true);
                        }),
                    RaisedButton(
                        color: Colors.black,
                        child: Text("Dark Theme",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          ToastBadge.show("Dark Theme Applied",
                              mode: ToastMode.ERROR);
                          isLightTheme.add(false);
                        }),
                  ]),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () async {
                    var name = await getUserNameFromBackend();
                    setState(() {
                      userName = name;
                    });
                  },
                  child:
                      Text("Fetch User", style: TextStyle(color: Colors.white)),
                ),
              ).enableBadge(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("User Name : $userName"),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ));
  }
}

Future<String> getUserNameFromBackend() async {
  await Future.delayed(Duration(milliseconds: 400));
  var success = Random().nextInt(30) % 4 != 0;
  ToastBadge.show(
    success ? "User Fetch Success" : "User Fetch Failed",
    mode: success ? ToastMode.INFO : ToastMode.ERROR,
  );
  return success ? "Laxman Bhattarai" : "User Fetch Error";
}
