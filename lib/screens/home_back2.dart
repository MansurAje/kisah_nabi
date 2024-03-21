import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:kisah_nabi/screens/detail_nabi.dart';
import 'package:kisah_nabi/screens/doa.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  late PageController _pageController;

  // List of screens to navigate
  final List<Widget> _screens = [
    Home(),
    Doa(),
  ];

  final ScrollController _scrollController = ScrollController();
  int page = 1;
  List<dynamic> data = []; // List to hold the loaded data

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to load data from JSON file
  Future<void> _loadData() async {
    String jsonString = await rootBundle.loadString('assets/res/story.json');
    setState(() {
      data = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kisah Nabi & Rasul")),
      body: SingleChildScrollView(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: buildCard(context, index, data),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNabi(
                          nbName: data[index]["name"],
                          thnKelahiran: data[index]["thn_kelahiran"].toString(),
                          nbAge: data[index]["usia"].toString(),
                          nbDesc: data[index]["description"],
                          nbImage: data[index]["image_url"],
                          nbTmp: data[index]["tmp"],
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: data.length,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        //onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.list),
            title: const Text('Kisah'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.people),
            title: const Text('Doa'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.calendar_month),
            title: const Text(
              'Kalender ',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Setting'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  smallSentence(String bigSentence) {
    if (bigSentence.length > 80) {
      return '${bigSentence.substring(0, 80)}...';
    } else {
      return bigSentence;
    }
  }

  // buildCard function remains the same
  buildCard(contex, index, datas) {
    var nbName = datas[index]['name'];
    var thnKelahiran = datas[index]['thn_kelahiran'].toString();
    //var nbAge = datas[index]['usia'].toString();
    var nbDesc = smallSentence(datas[index]['description']);
    var nbImage = datas[index]['image_url'];
    //var cardImage = Image.asset("assets/images/news.png", fit: BoxFit.cover);

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(nbName),
              subtitle: Text(nbDesc),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                fit: BoxFit.cover,
                nbImage.toString(),
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset('assets/images/nabi.jpg');
                },
              ),
              //child: Image.network(nbImage.toString(), fit: BoxFit.cover),

              // child: Image.network('https://gpsmsg.prod1.novellpharm.com/assets/img/20230115_162658.jpg'),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(thnKelahiran),
            ),
          ],
        ));
  }
}
