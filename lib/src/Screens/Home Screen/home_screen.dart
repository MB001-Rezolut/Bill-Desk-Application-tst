import 'package:bill_desk/src/Configuration/Bottom%20Naviagtion%20Bar/bottom_navigation.dart';
import 'package:bill_desk/src/Configuration/Styling/font_styles.dart';
import 'package:bill_desk/src/Configuration/Widgets/product_card.dart';
import 'package:bill_desk/src/Configuration/model/data.dart';
import 'package:bill_desk/src/Images%20Configs/img_config.dart';
import 'package:bill_desk/src/Themes/light_color.dart';
import 'package:bill_desk/src/Themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int defaultChoiceIndex = 0;
  List<String> _choicesList = [
    'IPhone',
    'Macbook',
    'IPad',
    'Airpods',
    'IPhone',
    'Macbook',
    'IPad',
    'Airpods',
    'IPhone',
    'Macbook',
    'IPad',
    'Airpods',
  ];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
    _controller = AnimationController(vsync: this);
  }

  bool isHomePageSelected = true;
  bool isExplorePageSelected = false;
  bool isClipboardSelected = false;
  bool isCheckoutSelected = false;
  bool isCalogSelected = false;
  bool isChipSelected = false;

  late AnimationController _controller;
  String searchtext = '';

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
        isExplorePageSelected = false;
        isCheckoutSelected = false;
        isCalogSelected = false;
        isClipboardSelected = false;
      });
      //print(isClipboardSelected);
    } else if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        isExplorePageSelected = true;
        isCheckoutSelected = false;
        isCalogSelected = false;
        isClipboardSelected = false;
        //print(isHomePageSelected);
      });
    } else if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isExplorePageSelected = false;
        isCheckoutSelected = true;
        isCalogSelected = false;
        isClipboardSelected = false;
      });
    } else if (index == 3) {
      setState(() {
        isHomePageSelected = false;
        isExplorePageSelected = false;
        isCheckoutSelected = false;
        isCalogSelected = false;
        isClipboardSelected = true;
      });
    } else if (index == 4) {
      setState(() {
        isHomePageSelected = false;
        isExplorePageSelected = false;
        isCheckoutSelected = false;
        isCalogSelected = true;
        isClipboardSelected = false;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return InkWell(
      onTap: () {},
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  decoration: const BoxDecoration(
                      color: LightColor.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchtext = value;
                      });
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Products",
                        hintStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 0, top: 5),
                        prefixIcon: Icon(Icons.search, color: Colors.black54)),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _icon(Icons.settings, color: Colors.black54)
            ],
          ),
        ],
      ),
    );
  }

  _chips(String name) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isChipSelected = !isCalogSelected;
          });
        },
        child: Wrap(
          spacing: 8,
          children: List.generate(_choicesList.length, (index) {
            return Container(
              margin: const EdgeInsets.all(2),
              child: ChoiceChip(
                labelPadding: const EdgeInsets.all(5.0),
                label: Text(
                  _choicesList[index],
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color(0xff5F6062),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                selected: defaultChoiceIndex == index,
                selectedColor: LightColor.orange,
                onSelected: (value) {
                  print(defaultChoiceIndex);
                  setState(() {
                    defaultChoiceIndex = value ? index : defaultChoiceIndex;
                  });
                },
                elevation: 1,
              ),
            );
          }),
        ));
  }

  Widget _productWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * 1.3,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 8 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        children: AppData.productList
            .map(
              (product) => MediCard(
                product: product,
                onSelected: (model) {
                  setState(() {
                    AppData.productList.forEach((item) {
                      item.isSelected = false;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _mainbody() {
    return isHomePageSelected
        ? const Text("Home Page")
        : isExplorePageSelected
            ? Container(
                height: 1000,
                child: Column(
                  children: [
                    _search(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _chips("Sting"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _productWidget()
                  ],
                ),
              )
            : isCalogSelected
                ? const Text("Catlog Page")
                : isCheckoutSelected
                    ? const Text("Checkout Page")
                    : isClipboardSelected
                        ? const Text("Clipboard Page")
                        : const Text("Catlog Page");
  }

  Widget _appBar() {
    return isHomePageSelected
        ? InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(border: AppTheme.borderappbar),
              padding: AppTheme.padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Home",
                      style: appBarTextHeadding.merge(const TextStyle())),
                  Row(
                    children: [
                      _icon(Icons.notification_add, color: Colors.black54),
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(33)),
                          child: Container(
                            padding: AppTheme.paddingLeft,
                            height: 50,
                            child: pizzaAsset,
                          )),
                    ],
                  )
                ],
              ),
            ))
        : isExplorePageSelected
            ? InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(border: AppTheme.borderappbar),
                  padding: AppTheme.padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Products",
                          style: appBarTextHeadding.merge(const TextStyle())),
                      Row(
                        children: [
                          _icon(Icons.notification_add, color: Colors.black54),
                          ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(33)),
                              child: Container(
                                padding: AppTheme.paddingLeft,
                                height: 50,
                                child: pizzaAsset,
                              )),
                        ],
                      )
                    ],
                  ),
                ))
            : isCalogSelected
                ? InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(border: AppTheme.borderappbar),
                      padding: AppTheme.padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Check Eligiblity ",
                              style:
                                  appBarTextHeadding.merge(const TextStyle())),
                          Row(
                            children: [
                              _icon(Icons.notification_add,
                                  color: Colors.black54),
                              ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(33)),
                                  child: Container(
                                    padding: AppTheme.paddingLeft,
                                    height: 50,
                                    child: pizzaAsset,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ))
                : isCheckoutSelected
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          decoration:
                              BoxDecoration(border: AppTheme.borderappbar),
                          padding: AppTheme.padding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Cart",
                                  style: appBarTextHeadding
                                      .merge(const TextStyle())),
                              Row(
                                children: [
                                  _icon(Icons.notification_add,
                                      color: Colors.black54),
                                  ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(33)),
                                      child: Container(
                                        padding: AppTheme.paddingLeft,
                                        height: 50,
                                        child: pizzaAsset,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ))
                    : isClipboardSelected
                        ? InkWell(
                            onTap: () {},
                            child: Container(
                              decoration:
                                  BoxDecoration(border: AppTheme.borderappbar),
                              padding: AppTheme.padding,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Order",
                                      style: appBarTextHeadding
                                          .merge(const TextStyle())),
                                  Row(
                                    children: [
                                      _icon(Icons.notification_add,
                                          color: Colors.black54),
                                      ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(33)),
                                          child: Container(
                                            padding: AppTheme.paddingLeft,
                                            height: 50,
                                            child: pizzaAsset,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ))
                        : const Text("Catlog Page");
  }

  Widget _title() {
    return isHomePageSelected
        ? const Text("Home Page")
        : isExplorePageSelected
            ? const Text("Explore Page")
            : isCalogSelected
                ? const Text("Catlog Page")
                : isCheckoutSelected
                    ? const Text("Checkout Page")
                    : isClipboardSelected
                        ? const Text("Clipboard Page")
                        : const Text("Catlog Page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                _appBar(),
                _mainbody(),
              ],
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MediCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  MediCard({
    Key? key,
    required this.product,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var add;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: 50,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Image.asset(
                            product.image,
                            width: 80,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500)),

                            // fontSize: product.isSelected ? 16 : 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.price == ""
                                ? "₹ N/A"
                                : "₹ ${product.price}",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff5F6062),
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),

                        //  Icon(Icons.add_circle,
                        Container(
  
                          child: Text("Add Cart Button")
                        )
                        // Image.asset("assets/png/Screenshot 2022-07-01 at 10.40.34 PM.png", height: 30, width: 50,)
                        //     color: LightColor.grey, size: 27),
                        // Icon(Icons.remove_circle,
                        //     color: LightColor.grey, size: 27),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: LightColor.orange,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "Add To Cart",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
