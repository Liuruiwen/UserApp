import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'account/controller/LoginController.dart';
import 'account/ui/LoginWidget.dart';


void main() async {
  // Add this line
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child:  LoginWidget(),
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _bloc = BlocProvider.of<LoginBloc>(context);

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX计数器'),
      ),
      body: Center(
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (_) => Text(
            LoginController.to.loginData?.customerAccount??"",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
         await LoginController.to.getLoginData("13333333333","123456","GY11156336987889");
        },
      ),
    );
  }
}
