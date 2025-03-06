import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/features/auth/presentation/view/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock the LoginBloc
class MockLoginBloc extends Mock implements LoginBloc {
  @override
  Stream<LoginState> get stream => Stream<LoginState>.fromIterable([]);
}

// Define a FakeBuildContext
class FakeBuildContext extends Fake implements BuildContext {}

// Define a FakeLoginEvent
class FakeLoginEvent extends Fake implements LoginEvent {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUpAll(() {
    registerFallbackValue(Container()); // Register a dummy Widget
    registerFallbackValue(FakeLoginEvent()); // Register a dummy LoginEvent
    registerFallbackValue(FakeBuildContext()); // Register a dummy BuildContext
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    when(() => mockLoginBloc.add(any())).thenAnswer((_) async {});
  });

  // Helper function to create the LoginView wrapped in a BlocProvider
  Widget createLoginView() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: mockLoginBloc,
        child: const LoginView(),
      ),
    );
  }

  group('LoginView Widget Tests', () {
    testWidgets('renders LoginView correctly', (WidgetTester tester) async {
      // Build the LoginView
      await tester.pumpWidget(createLoginView());

      // Verify that the LoginView renders correctly
      expect(find.text('Welcome to Guide Go!'), findsOneWidget);
      expect(find.text('From Far to Near, Your Guide is Here'), findsOneWidget);

      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Don’t have an account? Register'), findsOneWidget);
    });

    testWidgets('shows error messages when form is empty',
        (WidgetTester tester) async {
      // Build the LoginView
      await tester.pumpWidget(createLoginView());

      // Ensure the Login button is visible
      await tester.ensureVisible(find.text('Login'));

      // Tap the Login button without entering any data
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle(); // Allow the form validation to complete

      // Verify that error messages are shown
      expect(find.text('Please enter username'), findsOneWidget);
      expect(find.text('Please enter password'), findsOneWidget);
    });


  });
}