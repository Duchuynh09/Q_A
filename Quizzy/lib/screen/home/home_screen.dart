import 'package:flutter/material.dart';
import 'package:quizzy/auth/authManager.dart';
// import 'package:get/get.dart';
import 'package:quizzy/data/question.dart';
import 'package:quizzy/screen/quiz/quiz_manager.dart';
import 'package:quizzy/constants.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'category_header.dart';

// import 'package:font_awesome_flutter_example/icons.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchQuizzy;
  final typeQuest = [0, 1, 2, 3];
  final List<String> typeString = [
    'Triết học',
    'Kinh tế chính trị',
    'Lịch sử đảng',
    'Tư tưởng'
  ];
  List<IconData> iconCategory = [
    FontAwesomeIcons.bookBookmark,
    FontAwesomeIcons.bookBible,
    FontAwesomeIcons.bookJournalWhills,
    FontAwesomeIcons.bookOpenReader
  ];
  late List<Question> quests = context.read<QuestionController>().question;
  List<Question> matchQuest = [];
  @override
  void initState() {
    super.initState();
    _fetchQuizzy = context.read<QuestionController>().fetchQuizzys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('School Quiz'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Consumer<UserManager>(
              builder: (context, userManager, child) {
                return buildWelcome(userManager.userPlay.name);
              },
            ),
          ),
        ),
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
      body: FutureBuilder(
        future: _fetchQuizzy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(height: 8),
                  buildCategories(),
                  SizedBox(height: 32),
                ]);
          else
            return const Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  // ==================================================
  Widget buildWelcome(String username) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      );
  Widget buildCategories() => Container(
        padding: EdgeInsets.all(15),
        height: 400,
        child: GridView.builder(
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            final List<Question> typeMatch = [];
            quests.forEach((element) {
              if (element.type == index + 1) {
                typeMatch.add(element);
              }
            });
            matchQuest = [...typeMatch];
            return CategoryHeaderWidget(
                matchQuests: matchQuest,
                iconCategory: iconCategory[index],
                typeOption: typeString[index]);
          },
          // children: [
          //   CategoryHeaderWidget(),
          // ]),
        ),
      );

  // Widget buildPopular(BuildContext context) => Column(
  //       children: [
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             'Popular',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //         SizedBox(height: 16),
  //         Container(
  //           height: 240,
  //           child: ListView(
  //             physics: BouncingScrollPhysics(),
  //             scrollDirection: Axis.horizontal,
  //             children: categories
  //                 .map((category) => CategoryDetailWidget(
  //                       category: category,
  //                       onSelectedCategory: (category) {
  //                         Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (context) =>
  //                               CategoryPage(category: category),
  //                         ));
  //                       },
  //                     ))
  //                 .toList(),
  //           ),
  //         )
  //       ],
  //     );
// =====================================================
  Widget welcomeScreen() {
    return Stack(
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
                Text("Enter your informations below"),
                Spacer(), // 1/6
                TextField(
                  onChanged: (value) => setState(() {
                    // userName = value;
                  }),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1C2341),
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                Spacer(), // 1/6
                InkWell(
                  onTap: () {
                    // context.read<UserManager>().changeName(userName);
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
    );
  }
}
