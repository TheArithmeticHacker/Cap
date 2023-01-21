//@dart = 2.9
import 'package:flutter/material.dart';
import 'ph.dart';
import 'temp.dart';
import 'home.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import './assets/my_flutter_app_icons.dart';
//import 'oldPh.dart';

var theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.yellow, 
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
  textTheme: const TextTheme(
    headline6: TextStyle(color: Colors.red)
  )
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController(initialPage: 1);
  void _onTap(int index)
  {
    setState(() {
      pageIndex = index;
    });
  }
  final bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.thermostat_outlined,),
      label: 'Temp',
      
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.ph),
      label: 'pH',
    ),
  ];
  static List<Widget> pages = <Widget> [ temp(), const Home(), ph()];
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Swam'pH'20",
            ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState((){pageIndex = newIndex;});
          },
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          iconSize: 20,
          items: bottomNavBarItems,
          currentIndex: pageIndex,
          onTap: (index){
            _pageController.animateToPage(index, duration:Duration(milliseconds: 500), curve: Curves.ease);
          }
        ),
      )
    );
  }
}


//Center(child: pages.elementAt(pageIndex))