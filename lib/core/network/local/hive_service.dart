import 'package:chitto_tatto/config/constants/hive_table_constants.dart';
import 'package:chitto_tatto/features/auth/data/model/user_hive_model.dart';
import 'package:chitto_tatto/features/category/data/model/category_hive_model.dart';
import 'package:chitto_tatto/features/food/data/model/food/food_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider(
  (ref) => HiveServices(),
);

class HiveServices {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(FoodHiveModelAdapter());

    await addDummyCategory();
  }

// //batches
  Future<void> addCategory(CategoryHiveModel category) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(category.categoryId, category);
    box.close();
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    var categories = box.values.toList();
    // box.close();
    return categories;
  }

// //courses
//   Future<void> addCourse(CourseHiveModel course) async {
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     await box.put(course.courseId, course);
//     box.close();
//   }

//   Future<List<CourseHiveModel>> getAllCourses() async {
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     var courses = box.values.toList();
//     box.close();
//     return courses;
//   }

  //student
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
    box.close();
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }

//batch dummy data
  Future<void> addDummyCategory() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    if (box.isEmpty) {
      final category1 = CategoryHiveModel(categoryName: '29-A');
      final category2 = CategoryHiveModel(categoryName: '29-B');
      final category3 = CategoryHiveModel(categoryName: '30-A');
      final category4 = CategoryHiveModel(categoryName: '30-B');

      List<CategoryHiveModel> categories = [
        category1,
        category2,
        category3,
        category4
      ];

      for (var category in categories) {
        await box.put(category.categoryId, category);
      }
    }
  }

//   //course dummy data
//   Future<void> addDummyCourse() async {
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     if (box.isEmpty) {
//       final course1 = CourseHiveModel(courseName: 'Flutter');
//       final course2 = CourseHiveModel(courseName: 'Dart');
//       final course3 = CourseHiveModel(courseName: 'Computer Vision');
//       final course4 = CourseHiveModel(courseName: 'Design Thinking');
//       final course5 = CourseHiveModel(courseName: 'AWS');

//       List<CourseHiveModel> courses = [
//         course1,
//         course2,
//         course3,
//         course4,
//         course5
//       ];

//       for (var course in courses) {
//         await box.put(course.courseId, course);
//       }
//     }
//   }
}
