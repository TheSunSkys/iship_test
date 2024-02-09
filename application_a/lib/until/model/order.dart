import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  const OrderModel({
    required this.id,
    required this.logoMobile,
    required this.statusName,
    required this.trackNo,
    required this.srcName,
    required this.dstName,
  });

  final int id;
  final String logoMobile, statusName, trackNo, srcName, dstName;

  static const empty = OrderModel(
    id: -1,
    logoMobile: '',
    statusName: '',
    trackNo: '',
    srcName: '',
    dstName: '',
  );

  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty;

    return OrderModel(
      id: json['id'] ?? empty.id,
      logoMobile: json['logo_mobile'] ?? empty.logoMobile,
      statusName: json['status_name'] ?? empty.statusName,
      trackNo: json['track_no'] ?? empty.trackNo,
      srcName: json['src_name'] ?? empty.srcName,
      dstName: json['dst_name'] ?? empty.dstName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        logoMobile,
        statusName,
        trackNo,
        srcName,
        dstName,
      ];
}
