import 'package:flutter/material.dart';
import 'package:movie_master_detail/core/core_providers/app_repository_provider.dart';
import 'package:movie_master_detail/core/core_providers/app_service_provider.dart';
import 'package:movie_master_detail/core/movie_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  return runApp(
    AppServiceProvider(
      sharedPreferences: sharedPreferences,
      child: AppRepositoryProvider(
        child: MovieApp(),
      ),
    ),
  );
}
