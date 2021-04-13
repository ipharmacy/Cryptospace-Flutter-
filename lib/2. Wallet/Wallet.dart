import 'dart:convert';

import 'package:flutter_universe/2.%20Wallet/qr_create_page.dart';
import 'package:flutter_universe/2.%20Wallet/qr_scan_page.dart';
import 'package:flutter_universe/Controllers/TransactionController.dart';
import 'package:http/http.dart';

import '../staticdata/constants.dart';
import 'package:flutter_universe/custom_widgets/card_widget.dart';
import 'package:flutter_universe/2. Wallet/Coindetails.dart';

import 'package:flutter_universe/custom_widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Wallet extends StatefulWidget {

  @override
  _WalletdetailsState createState() => _WalletdetailsState();
}
class _WalletdetailsState extends State<Wallet> {

  final TransactionController transactionController = TransactionController();
  int touchedIndex;
  List data;
  String balance;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }
  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: () async => false,
      child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: [const Color(0xFF543CBA),const Color(0xFF3FA5B1)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 35,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'My Wallet',
                        style: GoogleFonts.spartan(
                          fontSize: 33,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.kwhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(
                  left: 3,
                  right: 15,
                  top: 10,
                ),
                child: Container(
                  child: Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                setState(() {
                                  if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                      pieTouchResponse.touchInput is FlPanEnd) {
                                    touchedIndex = -1;
                                  } else {
                                    touchedIndex = pieTouchResponse.touchedSectionIndex;
                                  }
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 7,
                              centerSpaceRadius: 100,
                              sections: showingSections()),
                        ),
                      ),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      children: [
                        ButtonTheme(
                          minWidth: 130.0,
                          child: OutlineButton(
                            disabledBorderColor: const Color(0xffffffff),
                            highlightedBorderColor: const Color(0xffffffff),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => QRScanPage(),
                                ),
                              )
                            },
                            padding: EdgeInsets.all(10.0),
                            child: Row( // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Icon(Icons.send,color: const Color(0xffffffff),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Send",style: TextStyle(color: const Color(0xffffffff),))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ButtonTheme(
                          minWidth: 130.0,
                          child: OutlineButton(
                            disabledBorderColor: const Color(0xffffffff),
                            highlightedBorderColor: const Color(0xffffffff),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () => {

                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => QRCreatePage(),
                                ),
                              )
                            },

                            padding: EdgeInsets.all(10.0),
                            child: Row( // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Icon(Icons.attach_money,color: const Color(0xffffffff),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Receive",style: TextStyle(color: const Color(0xffffffff),))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                        children: [
                          Container(
                            child: FutureBuilder(
                              future: transactionController.getBalance(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if(snapshot.data == null){
                                  return Container(
                                      child: Center(
                                          child: SpinKitDoubleBounce(
                                            color: Colors.white,
                                            size: 50.0,
                                          )
                                      )
                                  );
                                }else{
                                  return Column(
                                    children:
                                    List.generate(
                                      snapshot.data == null ? 0 : 1,
                                          (index) {
                                        return TransactionListWidget(
                                          icon: Constants.iconList[index],
                                          titleTxt: "Vault",
                                          subtitleTxt: "",
                                          amount: snapshot.data,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Transactions",
                                style: GoogleFonts.spartan(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kwhiteColor,
                                ),
                              ),

                              Text(
                                "See All",
                                style: GoogleFonts.spartan(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffBEBEF4),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: FutureBuilder(
                            future: transactionController.getTransactions(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.data == null){
                                return Container(
                                    child: Center(
                                        child: SpinKitDoubleBounce(
                                          color: Colors.white,
                                          size: 50.0,
                                        )
                                    )
                                );
                              }else{
                                return Column(
                                  children:
                                    List.generate(
                                      snapshot.data == null ? 0 : snapshot.data.length,
                                          (index) {
                                        return TransactionListWidget(
                                          icon: snapshot.data[index].status == "Transfered" ? Icon(
                                            Icons.arrow_upward_rounded,
                                            color: ColorConstants.kwhiteColor,
                                          ) : Icon(
                                            Icons.arrow_downward_rounded,
                                            color: ColorConstants.kwhiteColor,
                                          ),
                                          titleTxt: snapshot.data[index].status,
                                          subtitleTxt:  snapshot.data[index].to,
                                          amount:  snapshot.data[index].tokens,
                                        );
                                      },
                                    ),
                                );
                              }
                            },
                          ),
                        )
                      ]

                    ),

                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFfad502),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

