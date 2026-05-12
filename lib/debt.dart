import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class debt extends StatefulWidget {
  @override
  debtState createState() => debtState();
}

class debtState extends State<debt> {
  bool _saved = false;
  bool _noValue = false;
  double currentlia = 0;
  double longlia = 0;
  double currentassets = 0;
  double longassets = 0;
  double equity = 0;
  double netincome = 0;
  double interest = 0;
  double taxes = 0;
  double debtratio = 0;
  double equityratio = 0;
  double interestratio = 0;

  TextEditingController cliaController = TextEditingController();
  TextEditingController lliaController = TextEditingController();
  TextEditingController cassetsController = TextEditingController();
  TextEditingController lassetsController = TextEditingController();
  TextEditingController equityController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController taxesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentItem();
  }


  setCurrentItem() async {
    setState(() {
      _saved = false;
      _noValue = false;
    });
  }



  RichText info = new RichText(
    text: TextSpan(text: 'Debt ratios measure the amount of leverage used by a company in terms of total debt to total assets or shareholder equity. Times Interest Earned Ratio '
        'measures a company\'s ability to make interest payments.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'These entries will calculate the Debt Ratio, Debt Equity Ratio, and the Times Interest Earned Ratio. The formulas used to calculate these ratios are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Debt Ratio = (current liabilities + long-term liabilities) ÷ (current assets + long-term assets)\n'
            'Debt Equity Ratio = (current liabilities + long-term liabilities) ÷ equity\n'
            'Times Interest Earned Ratio (TIER) = (net income + interest + taxes) ÷ taxes',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("Debt Ratios",
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:25.0,
            color: Colors.white,
          ),),
        centerTitle: true,
      ),

      content: Container(
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width * .9,
        child: Scrollbar(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: info
          ),),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  calctarget() async{
    currentlia = 0;
    longlia = 0;
    currentassets = 0;
    longassets = 0;
    equity = 0;
    netincome = 0;
    interest = 0;
    taxes = 0;
    equityratio = 0;
    interestratio = 0;

    if (cliaController.text != "") {
      currentlia = double.parse(cliaController.text);
    }
    if (lliaController.text != "") {
      longlia= double.parse(lliaController.text);
    }
    if (cassetsController.text != "") {
      currentassets= double.parse(cassetsController.text);
    }
    if (lassetsController.text != "") {
      longassets= double.parse(lassetsController.text);
    }
    if (equityController.text != "") {
      equity= double.parse(equityController.text);
    }
    if (incomeController.text != "") {
      netincome = double.parse(incomeController.text);
    }
    if (interestController.text != "") {
      interest = double.parse(interestController.text);
    }
    if (taxesController.text != "") {
      taxes = double.parse(taxesController.text);
    }


    if ((currentlia > 0 || longlia > 0) && (currentassets > 0 || longassets > 0)) {
      print("Values Submitted");
      debtratio = (currentlia + longlia) / (currentassets + longassets);
      if ( equity > 0) {
        equityratio = (currentlia + longlia) / equity;
      }
      if (taxes > 0){
        interestratio = (netincome + interest + taxes) / taxes;
      }
      print(debtratio.toStringAsFixed(2));
      print(equityratio.toStringAsFixed(2));
      print(interestratio.toStringAsFixed(2));
      setState(() {
        _saved = true;
        _noValue = false;
      });
    }
    else{
      print("Value missing.");
      setState(() {
        _saved = false;
        _noValue = true;
      });
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, textStyle: const TextStyle(fontSize: 20));

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debt Ratios',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Debt Ratios', style: new TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: new IconButton(
                icon: new Icon(Icons.info, color: Colors.white),
                iconSize: 40,
                onPressed: () {
                  showInfoDialog(context);
                },
              ),
            ),
          ],
        ),
        body:
        Container(
          padding: const EdgeInsets.all(10.0),
          child:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(170),
                1: FixedColumnWidth(150)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 10.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 10.0),),
                    ),
                  ],),
                TableRow(
                children: <Widget>[
                  TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text('Current Liabilites ', style: TextStyle(fontSize: 20.0),),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      width: 100,
                      height: 32,
                      child: TextField(
                          controller: cliaController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )
                      ),
                    ),
                  ),
                ],
              ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Long-Term Liabilites ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: lliaController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Current Assets ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: cassetsController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Long Term Assets ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: lassetsController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ], ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Shareholder Equity ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: equityController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ], ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Net Income ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: incomeController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ], ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Interest ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: interestController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ], ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 8.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 8.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Taxes  ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: taxesController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                    ),
                  ], ),
                ],
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(' ', style: TextStyle(fontSize: 24.0),),
                    ], ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: _saved,
                        child: Center(
                          child: Text('Debt Ratio: ' + debtratio.toStringAsFixed(3) + '\nDebt Equity Ratio: ' + equityratio.toStringAsFixed(3) + '\nTimes Interest Earned Ratio: ' + interestratio.toStringAsFixed(3), style: TextStyle(fontSize: 16.0, color: Colors.red),
                        ),
                        ),
                      ),
                      Visibility(
                        visible: _noValue,
                        child: Text('Value missing', style: TextStyle(fontSize: 16.0, color: Colors.red),
                        ),
                      ),
                    ], ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(' ', style: TextStyle(fontSize: 24.0),),
                    ], ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        calctarget();
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(' ', style: TextStyle(fontSize: 24.0),),
                  ], ),
              ],),
          ), ),
      ),
      );
  }
}
