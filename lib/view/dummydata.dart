import 'package:get/get.dart';

var customerObjection = ''.obs;
var customerSteps = ''.obs;

var agentImprovement = " ".obs;

var speakerData = [].obs;

var entity_data = [].obs;

List<Map<String, dynamic>> filterAndCombineDuplicates(
    List<Map<String, dynamic>> entityData) {
  var entityMap = <String, String>{};

  for (var entity in entityData) {
    var entityType = entity['entity_type'];
    var entityText = entity['entity_text'];

    if (!entityMap.containsKey(entityType)) {
      entityMap[entityType] = entityText;
    } else {
      entityMap[entityType] = entityMap[entityType]! + ', $entityText';
    }
  }

  var filteredEntityData = <Map<String, dynamic>>[];

  for (var entry in entityMap.entries) {
    filteredEntityData.add({
      'entity_text': entry.value,
      'entity_type': entry.key,
    });
  }

  return filteredEntityData;
}
