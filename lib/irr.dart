import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'dart:ui';
import 'finance.dart';

class irr extends StatefulWidget {
  @override
  irrState createState() => irrState();
}

class irrState extends State<irr> {
  double ivalue = 0;
  double discount = 10;
  int numyears = 0;
  bool _saved1 = false;
  bool _noValue = false;
  double NPV = 0;
  double cashFlow = 0;
  double grossReturn = 0;
  num IRR = 0;
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
      _saved1 = false;
      _noValue = false;
    });
  }

  RichText info = new RichText(
    text: TextSpan(text: 'The Internal Rate of Return (IRR) is used to estimate the profitability of potential investments. IRR is a discount rate that makes the Net Present Value (NPV) of all cash flows equal to zero in a discounted cash flow analysis.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'The Internal Rate of Return (IRR) is the annual rate of growth that an investment is expected to generate over a period of time. '
            'IRR uses the same formula as the Net Present Value when it is set to 0. IRR finds the discount rate which makes the present value of the sum of annual cash flows equal to the initial net cash outlay for the investment. 0 = Sum from 0 to Number of Years of Cash Flow for the Year/(1 + Discount/100)^Year.',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("IRR",
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
    discount = 10;
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
    IRR = 0;

    List<num> flow = [];
    double sumYears = 0;

    if (ivController.text != "") {
      ivalue = double.parse(ivController.text);
    }
    if (discountController.text != "") {
      discount = double.parse(discountController.text);
    }
    if (y1Controller.text != "") {
      year1= int.parse(y1Controller.text);
      sumYears = sumYears + year1;
      flow.add(year1);
    }
    if (y2Controller.text != "") {
      year2= int.parse(y2Controller.text);
      sumYears = sumYears + year2;
      flow.add(year2);
    }
    if (y3Controller.text != "") {
      year3= int.parse(y3Controller.text);
      sumYears = sumYears + year3;
      flow.add(year3);
    }
    if (y4Controller.text != "") {
      year4= int.parse(y4Controller.text);
      sumYears = sumYears + year4;
      flow.add(year4);
    }
    if (y5Controller.text != "") {
      year5= int.parse(y5Controller.text);
      sumYears = sumYears + year5;
      flow.add(year5);
    }
    if (y6Controller.text != "") {
      year6= int.parse(y6Controller.text);
      sumYears = sumYears + year6;
      flow.add(year6);
    }
    if (y7Controller.text != "") {
      year7= int.parse(y7Controller.text);
      sumYears = sumYears + year7;
      flow.add(year7);
    }
    if (y8Controller.text != "") {
      year8= int.parse(y8Controller.text);
      sumYears = sumYears + year8;
      flow.add(year8);
    }
    if (y9Controller.text != "") {
      year9= int.parse(y9Controller.text);
      sumYears = sumYears + year9;
      flow.add(year9);
    }
    if (y10Controller.text != "") {
      year10= int.parse(y10Controller.text);
      sumYears = sumYears + year10;
      flow.add(year10);
    }

    cashFlow = sumYears - ivalue;
    grossReturn = (cashFlow / ivalue) * 100;
    if (cashFlow < 0){
      discount = -1 * discount;
    }

    print(ivalue.toString() + ' ' + year1.toString());
    if (ivalue > 0 && year1 != 0) {
      print("Values Submitted");
      IRR = internal_rate_of_return(flow, ivalue, discount/100);
      print(IRR.toStringAsFixed(3));
      setState(() {
        _saved1 = true;
        _noValue = false;
      });
    }
    else{
      print("Value missing.");
      setState(() {
        _noValue = true;
        _saved1 = false;
      });
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, textStyle: const TextStyle(fontSize: 20));

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internal Rate Return',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Internal Rate Return', style: const TextStyle(
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
                        visible: _saved1,
                        child: Center(
                          child: Text('Internal Rate of Return: ' + IRR.toStringAsFixed(2) + '%\nGross Return: ' + grossReturn.toStringAsFixed(2) + '%\nCash Flow: ' + cashFlow.toStringAsFixed(2), style: TextStyle(fontSize: 16.0, color: Colors.red),
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
