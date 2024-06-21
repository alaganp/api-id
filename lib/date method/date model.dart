import 'package:apiid/sort%20method/Sort%20id.dart';
import 'package:apiid/sort%20method/sort%20list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class date extends StatefulWidget {
  const date({super.key});

  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {
  final TextEditingController a = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             body: Column(children: [
               TextFormField(
                 controller: a,
                 decoration: InputDecoration(
                   hintText: 'enter limit'
                 ),
               ),SizedBox(height: 20,),
               ElevatedButton(onPressed: (){
                 int? limit = int.tryParse(a.text); // Parse text input to int
                 if (limit != null) {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => sortlist(a: limit)),
                   );
                 }
               }, child: Text('okay'))
             ],),
    );
  }
}
