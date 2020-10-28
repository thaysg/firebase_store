class SectionItem {
  SectionItem({this.image, this.product, this.title});

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
    title = map['title'] as String;
    product = map['product'] as String;
  }

  dynamic image;
  String title;
  String product;

  SectionItem clone() {
    return SectionItem(
      image: image,
      title: title,
      product: product,
    );
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, title: $title, product: $product}';
  }
}
