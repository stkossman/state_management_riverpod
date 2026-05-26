import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_management_riverpod/main.dart';

void main() {
  testWidgets('shows shop screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    expect(find.text('SHOP'), findsOneWidget);
    expect(find.text('SEARCH PRODUCTS'), findsOneWidget);
  });
}
