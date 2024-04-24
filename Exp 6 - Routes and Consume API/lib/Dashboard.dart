import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var username;
  Map userdata = {};

  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments as Map;
    print(userdata);
    setState(() {
      username = userdata['name'];
    });

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "$username",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
              child: Text("Go to home"),
            ),
          ],
        ),
      ),
    );
  }
}
