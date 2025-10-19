import 'package:hive/hive.dart';

part 'color_scheme.g.dart';

@HiveType(typeId: 0)
class CurrColorScheme extends HiveObject {
  @HiveField(0)
  final String schemeName;

  CurrColorScheme({required this.schemeName});
}
