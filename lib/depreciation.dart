import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'dart:ui';

class depreciaton extends StatefulWidget {
  @override
  depreciatonState createState() =>depreciatonState();
}

class depreciatonState extends State<depreciaton> {
  bool _saved1 = false;
  bool _saved2 = false;
  bool _noValue = false;
  bool monthShow = true;
  bool unitShow = false;
  bool tableShow = false;
  bool factorShow = false;
  double depFactor = 0;
  double cost = 0;
  double salvage = 0;
  int life = 0;
  int month = 12;
  int units = 0;
  int produced = 0;
  double lifeLabel = 120;
  String choice = '';
  String label1 = 'Useful Life (Years)';
  String label2 = '1st Month in Service';
  String results = '';
  String missingInfo = '';

  // Initial Selected Value
  String dropdownvalue = 'Straight Line';
  String monthvalue = 'January';

  // List of items in our dropdown menu
  var items = ['Straight Line', 'Declining Balance', 'Sum of Years', 'Units of Production'];
  var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'Octoer', 'November', 'December'];
  List <String> depreciationList = [];
  List <String> beginYear = [];
  List <String> endYear = [];

  TextEditingController costController = TextEditingController();
  TextEditingController salvageController = TextEditingController();
  TextEditingController lifeController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController factorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentItem();
  }

  setCurrentItem() async {
    setState(() {
      monthShow = true;
      unitShow = false;
      _saved1 = false;
      _saved2 = false;
      _noValue = false;
      depFactor = 2;
    });
  }

  RichText info = new RichText(
    text: TextSpan(text: 'Depreciation is a way to show how the value of an asset decreases over time. It is an accounting method used by businesses to spread the initial cost of an asset over its years of useful life.\n\n',
      style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),

      children: <TextSpan>[
        TextSpan(text: 'Straight Line Depreciation is a straight line drop in asset value. The depreciation of an asset is spread evenly across the life. The formulas used to calculate the results are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Yearly Depreciation = ((Cost - Salvage) / Life)\n'
            'For Partial year depreciation, when the first year has M months is taken as:\n'
            'First year depreciation = (M / 12) * ((Cost - Salvage) / Life)\n'
             'Last year depreciation = ((12 - M) / 12) * ((Cost - Salvage) / Life)\n\n',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Declining Balance Depreciation does not consider the salvage value in the depreciation of each period. It applies a factor to each annual percentage based on the useful life. The percentage is then multiplied by the book value at the beginning of each year. A factor of 2 is commonly called the Double Declining Balance meethod. If the book value will fall below the salvage value, the last period might be adjusted so that it ends at the salvage value. The formulas used to calculate the results are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Straight-Line Depreciation Percent = 100% / Useful Life\n'
            'Depreciation Rate = Depreciation Factor x Straight-Line Depreciation Percent\n'
            ' Annual Depreciation = Depreciation Rate x Book Value at Beginning of the Period\n'
            'If the first year is not a full 12 months and is a number M months, the first and last years will be calculated as\n'
            'First Year Depreciation Rate = M/12 x Depreciation Rate\n'
            'Last Year Depreciation Rate = (12-M)/12 x Depreciation Rate\n\n',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Sum of Years Depreciation is calculated as a fractional part of a sum of all the years. For example, if an asset has a life of 4 years the sum of years is 1+2+3+4 = 10. Fractional parts are built in reverse order with the year as the numerator and the sum of years as the denominator. Year 1 is 4/10 * depreciable cost, Year 2 is 3/10 * depreciable cost, etc. The formulas used to calculate the results are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Depreciable Cost = Original Cost - Salvage Value\n'
            'Depreciation in Any Period: = Fraction for Given Period * Depreciable Cost\n\n',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'The Units of Production or Activity method is a way of calculating the depreciation of the value of an asset over the expected number of units it can produce. It becomes useful when an asset\'s value is more closely related to the number of units it produces rather than the number of years it is in service.The calculation is based on the units produced during the desired period compared to the number of units that can be produced for the life of the asset. The formulas used to calculate the results are:\n\n', style: new TextStyle(
            fontSize: 16.0, color: Colors.blueGrey),),

        TextSpan(text: 'Depreciable Base = Asset Cost - Salvage Value\n'
            'Depreciation per Unit = Depreciable Base / Total Units\n'
            'Depreciation for Period = Depreciation per Unit x Number of Units Produced in a Period\n',
          style: new TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
      ],
    ),);

  showInfoDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:
        Text("Depreciation",
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

  setChoicePref(String? value) async {
    setState(() {
      print(choice + ' ' + value.toString());
      if ((value.toString() == 'Units of Production' && choice != 'Units of Production') || (value.toString() != 'Units of Production' && choice == 'Units of Production')) {
        costController.text = '';
        salvageController.text = '';
        lifeController.text = '';
        unitController.text = '';
        factorController.text = '';
        monthShow = true;
        monthvalue = 'January';
      }
      produced = 0;
      units = 0;
      choice = value.toString();
      if (choice == 'Units of Production'){
        label1 = 'Useful Life (Units)';
        label2 = 'Units Produced (in Period)';
        lifeLabel = 120;
        unitShow = true;
        monthShow = false;
        factorShow = false;
      }
      else if (choice == 'Straight Line'){
        label1 = 'Useful Life (Years)';
        label2 = '1st Month in Service';
        lifeLabel = 80;
        monthvalue = 'January';
        monthShow = true;
        unitShow = false;
        factorShow = false;
      }
      else if (choice == 'Declining Balance'){
        label1 = 'Useful Life (Years)';
        label2 = '1st Month in Service';
        lifeLabel = 80;
        depFactor = 2;
        factorController.text = '2';
        monthvalue = 'January';
        factorShow = true;
        monthShow = true;
        unitShow = false;
      }
      else{
        label1 = 'Useful Life (Years)';
        label2 = '';
        lifeLabel = 80;
        factorShow = false;
        monthShow = false;
        unitShow = false;
        monthvalue = 'January';
      }
      _saved1 = false;
      _saved2 = false;
      _noValue = false;
    });
  }

  calctarget() async {
    cost = 0;
    salvage = 0;
    life = 0;
    month = 12;
    produced = 0;
    units = 0;
    depFactor = 2;
    beginYear.clear();
    endYear.clear();
    depreciationList.clear();

    if (monthvalue != 'January'){
      switch (monthvalue){
        case ('February'):
          month = 11;
        break;
        case ('March'):
          month = 10;
          break;
        case ('April'):
          month = 9;
          break;
        case ('May'):
          month = 8;
          break;
        case ('June'):
          month = 7;
          break;
        case ('July'):
          month = 6;
          break;
        case ('August'):
          month = 5;
          break;
        case ('September'):
          month = 4;
          break;
        case ('October'):
          month = 3;
          break;
        case ('November'):
          month = 2;
          break;
        case ('December'):
          month = 1;
          break;
      }
    }

    if (costController.text != '') {
      cost = double.parse(costController.text);
    }
    if (salvageController.text != '') {
      salvage = double.parse(salvageController.text);
    }
    if (lifeController.text != '') {
      life = int.parse(lifeController.text);
    }
    if (unitController.text != '') {
      units = int.parse(unitController.text);
    }
    if (factorController.text != '') {
      depFactor = double.parse(factorController.text);
    }
    if (cost > 0 && life > 0 ) {
       print("Values Submitted");
       print(life);
       switch (dropdownvalue) {
         case 'Straight Line':{
           print(life.toString());
           if (life > 20){
             missingInfo = 'The Useful Life must be 20 years or less.';
             setState(() {
               _saved2 = false;
               _saved1 = false;
               _noValue = true;
               tableShow = false;
             });
           }
           else {
             int i;
             double depCost = 0;
             for (i = 0; i <= life; i++){
               if ( i == 0){
                 beginYear.add(cost.toStringAsFixed(0));
                 depCost = (month / 12) * ((cost - salvage) / life);
                 print(depCost.toString());
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[0]) - double.parse(depreciationList[0])).toStringAsFixed(0));
               }
               else if ( i < life){
                 depCost = (cost - salvage) / life;
                 beginYear.add((double.parse(beginYear[i-1]) - double.parse(depreciationList[i-1])).toStringAsFixed(0));
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[i]) - double.parse(depreciationList[i])).toStringAsFixed(0));
               }
               else if (i == life && month < 12){
                 depCost = ((12 - month )/ 12) * ((cost - salvage) / life);
                 beginYear.add((double.parse(beginYear[i-1]) - double.parse(depreciationList[i-1])).toStringAsFixed(0));
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[i]) - double.parse(depreciationList[i])).toStringAsFixed(0));
               }
             }
             print(beginYear);
             if (month == 12){
               life = life - 1;
             }
             setState(() {
               _saved2 = false;
               _saved1 = true;
               _noValue = false;
               tableShow = true;
             });
           }
         }
         break;
         case 'Declining Balance':{
           if (life > 20){
             missingInfo = 'The Useful Life must be 20 years or less.';
             setState(() {
               _saved2 = false;
               _saved1 = false;
               _noValue = true;
               tableShow = false;
             });
           }
           else {
             int i;
             double depCost = 0;
             for (i = 0; i <= life; i++){
               if ( i == 0){
                 beginYear.add(cost.toStringAsFixed(0));
                 depCost = (month / 12) * (cost / life) * depFactor;
                 print(depCost.toString());
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[0]) - double.parse(depreciationList[0])).toStringAsFixed(0));
               }
               else if ( i < life ){
                 beginYear.add((double.parse(beginYear[i-1]) - double.parse(depreciationList[i-1])).toStringAsFixed(0));
                 depCost = (double.parse(beginYear[i])/ life) * depFactor;
                 if ((double.parse(beginYear[i]) - depCost) < salvage && i <= life - 1 ) {
                     depCost = double.parse(beginYear[i]) - salvage;
                 }
                 else if ((double.parse(beginYear[i]) - depCost) > salvage && i == life - 1  && month == 12 ){
                     depCost = double.parse(beginYear[i]) - salvage;
                 }
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[i]) - double.parse(depreciationList[i])).toStringAsFixed(0));
               }
               else if (i == life && month < 12){
                   beginYear.add((double.parse(beginYear[i-1]) - double.parse(depreciationList[i-1])).toStringAsFixed(0));
                   depCost = ((12 - month )/ 12) * double.parse(beginYear[i])/life * depFactor;
                   if (double.parse(beginYear[i]) - depCost > salvage){
                     depCost = double.parse(beginYear[i]) - salvage;
                   }
                   depreciationList.add(depCost.toStringAsFixed(0));
                   endYear.add((double.parse(beginYear[i]) - double.parse(depreciationList[i])).toStringAsFixed(0));

               }
             }
             print(beginYear);
             if (month == 12){
               life = life - 1;
             }
             setState(() {
               _saved2 = false;
               _saved1 = true;
               _noValue = false;
               tableShow = true;
             });
           }
         }
         break;
         case 'Sum of Years':{
           if (life > 20){
             missingInfo = 'The Useful Life must be 20 years or less.';
             setState(() {
               _saved2 = false;
               _saved1 = false;
               _noValue = true;
               tableShow = false;
             });
           }
           else {
             List <int> numbers = [];

             for ( int j = 1; j <= life; j++){
               numbers.add(j);
             }

             var sum = 0;
             for (var i = 0; i < numbers.length; i++) {
               sum += numbers[i];
             }
             print(sum.toString());
             double depCost = 0;

             for (int i = 0; i <= life; i++){
               if ( i == 0){
                 beginYear.add(cost.toStringAsFixed(0));
                 depCost = ((month / 12) * (cost - salvage)) * (numbers[life-1]/sum);
                 print(depCost.toString());
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[0]) - double.parse(depreciationList[0])).toStringAsFixed(0));
               }
               else if ( i < life && month == 12){
                 depCost = (cost - salvage) * (numbers[life - (i+1)]/sum);
                 beginYear.add((double.parse(beginYear[i-1]) - double.parse(depreciationList[i-1])).toStringAsFixed(0));
                 depreciationList.add(depCost.toStringAsFixed(0));
                 endYear.add((double.parse(beginYear[i]) - double.parse(depreciationList[i])).toStringAsFixed(0));
               }
             }
             print(beginYear);
             if (month == 12){
               life = life - 1;
             }
             setState(() {
               _saved2 = false;
               _saved1 = true;
               _noValue = false;
               tableShow = true;
             });
           }
         }
         break;
         case 'Units of Production':{
           double depCost = 0;
           double depProd = 0;
           double depBase = cost - salvage;
           depCost = depBase / life;
           depProd = depCost * units;
           results = 'Depreciable Base: ' + depBase.toStringAsFixed(2) + '\nDepreciation per Unit: ' + depCost.toStringAsFixed(4) + '\nDepreciation for Period: ' + depProd.toStringAsFixed(2);
           setState(() {
             _saved2 = true;
             _saved1 = false;
             _noValue = false;
             tableShow = false;
           });
         }
         break;
       }

    }
    else{
      print("Value missing.");
      missingInfo = 'Value missing.';
      setState(() {
        _saved1 = false;
        _saved2 = false;
        _noValue = true;
        tableShow = false;
      });
    }
  }

  var i;
  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, textStyle: const TextStyle(fontSize: 20));

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depreciation',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
            },
          ),
          title: Text('Depreciation', style: new TextStyle(
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
              child: Text('Depreciation ', style: TextStyle(fontSize: 20.0),),
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
                  child: Text('Asset Cost ', style: TextStyle(fontSize: 20.0),),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child:
                    Row (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    Container(
                      width: 120,
                      height: 32,
                      child: TextField(
                          controller: costController,
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
                      child: Text(' ', style: TextStyle(fontSize: 5.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 5.0),),
                    ),
                ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Salvage Value ', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 32,
                                child: TextField(
                                    controller: salvageController,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    )
                                ),
                            ),
                      ],),
                    ),],
                  ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 5.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 5.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(label1, style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: lifeLabel,
                            height: 32,
                            child: TextField(
                                controller: lifeController,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                )
                            ),
                          ),
                        ],),
                    ),],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 5.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 5.0),),
                    ),
                  ],),
                factorShow == true ?
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('Depreciation Factor', style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 32,
                            child: TextField(
                                controller: factorController,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                )
                            ),
                          ),
                        ],),
                    ),],
                ):
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(' ', style: TextStyle(fontSize: 5.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text('', style: TextStyle(fontSize: 5.0),),
                    ),
                  ],),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(label2, style: TextStyle(fontSize: 20.0),),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          Visibility(
                          visible: monthShow,
                            child: Center(
                              child: DropdownButton(
                                // Initial Value
                                value: monthvalue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: months.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    monthvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: unitShow,
                                child: Container(
                                  width: 120,
                                  height: 32,
                                  child: TextField(
                                      controller: unitController,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      )
                                  ),
                                ),
                          ),
                      ],),
                    ),],
                  ),
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
                    children: [
                      tableShow == true ?
                        Visibility(
                        visible: _saved1,
                        child: Center(
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(60),
                              1: FixedColumnWidth(85),
                              2: FixedColumnWidth(85),
                              3: FixedColumnWidth(85),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                          TableRow(
                          children: <Widget>[
                            TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Text('Year', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Text('\nBook Value\nBegin Year\n', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text('Depreciation', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text('Book Value\nEnd Year', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                            ],),
                                for ( i = 0; i <= life; i++)
                                  TableRow(
                                    children: <Widget>[
                                      TableCell(
                                          verticalAlignment: TableCellVerticalAlignment
                                              .middle,
                                          child: Text(
                                              '\n' + (i+1).toString() + '\n',
                                              style: TextStyle(fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center)
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment
                                            .middle,
                                        child: Text(beginYear[i], style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment
                                            .middle,
                                        child: Text(depreciationList[i], style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment
                                            .middle,
                                        child: Text(endYear[i], style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],),
                            ],),
                        ),
                      ):
                      Visibility(
                        visible: _saved2,
                        child: Text(results, style: TextStyle(fontSize: 16.0, color: Colors.red),
                        ),
                      ),
                      Visibility(
                        visible: _noValue,
                        child: Text(missingInfo, style: TextStyle(fontSize: 16.0, color: Colors.red),
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
