import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class SecondPage extends StatefulWidget {

  var url;
  var count;


  SecondPage(
      {
        Key key,
        @required this.url,
        this.count,
      }
      )
      : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  var items = [
    'Товар №1',
    'Товар №2',
    'Товар №3',
    'Товар №4',
    'Товар №5',
  ];
  var prices = [
    10,
    15,
    20,
    25,
    30
  ];

  var counts = [
    0,
    0,
    0,
    0,
    0,
  ];

  var totalCount = 0;
  var totalPrice = 0;


  @override
  void initState() {
    print(widget.url);
    print(widget.count);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width/4*3,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Произвольный текст как заголовок',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Дополнительно',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.count,
                          itemBuilder: (context, index){
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 55,
                                  width: 55,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.url,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child:
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(items[index]),

                                    )
                                ),
                                Expanded(
                                  flex: 4,
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueGrey[50]
                                    ),
                                    height: 35,
                                    //width: MediaQuery.of(context).size.width/7,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: RaisedButton(
                                            elevation: 5,
                                            color: Colors.blueGrey[50],
                                            onPressed: (){
                                             setState(() {
                                               if (counts[index] != 0){
                                                 counts[index]--;
                                                 totalCount--;
                                                 totalPrice = totalPrice - prices[index];
                                               }
                                             });
                                            },
                                            shape: CircleBorder(),
                                            child: Text('-',),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(counts[index].toString(), textAlign: TextAlign.center,),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: RaisedButton(
                                            elevation: 5,
                                            color: Colors.white,
                                            padding: EdgeInsets.zero,
                                            onPressed: (){
                                              setState(() {
                                                if (counts[index] != 20){
                                                  counts[index]++;
                                                  totalCount++;
                                                  totalPrice = totalPrice + prices[index];
                                                }
                                              });
                                            },
                                            shape: CircleBorder(),
                                            child: Text('+'),
                                          ),
                                        ),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child:
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: Text('+' + prices[index].toString() + ' р.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),

                                      ),
                                    )
                                ),
                              ],
                            );
                          }),
                      Container(
                        padding: EdgeInsets.only(bottom: 50),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey[50],
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: DottedDecoration(
                    shape: Shape.box,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text('Дополнительно',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('x' + '$totalCount',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('$totalPrice' + ' р.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ],
      )
    );

  }
}
