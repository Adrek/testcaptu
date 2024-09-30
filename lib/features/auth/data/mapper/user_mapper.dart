import 'package:app_captusiat/features/auth/data/models/user_supabase_model.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';

class UserMapper {
  static UserCredentials fromUserSupbaseModel(UserSupabaseModel model) {
    return UserCredentials(
        id: model.id,
        username: model.username,
        token: 'token',
        refreshToken: 'refreshToken');
  }
}
