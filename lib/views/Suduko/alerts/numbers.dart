import 'package:flutter/material.dart';
import 'package:neon/utils/colors.dart';

class AlertNumbersState extends StatefulWidget {
  const AlertNumbersState({Key? key}) : super(key: key);

  @override
  AlertNumbers createState() => AlertNumbers();

  static int? get number {
    return AlertNumbers.number;
  }

  static set number(int? number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<AlertNumbersState> {
  // ignore: avoid_init_to_null
  static int? number = null;
  late int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];
  List<int> allNumbers = numberList1 + numberList2 + numberList3;

  List<SizedBox> createButtons(List<int> numberList) {
    return <SizedBox>[
      for (int numbers in numberList)
        SizedBox(
          width: 38,
          height: 38,
          child: TextButton(
            onPressed: () => {
              setState(() {
                numberSelected = numbers;
                number = numberSelected;
                Navigator.pop(context);
              })
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.backgroundColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColor.lightPurple),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: AppColor.lightPurple,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            child: Text(
              numbers.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        )
    ];
  }

  Row oneRow(List<int> numberList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(numberList),
    );
  }

  Row createSingleRow() {
    List<int> allNumbers = numberList1 + numberList2 + numberList3;
    return oneRow(allNumbers);
  }

  List<Row> createRows() {
    List<int> allNumbers = numberList1 + numberList2 + numberList3;
    List<Row> rowList = <Row>[];
    for (var i = 0; i <= 0; i++) {
      rowList.add(oneRow(allNumbers));
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: height / 1.688,
          ),
          createSingleRow(),
        ],
      ),
    );
    // return AlertDialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   backgroundColor: AppColor.backgroundColor,
    //   title: Center(
    //       child: Text(
    //     'Choose a Number',
    //     style: TextStyle(color: AppColor.lightPurple),
    //   )),
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: createRows(),
    //   ),
    // );
  }
}
