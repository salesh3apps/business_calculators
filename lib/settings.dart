import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

enum Availability { loading, available, unavailable }

class SettingsState extends State<Settings> {
  final Email email = Email(
    body: '',
    subject: 'Business Calculators',
    recipients: ['techsupport@h3apps.com'],
    isHTML: false,
  );

  final InAppReview inAppReview = InAppReview.instance;

  String _appStoreId = '';
  Availability _availability = Availability.loading;

  RichText disclaimer = new RichText(
    text: TextSpan(text: 'While this App uses accepted formulas, there is no assurance of the accuracy of the results. Any reliance you place on such material is therefore strictly at your own risk.',
      style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),

    ),);

  @override
  void initState() {
    super.initState();
    // (<T>(T? o) => o!) ensures that the following expression is not null for backwards compatibility.
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

 Future<void> _openStoreListing() => inAppReview.openStoreListing(
    appStoreId: _appStoreId,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Settings', style: new TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        body:
        Container(
          padding: const EdgeInsets.all(10.0),
          child:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text('', style: new TextStyle(fontSize: 16.0),),
                  ], ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Row(
                        children: <Widget>[
                        Icon(Icons.help, color: Colors.white),
                        Text(' CONTACT SUPPORT', style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,),),
                      ],),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                          ),
                          onPressed: () {
                            FlutterEmailSender.send(email);
                          },
                        ),
                      ],
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Text(' RATE APP', style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,),),
                            ],),
                        ],),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: _openStoreListing,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(' ', style: new TextStyle(fontSize: 24.0),),
                  ], ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(child: disclaimer)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),);
  }
}