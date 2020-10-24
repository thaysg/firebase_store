class SectionItem{

  SectionItem.fromMap(Map<String, dynamic>map){
    image = map['image'] as String;
    title = map['title'] as String;
    product = map['product'] as String;
  }

  String image;
  String title;

  String product;

  @override
  String toString() {
    return 'SectionItem{image: $image, title: $title, product: $product}';
  }
}