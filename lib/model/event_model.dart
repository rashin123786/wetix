class EventModel {
  final String id;
  final String userId;
  final String event;
  final String organization;
  final String eventCategory;
  final List<String> imagePath;
  final DateTime startDate;
  final DateTime endDate;
  final String place;
  final double price;
  final String note;
  final String status;
  final bool isBooked;
  final dynamic eventMap;
  final String feeOptions;
  final bool isDelete;

  EventModel({
    required this.id,
    required this.userId,
    required this.event,
    required this.organization,
    required this.eventCategory,
    required this.imagePath,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.price,
    required this.note,
    required this.status,
    required this.isBooked,
    required this.eventMap,
    required this.feeOptions,
    required this.isDelete,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      userId: json['userId'],
      event: json['event'],
      organization: json['organization'],
      eventCategory: json['eventCategory'],
      imagePath: List<String>.from(json['imagePath']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      place: json['place'],
      price: json['price'].toDouble(),
      note: json['note'],
      status: json['status'],
      isBooked: json['isBooked'],
      eventMap: json['eventMap'],
      feeOptions: json['feeOptions'],
      isDelete: json['is_delete'],
    );
  }
}
