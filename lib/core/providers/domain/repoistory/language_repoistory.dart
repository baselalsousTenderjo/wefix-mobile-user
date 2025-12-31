import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../errors/dio_exp.dart';
import '../../../errors/failure.dart';
import '../../../services/api_services/result_model.dart';
import '../model/language_model.dart';

abstract class LanguageRepoistory {
  Future<Either<Failure, Result<AppLanguageModel>>> getLanguage();
}

class LanguageRepoistoryImpl implements LanguageRepoistory {
  @override
  Future<Either<Failure, Result<AppLanguageModel>>> getLanguage() async {
    try {
      // Load languages from local JSON file instead of API
      final String jsonString = await rootBundle.loadString('assets/languages.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      AppLanguageModel languageModel = AppLanguageModel.fromJson(jsonData);
      return Right(Result.success(languageModel));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load localizations: ${e.toString()}'));
    }
  }
}
