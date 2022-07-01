import 'package:bill_desk/src/Configuration/Bottom%20Curved%20Pointer/bottom_curved_pointer.dart';
import 'package:bill_desk/src/Themes/light_color.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onIconPresedCallback;
  CustomBottomNavigationBar({Key? key, required this.onIconPresedCallback})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(String icon, bool isEnable, int index) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        onTap: () {
          _handlePressed(index);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
              height: isEnable ? 40 : 20,
              duration: Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isEnable ? LightColor.orange : Colors.white,
                  shape: BoxShape.circle),
              child: Opacity(
                opacity: 1,
                child: Image.asset("assets/png/$icon",
                    color:
                        isEnable ? LightColor.white : const Color(0xff616466),
                    width: 100.0,
                    height: 100.0),
              )),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    final inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          Theme.of(context).backgroundColor),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 620));
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        _yController.animateTo(1.0, duration: Duration(milliseconds: 1200));
      },
    );
    _yController.animateTo(0.0, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    const height = 60.0;
    return Container(
      width: appSize.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Container(
              decoration: const BoxDecoration(
                color: LightColor.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // _icon("home.png", _selectedIndex == 0, 0),
                  _icon("box.png", _selectedIndex == 1, 1),
                  _icon("shopping-cart.png", _selectedIndex == 2, 2),
                  _icon("clipboard.png", _selectedIndex == 3, 3),
                  _icon("grid.png", _selectedIndex == 4, 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
