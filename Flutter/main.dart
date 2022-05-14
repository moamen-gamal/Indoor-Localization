import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:math' as math;
//import 'dart:async';
//import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io/socket_io.dart';
import 'package:path/path.dart' as Path;
//import 'dart:html';



import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;

fetchdata(String url)
async {

http.Response response=await http.get(Uri.parse(url));
return response.body;

}


sendData(String url)
async{

  http.Response response=await http.post(Uri.parse(url),body: convert.json.encode({'name':'Forward'}));
  return  convert.json.decode(response.body) ;

}


sendData2(String url)
async{

  http.Response response2=await http.post(Uri.parse(url),body: convert.json.encode({'name':'Backword'}));
  return  convert.json.decode(response2.body) ;

}




var theone= const Icon(Icons.access_alarm_rounded,color: Colors.green);
int Alpha=1;
int WhereAmI=0;
double OpacityLevel=1.0;
abstract class FirebaseService {
  final Dio dio;

  FirebaseService(this.dio);

  Future<bool> onBlink();
}


//import 'dart:async';


//final channel = WebSocketChannel.connect(
//Uri.parse('ws://192.168.1.5:5050/'),
//);







String Hello220='';
class BlinkService extends FirebaseService {
  BlinkService(Dio dio) : super(dio);

  bool isBliked = false;

  @override
  Future<bool> onBlink() async {
  //  final response = await dio.put(
    //    'https://flutter-arduino-e9560-default-rtdb.firebaseio.com/.json',
      //  data: {'isBlinked': '$isBliked'});
    var Response =await dio.get('https://espdemo42-default-rtdb.firebaseio.com/');
    print(Response);
    return true;
    //if (response.statusCode == HttpStatus.ok) {
      //isBliked = !isBliked;
      //return true;
    //} else {
      //return false;
    //}
  }
}





final blinkService = BlinkService(
    Dio(
      BaseOptions(
        baseUrl:
        'https://flutter-arduino-e9560-default-rtdb.firebaseio.com/.json',
      ),
    ));







class DatabaseCollection
{

  //Collection refrence in our database
  final CollectionReference untitledCollection= FirebaseFirestore.instance.collection('SensorData');

  final String s;

  DatabaseCollection(this.s);
  Future updateTheDatabase(int Sensor1_Value,int Sensor2_Value)
  async{
    return await untitledCollection.doc(s).set({
      'Sensor1_Value':Sensor1_Value,
      'Sensor2_Value':Sensor2_Value,
    });
  }
}

double M=5.0;

final List<double> yValues = [
  1.3,
  1,
  1.8,
  1.5,
  2.2,
  1.8,
  3,
];


