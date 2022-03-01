import 'package:flutter/material.dart';
import 'package:lx_tips/lx_tips.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lx Tips Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                  "String Tips",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: () {
                  Tips.of(context).show(content: "Normal String Tips.");
                }),
            MaterialButton(
                color: Colors.blue,
                child: const Text("Custom Tips",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: () {
                  Tips.of(context).show(
                      color: Colors.pink.withOpacity(0.5),
                      content: Row(
                        children: const [
                          Icon(Icons.face, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text("Custom Tips.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      ));
                })
          ],
        ),
      ),
    );
  }
}
