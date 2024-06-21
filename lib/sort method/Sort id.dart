import 'dart:convert';

import 'package:apiid/sort%20method/product%202.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class sort extends StatefulWidget {
  final int price;
  const sort({super.key,required this.price});

  @override
  State<sort> createState() => _sortState();
}

class _sortState extends State<sort> {
  Future<List<Sort>> fetch() async {
    final int price = widget.price;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=2"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Sort.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            FutureBuilder(
                future: fetch(),
                builder: (BuildContext context, snapshot){
                  if(snapshot.hasData){
                    List<Sort> list = snapshot.data!;
                    return Container(
                      height: 800,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              leading: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(list[index].image!),fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Text(list[index].id!.toString()),
                                  Text(list[index].title!.toString()),
                                  Text(list[index].category!.toString()),
                                  Text(list[index].description!.toString()),
                                  Text(list[index].price!.toString()),

                                  Text(list[index].rating!.toString()),
                                ],
                              ),
                            );
                          }
                      ),
                    );
                  } else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
            )
          ],
        )
    );
  }
}
