import 'package:app4car/models/car_data.dart';
import 'package:meta/meta.dart';

@immutable
class CarState {
  final CarData selectedCar;
  final List<CarData> cars;

  CarState({
    @required this.selectedCar,
    @required this.cars,
  });

  factory CarState.initial() {
    return CarState(
      selectedCar: null,
      cars: <CarData>[],
    );
  }

  CarState copyWith({
    CarData selectedCar,
    List<CarData> cars,
  }) {
    return CarState(
      selectedCar: selectedCar ?? this.selectedCar,
      cars: cars ?? this.cars,
    );
  }

  //TODO: Equals e hashCode
}
