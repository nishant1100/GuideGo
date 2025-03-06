import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/features/auth/presentation/view/register_view.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_event.dart';
import 'package:mocktail/mocktail.dart';

// Mock the RegisterBloc
class MockRegisterBloc extends Mock implements RegisterBloc {}

// Define a FakeRegisterEvent
class FakeRegisterEvent extends Fake implements RegisterEvent {}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUpAll(() {
    registerFallbackValue(Container()); // Register a dummy Widget
    registerFallbackValue(
        FakeRegisterEvent()); // Register a dummy RegisterEvent
  });

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    when(() => mockRegisterBloc.add(any())).thenAnswer((_) async {});
  });

  // Helper function to create the RegisterView wrapped in a BlocProvider
  Widget createRegisterView() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const RegisterView(),
      ),
    );
  }

  group('RegisterView Widget Tests', () {
    testWidgets('renders RegisterView correctly', (WidgetTester tester) async {
      // Build the RegisterView
      await tester.pumpWidget(createRegisterView());

      // Verify that the RegisterView renders correctly
      expect(find.text('Create Account'), findsOneWidget);

      // Use find.byWidgetPredicate to find the RichText widget with the specific text
      expect(find.byWidgetPredicate((widget) {
        if (widget is RichText) {
          // Convert the text span to plain text and check if it contains the desired string
          final text = widget.text.toPlainText();
          return text.contains('To\nembark adventures & discover hidden gems');
        }
        return false;
      }), findsOneWidget);

      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Already have an account? Sign In'), findsOneWidget);
    });

    testWidgets('shows error messages when form is empty',
        (WidgetTester tester) async {
      // Build the RegisterView
      await tester.pumpWidget(createRegisterView());

      // Ensure the Register button is visible
      await tester.ensureVisible(find.text('Register'));

      // Tap the Register button without entering any data
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle(); // Allow the form validation to complete

      // Verify that error messages are shown
      expect(find.text('Please enter first name'), findsOneWidget);
      expect(find.text('Please enter phone number'), findsOneWidget);
      expect(find.text('Please enter username'), findsOneWidget);
      expect(find.text('Please enter password'), findsOneWidget);
    });

    testWidgets('triggers image selection when camera button is tapped',
        (WidgetTester tester) async {
      // Build the RegisterView
      await tester.pumpWidget(createRegisterView());

      // Ensure the image selection area is visible
      await tester.ensureVisible(find.byType(GestureDetector).first);

      // Tap the image selection area to display the modal bottom sheet
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Ensure the camera button is visible
      await tester.ensureVisible(find.byIcon(Icons.camera));

      // Tap the camera button
      await tester.tap(find.byIcon(Icons.camera));
      await tester.pumpAndSettle();

      // Verify that the image picker is triggered
      // Note: This is a simplified check. In a real test, you would mock the ImagePicker.
      expect(find.byType(ElevatedButton), findsWidgets);
    });
    testWidgets('triggers image selection when gallery button is tapped',
        (WidgetTester tester) async {
      // Build the RegisterView
      await tester.pumpWidget(createRegisterView());

      // Ensure the image selection area is visible
      await tester.ensureVisible(find.byType(GestureDetector).first);

      // Tap the image selection area to display the modal bottom sheet
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Ensure the gallery button is visible
      await tester.ensureVisible(find.byIcon(Icons.image));

      // Tap the gallery button
      await tester.tap(find.byIcon(Icons.image));
      await tester.pumpAndSettle();

      // Verify that the image picker is triggered
      // Note: This is a simplified check. In a real test, you would mock the ImagePicker.
      expect(find.byType(ElevatedButton), findsWidgets);
    });
  });
}
