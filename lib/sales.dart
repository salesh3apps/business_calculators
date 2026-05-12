import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'dart:ui';

class sales extends StatefulWidget {
  @override
  salesState createState() =>salesState();
}

class salesState extends State<sales> {
  bool _saved = false;
  bool _noValue = false;
  double margin = 0;
  double cost = 0;
  double profit = 0;
  double markup = 0;
  double revenue = 0;
  String choice = '';
  String choice1 = '';
  String choice2 = '';
  String label = '';
  String label1 = '';
  String label2 = '';
  double first = 0;
  double second = 0;
  String results = '';

  // Initial Selected Value
  String dropdownvalue = 'Cost and Revenue';

  // List of items in our dropdown menu
  var items = ['Cost and Revenue', 'Cost and Profit', 'Cost and Margin', 'Cost and Markup', 'Revenue and Profit', 'Revenue and Margin', 'Revenue and Markup', 'Profit and Margin', 'Profit and Markup'];

  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentItem();
  }

  setCurrentItem() async {
    setState(() {
      choice1 = 'Cost';
      choice2 = 'Revenue';
      _saved = false;
      _noValue = false;
    });
  }

  RichText info = new RichText(
    text: TextSpan(text: 'Calculating important values related to sales analysis involves 5 key variables and 3 primary equations. The key variables are Revenue, Cost, Profit, Markup, and Margin. Given two of these values, the other three can be calculated with some algebraic manipulations using the three equations below.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'These entries will calculate the Cost, Revenue, Gross Profit, Gross Margin (%), and Mark Up (%). The formulas used to calculate these ratios are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Gross Profit = Revenue - Cost\n'
            'Markup = (Gross Profit / Cost) * 100\n'
            'Gross Margin = (Gross Profit / Revenue) * 100',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("Sales",
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

  setChoicePref(String? value) async {
    setState(() {
      choice = value.toString();
      String str = choice;
      final values = str.split(' and ');
      choice1 = values[0];
      choice2 = values[1];
      firstController.text = '';
      secondController.text = '';
      _saved = false;
      _noValue = false;
      if (choice1 == 'Profit'){
        label1 = 'Gross ';
      }
      else{
        label1 = '';
      }
      if (choice2 == 'Margin' || choice2 == 'Profit'){
        label2 = 'Gross ';
      }
      else{
        label2 = '';
      }
      if (choice2 == 'Margin' || choice2 == 'Markup'){
        label = '%';
      }
      else{
        label = '';
      }
      print(choice1 + ' ' + choice2);
    });
  }

  calctarget() async {
    first = 0;
    second = 0;
    margin = 0;
    cost = 0;
    profit = 0;
    markup = 0;
    revenue = 0;

    if (firstController.text != '') {
      first = double.parse(firstController.text);
    }
    if (secondController.text != '') {
      second = double.parse(secondController.text);
    }

    if (first > 0 && second > 0) {
       print("Values Submitted");
       print(dropdownvalue);
       switch (dropdownvalue) {
         case 'Cost and Revenue':{
            cost = first;
            revenue = second;
            profit = revenue - cost;
            markup = (profit / cost) * 100;
            margin = (profit / revenue) * 100;
         }
         break;
         case 'Cost and Profit':{
           cost = first;
           profit = second;
           revenue = profit + cost;
           markup = (profit / cost) * 100;
           margin = (profit / revenue) * 100;
         }
         break;
         case 'Cost and Margin':{
           cost = first;
           margin = second;
           revenue = cost/(1 - margin/100);
           profit = revenue - cost;
           markup = (profit / cost) * 100;
         }
         break;
         case 'Cost and Markup':{
           cost = first;
           markup = second;
           profit= (markup/100) * cost;
           revenue = profit + cost;
           margin = (profit / revenue) * 100;
         }
         break;
         case 'Revenue and Profit':{
           revenue = first;
           profit = second;
           margin = (profit / revenue) * 100;
           cost = revenue - profit;
           markup = (profit / cost) * 100;
         }
         break;
         case 'Revenue and Margin':{
           revenue = first;
           margin = second;
           profit  = (margin/100) * revenue;
           cost = revenue - profit;
           markup = (profit / cost) * 100;
         }
         break;
         case 'Revenue and Markup':{
           revenue = first;
           markup = second;
           cost = revenue/(1 + markup/100);
           profit = revenue - cost;
           margin = (profit / revenue) * 100;
         }
         break;
         case 'Profit and Margin':{
           profit = first;
           margin = second;
           revenue = profit / (margin/100);
           cost = revenue - profit;
           markup = (profit / cost) * 100;
         }
         break;
         case 'Profit and Markup':{
           profit = first;
           markup= second;
           cost = profit / (markup/100);
           revenue = cost + profit;
           margin = (profit / revenue) * 100;
         }
         break;
       }
       results = 'Cost: ' + cost.toStringAsFixed(2) + '\nRevenue: ' + revenue.toStringAsFixed(2) + '\nGross Profit: ' + profit.toStringAsFixed(2) + '\nMarkup: ' + markup.toStringAsFixed(2) + '%\nGross Margin: ' + margin.toStringAsFixed(2) + '%';
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
      title: 'Sales Calculator',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Sales Calculator', style: new TextStyle(
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
                0: FixedColumnWidth(150),
                1: FixedColumnWidth(180)
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
              child: Text('Chosen Values ', style: TextStyle(fontSize: 20.0),),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,

              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Center(
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          setChoicePref(dropdownvalue);
                        });
                      },
                    ),
                      ),
                   ],),
                  ),
                  ],
                ),
                TableRow(
                children: <Widget>[
                  TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(label1 + choice1, style: TextStyle(fontSize: 20.0),),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child:
                    Row (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    Container(
                      width: 90,
                      height: 32,
                      child: TextField(
                          controller: firstController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                      ),
                    ),],
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
                      child: Text(label2 + choice2, style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 32,
                                child: TextField(
                                    controller: secondController,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    )
                                ),
                            ),
                            Text(' ' + label, style: TextStyle(fontSize: 16.0),),
                      ],),
                    ),],
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
                          child: Text(results, style: TextStyle(fontSize: 16.0, color: Colors.red),
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