double K=0;
int Floor=0;
Stream<DocumentSnapshot<Map<String, dynamic>>>documentStream = FirebaseFirestore.instance.collection('SensorData').doc('Hello77').snapshots();
Future<void> main()
async {

  print('rr');
  var data=await fetchdata('http://192.168.1.4:8000/api?');
  print((data));
  //var R= await sendData('http://172.28.130.134:5000/name?') as Map <String, dynamic>;
  //String K=convert.jsonDecode(R);
  print('Ohmymy');
  //print(R['name']);







  // var io = new Server();
  // var nsp = io.of('/some');
  //nsp.on('connection', (client) {
  // print('connection /some');
  // client.on('msg', (data) {
  //   print('data from /some => $data');
  //client.emit('fromServer', "ok 2");

  //});
  //});
  // io.on('connection', (client) {
  // print('connection default namespace');
  // client.on('msg', (data) {
  // print('data from default => $data');
  //client.emit('fromServer', "ok");
  //});
  //});
  //io.listen(5050);



/*
//reciever
  IO.Socket socket = IO.io('http://192.168.1.5:5050');
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', () => print());
*/


  runApp(Esp());



  var time = const Duration(seconds: 2);
  var time2 = const Duration(seconds: 1);
  var data77;
  var data779;
  String KKL="";
  String datam="";
  http.Response response;
  http.Response responseLong;

  var client ;
  int K=0;
  Timer.periodic(time2, (timer)async =>{
    K++,
    if(K%2==0)
      {OpacityLevel= 0,}
    else
      {
        OpacityLevel= 1,
      }
    ,
    runApp(Esp())
  });


  Timer.periodic(time, (timer)async =>
  {

    if(Alpha==1){
      if(K > 2){
        K = 0,
        client = http.Client(),
        response =
        await client.get(Uri.parse('http://192.168.1.4:8000/api?')),
        data77 = await response.body,
        datam = data77,
        //data=await fetchdata('http://192.168.1.4:8000/api?'),

        if(Floor >= datam.length - 1)
          {
            Floor = datam.length - 1,

          },
        if(Floor <= 0)
          {
            Floor = 0,

          },
        //WhereAmI = convert.jsonDecode(data77),
        WhereAmI = convert.jsonDecode(datam[Floor]),

/*
      responseLong =
      await client.get(Uri.parse('http://172.28.131.70:5000/sendLastReadings?')),
      data779 = await responseLong.body,


      KKL = convert.jsonDecode(data779),
*/


      },
      print('Ohmymy'),
      print(data77),


      print('Ohmymy2'),
      print(WhereAmI),
      // print(KKL),
      client.close(),


/*
//print(documentStream);
//AsyncSnapshot<QuerySnapshot> snapshot;
    Firebase.initializeApp(),
    documentStream.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      print(data);
//print(data['Sensor2_Value']);
    }).toList(),
*/

    },


  runApp(Esp())
  }
  );

}

/*
class MM extends StatefulWidget {
  const MM({Key? key}) : super(key: key);

  @override
  _MMState createState() => _MMState();
}

class _MMState extends State<MM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 */
class Esp2 extends StatefulWidget {
  const Esp2({Key? key}) : super(key: key);

  @override
  _Esp2State createState() => _Esp2State();
}

class _Esp2State extends State<Esp2> {
  @override
  Widget build(BuildContext context) {
    return MM();
  }
}


class Esp  extends StatelessWidget {
  @override
  void initState()
  {
    getData2();

  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp( theme: ThemeData.dark(),debugShowCheckedModeBanner: false,
      home: MM(),
    );
  }
}


//////////////////////////////////////////////////////'/
double z=10;
class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    color: const Color(0xff020227),
    child: Padding(
      padding: const EdgeInsets.only(top: 16),
      child: LineChartWidget(),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: Text("Temperature & pressure Control", style: TextStyle(fontSize: 15, color: Colors.blueAccent)), centerTitle: true,backgroundColor: Colors.white, ),
        body:
        Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 45),
                child: LineChartPage()),
            Container(
              width: 250,height: 45,margin: EdgeInsets.only(left: 200),
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: getcolor(Colors.white,Colors.amber),
                ),
                onPressed: ()=>Draw(),
                child: const Text('Temperature'),

              ),
            ),
            Container(
              width: 250,height: 45,margin: EdgeInsets.only(right: 215),
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: getcolor(Colors.white,Colors.amber),
                ),
                onPressed: ()=>Draw(),
                child: const Text('Pressure',style: TextStyle(color:Colors.black),),
              ),
            )


          ],
        ),





      );
}

void Draw() {

}

MaterialStateProperty<Color> getcolor(Color color, Color colorPressed) {
  final getcolor=(Set<MaterialState> states)
  {
    if(states.contains(MaterialState.pressed))
    {

      return colorPressed;
    }
    else
      return color;

  };

  return MaterialStateProperty.resolveWith(getcolor);

}





class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      topTitles: SideTitles(
        showTitles: true,
        reservedSize: -5,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return '';
            case 5:
              return '';
            case 8:
              return '';
          }
          return '';
        },

      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '';
            case 3:
              return '';
            case 5:
              return '';
          }
          return '';
        },
        reservedSize: 35,
        margin: 12,
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        margin:3,


      )


  );
}









