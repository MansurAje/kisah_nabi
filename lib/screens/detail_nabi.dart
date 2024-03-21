import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class DetailNabi extends StatefulWidget {
  final String nbName;
  final String thnKelahiran;
  final String nbAge;
  final String nbDesc;
  final String nbImage;
  final String nbTmp;

  const DetailNabi({
    Key? key,
    required this.nbName,
    required this.thnKelahiran,
    required this.nbAge,
    required this.nbDesc,
    required this.nbImage,
    required this.nbTmp,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailNabiState createState() => _DetailNabiState();
}

class _DetailNabiState extends State<DetailNabi> {
  late WebViewPlusController controller;
  @override
  Widget build(BuildContext context) {
    // print("konten "+widget.nbTmp);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("View ${widget.nbName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(widget.nbDesc),
          ],
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // print("konten "+widget.nbTmp);
    });
  }
}
