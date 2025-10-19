import 'package:hive/hive.dart';

part 'curr_color_scheme_persistency.g.dart';

@HiveType(typeId: 0)
class CurrColorScheme extends HiveObject {
  @HiveField(0)
  final String schemeName;

  CurrColorScheme({required this.schemeName});
}
