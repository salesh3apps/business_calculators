import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'dart:ui';
import 'dart:math';

class mirr extends StatefulWidget {
  @override
  mirrState createState() => mirrState();
}

class mirrState extends State<mirr> {
  double ivalue = 0;
  double discount = 0;
  double finance = 0;
  int numyears = 0;
  bool _saved = false;
  bool _noValue = false;
  num MIRR = 0;
  int year1 = 0;
  int year2 = 0;
  int year3 = 0;
  int year4 = 0;
  int year5 = 0;
  int year6 = 0;
  int year7 = 0;
  int year8 = 0;
  int year9 = 0;
  int year10 = 0;

  TextEditingController ivController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController financeController = TextEditingController();
  TextEditingController y1Controller = TextEditingController();
  TextEditingController y2Controller = TextEditingController();
  TextEditingController y3Controller = TextEditingController();
  TextEditingController y4Controller = TextEditingController();
  TextEditingController y5Controller = TextEditingController();
  TextEditingController y6Controller = TextEditingController();
  TextEditingController y7Controller = TextEditingController();
  TextEditingController y8Controller = TextEditingController();
  TextEditingController y9Controller = TextEditingController();
  TextEditingController y10Controller = TextEditingController();

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
    text: TextSpan(text: 'The Modified Internal Rate of Return (MIRR) measures the attractiveness of an investment and can be used to compare different investments. The MIRR is a modification of the internal rate of return (IRR) formula that resolves some issues associated with that financial measure.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'The Modified Internal Rate of Return (MIRR) assumes that positive cash flows are reinvested at the reinvestment rate and that negative cash flows are financed at the financing cost. '
    'The formula used to calculate is MIRR = (Sum of the Future Value of Positive Cash Flows/(Intitial Investment - Sum of the Present Value of Negative Cash Flows))^(1/number of years) - 1.', style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("MIRR",
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:24.0,
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
    ivalue = 0;
    discount = 0;
    finance = 0;
    year1 = 0;
    year2 = 0;
    year3 = 0;
    year4 = 0;
    year5 = 0;
    year6 = 0;
    year7 = 0;
    year8 = 0;
    year9 = 0;
    year10 = 0;
    MIRR = 0;
    num posAns = 0;
    num negAns = 0;
    int numYears = 0;

    if (ivController.text != "") {
      ivalue = double.parse(ivController.text);
    }
    if (discountController.text != "") {
      discount = double.parse(discountController.text)/100;
    }
    if (financeController.text != "") {
      finance = double.parse(financeController.text)/100;
    }
    if (y1Controller.text != "") {
      year1 = int.parse(y1Controller.text);
      numYears = numYears + 1;
    }
    if (y2Controller.text != "") {
      year2 = int.parse(y2Controller.text);
      numYears = numYears + 1;
    }
    if (y3Controller.text != "") {
      year3 = int.parse(y3Controller.text);
      numYears = numYears + 1;
    }
    if (y4Controller.text != "") {
      year4 = int.parse(y4Controller.text);
      numYears = numYears + 1;
    }
    if (y5Controller.text != "") {
      year5 = int.parse(y5Controller.text);
      numYears = numYears + 1;
    }
    if (y6Controller.text != "") {
      year6 = int.parse(y6Controller.text);
      numYears = numYears + 1;
    }
    if (y7Controller.text != "") {
      year7 = int.parse(y7Controller.text);
      numYears = numYears + 1;
    }
    if (y8Controller.text != "") {
      year8 = int.parse(y8Controller.text);
      numYears = numYears + 1;
    }
    if (y9Controller.text != "") {
      year9 = int.parse(y9Controller.text);
      numYears = numYears + 1;
    }
    if (y10Controller.text != "") {
      year10 = int.parse(y10Controller.text);
      numYears = numYears + 1;
    }

    if (ivalue > 0 && discount > 0 && finance > 0 && numYears > 0) {
      print("Values Submitted");
      if (year1 > 0){
        posAns = year1 * pow((1 + discount), numYears - 1);
      }
      else if (year1 < 0){
        negAns = year1/(1 + finance);
      }
      if (year2 > 0){
        posAns = posAns + year2 * pow((1 + discount), numYears - 2);
      }
      else if (year2 < 0){
        negAns = negAns + year2/pow((1 + finance), 2);
      }
      if (year3 > 0){
        posAns = posAns + year3 * pow((1 + discount), numYears - 3);
      }
      else if (year3 < 0){
        negAns = negAns + year3/pow((1 + finance), 3);
      }
      if (year4 > 0){
        posAns = posAns + year4 * pow((1 + discount), numYears - 4);
      }
      else if (year4 < 0){
        negAns = negAns + year4/pow((1 + finance), 4);
      }
      if (year5 > 0){
        posAns = posAns + year5 * pow((1 + discount), numYears - 5);
      }
      else if (year5 < 0){
        negAns = negAns + year5/pow((1 + finance), 5);
      }
      if (year6 > 0){
        posAns = posAns + year6 * pow((1 + discount), numYears - 6);
      }
      else if (year6 < 0){
        negAns = negAns + year6/pow((1 + finance), 6);
      }
      if (year7 > 0){
        posAns = posAns + year7 * pow((1 + discount), numYears - 7);
      }
      else if (year7 < 0){
        negAns = negAns + year7/pow((1 + finance), 7);
      }
      if (year8 > 0){
        posAns = posAns + year8 * pow((1 + discount), numYears - 8);
      }
      else if (year8 < 0){
        negAns = negAns + year8/pow((1 + finance), 8);
      }
      if (year9 > 0){
        posAns = posAns + year9 * pow((1 + discount), numYears - 9);
      }
      else if (year9 < 0){
        negAns = negAns + year9/pow((1 + finance), 9);
      }
      if (year10 > 0){
        posAns = posAns + year10 * pow((1 + discount), numYears - 10);
      }
      else if (year10 < 0){
        negAns = negAns + year10/pow((1 + finance), 10);
      }

      MIRR = (pow(posAns/(ivalue - negAns), 1/numYears) - 1) * 100;
      print(posAns.toStringAsFixed(2));
      print(negAns.toStringAsFixed(2));
      setState(() {
        _saved = true;
        _noValue = false;
      });
    }
    else{
      print("Value missing.");
      setState(() {
        _noValue = true;
        _saved = false;
      });
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, textStyle: const TextStyle(fontSize: 20));

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modified IRR',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Modified IRR', style: new TextStyle(
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
                  child: Text('Initial Investment ', style: TextStyle(fontSize: 20.0),),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: TextField(
                          controller: ivController,
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
                      child: Text('Reinvestment Rate ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        children: <Widget>[
                        Container(
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: discountController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                          Text (' %', style: TextStyle(fontSize: 20.0),),
                      ],),
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
                      child: Text('Finance Rate ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 30,
                            child: TextField(
                                controller: financeController,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                )
                            ),
                          ),
                          Text (' %', style: TextStyle(fontSize: 20.0),),
                        ],),
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
                      child: Text('Cash Flow', style: TextStyle(fontSize: 24.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 24.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('   Year 1 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y1Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 2 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y2Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 3 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y3Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 4 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y4Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 5 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y5Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 6 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y6Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 7 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y7Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 8 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y8Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 9 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y9Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                      child: Text('   Year 10 ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 30,
                        child: TextField(
                            controller: y10Controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
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
                          child: Text('Modified IRR: ' + MIRR.toStringAsFixed(2) + '%', style: TextStyle(fontSize: 16.0, color: Colors.red),
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
