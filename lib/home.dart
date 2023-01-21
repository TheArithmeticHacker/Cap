//@dart = 2.9
import 'package:cap_ph/main.dart';
import 'package:flutter/material.dart';



class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width*0.4,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                      'CAPSTONE GROUP: 10329',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    child: name('Mohamed Amer')
                  ),
                  SizedBox(
                    child: name('Tariq Alaa')
                  ),
                  SizedBox(
                    child: name('Mohamed Hany')
                  ),
                ]
                ),
            ],
          ),
        )
      );
  }
}


Widget name(String title){
  return SizedBox(
    width: 200,
    height: 50,
    child: Center(child: Text(title,))
  );
}