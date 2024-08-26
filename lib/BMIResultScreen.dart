import 'dart:math';

import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final bool isMale;
  final int height;
  final int weight;
  final int age;

  const BMIResultScreen(
      {super.key,
      required this.isMale,
      required this.height,
      required this.weight,
      required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
        title: const Text("BMI Result", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: screenBody(isMale, height, weight, age),
    );
  }

  Widget screenBody(bool isMale, int height, int weight, int age) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          dataSection(isMale, height, weight, age),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: Colors.grey[400]),
          ),
          resultSection(isMale, height, weight, age)
        ],
      ),
    );
  }

  Widget dataSection(bool isMale, int height, int weight, int age) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Your Information",
          style: TextStyle(
              color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        dataItem("Gender", isMale ? "Male" : "Female"),
        const SizedBox(height: 8.0),
        dataItem("Height", "$height cm"),
        const SizedBox(height: 8.0),
        dataItem("Weight", "$weight kg"),
        const SizedBox(height: 8.0),
        dataItem("Age", "$age years"),
      ],
    );
  }

  Widget dataItem(String label, String value) {
    return Container(
      width: double.infinity,
      height: 45.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        children: [
          Text("$label : ",
              style: const TextStyle(color: Colors.redAccent, fontSize: 18.0)),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 16.0)),
        ],
      ),
    );
  }

  Widget resultSection(bool isMale, int height, int weight, int age) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "BMI Result",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        calcBMI(height, weight, age),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 72.0,
                            fontWeight: FontWeight.w900),
                      ),
                      const Text(" kg/m\u00B2",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                  Text(
                    getBMIStatus(double.parse(calcBMI(height, weight, age))),
                    style: TextStyle(
                        color: getStatusColor(
                            double.parse(calcBMI(height, weight, age))),
                        fontSize: 46.0,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String calcBMI(int height, int weight, int age) {
    return (weight / pow(height / 100, 2)).toStringAsFixed(1);
  }

  String getBMIStatus(double bmi) {
    String status;
    if (bmi < 18.5) {
      status = "Under Weight";
    } else if (bmi >= 18.5 && bmi <= 25) {
      status = "Normal";
    } else if (bmi > 25 && bmi <= 30) {
      status = "Overweight";
    } else {
      status = "Obesity";
    }
    return status;
  }

  Color getStatusColor(double bmi) {
    Color color;
    if (bmi < 18.5) {
      color = Colors.yellow;
    } else if (bmi >= 18.5 && bmi <= 25) {
      color = Colors.green;
    } else if (bmi > 25 && bmi <= 30) {
      color = Colors.yellow;
    } else {
      color = Colors.red;
    }
    return color;
  }
}
