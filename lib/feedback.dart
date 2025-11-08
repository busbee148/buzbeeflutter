import 'package:buzbee/API/registerAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
   FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController Feedback=TextEditingController();
  List<dynamic> Bus = [];
  String? selectedBusId;
 Future <void>SentFeedback()async{
  
  final feedbacktext=Feedback.text;
 if (feedbacktext.isEmpty){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter your valuable feedback')));
  // return;
 }
  try {
    Response response= await dio.post('$baseurl/FeedbackAPI/$LID',
    data: {
      'BUS':selectedBusId,
      'Feedback': Feedback.text
    }
    ) ;
     if (response.statusCode==200 ||  response.statusCode==201) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('complaint sent successfully')));
        Feedback.clear();
     }
 } catch (e) {
   print(e);
 }

 }
 Future<void> _fetchBus() async {
    try {
      final response = await dio.get('$baseurl/ViewbusAPI');
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          Bus = response.data;
        });
      }
    } catch (e) {
      debugPrint('Error fetching buses: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBus();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("Feedback"),centerTitle: true,),
      body: Column(children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextFormField(decoration: InputDecoration(hintText: "Busname",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),),
        //   ),
        // ),

         DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.directions_bus, color: Colors.black12),
                hintText: "Select Bus",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              value: selectedBusId,
              items: Bus
                  .map<DropdownMenuItem<String>>(
                    (bus) => DropdownMenuItem(
                      value: bus['id'].toString(), // 👈 storing bus ID
                      child: Text('${bus['Busname']} - ${bus['Bus_NO']}' ),
                    ),
                     )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedBusId = value);
              },
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: Feedback,
            decoration: InputDecoration(hintText: "Feedback",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        ElevatedButton(onPressed: (){
          SentFeedback();
        }, child: Text("Submit"))
      ],),
    );
  }
}