import 'package:flutter/material.dart';
// import 'package:morphable_shape/morphable_shape.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final buttonText;
  final buttonTapped;
  bool _selected = true;

  MyButton({
    this.color,
    this.textColor,
    this.buttonText,
    this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          onEnd: () => _selected = true,
          duration: Duration(milliseconds: 5000),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: color,
            boxShadow: _selected
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white60,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(-4, -4),
                    ),
                  ]
                : [],
          ),
          child: Container(
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//widget
// Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: buttonTapped,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(250)),
//             color: color,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 spreadRadius: 5.0,
//                 blurRadius: 2,
//               ),
//             ],
//           ),
//           child: Container(
//             child: Center(
//               child: Text(
//                 buttonText,
//                 style: TextStyle(color: textColor, fontSize: 20),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
