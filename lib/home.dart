// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_api_three/model/user_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  Future<List<User>> getUsers() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        users.add(User.fromJson(i));
        print(users.length);
      }
      return users;
    } else {
      return users;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.2),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                            offset: Offset(0, 5),
                                          )
                                        ]),
                                    child: Text(
                                        snapshot.data![index].id.toString()),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Name: ${snapshot.data![index].name.toString()}'),
                                      Text(
                                          'Username: ${snapshot.data![index].username.toString()}'),
                                      Text(
                                          'Email: ${snapshot.data![index].email.toString()}'),
                                      Text(
                                          'Phone: ${snapshot.data![index].phone.toString()}'),
                                      Text(
                                          'street: ${snapshot.data![index].address.street.toString()}'),
                                      Text(
                                        'City: ${snapshot.data![index].address.city.toString()}',
                                      ),
                                      Text(
                                        'Company: ${snapshot.data![index].company.name.toString()}',
                                      ),
                                      Text(
                                        'Website: ${snapshot.data![index].website.toString()}',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
