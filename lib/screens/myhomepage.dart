import 'dart:ui';

import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Splitter"),
        centerTitle: true,

      ),
      body:  Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Per Person", style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("₹ ${
                        calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)

              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey.shade900,fontSize: 17),

                    decoration: InputDecoration(
                      prefixText: "Bill Amount : ₹ ",

                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }
                      catch(exception){
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Split", style: TextStyle(
                        color: Colors.grey.shade700,

                      ),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personCounter > 1)
                                {
                                  _personCounter--;
                                }else {//do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.deepPurple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                  color:Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                                ),
                              ),
                            ),
                          ),
                          //
                          Container(
                            width: 30,
                            child: TextField(

                              keyboardType: TextInputType.numberWithOptions(decimal: false),
                              style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 17),
                              decoration: InputDecoration(
                                labelText: "$_personCounter",
                              ),
                              onChanged: (String value){
                                try{
                                  int inputText = int.parse(value);

                                  if (inputText>0)
                                    {
                                      _personCounter = inputText;
                                    }
                                   else {
                                    _personCounter = 1;
                                    final snackBar = SnackBar(content: Text('Person\'s cannot be 0'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                                catch(exception){
                                  _personCounter = 1;
                                }
                              },
                            ),
                          ),
                          //
                          // Text("$_personCounter",style: TextStyle(
                          //   color: Colors.deepPurpleAccent,
                          //   fontSize: 17.0,
                          //   fontWeight: FontWeight.bold,
                          // ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text(
                                  "+", style: TextStyle(
                                  color:Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Tip", style: TextStyle(
                        color: Colors.grey.shade700,

                      ),),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("₹ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),

                    ],
                  ),
                  //Slider
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("$_tipPercentage %", style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurpleAccent,
                          inactiveColor: Colors.deepPurpleAccent.withOpacity(0.3),
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          }
                      )

                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson (double billAmount, int splitBy, int tipPercentage)
  {
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;

    return totalPerPerson.toStringAsFixed(2);

  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage)
  {
    double totalTip = 0.0;
    if( billAmount < 0 || billAmount.toString().isEmpty )
    {

    }
    else{
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
