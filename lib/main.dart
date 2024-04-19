import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultPost = "null";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Testing Fetching Post API'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                postData();
              },
              child: const Text('consultar post'),
            ),
            Text(resultPost),
          ],
        ),
      ),
    );
  }
  Future postData() async {
    var apiUrl = Uri.parse("http://190.12.79.135:8060/get/api/TradeMarketing/Get");
    var requestData = {
      "DateStart": "20240101",
      "DateFinish": "20240416"
    };
    var requestBody = json.encode(requestData);
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '/'
    };
    var response = await http.post(
      apiUrl,
      headers: headers,
      body: requestBody,
    );
    if (response.statusCode == 200) {
      setState(() {
        resultPost = response.body;
      });
    } else {
      setState(() {
        resultPost = "Error: ${response.statusCode} ${response.reasonPhrase}";
      });
    }
  }

}

