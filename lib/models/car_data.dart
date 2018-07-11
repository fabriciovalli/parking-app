class CarData {
  CarData({this.brand, this.model, this.modelComplement, this.year});

  String brand;
  String model;
  String modelComplement;
  int year;

  set carYear(int year) => this.year = year;
}
