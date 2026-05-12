import 'package:business_calculators/depreciation.dart';
import 'package:business_calculators/liquidity.dart';
import 'package:business_calculators/operations.dart';
import 'package:business_calculators/profitability.dart';
import 'package:business_calculators/profitgoal.dart';
import 'package:business_calculators/sales.dart';
import 'package:business_calculators/stock.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'roi.dart';
import 'npv.dart';
import 'irr.dart';
import 'mirr.dart';
import 'debt.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      '/home': (context) => MyHomePage(),
      '/third': (context) => Settings(),
      '/fourth': (context) => debt(),
      '/fifth': (context) => liquidity(),
      '/sixth': (context) => operations(),
      '/seventh': (context) => profitability(),
      '/eighth': (context) => stock(),
      '/ninth': (context) => sales(),
      '/tenth': (context) => profitgoal(),
      '/eleventh': (context) => roi(),
      '/twelfth': (context) => npv(),
      '/thirteenth': (context) => irr(),
      '/fourteenth': (context) => mirr(),
      '/fifteenth': (context) => depreciaton(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash.png'),
            fit: BoxFit.cover
        ),

      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String catName = "";
  int catNum = 0;
  String solve= "";
  bool? info;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  String adID = "";

  final List<String> types = <String>['Debt Ratios', 'Liquidity Ratios', 'Operating Ratios', 'Profitability Ratios', 'Stock Ratios', 'Sales Margin, Markup, & Profit', 'Profit/Sales Goal', 'Return on Investment (ROI)', 'Net Present Value (NPV)', 'Internal Rate of Return (IRR)', 'Modified IRR (MIRR)', 'Depreciation'];
  final List<int> colorCodes = <int>[50, 100, 150, 200, 50, 100, 150, 200, 50, 100, 150, 200];
  final List page = ['/fourth', '/fifth', '/sixth', '/seventh', '/eighth', '/ninth', '/tenth', '/eleventh', '/twelfth', '/thirteenth', '/fourteenth', '/fifteenth'];


  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return 'ca-app-pub-3940256099942544/6300978111';
      return 'ca-app-pub-9664590269609351/8906058979';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9664590269609351/3985777851';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  setBoolPref(bool info, String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool(category, info);
    });
  }

  loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    info = (prefs.getBool('info') ?? false);
    if (info == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Navigator.pushNamed(context, '/second');
      });
      setBoolPref(true, 'info');
    }

    prefs.setString('AdID', bannerAdUnitId);
    adID = prefs.getString('AdID')!;
    _bannerAd = BannerAd(
      adUnitId: adID,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/home': (context) => MyHomePage(),
        '/third': (context) => Settings(),
        '/fourth': (context) => debt(),
        '/fifth': (context) => liquidity(),
        '/sixth': (context) => operations(),
        '/seventh': (context) => profitability(),
        '/eighth': (context) => stock(),
        '/ninth': (context) => sales(),
        '/tenth': (context) => profitgoal(),
        '/eleventh': (context) => roi(),
        '/twelfth': (context) => npv(),
        '/thirteenth': (context) => irr(),
        '/fourteenth': (context) => mirr(),
        '/fifteenth': (context) => depreciaton(),
      },
      title: 'Business Financial Calculators',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            iconSize: 40,
            onPressed: () => {
              Navigator.pushNamed(context, '/third'),
            },
          ),
          title: Text('Business Calcs', style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold)),

          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        body:
        SafeArea(
          child: Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: types.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: Colors.orange[colorCodes[index]],
                    title: Text('${types[index]}', style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.red),
                    onTap: () => {
                      Navigator.pushNamed(context, page[index]),
                    },
                  );
                },
              ),

            ],),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),);
  }
}
