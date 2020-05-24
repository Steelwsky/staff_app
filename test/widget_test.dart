import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staffapp/main.dart';
import 'package:staffapp/models/staff_model.dart';

import 'test_database.dart';

void main() {
  Future<void> givenAppIsPumped(WidgetTester tester, TestDatabase testDatabase) async {
    await tester.pumpWidget(
      MyApp(database: testDatabase),
    );
  }

  group('main widget possibilities', () {
    testWidgets('should see empty staff page after app is pumped', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      thenShouldBeEmptyStaffPage();
    });

    testWidgets('staff creating page should be opened', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      await tester.tap(find.byKey(ValueKey('fabCreateStaff')));
      await tester.pumpAndSettle();
      expect(find.text('Создание сотрудника'), findsOneWidget);
    });

    testWidgets('should see failed date snackbar on save button pressed', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      await tester.tap(find.byKey(ValueKey('fabCreateStaff')));
      await tester.pumpAndSettle();
      expect(find.text('Создание сотрудника'), findsOneWidget);
      await tester.tap(find.text('Сохранить'));
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should see date picker after click on calendar icon', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      await tester.tap(find.byKey(ValueKey('fabCreateStaff')));
      await tester.pumpAndSettle();
      expect(find.text('Создание сотрудника'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();
      thenShouldBeDatePicker();
    });

    testWidgets('date picker should be closed after pressing button', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      await tester.tap(find.byKey(ValueKey('fabCreateStaff')));
      await tester.pumpAndSettle();
      expect(find.text('Создание сотрудника'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();
      expect(find.text('Готово'), findsOneWidget);
      expect(find.text('2020'), findsOneWidget);
      await tester.tap(find.text('Готово'));
      await tester.pumpAndSettle();
      expect(find.text('Готово'), findsNothing);
      expect(find.text('2020'), findsNothing);
    });
  });

  group('description', () {
    testWidgets('should see empty staff page after app is pumped', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      await givenAppIsPumped(tester, testDatabase);
      thenShouldBeEmptyStaffPage();
    });

    testWidgets('should see 1 item after app is pumped', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      StaffMemberModel staffMemberModel = StaffMemberModel(
        lastName: 'lastName',
        firstName: 'name',
        middleName: 'middleName',
        birthDay: '2004-08-26',
        position: 'pos',
      );
      testDatabase.staffList.add(staffMemberModel);
      await givenAppIsPumped(tester, testDatabase);
      await tester.pumpAndSettle();
      thenShouldBeItemInStaffPage(staffMemberModel);
    });

    testWidgets('children amount not loaded after app is pumped', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      StaffMemberModel staffMemberModel = StaffMemberModel(
        lastName: 'lastName',
        firstName: 'name',
        middleName: 'middleName',
        birthDay: '2004-08-26',
        position: 'pos',
      );
      testDatabase.staffList.add(staffMemberModel);
      await givenAppIsPumped(tester, testDatabase);
      await tester.pumpAndSettle();
      thenShouldLoadingChildrenAmount();
    });

    testWidgets('selecting staff item changes the page', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      StaffMemberModel staffMemberModel = StaffMemberModel(
        lastName: 'lastName',
        firstName: 'name',
        middleName: 'middleName',
        birthDay: '2004-08-26',
        position: 'pos',
      );
      testDatabase.staffList.add(staffMemberModel);
      await givenAppIsPumped(tester, testDatabase);
      await tester.pumpAndSettle();
      await tester
          .tap(find.text('${staffMemberModel.lastName} ${staffMemberModel.firstName} ${staffMemberModel.middleName}'));
      await tester.pumpAndSettle();
      thenShouldBeSelectedStaffPage(staffMemberModel);
    });

    testWidgets('should see zero children in selected staff page', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      StaffMemberModel staffMemberModel = StaffMemberModel(
        lastName: 'lastName',
        firstName: 'name',
        middleName: 'middleName',
        birthDay: '2004-08-26',
        position: 'pos',
      );
      testDatabase.staffList.add(staffMemberModel);
      await givenAppIsPumped(tester, testDatabase);
      await tester.pumpAndSettle();
      await tester
          .tap(find.text('${staffMemberModel.lastName} ${staffMemberModel.firstName} ${staffMemberModel.middleName}'));
      await tester.pumpAndSettle();
      thenShouldBeZeroChildren();
    });

    testWidgets('should open the child creating page', (WidgetTester tester) async {
      TestDatabase testDatabase = TestDatabase();
      StaffMemberModel staffMemberModel = StaffMemberModel(
        lastName: 'lastName',
        firstName: 'name',
        middleName: 'middleName',
        birthDay: '2004-08-26',
        position: 'pos',
      );
      testDatabase.staffList.add(staffMemberModel);
      await givenAppIsPumped(tester, testDatabase);
      await tester.pumpAndSettle();
      await tester
          .tap(find.text('${staffMemberModel.lastName} ${staffMemberModel.firstName} ${staffMemberModel.middleName}'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();
      thenShouldBeChildCreatingPage();
    });
  });
}

void thenShouldBeEmptyStaffPage() {
  expect(find.byKey(ValueKey('emptyStaffList')), findsOneWidget);
}

void thenShouldBeItemInStaffPage(StaffMemberModel staffMemberModel) {
  expect(find.text('${staffMemberModel.lastName} ${staffMemberModel.firstName} ${staffMemberModel.middleName}'),
      findsOneWidget);
  expect(find.byKey(ValueKey('emptyStaffList')), findsNothing);
}

void thenShouldBeDatePicker() {
  expect(find.text('Готово'), findsOneWidget);
  expect(find.text('2020'), findsOneWidget);
  expect(find.text('Май'), findsOneWidget);
}

void thenShouldLoadingChildrenAmount() {
  expect(find.text('загрузка...'), findsOneWidget);
}

void thenShouldBeSelectedStaffPage(StaffMemberModel staffMemberModel) {
  expect(find.text('${staffMemberModel.lastName} ${staffMemberModel.firstName}'), findsOneWidget);
}

void thenShouldBeZeroChildren() {
  expect(find.byKey(ValueKey('emptyChildrenList')), findsOneWidget);
  expect(find.text('Детей нет'), findsOneWidget);
}

void thenShouldBeChildCreatingPage() {
  expect(find.text('Добавление ребенка'), findsOneWidget);
}

Future whenUserGoesBack(WidgetTester tester) async {
  await tester.tap(find.byType(BackButtonIcon));
  await tester.pumpAndSettle();
}
