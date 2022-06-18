import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/type_product_2.dart';
import 'package:flutter_cahoi_barbershop/core/services/booking_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/admin_model/product_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/success_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/product/add_product.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/product/edit_product.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/product/show_product_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
    with SingleTickerProviderStateMixin {
  late Size size;
  List<TypeProduct2> typeProducts = locator<BookingService>().typeProducts;
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<ProductModel>(
      onModelReady: (model) {
        tabController = TabController(
          length: typeProducts.length,
          vsync: this,
        );
      },
      builder: (context, model, child) {
        typeProducts = locator<BookingService>().typeProducts;

        return Scaffold(
          backgroundColor: backgroundColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var res = await Navigator.pushNamed(context, AddProductView.name);
              if (res != null && res == true) {
                await model.getAllProduct();
              }
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: typeProducts.isEmpty
                ? null
                : TabBar(
                    labelStyle: const TextStyle(
                      fontFamily: fontBold,
                    ),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    controller: tabController,
                    automaticIndicatorColorAdjustment: true,
                    tabs: _buildTabBar(),
                  ),
          ),
          body: Stack(
            children: [
              typeProducts.isEmpty
                  ? Container()
                  : TabBarView(
                      children: _buildTabView(model),
                      controller: tabController,
                    ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildTabBar() {
    List<Widget> tabs = [];
    for (int i = 0; i < typeProducts.length; i++) {
      tabs.add(
        Tab(
          text: typeProducts[i].name,
        ),
      );
    }
    return tabs;
  }

  List<Widget> _buildTabView(ProductModel model) {
    final paddingW = size.width * 0.01;

    List<Widget> tabBarViews = [];
    for (int i = 0; i < typeProducts.length; i++) {
      tabBarViews.add(
        typeProducts[i].products!.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/not_item.png',
                  height: size.width * 0.3,
                  // width: ,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await model.getAllProduct();
                },
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: paddingW,
                    right: paddingW,
                    top: paddingW,
                    bottom: size.height * 0.1,
                  ),
                  cacheExtent: 1000,
                  itemCount: typeProducts[i].products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 4 / 7,
                  ),
                  itemBuilder: (context, index) {
                    final product = typeProducts[i].products![index];
                    return _buildProductTile(
                      product: product,
                      onRemove: () async {
                        if (await model.deleteProduct(productId: product.id)) {
                          SuccessDialog.show(
                            context,
                            btnOkOnPress: () async {
                              await model.getAllProduct();
                            },
                          );
                        } else {
                          Fluttertoast.showToast(msg: "Đã có sự cố");
                        }
                      },
                    );
                  },
                ),
              ),
      );
    }
    return tabBarViews;
  }

  Widget _buildProductTile(
      {required Product product, required Function() onRemove}) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          ShowProductView.name,
          arguments: product,
        );
      },
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      '$localHost${product.image}',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: fontBold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.sortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: fontLight,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price}K',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontBold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 18,
                            ),
                            Text(
                              '${product.duration} phút',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // TextButton(
                    //   onPressed: () {
                    //     AwesomeDialog(
                    //       context: context,
                    //       dialogType: DialogType.QUESTION,
                    //       title: "Xác nhận",
                    //       desc: "Bạn có muốn xóa sản phẩm này không?",
                    //       btnOkOnPress: onRemove,
                    //       btnCancelOnPress: () {},
                    //     ).show();
                    //   },
                    //   child: const Text("Xóa"),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO sửa dịch vụ
                        Navigator.pushNamed(
                          context,
                          EditProductView.name,
                          arguments: product,
                        );
                      },
                      child: const Text("Sửa"),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(
              Icons.info_outline,
              color: Theme.of(context).backgroundColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
