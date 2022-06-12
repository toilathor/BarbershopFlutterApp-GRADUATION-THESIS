import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/type_product.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/product_tile.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';

class SelectProductView extends StatefulWidget {
  final BookingModel model;

  const SelectProductView({Key? key, required this.model}) : super(key: key);

  @override
  _SelectProductViewState createState() => _SelectProductViewState();
}

class _SelectProductViewState extends State<SelectProductView>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  late TabController tabController = TabController(length: 0, vsync: this);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<BookingModel>(
      onModelReady: (model) async {
        await model.changeTypeProduct();

        tabController = TabController(
          length: model.typeProducts.length,
          vsync: this,
        );
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: model.typeProducts.isEmpty
              ? null
              : TabBar(
                  labelStyle: const TextStyle(
                    fontFamily: fontBold,
                  ),
                  physics: const BouncingScrollPhysics(),
                  isScrollable: true,
                  controller: tabController,
                  automaticIndicatorColorAdjustment: true,
                  tabs: _buildTabBar(
                    typeProducts: model.typeProducts,
                  ),
                ),
          title: Text(
            appLang(context)!.select_product,
          ),
        ),
        body: Stack(
          children: [
            model.typeProducts.isEmpty
                ? Container()
                : TabBarView(
                    children: _buildTabBarView(model),
                    controller: tabController,
                  ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.08,
                padding: const EdgeInsets.all(8.0),
                color: Theme.of(context).backgroundColor,
                child: ElevatedButtonIcon(
                  onPressed: model.selectedProducts.isEmpty
                      ? null
                      : () {
                          Navigator.of(context)
                              .pop({'services': model.selectedProducts});
                        },
                  title: appLang(context)!
                      .selected_num("${model.selectedProducts.length}")
                      .toUpperCase(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabBar({required List<TypeProduct> typeProducts}) {
    List<Widget> tabs = [];
    for (int i = typeProducts.length - 1; i >= 0; i--) {
      tabs.add(
        Tab(
          text: typeProducts[i].name,
        ),
      );
    }
    return tabs;
  }

  List<Widget> _buildTabBarView(BookingModel model) {
    final paddingW = size.width * 0.01;

    List<Widget> tabBarViews = [];
    for (int i = model.typeProducts.length - 1; i >= 0; i--) {
      tabBarViews.add(
        model.products[i].isEmpty
            ? Center(
                child: Image.asset(
                  'assets/not_item.png',
                  height: size.width * 0.3,
                  // width: ,
                ),
              )
            : GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: paddingW,
                  right: paddingW,
                  top: paddingW,
                  bottom: size.height * 0.1,
                ),
                itemCount: model.products[i].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 7,
                ),
                itemBuilder: (context, index) {
                  final productTemp = model.products[i][index];

                  return ProductTile(
                    isSelected: model.selectedProducts.contains(productTemp),
                    onPressSelect: () {
                      model.selectedProduct(productTemp);
                    },
                    width: size.width / 2,
                    height: size.height / 2.7,
                    product: productTemp,
                  );
                },
              ),
      );
    }
    return tabBarViews;
  }
}
