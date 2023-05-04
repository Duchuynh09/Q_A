import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/constants.dart';

import '../../auth/authManager.dart';
import 'home_screen.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  late String userName;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('School Quiz'),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(80),
        //   child: Container(
        //     padding: EdgeInsets.all(16),
        //     alignment: Alignment.centerLeft,
        //     child: buildWelcome('Duc'),
        //   ),
        // ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(width: 12),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), //2/6
                  Text(
                    "Let's Play Quiz,",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Enter your informations below",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(), // 1/6
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.purple],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        userName = value;
                      }),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color.fromARGB(255, 247, 96, 174),
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: () {
                      context.read<UserManager>().changeName(userName);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Lets Start Quiz",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
