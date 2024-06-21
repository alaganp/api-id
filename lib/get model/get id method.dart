import 'dart:convert';

import 'package:apiid/get%20model/product%201.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class getid extends StatefulWidget {
  final int id;
  const getid({super.key,required this.id,});

  @override
  State<getid> createState() => _getidState();
}

class _getidState extends State<getid> {
  Future<Product> fetch() async {
    final int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));

    return  Product.fromJson(jsonDecode(res.body));
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
                            return ListTile(
                              leading: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.image!),fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Text(snapshot.data!.id!.toString()),
                                  Text(snapshot.data!.title!.toString()),
                                  Text(snapshot.data!.category!.toString()),
                                  Text(snapshot.data!.description!.toString()),
                                  Text(snapshot.data!.price!.toString()),
                                  Text(snapshot.data!.rating!.count.toString()),
                                  Text(snapshot.data!.rating!.rate.toString()),
                                ],
                              ),
                            );
                          }
                  else if(snapshot.hasError){
                    return Text(".error}");
                  }
                  return CircularProgressIndicator();
                }
            )
          ],
        )
    );
  }
}
