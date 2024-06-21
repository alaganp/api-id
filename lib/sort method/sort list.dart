import 'dart:convert';

import 'package:apiid/sort%20method/Sort%20id.dart';
import 'package:apiid/sort%20method/product%202.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class sortlist extends StatefulWidget {
 final int a;
  const sortlist({super.key,required this. a});

  @override
  State<sortlist> createState() => _sortlistState();
}

class _sortlistState extends State<sortlist> {
  Future<List<Sort>> fetch() async {
   final int a = widget.a;

    var res = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=$a"));
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
                            return GestureDetector(onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>sort(price:list[index].id!,) ));
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

                                    Text(list[index].rating!.toString()),
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
