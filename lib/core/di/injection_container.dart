import 'package:get_it/get_it.dart';

// Data sources
import '../../data/datasources/local_data_source.dart';

// Repository implementations
import '../../data/repositories/tale_repository_impl.dart';
import '../../data/repositories/historical_figure_repository_impl.dart';
import '../../data/repositories/african_festival_repository_impl.dart';
import '../../data/repositories/african_kingdom_repository_impl.dart';
import '../../data/repositories/african_music_repository_impl.dart';
import '../../data/repositories/art_object_repository_impl.dart';
import '../../data/repositories/quote_repository_impl.dart';

// Repository interfaces
import '../../domain/repositories/tale_repository.dart';
import '../../domain/repositories/historical_figure_repository.dart';
import '../../domain/repositories/african_festival_repository.dart';
import '../../domain/repositories/african_kingdom_repository.dart';
import '../../domain/repositories/african_music_repository.dart';
import '../../domain/repositories/art_object_repository.dart';
import '../../domain/repositories/quote_repository.dart';

// Use cases - Tales
import '../../domain/usecases/get_tales.dart';

// Use cases - Historical Figures  
import '../../domain/usecases/get_historical_figures.dart';
import '../../domain/usecases/search_historical_figures.dart';

// Use cases - Festivals
import '../../domain/usecases/get_festivals.dart';

// Use cases - Kingdoms
import '../../domain/usecases/get_kingdoms.dart';

// Use cases - Music
import '../../domain/usecases/get_music.dart';

// Use cases - Art Objects
import '../../domain/usecases/get_art_objects.dart';

// Use cases - Quotes
import '../../domain/usecases/get_quotes.dart';

// Repositories - African Deities
import '../../domain/repositories/african_deity_repository.dart';
import '../../data/repositories/african_deity_repository_impl.dart';

// Repositories - Historical Sites
import '../../domain/repositories/historical_site_repository.dart';
import '../../data/repositories/historical_site_repository_impl.dart';

// Repositories - Museums
import '../../domain/repositories/museum_repository.dart';
import '../../data/repositories/museum_repository_impl.dart';

// Use cases - African Deities
import '../../domain/usecases/get_deities.dart';

// Use cases - Historical Sites
import '../../domain/usecases/get_historical_sites.dart';

// Use cases - Museums
import '../../domain/usecases/get_museums.dart';

// ViewModels
import '../../presentation/viewmodels/tale_viewmodel.dart';
import '../../presentation/viewmodels/historical_figure_viewmodel.dart';
import '../../presentation/viewmodels/african_festival_viewmodel.dart';
import '../../presentation/viewmodels/african_kingdom_viewmodel.dart';
import '../../presentation/viewmodels/african_music_viewmodel.dart';
import '../../presentation/viewmodels/art_object_viewmodel.dart';
import '../../presentation/viewmodels/quote_viewmodel.dart';
import '../../presentation/viewmodels/african_deity_viewmodel.dart';
import '../../presentation/viewmodels/historical_site_viewmodel.dart';
import '../../presentation/viewmodels/museum_viewmodel.dart';

final GetIt sl = GetIt.instance;

/// Initialize all dependencies for dependency injection
Future<void> initializeDependencies() async {
  // Data sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<TaleRepository>(
    () => TaleRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<HistoricalFigureRepository>(
    () => HistoricalFigureRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<AfricanFestivalRepository>(
    () => AfricanFestivalRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<AfricanKingdomRepository>(
    () => AfricanKingdomRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<AfricanMusicRepository>(
    () => AfricanMusicRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<ArtObjectRepository>(
    () => ArtObjectRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<AfricanDeityRepository>(
    () => AfricanDeityRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<HistoricalSiteRepository>(
    () => HistoricalSiteRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<MuseumRepository>(
    () => MuseumRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTales(sl()));
  sl.registerLazySingleton(() => GetHistoricalFigures(sl()));
  sl.registerLazySingleton(() => SearchHistoricalFigures(sl()));
  sl.registerLazySingleton(() => GetFestivals(sl()));
  sl.registerLazySingleton(() => GetKingdoms(sl()));
  sl.registerLazySingleton(() => GetMusic(sl()));
  sl.registerLazySingleton(() => GetArtObjects(sl()));
  sl.registerLazySingleton(() => GetQuotes(sl()));
  sl.registerLazySingleton(() => GetDeities(sl()));
  sl.registerLazySingleton(() => GetHistoricalSites(sl()));
  sl.registerLazySingleton(() => GetMuseums(sl()));

  // ViewModels
  sl.registerFactory(() => TaleViewModel());
  sl.registerFactory(() => HistoricalFigureViewModel());
  sl.registerFactory(() => AfricanFestivalViewModel());
  sl.registerFactory(() => AfricanKingdomViewModel());
  sl.registerFactory(() => AfricanMusicViewModel());
  sl.registerFactory(() => ArtObjectViewModel());
  sl.registerFactory(() => QuoteViewModel());
  sl.registerFactory(() => AfricanDeityViewModel());
  sl.registerFactory(() => HistoricalSiteViewModel());
  sl.registerFactory(() => MuseumViewModel());
}