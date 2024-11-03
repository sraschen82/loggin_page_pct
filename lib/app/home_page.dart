
import 'package:flutter/material.dart';
import 'package:loggin_page_pct/app/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.amber,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(2.0),
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
        child: SizedBox.expand(
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(gradient: MyColors().gradientHomePage()),
                  child: SizedBox.expand(
                      child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // imageShimmerWidget(
                      //     'assets/image/home.jpg', 0, Alignment.center),
                      Card(
                        color: Colors.black.withOpacity(.2),
                        elevation: 20,
                        child: SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'HOME PAGE',
                              style: TextStyle(
                                  color: MyColors().titleColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // imageShimmerWidget(
                      //     'assets/image/logo02.png', 0, Alignment.bottomCenter),
                    ],
                  )),
                ),
              ),
              Flexible(
                flex: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      gradient: MyColors().gradientHomePage()),
                  child: SizedBox(
                      height: height,
                      width: width * .98,
                      child: const SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text('Home Page'),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
