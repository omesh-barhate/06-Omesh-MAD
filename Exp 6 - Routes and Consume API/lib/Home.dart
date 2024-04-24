import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World!"),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(fontSize: 30),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: const Text(
              "Welcome to MAD Lab",
              style: TextStyle(
                  fontSize: 40, color: Colors.black, fontFamily: 'Tinos'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                      print("Logging in");
                    },
                    child: const Text("Click to login", style: TextStyle(
                      fontSize: 20
                    ),)
                ),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
