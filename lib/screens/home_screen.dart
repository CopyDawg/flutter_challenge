import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import 'package:my_challenge_app/infrastructure/api_controller.dart';


class HomeScreen extends StatefulWidget{

  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> response = [];
  final TextEditingController _countryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football API'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/login'),
            padding: const EdgeInsets.only(right: 25),
            iconSize: 30,
          ),
        ],
      ),
      body:  Column(
        children: [
          
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
      
                const Text('Search teams by country',style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
      
                TextFormField(
                  controller: _countryTextController,
                  decoration:  const InputDecoration(
                    hintText: 'Country',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.sports_soccer),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
      
                const SizedBox(height: 20),

                ElevatedButton(
                    style: ElevatedButton.styleFrom( 
                      minimumSize: const Size(150, 40),
                      backgroundColor: Colors.white, 
                      foregroundColor: Colors.black, 
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1), 
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      List<Map<String, dynamic>> fetchedData = await fetchData(_countryTextController.text);
                      setState(() {
                        response = fetchedData;
                      });
                    },
                    child: const Text('SEARCH'),
                  ),

                  const SizedBox(height: 10),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: response.isEmpty
                ? const Text('No data available', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15))
                : ListView.builder(
                    itemCount: math.min(response.length, 10),
                    itemBuilder: (context, index) {
                      final team = response[index]['team'];
                      final venue = response[index]['venue'];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color.fromARGB(255, 92, 0, 0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${team['name'] ?? 'No data'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            Text('Founded: ${team['founded'] ?? 'No data'}'),
                            Image.network(
                              team['logo'] ?? 'https://media.api-sports.io/football/venues/11905.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 10),
                            Text('Stadium: ${venue['name'] ?? 'No data'}', textAlign: TextAlign.center),
                            Text('City: ${venue['city'] ?? 'No data'}'),
                            Container(
                              width: 100,
                              height: 76,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Image.network(
                                venue['image'] ?? 'https://media.api-sports.io/football/venues/11905.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            
                          ],
                        ),
                      );
                    },
                  ),
                
            ),
          )

        ]
      )
    );
  }
}