import 'package:flutter/material.dart';
import 'package:ta_setstate/models/Movie.dart';
import 'package:ta_setstate/services/MovieService.dart';
import 'package:readmore/readmore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MovCat - setState'),
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
  final MovieService _movieService = MovieService();
  Future<List<Movie>> _movieList;
  String dropdownValue = '1000';
  Color cardColor = Colors.white;
  Color titleColor = Colors.black;
  double themeFontSize = 10;
  String themeFontFamily = "Arial";
  List<double> imageSize = [100.0, 120.0];

  @override
  void initState() {
    super.initState();
    print("init");
    _movieList = getMovies(1000);
  }

  Future<List<Movie>> getMovies(int limit) async {
    print('getMovies');
    return await _movieService.readMovies(limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black45,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.title),
                  title: Text('Purple Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.title),
                  title: Text('Black Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('White Card'),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('Purple Card'),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text('Small Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: ListTile(
                  leading: Icon(Icons.format_size),
                  title: Text('Large Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: ListTile(
                  leading: Icon(Icons.text_format),
                  title: Text('Arial Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 7,
                child: ListTile(
                  leading: Icon(Icons.text_format),
                  title: Text('Roboto Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 8,
                child: ListTile(
                  leading: Icon(Icons.zoom_out),
                  title: Text('Small Picture'),
                ),
              ),
              PopupMenuItem<int>(
                value: 9,
                child: ListTile(
                  leading: Icon(Icons.zoom_in),
                  title: Text('Large Picture'),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Jumlah data:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      items: <String>['1000', '5000', '10000']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.right,
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          _movieList = getMovies(int.parse(newValue));
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: FutureBuilder(
                    future: _movieList,
                    builder: (context, snapshots) {
                      if (snapshots.hasError) {
                        return Text(
                            'Error while retrieving data from database');
                      } else if (snapshots.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (var i in snapshots.data)
                                Card(
                                  color: cardColor,
                                  elevation: 5,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          height: imageSize[1],
                                          width: imageSize[0],
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      i.image.toString()),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                i.title.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: titleColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)),
                                                  color: Colors.amber,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    i.genre.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: themeFontFamily,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              ReadMoreText(
                                                i.synopsis.toString(),
                                                trimLines: 2,
                                                colorClickableText: Colors.pink,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                                style:
                                                TextStyle(
                                                  fontSize: themeFontSize,
                                                  fontFamily: themeFontFamily,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          titleColor = Colors.purple;
        });
        break;
      case 1:
        setState(() {
          titleColor = Colors.black;
        });
        break;
      case 2:
        setState(() {
          cardColor = Colors.white;
        });
        break;
      case 3:
        setState(() {
          cardColor = Colors.purpleAccent;
        });
        break;
      case 4:
        setState(() {
          themeFontSize = 10;
        });
        break;
      case 5:
        setState(() {
          themeFontSize = 20;
        });
        break;
      case 6:
        setState(() {
          themeFontFamily = "Arial";
        });
        break;
      case 7:
        setState(() {
          themeFontFamily = "Roboto";
        });
        break;
      case 8:
        setState(() {
          imageSize = [100.0,120.0];
        });
        break;
      case 9:
        setState(() {
          imageSize = [120.0,140.0];
        });
        break;
    }
  }
}
