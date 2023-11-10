// Busca dados da conta do usuário (não importa da onde)
import '../entities/entities.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity> load();
}
