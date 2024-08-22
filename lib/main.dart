import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scan_and_get_images/screen/batch_reader/batch_reader.dart';
import 'package:scan_and_get_images/screen/batch_reader/logic/batch_reader_cubit.dart';
import 'package:scan_and_get_images/screen/nutraceuticals/logic/nutraceuticals_cubit.dart';
import 'package:scan_and_get_images/screen/nutraceuticals/nutraceuticals.dart';
import 'package:scan_and_get_images/screen/nutritional/logic/nutritional_cubit.dart';
import 'package:scan_and_get_images/screen/nutritional/nutritional.dart';
import 'package:scan_and_get_images/screen/product_hunt/product_hunt_form/logic/product_hunt_form_cubit.dart';
import 'package:scan_and_get_images/screen/product_hunt/product_hunt_form/product_hunt_form.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductHuntFormCubit()..historyRefresh(),
        ),
        // BlocProvider(
        //   create: (context) => HuntingStageCubit()..setImageList(),
        // ),
        BlocProvider(
          create: (context) => BatchReaderCubit()..checkDrugValue(),
        ),
        BlocProvider(
          create: (context) => NutraceuticalsCubit()..initLocalList(),
        ),
        BlocProvider(
          create: (context) => NutritionalCubit()..initLocalList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'OCR of Nutraceuticals & Batch reader '),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearCatch();
  }

  clearCatch() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: currentIndex == 0
          ? const NutraceuticalScreen()
          : currentIndex == 1
              ? const NutritionalScreen()
              : currentIndex == 2
                  ? BatchReaderScreen()
                  : ProductHunt(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.image_search_sharp,
              ),
              label: "Nutraceutical"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.propane_tank_rounded,
              ),
              label: "Nutritional"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.document_scanner_outlined,
              ),
              label: "Batch reader"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.precision_manufacturing,
              ),
              label: "Product Hunt"),
        ],
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
