import '../../utils/app_constants.dart';

class Gift {
  final String id; 
  final String eventId; 
  final String guestId; 
  final String qrToken; 
  final GiftStatus status; 
  final DateTime? unlockedAt; 
  final DateTime? redeemedAt; 
  final String? redeemedBy; 

  Gift({
    required this.id, required this.eventId, required this.guestId,
    required this.qrToken, required this.status, this.unlockedAt,
    this.redeemedAt, this.redeemedBy,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
    id: json['id'],
    eventId: json['event_id'],
    guestId: json['guest_id'],
    qrToken: json['qr_token'],
    status: GiftStatus.values.byName(json['status']),
    unlockedAt: json['unlocked_at'] != null ? DateTime.parse(json['unlocked_at']) : null,
    redeemedAt: json['redeemed_at'] != null ? DateTime.parse(json['redeemed_at']) : null,
    redeemedBy: json['redeemed_by'],
  );
}