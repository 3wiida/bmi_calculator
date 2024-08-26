import 'package:bmi_calculator/BMIResultScreen.dart';
import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  bool isMaleSelected = true;
  double height = 120.0;
  int weight = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black38,
          appBar: AppBar(
            backgroundColor: Colors.black38,
            title: const Text("BMI Calculator",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: screenBody(isMaleSelected, height, weight, age,
              (double newHeight) {
            setState(() {
              height = newHeight;
            });
          }, (bool isMale) {
            setState(() {
              isMaleSelected = isMale;
            });
          }, (bool isIncrease) {
            setState(() {
              isIncrease ? weight++ : weight--;
            });
          }, (bool isIncrease) {
            setState(() {
              isIncrease ? age++ : age--;
            });
          }, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BMIResultScreen(
                        isMale: isMaleSelected,
                        height: height.round(),
                        weight: weight,
                        age: age)));
          })),
    );
  }
}

Widget screenBody(
    bool isMaleSelected,
    double heightValue,
    int weight,
    int age,
    Function(double) onHeightChanged,
    Function(bool) onGenderSelect,
    Function(bool) onWeightChanged,
    Function(bool) onAgeChanged,
    Function() onClick) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        genderSection(isMaleSelected, onGenderSelect),
        const SizedBox(height: 16.0),
        heightSection(heightValue, onHeightChanged),
        const SizedBox(height: 16.0),
        Row(
          children: [
            weightSection(weight, onWeightChanged),
            const SizedBox(width: 16.0),
            ageSection(age, onAgeChanged),
          ],
        ),
        calculateButton(onClick)
      ],
    ),
  );
}

Widget genderSection(bool isMaleSelected, Function(bool) onGenderSelect) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      children: [
        genderItem(true, isMaleSelected, () {
          onGenderSelect(true);
        }),
        const SizedBox(width: 16.0),
        genderItem(false, !isMaleSelected, () {
          onGenderSelect(false);
        }),
      ],
    ),
  );
}

Widget genderItem(bool isMale, bool isSelected, Function() onSelect) {
  return Expanded(
    child: GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.redAccent : Colors.grey[900],
            borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              width: 60.0,
              height: 60.0,
              child: Image(
                image: AssetImage(
                    "${isMale ? 'assets/images/male.png' : 'assets/images/female.png'}"),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "${isMale ? 'MALE' : 'FEMALE'}",
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 16.0),
            )
          ],
        ),
      ),
    ),
  );
}

Widget heightSection(double heightValue, Function(double) onHeightChanged) {
  return Expanded(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: Colors.grey[900]),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Height",
            style: TextStyle(color: Colors.grey[400], fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "${heightValue.round()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42.0,
                      color: Colors.white),
                ),
                const SizedBox(width: 4.0),
                Text(
                  "cm",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[400]),
                )
              ],
            ),
          ),
          Slider(
            value: heightValue,
            min: 80.0,
            max: 220.0,
            onChanged: onHeightChanged,
            activeColor: Colors.redAccent,
            inactiveColor: Colors.grey[400],
          )
        ],
      ),
    ),
  );
}

Widget weightSection(int value, Function(bool) onChange) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: [
          Text(
            "Weight",
            style: TextStyle(color: Colors.grey[400], fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "$value",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42.0,
                      color: Colors.white),
                ),
                const SizedBox(width: 4.0),
                Text(
                  "kg",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[400]),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onChange(false);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  onChange(true);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget ageSection(int value, Function(bool) onChange) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: [
          Text(
            "Age",
            style: TextStyle(color: Colors.grey[400], fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "$value",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42.0,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onChange(false);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  onChange(true);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget calculateButton(Function() onClick) {
  return SizedBox(
    height: 105.0,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        onPressed: onClick,
        textColor: Colors.white,
        color: Colors.redAccent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        child: const Text("Calculate", style: TextStyle(fontSize: 18.0)),
      ),
    ),
  );
}
