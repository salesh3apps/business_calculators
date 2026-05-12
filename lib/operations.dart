import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'dart:ui';

class operations extends StatefulWidget {
  @override
  operationsState createState() => operationsState();
}

class operationsState extends State<operations> {
  bool _saved = false;
  bool _noValue = false;
  double costgoods = 0;
  double expenses = 0;
  double sales = 0;
  double inventory = 0;
  double assets = 0;
  double accountsrec = 0;
  double equity = 0;
  double operating = 0;
  double inventoryturnover = 0;
  double assetturnover = 0;
  double averagecollection = 0;
  double equityturnover = 0;

  TextEditingController costgoodsController = TextEditingController();
  TextEditingController assetsController = TextEditingController();
  TextEditingController inventoryController = TextEditingController();
  TextEditingController salesController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  TextEditingController equityController = TextEditingController();
  TextEditingController accountsrecController = TextEditingController();

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
    text: TextSpan(text: 'Operating Ratios measure a company\'s operational efficiency. Tracking the operating ratio over a period of time helps identify trends in operational efficiency or inefficiency.'
        ' Inventory Turnover measures the liquidity of a company\'s inventory. Total Asset Turnover measures the efficiency of a company in using it\'s total assets.'
        ' Average Collection Period is the mean amount of time for a company to collect it\'s accounts recieivables. Equity Multiplier measures the portion of total assets purchased through equity.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'These entries will calculate the Operating Ratio, Inventory Turnover, Total Asset Turnover, Average Collection Period, and Equity Multiplier. The formulas used to calculate these ratios are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Operating Ratio = (cost of goods sold + operaring expenses) ÷ annual sales\n'
            'Inventory Turnover = cost of goods sold ÷ inventory\n'
            'Total Asset Turnover = annual sales ÷ total assets\n'
            'Average Collection Period = accounts receivable ÷ (annual sales ÷ 365)\n'
            'Equity Multiplier = total assets ÷ shareholder equity',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("Operating",
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
    inventory = 0;
    assets = 0;
    sales = 0;
    expenses = 0;
    equity = 0;
    costgoods = 0;
    accountsrec = 0;
    inventoryturnover = 0;
    assetturnover = 0;
    averagecollection = 0;
    equityturnover = 0;

    if (costgoodsController.text != "") {
      costgoods = double.parse(costgoodsController.text);
    }
    if (assetsController.text != "") {
      assets= double.parse(assetsController.text);
    }
    if (inventoryController.text != "") {
      inventory = double.parse(inventoryController.text);
    }
    if (salesController.text != "") {
      sales = double.parse(salesController.text);
    }
    if (expenseController.text != "") {
      expenses = double.parse(expenseController.text);
    }
    if (equityController.text != "") {
      equity = double.parse(equityController.text);
    }
    if (accountsrecController.text != "") {
      accountsrec = double.parse(accountsrecController.text);
    }

    if (costgoods == 0 || expenses == 0 || sales == 0) {
      print("Values missing.");
      setState(() {
        _saved = false;
        _noValue = true;
      });
    }
    else{
      print("Values Submitted");
      if (costgoods > 0 && sales > 0) {
        operating = (costgoods + expenses )/ sales;
      }
      if (costgoods > 0 && inventory > 0) {
        inventoryturnover = costgoods / inventory;
      }
      if (sales > 0 && assets > 0) {
        assetturnover = sales / assets;
      }
      if (accountsrec > 0 && sales > 0) {
        averagecollection = accountsrec / (sales / 365);
      }
      if (equity > 0 && assets > 0) {
        equityturnover = assets / equity;
      }
      setState(() {
        _saved = true;
        _noValue = false;
      });
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, textStyle: const TextStyle(fontSize: 20));

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Operating Ratios',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Operating Ratios', style: new TextStyle(
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
                      child: Text('Cost of Goods ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: costgoodsController,
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
                      child: Text('Operating Expenses ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: expenseController,
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
                  child: Text('Inventory Value ', style: TextStyle(fontSize: 20.0),),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      width: 100,
                      height: 32,
                      child: TextField(
                          controller: inventoryController,
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
                      child: Text('Annual Sales ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: salesController,
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
                      child: Text('Total Assets ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: assetsController,
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
                      child: Text('Accounts Receivable  ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child:  Container (
                        width: 100,
                        height: 32,
                        child: TextField(
                            controller: accountsrecController,
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
                      child: Text('Shareholder Equity  ', style: TextStyle(fontSize: 20.0),),
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
                          child: Text('Operating Ratio: ' + operating.toStringAsFixed(3) + '\nInventory Turnover: ' + inventoryturnover.toStringAsFixed(3) + '\nTotal Asset Turnover: ' + assetturnover.toStringAsFixed(3) + '\nAverage Collection Period: ' + averagecollection.toStringAsFixed(1) + ' days\nEquity Multiplier: ' + equityturnover.toStringAsFixed(2), style: TextStyle(fontSize: 16.0, color: Colors.red),
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
