import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textToggleChange = "Toggle";
  String sliderSettingText = "Increment Value 5";

  String? incrementText;
  String buttonCountText = "Click me!";
  int count = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      count++;
      buttonCountText = "Clicked: $count";

      if (incrementText == null) {
        incrementText = "New text!";
      } else {
        incrementText = "someOtherText$count";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            const Tooltip(
              message: 'hint',
              child: Text('hi'),
            ),
            const Text(
              "This is cool! Pink Cute!",
              style: TextStyle(color: Color.fromARGB(1, 255, 61, 171)),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Cool!"),
                        content: const Text("Look at me!"),
                        actions: [
                          ElevatedButton(
                            child: const Text("Close!"),
                            onPressed: () {
                              // dismiss dialogue
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: const Text("More info!"),
            ),
            const TestComponent(prefix: "pink cute eris cute"),
            const RainbowText(text: "Rainbow!"),
            Center(child: Image.asset("images/taco.jpg")),
            const Text("Toggle false"),
            Switch(
              value: false,
              onChanged: (_) {},
            ),
            Text(textToggleChange),
            Switch(
              value: false,
              onChanged: (_) {
                setState(() {
                  textToggleChange = "Toggle $_"; // var name is actually _
                });
              },
            ),
            const Text("Text setting"),
            TextField(
              onChanged: (s) => print("Input! $s"),
            ),
            Slider(
              value: 1,
              onChanged: (v) {
                print("Increment value! $v");
                setState(() {
                  sliderSettingText = "Increment value: $v";
                });
              },
              min: 0.05,
              max: 2,
              // todo: increment amount?
            ),

            // todo: too lazy to change button text
            const Text("Dropdowns are cool!"),
            DropdownButton(
              items: ["value 1", "value 2", "some val", "value 3"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
            ),

            const Tooltip(
              message: "hinteee",
              child: Text("Hello from the other world!"),
            ),
            const Tooltip(
              message: "another hintee",
              child: Text("This is cooler!!"),
            ),

            ElevatedButton(
                onPressed: _incrementCounter, child: Text(buttonCountText)),

            Visibility(
              child: Text(incrementText ?? ""),
              visible: incrementText != null,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TestComponent extends StatelessWidget {
  final String prefix;

  const TestComponent({Key? key, required this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${prefix}Group 1"),
        Text("${prefix}Group 2"),
      ],
    );
  }
}

class RainbowText extends StatefulWidget {
  final String text;

  const RainbowText({Key? key, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RainbowTextState();
}

class RainbowTextState extends State<RainbowText>
    with SingleTickerProviderStateMixin {
  late Animation<Color> animation;
  late AnimationController controller;

  final Rainbow _rb = Rainbow(spectrum: const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
  ], rangeStart: 0.0, rangeEnd: 300.0);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = RainbowColorTween(_rb.spectrum).animate(controller)
      ..addListener(() {
        // Run an update
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: animation.value),
    );
  }
}
