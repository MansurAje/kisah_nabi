import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:http/http.dart' as http;

class Doa extends StatefulWidget {
  const Doa({super.key});

  @override
  State<Doa> createState() => _DoaState();
}

class _DoaState extends State<Doa> {
  late Future<List<String>> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = fetchData();
  }

  Future<List<String>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Center(
                      child: Text(snapshot.data![index]),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
              );
            }
          },
        ),
      ),
    );
  }
}
