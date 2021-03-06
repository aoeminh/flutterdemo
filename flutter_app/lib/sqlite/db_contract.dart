import 'dog.dart';

abstract class DbContract {
  Future<int> insertDog(String name, int age);

  Future<List<Dog>> getAllDog();

  Future<List<Dog>> getDogById(int id);

  Future<int> updateDog(Dog dog);

  closeDb();
}
