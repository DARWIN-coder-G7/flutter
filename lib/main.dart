import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //declare variable and methods
  List data = [];
  //https://retool.com/api-generator
  //https://reqres.in/api/users?page=2
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://retoolapi.dev/jfRMEz/data"));
    print(res.statusCode);
    print(res.body.toString());

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  //end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                print("ADD BUTTOn");
                setState(() {
                  data += [
                    {
                      "id": data.length + 1,
                      "email": "george.edwards@reqres.in",
                      "first_name": "George",
                      "last_name": "Edwards",
                      "avatar": "https://reqres.in/img/faces/11-image.jpg"
                    }
                  ];
                });
              },
              icon: Icon(Icons.add_outlined)),
        ],
        title: Center(
          child: Text(
            "API <=> ListView",
            style: TextStyle(color: Colors.cyanAccent),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              width: double.infinity,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data[index]['logo']),
                  radius: 30,
                ),
                trailing: IconButton(
                    onPressed: () {
                      print("DELETE");
                      setState(() {
                        data.removeWhere(
                            (entry) => entry["id"] == data[index]['id']);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                title: Text(
                  data[index]['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data[index]['email'],
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
