import 'package:equatable/equatable.dart';

class GuideEntity extends Equatable {
  final String? guideId;
  final String full_name;
  final String price;
  final String image;
  final String available;

  const GuideEntity(
      {required this.guideId,
      required this.full_name,
      required this.price,
      required this.image,
      required this.available});

  @override
  // TODO: implement props
  List<Object?> get props => [guideId, full_name, price, image, available];
}
