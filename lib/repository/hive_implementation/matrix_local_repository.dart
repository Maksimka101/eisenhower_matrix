import 'package:eisenhower_matrix/models/ceil_item.dart';
import 'package:eisenhower_matrix/models/matrix.dart';
import 'package:eisenhower_matrix/repository/abstract/matrix_local_repository.dart';
import 'package:eisenhower_matrix/repository/hive_implementation/ceil_item.dart';
import 'package:eisenhower_matrix/utils/hive_utils.dart';

class HiveMatrixLocalRepository extends MatrixLocalRepository {
  @override
  Future<void> addUnSyncCeilItem(String itemId) async {
    var box = await HiveUtils.getBox<String>(HiveUtils.unSyncCeilItemsBoxName);
    await box.put(_prepareId(itemId), _prepareId(itemId));
  }

  @override
  Future<void> addUnSyncDeletedCeilItem(String itemId) async {
    var box = await HiveUtils.getBox<String>(HiveUtils.unSyncDeletedCeilItemBoxName);
    assert(box.keys.contains(_prepareId(itemId)));
    await box.put(_prepareId(itemId), _prepareId(itemId));
  }

  @override
  Future<Matrix> deleteCeilItem(String itemId) async {
    var box = await HiveUtils.getBox<HiveCeilItem>(HiveUtils.ceilItemsBoxName);
    assert(box.keys.contains(_prepareId(itemId)));
    await box.delete(_prepareId(itemId));
    return fetchMatrix();
  }

  @override
  Future<void> deleteUnSyncCeilItem(String itemId) async {
    var box = await HiveUtils.getBox<String>(HiveUtils.unSyncCeilItemsBoxName);
    assert(box.keys.contains(_prepareId(itemId)));
    await box.delete(_prepareId(itemId));
  }

  @override
  Future<void> deleteUnSyncDeletedCeilItem(String itemId) async {
    var box = await HiveUtils.getBox<String>(HiveUtils.unSyncDeletedCeilItemBoxName);
    assert(box.keys.contains(_prepareId(itemId)));
    await box.delete(_prepareId(itemId));
  }

  @override
  Future<Matrix> fetchMatrix() async {
    var box = await HiveUtils.getBox<HiveCeilItem>(HiveUtils.ceilItemsBoxName);
    return Matrix.fromCeilItems(
        box.values.map<CeilItem>((hiveItem) => hiveItem.toCeilItem()).toList());
  }

  @override
  Future<Matrix> saveCeilItem(CeilItem item) async {
    var box = await HiveUtils.getBox<HiveCeilItem>(HiveUtils.ceilItemsBoxName);
    await box.put(_prepareId(item.id), HiveCeilItem.fromCeilItem(item));
    return fetchMatrix();
  }

  @override
  Future<List<String>> get unSyncCeilItems async =>
      (await HiveUtils.getBox<String>(HiveUtils.unSyncCeilItemsBoxName)).values.toList();

  @override
  Future<List<String>> get unSyncDeletedCeilItems async =>
      (await HiveUtils.getBox<String>(HiveUtils.unSyncDeletedCeilItemBoxName)).values.toList();

  @override
  Future<void> dispose() async {}

  /// Remove non Ascii symbols
  String _prepareId(String id) {
    id = String.fromCharCodes(id.codeUnits.toList()..removeWhere((element) => element > 126));
    if (id.isEmpty) {
      throw Exception('Id must contains Ascii');
    }
    return id;
  }
}