class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(

      titlesData: LineTitles.getTitleData(),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots  :
          yValues.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble()+K, e.value);
          }).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    ),
  );
}
//MM instead of Homepage
class MM extends StatefulWidget {
  const MM({Key? key}) : super(key: key);

  @override
  _MMState createState() => _MMState();
}

class _MMState extends State<MM> {
  @override
  Widget build(BuildContext context) {
    List<double> Topers=[] ;
    List<double> Lefterss=[] ;


    ///////////////////////////////////////0





    /////////////////0


    ////////////////// 0 old 6
    double DoctorTamerHallTop=MediaQuery.of(context).size.height*0.6;
    double DoctorTamerHallLeft=MediaQuery.of(context).size.width*0.3;

    Topers.add(DoctorTamerHallTop) ;
    Lefterss.add(DoctorTamerHallLeft);
  //////////////////////4 old 1
    double LONGOutofLectureHallTop=MediaQuery.of(context).size.height*0.68;
    double LONGOutOfLectureHallLeft=MediaQuery.of(context).size.width*0.48;

    Topers.add(LONGOutofLectureHallTop) ;
    Lefterss.add(LONGOutOfLectureHallLeft);

    ////////////////////2 old 1
    double ElectricalLabTop=MediaQuery.of(context).size.height*0.5;
    double ElectricalLabLeft=MediaQuery.of(context).size.width*0.25;
    Topers.add(ElectricalLabTop) ;
    Lefterss.add(ElectricalLabLeft);

///////////////////////////3 old 0
    double UphighWayTop=MediaQuery.of(context).size.height*0.4;
    double UphighWayLeft=MediaQuery.of(context).size.width*0.47;
    Topers.add(UphighWayTop) ;
    Lefterss.add(UphighWayLeft);


    /////////////////////////////////4 old 2
    double OutofLectureHallTop=MediaQuery.of(context).size.height*1/3.5;
    double OutOfLectureHallLeft=MediaQuery.of(context).size.width*0.44;
    Topers.add(OutofLectureHallTop) ;
    Lefterss.add(OutOfLectureHallLeft);


/////////////////////////0






    /////////////////////////1



    //////////////////////////2


/*
    //////////////////////////3
    double HallTop=MediaQuery.of(context).size.height*0.2;
    double HallLeft=MediaQuery.of(context).size.width*0.46;
    Topers.add(HallTop) ;
    Lefterss.add(HallLeft);



    //////////////////////////////4


    //////////////5
    double LectureHallTop=MediaQuery.of(context).size.height*1/6.5;
    double LectureHallLeft=MediaQuery.of(context).size.width*2/3;
    Topers.add(LectureHallTop) ;
    Lefterss.add(LectureHallLeft);
*/







/////////////////6




    return Scaffold(
      appBar: AppBar(title: Text("Temperature & pressure Control", style: TextStyle(fontSize: 15, color: Colors.blueAccent)), centerTitle: true,backgroundColor: Colors.white,
      actions: [
        IconButton(onPressed: ()=>
        {

        Floor= Floor+1,

        }, icon:Icon(Icons.arrow_back),color: Colors.black),



        IconButton(onPressed: ()=>
        {

          Floor= Floor-1,
        }, icon:Icon(Icons.arrow_forward_sharp),color: Colors.black),

        IconButton(onPressed: ()=>
        {
          if(Alpha==0)
          {
            Alpha=1,
            theone= const Icon(Icons.access_alarm_rounded,color: Colors.green),
          }
          else if(Alpha==1)
          {

            Alpha=0,
           theone= const Icon(Icons.access_alarm_rounded,color: Colors.red),

          },

        }, icon:theone),


      ],

      ),
      body:
          //Transform.translate(offset: (double)-math.pi / 2)
     Stack(


      children: <Widget>[
        Container(
        child: Image(image: AssetImage('assets/Map.jpeg'),
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,


        ),
    ),
        Container(

          padding: EdgeInsets.only(top: Topers[WhereAmI],left: Lefterss[WhereAmI]),


          child:AnimatedOpacity(
            opacity: OpacityLevel,
            duration: const Duration(seconds: 1),
            child: ClipRRect(


              borderRadius: new BorderRadius.circular(40.0),
              child: Image.asset('assets/Red.png', height: 50, width: 50),
            ),
          ),

        ),

      ],
      ),

          /*
      Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 45),
              child: LineChartPage()),
          Container(
            width: 250,height: 45,margin: EdgeInsets.only(left: 200),
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: getcolor(Colors.white,Colors.amber),
              ),
              onPressed: ()async
              {

                Firebase.initializeApp();
                setState(()  {
                  yValues.add(4);
                  DatabaseCollection('Hello77').updateTheDatabase(10, 20);
                  print("Hello77");
                  Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream = FirebaseFirestore.instance.collection('SensorData').doc('Hello77').snapshots();
                  //print(documentStream);
                  //AsyncSnapshot<QuerySnapshot> snapshot;
                  documentStream.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  print(data);
                  //print(data['Sensor2_Value']);


                  }).toList();


                  ////////////////////////////////////////////////////Connect

                  final helloer = blinkService.onBlink();




                  //getData();
                  //getData2();


                  //channel.sink.add('asdasdassdqdwqwd');
                  //channel.sink.close(status.goingAway);

                });
                //z++;

              },
              child: const Text('Temperature'),

            ),
          ),
          Container(
            width: 250,height: 45,margin: EdgeInsets.only(right: 215),
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: getcolor(Colors.white,Colors.amber),
              ),
              onPressed: () async
              {
                setState(() {
                  yValues.add(5);
                  //createAlbum('5');
                  //getData();
                  print('HELLLLLLLLLLLLLLO1');
                  //getData2();
                  //getData2();
                  Firebase.initializeApp();
                  DatabaseCollection('Hello3').updateTheDatabase(10, 20);
                  Stream documentStream = FirebaseFirestore.instance.collection('SensorData').doc('Hello').snapshots();
                  print(documentStream.toString());


                  print('HELLLLLLLLLLLLLLO2');

                  //var encoded = utf8.encode('2');
                  //channel.sink.add('leaddasjdjkqaqsnd');
                  //channel.sink.close(status.goingAway);

                });

                //z++;

              },
              child: const Text('Pressure',style: TextStyle(color:Colors.black),),
            ),
          ),
          //StreamBuilder(
          //stream: channel.stream,
          //builder: (context, snapshot) {
          //return Text(snapshot.hasData ? '${snapshot.data}' : '');
          //},
          //),


        ],
      ),

      */





    );
  }
}


String name="1";
/////////////////////////////////



/*
Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('http://0.0.0.0:8090/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(<String, String>{
      'title': title,
    }),
  );
}

*/


int index=0;
Future getData2() async {
  String url = "http://127.0.0.1:55056/helloesp?ID="+index.toString();
  index++;
  http.Response response = await http.get(Uri.parse(url));
  //http.Response mm=await http.post(Uri.parse(url));

  //var data = convert.jsonDecode(response.body);
  print(response.body);
  //print(response.body[16]);

  //convert.base64Decode(response.body);


  //print("MMMMMMMMMMMMMMMMMMM");
  //print(data.toString());
  //String sensor1_data=data[1]['sensor_1'].toString();
  //double long2 = double.parse(sensor1_data);
  //createAlbum2();
  yValues.add(200);


  //print(sensor1_data);
  //return long2;
}

/*
Future<http.Response> createAlbum2() {
  return http.post(
    Uri.parse('https://225235.000webhostapp.com/get.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(<String, String>{
      'id': '2',
      'sensor_1':'5',
      'sensor_2':'20',
    }),
  );
}
*/