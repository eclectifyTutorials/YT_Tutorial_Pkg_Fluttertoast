// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

GlobalKey globalKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(key: globalKey,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FToast fToast;

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(width: 12.0,),
        Text("This is a Custom Toast"),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(globalKey.currentState!.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Toast"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("With Context", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ElevatedButton(
              child: Text("Show Custom Toast"),
              onPressed: () {_showToast();},
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("Show Custom Toast via PositionedToastBuilder"),
              onPressed: () {_showBuilderToast();},
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("Custom Toast With Close Button"),
              onPressed: () {_showToastCancel();},
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("Queue Toasts"),
              onPressed: () {_queueToasts();},
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("Cancel Toast"),
              onPressed: () {_removeToast();},
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("Remove Queued Toasts"),
              onPressed: () {_removeAllQueuedToasts();},
            ),
            SizedBox(height: 40,),
            /// -------------- NO CONTEXT --------------
            Text("Without Context", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ElevatedButton(
              child: Text('Show Toast'),
              onPressed: showToast,
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text('Show Center Short Toast'),
              onPressed: showCenterShortToast,
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text('Show Top Short Toast'),
              onPressed: showTopShortToast,
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text('Show Colored Toast'),
              onPressed: showColoredToast,
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text('Cancel Toasts'),
              onPressed: cancelToast,
            ),
          ],
        ),
      ),
    );
  }

  void _showToast() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void _showBuilderToast() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(child: child, top: 16.0, left: 16.0,);
      },);
  }

  void _showToastCancel() {
    Widget toastWithButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("This is a Custom Toast This is a Custom Toast This is a "
                "Custom Toast This is a Custom Toast This is a Custom Toast This is a Custom Toast",
              softWrap: true,
              style: TextStyle(color: Colors.white,),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close,),
            color: Colors.white,
            onPressed: () {fToast.removeCustomToast();},
          )
        ],
      ),
    );
    fToast.showToast(
      child: toastWithButton,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 50),
    );
  }

  void _queueToasts() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void _removeToast() {
    fToast.removeCustomToast();
  }

  void _removeAllQueuedToasts() {
    fToast.removeQueuedCustomToasts();
  }

  /// ------- NO CONTEXT ---------
  void showToast() {
    Fluttertoast.showToast(
      msg: "This is Long Toast",
      toastLength: Toast.LENGTH_LONG,
      fontSize: 18.0,
    );
  }

  void showColoredToast() {
    Fluttertoast.showToast(
        msg: "This is Colored Toast with android duration of 5 Sec",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void showTopShortToast() {
    Fluttertoast.showToast(
        msg: "This is Top Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1);
  }

  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  void cancelToast() {
    Fluttertoast.cancel();
  }

}

