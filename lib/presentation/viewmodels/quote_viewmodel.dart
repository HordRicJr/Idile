import 'package:flutter/foundation.dart';
import '../../domain/entities/quote.dart';
import '../../domain/usecases/get_quotes.dart';
import '../../core/di/injection_container.dart';

class QuoteViewModel extends ChangeNotifier {
  final GetQuotes _getQuotes = sl<GetQuotes>();

  List<Quote> _quotes = [];
  bool _isLoading = false;
  String? _error;

  List<Quote> get quotes => _quotes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getQuotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getQuotes();
    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (quotesList) {
        _quotes = quotesList;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}