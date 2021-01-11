import 'package:flutter/material.dart';
import 'package:test_app/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController url_tec = TextEditingController();
  TextEditingController count_tec = TextEditingController();
  final emptySnackBar = SnackBar(content: Text('Заполните все поля'));
  final urlSnackBar = SnackBar(content: Text('Url не верен'));
  final countSnackBar = SnackBar(content: Text('Число должно быть от 3 до 5'));
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RegExp regExp = new RegExp(
    r"(https?:\/\/.*\.(?:png|jpg|jpeg|gif|png|svg))",
    caseSensitive: false,
    multiLine: false,
  );

  @override
  void dispose() {
    url_tec.dispose();
    count_tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('1 экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.url,
                controller: url_tec,
                decoration: InputDecoration(
                  labelText: "Введите url картинки",
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: count_tec,
                decoration: InputDecoration(
                  labelText: "Введите число от 3 до 5",
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('2 экран'),
                onPressed: (){
                  if(url_tec.text.isEmpty || count_tec.text.isEmpty){
                    _scaffoldKey.currentState.showSnackBar(emptySnackBar);
                  } else {
                    if(!regExp.hasMatch(url_tec.text)){
                      _scaffoldKey.currentState.showSnackBar(urlSnackBar);
                    } else if(int.parse(count_tec.text) < 6 && int.parse(count_tec.text) > 2){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage(url: url_tec.text, count: int.parse(count_tec.text),)));
                    } else {
                      _scaffoldKey.currentState.showSnackBar(countSnackBar);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
