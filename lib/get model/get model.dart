import 'dart:convert';

import 'package:apiid/get%20model/get%20id%20method.dart';
import 'package:apiid/get%20model/product%201.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class product extends StatefulWidget {
  const product({super.key});

  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {
  Future<List<Product>> fetch() async {
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Product.fromJson(e)).toList();
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
                    List<Product> list = snapshot.data!;
                    return Container(
                      height: 800,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return GestureDetector(onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>getid(id:list[index].id!,) ));
                            },
                              child: ListTile(
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
                                    Text(list[index].rating!.count.toString()),
                                    Text(list[index].rating!.rate.toString()),
                                  ],
                                ),
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

