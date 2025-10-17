import 'package:equatable/equatable.dart';

/// Entity representing an African historical site
class HistoricalSite extends Equatable {
  final String id;
  final String name;
  final String description;
  final String location;
  final String country;
  final String region;
  final String period;
  final String significance;
  final List<String> imageUrls;
  final String category; // temple, palace, archaeological site, etc.
  final bool isUnescoSite;
  final String visitInfo;

  const HistoricalSite({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.country,
    required this.region,
    required this.period,
    required this.significance,
    required this.imageUrls,
    required this.category,
    required this.isUnescoSite,
    required this.visitInfo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        location,
        country,
        region,
        period,
        significance,
        imageUrls,
        category,
        isUnescoSite,
        visitInfo,
      ];
}