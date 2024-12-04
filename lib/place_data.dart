class PlaceData{
  int id;
  String name;
  String image;
  String tag;
  String place;
  String data;
  String rating;
  bool isPopular;
  PlaceData({
    required this.id,
    required this.name,
    required this.image,
    required this.tag,
    required this.place,
    required this.data,
    required this.rating,
    required this.isPopular,
  });
}


void main(){
  Future.delayed(const Duration(seconds: 1),(){
    print("dsadsadasdsa");
    throw Exception("ds");
  });
  for (int i = 0; i < 1000000000; i++) {
    print("s $i");
  }
}