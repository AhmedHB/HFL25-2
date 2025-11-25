import 'package:flutter/material.dart';
import 'package:fluttercalculatorprojekt_01/logic/calculatorcontroller.dart';
import 'package:fluttercalculatorprojekt_01/logic/memorycontroller.dart';
import 'package:fluttercalculatorprojekt_01/ui/widgets/displaywidget.dart';
import 'package:fluttercalculatorprojekt_01/ui/widgets/buttonrow.dart';
import 'package:fluttercalculatorprojekt_01/ui/widgets/calcbutton.dart';
import 'package:fluttercalculatorprojekt_01/ui/widgets/specialbutton.dart';
import 'package:fluttercalculatorprojekt_01/ui/widgets/deletebutton.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

/**
 * Ritar en layout som ser ut så här:
 *
 *      Knapptryckningar (tidigare uttryck)
 *      Display (aktuellt tal)
 *
 *  [  C  ] [  M  ] [ MC ] [  %  ] [  ÷  ]
 *  [  7  ] [  8  ] [  9  ] [  (  ] [  ×  ]
 *  [  4  ] [  5  ] [  6  ] [  )  ] [  −  ]
 *  [  1  ] [  2  ] [  3  ] [ DEL ] [  +  ]
 *  [  0  ] [  ,  ] [ +/- ] [     ] [  =  ]
 *
 */
class _CalculatorPageState extends State<CalculatorPage> {
  final controller = CalculatorController();
  final memory = MemoryController();

  @override
  Widget build(BuildContext context) {
    final display = controller.getDisplay();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shortest = constraints.biggest.shortestSide; // Hämtar kortast sida
            final cardWidth = shortest.clamp(320.0, 420.0); // bred(min), bred(max)
            final cardHeight = cardWidth * 1.7; // Dynamisk höjd proportionellt mot bredden
            final scale = cardWidth / 360.0; // Skalning

            return Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32 * scale),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF363B44),
                    Color(0xFF22252B),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 30 * scale,
                    offset: Offset(0, 20 * scale),
                  )
                ],
              ),
              padding: EdgeInsets.all(24 * scale),
              child: Column(
                children: [
                  // Display
                  DisplayWidget(
                    text: display, // Aktuellt tal
                    lastExpression: controller.lastExpression,//tidigare uttryck
                    scale: scale,
                  ),
                  const SizedBox(height: 20),

                  // Knappar
                  Expanded(
                    child: Column(
                      children: [
                        ButtonRow(children: [
                          SpecialButton("c", onPressed: () => setState(controller.clear)),
                          SpecialButton("m", onPressed: () => setState(() => controller.memory(memory))),
                          SpecialButton("mc", onPressed: () => setState(memory.clear)),
                          SpecialButton("%", onPressed: () => setState(controller.percent)),
                          CalcButton("÷", value: "/", onPressed: () => setState(() => controller.add("/"))),
                        ]),
                        ButtonRow(children: [
                          CalcButton("7", onPressed: () => setState(() => controller.add("7"))),
                          CalcButton("8", onPressed: () => setState(() => controller.add("8"))),
                          CalcButton("9", onPressed: () => setState(() => controller.add("9"))),
                          CalcButton("(" , onPressed: () => setState(() => controller.add("("))),
                          CalcButton("×", value: "*", onPressed: () => setState(() => controller.add("*"))),
                        ]),
                        ButtonRow(children: [
                          CalcButton("4", onPressed: () => setState(() => controller.add("4"))),
                          CalcButton("5", onPressed: () => setState(() => controller.add("5"))),
                          CalcButton("6", onPressed: () => setState(() => controller.add("6"))),
                          CalcButton(")", onPressed: () => setState(() => controller.add(")"))),
                          CalcButton("−", value: "-", onPressed: () => setState(() => controller.add("-"))),
                        ]),
                        ButtonRow(children: [
                          CalcButton("1", onPressed: () => setState(() => controller.add("1"))),
                          CalcButton("2", onPressed: () => setState(() => controller.add("2"))),
                          CalcButton("3", onPressed: () => setState(() => controller.add("3"))),
                          DeleteButton(onPressed: () => setState(controller.deleteLast)),
                          CalcButton("+", onPressed: () => setState(() => controller.add("+"))),
                        ]),
                        ButtonRow(children: [
                          CalcButton("0", onPressed: () => setState(() => controller.add("0"))),
                          CalcButton(",", onPressed: () => setState(() => controller.add(","))),
                          CalcButton("+/-", onPressed: () => setState(controller.toggleSign)),
                          const Spacer(),
                          CalcButton("=", onPressed: () => setState(controller.evaluate)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
