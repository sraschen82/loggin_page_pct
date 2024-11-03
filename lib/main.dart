import 'package:flutter/material.dart';
import 'package:loggin_page_pct/app/app_colors.dart';
import 'package:loggin_page_pct/app/loggin/pages/switch_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(MyColors().titleColor))),
        iconTheme: const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Colors.white),
        textTheme: Typography(platform: TargetPlatform.android).white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 80,
          backgroundColor: Color.fromARGB(255, 1, 4, 34),
        ),
        cardColor: MyColors().paletteColor1,
        cardTheme: const CardTheme(
          elevation: 15,
        ),
        focusColor: Colors.black.withOpacity(.3),
        brightness: Brightness.dark,
        visualDensity: VisualDensity.comfortable,
        colorScheme: ColorScheme.dark(surface: MyColors().paletteColor1),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Loggin Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.blue, gradient: MyColors().gradientHomePage()),
          child: SizedBox(
              height: height,
              width: width,
              child:
                  const LoginSwitchPage() //const LoginPage(isRegisterPage: true),
              )),
    );
  }
}
