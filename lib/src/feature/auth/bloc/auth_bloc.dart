import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

///
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ///
  final AuthRepository authRepository;

  ///
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        await authRepository.login(event.params);
        emit(LoginSuccess());
      } catch (e) {
        if (e is DioException) {
          final String? errorMessage = e.response?.data['message'].toString();
          emit(AuthFailure(errorMessage.toString()));
        } else {
          emit(AuthFailure(e.toString()));
        }

        rethrow;
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(RegisterLoading());

      try {
        await authRepository.register(event.params);
        emit(RegisterSuccess());
      } catch (e) {
        if (e is DioException) {
          final String? errorMessage = e.response?.data['message'].toString();
          emit(AuthFailure(errorMessage.toString()));
        } else {
          emit(AuthFailure(e.toString()));
        }

        rethrow;
      }
    });

    on<TokenRefreshRequested>((event, emit) async {
      emit(TokenRefreshLoading());
      try {
        await authRepository.refresh(event.refreshToken);
        emit(TokenRefreshSuccess());
      } catch (e) {
        if (e is DioException) {
          final String? errorMessage = e.response?.data['message'].toString();
          emit(AuthFailure(errorMessage.toString()));
        } else {
          emit(AuthFailure(e.toString()));
        }
        rethrow;
      }
    });
  }
}
