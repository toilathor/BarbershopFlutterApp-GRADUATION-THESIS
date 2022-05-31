import 'package:flutter_cahoi_barbershop/core/models/product.dart';

/// id : 1
/// name : "Cắt gội massage"
/// products : [{"id":1,"name":"ShineCombo cắt gội 10 bước","duration":45,"price":120,"sort_description":"Đặc sắc nổi tiếng","description":"Combo “đặc sản” của 30Shine, bạn sẽ cùng chúng tôi trải nghiệm chuyến hành trình tỏa sáng đầy thú vị - nơi mỗi người đàn ông không chỉ cắt tóc mà còn tìm thấy nhiều hơn như thế","image":"/upload/products/Cắt_gội_massage/ShineCombo_cắt_gội_10_bước.jpg","type_product_id":1},{"id":2,"name":"Combo Super Vip - Paradise Siêu Cấp","duration":60,"price":300,"sort_description":"Cắt_gội_massage đẳng cấp - phục vụ chỉ 15 khách/ngày","description":"Trải nghiệm đẳng cấp xuyên suốt từ đội ngũ tuyển chọn chuyên phục vụ khách VIP, quy trình thiết kế đặc biệt 16 bước chuyên nghiệp","image":"/upload/products/Cắt_gội_massage/Combo_Super_Vip_-_Paradise_Siêu_Cấp.jpg","type_product_id":1},{"id":3,"name":"Gội massage dưỡng sinh","duration":20,"price":40,"sort_description":"Gội sấy vuốt sáp - Siêu thư giãn","description":"Thư giãn, giải tỏa mệt mỏi ư! Đơn giản, các bạn skinner với bài gội đầu massage dưỡng sinh sẽ giúp anh. Sau cùng stylist sẽ vuốt sáp tạo kiểu để đẹp trai cả ngày","image":"/upload/products/Cắt_gội_massage/Gội_massage_dưỡng_sinh.jpg","type_product_id":1},{"id":4,"name":"Kid combo","duration":30,"price":70,"sort_description":"Mĩ phẩm dịu nhẹ - thợ chiều trẻ em","description":"Đẹp trai không phân biệt tuổi tác! Gói dịch vụ thiết kế dành riêng cho các bé trai, mĩ phẩm dịu nhẹ phù hợp với làn da và phải nói nhỏ thợ tại 30Shine siêu chiều các bé!","image":"/upload/products/Cắt_gội_massage/Kid_combo.jpg","type_product_id":1},{"id":5,"name":"Cắt xả tạo kiểu nhanh (Không gội massage)","duration":30,"price":80,"sort_description":"Stylist cắt - xả - vuốt sáp tạo kiểu (Không gội massage)","description":"Quá bận! Eo hẹp về thời gian, phải đi công chuyện gấp thì đây là gói dịch vụ anh nên chọn! Thợ cắt sẽ xả và cắt tóc tạo kiểu cho anh luôn!","image":"/upload/products/Cắt_gội_massage/Cắt_xả_tạo_kiểu_nhanh_(Không_gội_massage).jpg","type_product_id":1},{"id":6,"name":"Gội massage bấm huyệt VIP","duration":35,"price":80,"sort_description":"Kết hợp đai rung bụng và cao dán nhân sâm giảm đau nhức","description":"Giải tỏa căng thẳng mệt mỏi nhanh chóng với gói dịch vụ massage bấm huyệt tuyệt vời này","image":"/upload/products/Cắt_gội_massage/Gội_massage_bấm_huyệt_VIP.jpg","type_product_id":1},{"id":7,"name":"Combo Gội SuperVip Paradise","duration":50,"price":220,"sort_description":"Trải nghiệm dịch vụ GỘI VIP nhất từ trước đến giờ!!!!","description":"Không gian nội thất thư giãn, thoáng đãng, nội thất sang trọng cùng dàn Skinner chuyên nghiệp, hứa hẹn đem lại cho khách trải nghiệm tuyệt nhất.","image":"/upload/products/Cắt_gội_massage/Combo_Gội_SuperVip_Paradise.jpg","type_product_id":1}]

class TypeProduct2 {
  TypeProduct2({
    this.id,
    this.name,
    this.products,
  });

  TypeProduct2.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  List<Product>? products;

  TypeProduct2 copyWith({
    int? id,
    String? name,
    List<Product>? products,
  }) =>
      TypeProduct2(
        id: id ?? this.id,
        name: name ?? this.name,
        products: products ?? this.products,
      );
}
