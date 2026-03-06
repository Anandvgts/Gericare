import 'package:equatable/equatable.dart';

class ForgotPasswordResponse extends Equatable {
  final String exchangeKey;

  const ForgotPasswordResponse({
    required this.exchangeKey,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      exchangeKey: json['exchange_key'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exchange_key': exchangeKey,
    };
  }

  @override
  List<Object?> get props => [exchangeKey];
}
