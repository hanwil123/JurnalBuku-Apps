import 'package:fpdart/fpdart.dart';
import 'package:jurnalbukuapps/core/Error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signupWithEmailPassword ({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> loginWithEmailPassword ({
    required String email,
    required String password,
  });
}