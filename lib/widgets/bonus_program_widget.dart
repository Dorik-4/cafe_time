import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BonusProgramWidget extends StatefulWidget {
  final String phoneNumber;

  BonusProgramWidget({required this.phoneNumber});

  @override
  _BonusProgramWidgetState createState() => _BonusProgramWidgetState();
}

class _BonusProgramWidgetState extends State<BonusProgramWidget> {
  bool _showBarcode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showBarcode = !_showBarcode;  // Переключаем виджет
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationYTransition(
            turns: animation,
            child: child,
          );
        },
        child: _showBarcode
            ? Container(
                key: ValueKey(1),
                padding: EdgeInsets.all(16),
                color: Colors.white,  // Белая подложка под баркод
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: widget.phoneNumber,
                  height: 120,
                  drawText: false,
                  backgroundColor: Colors.white,
                ),
              )
            : Container(
                key: ValueKey(2),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,  // Белая подложка для текста
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Нажмите и покажите код сотруднику для скидки',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}

// Анимация переворота по оси Y
class RotationYTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> turns;

  RotationYTransition({required this.turns, required this.child})
      : super(listenable: turns);

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.identity()
      ..rotateY((turns.value - 1.0) * 3.1415927);  // Анимация поворота
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }
}
