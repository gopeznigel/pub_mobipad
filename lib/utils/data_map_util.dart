class DataMapUtil {
  // This function casts the serialized object as Map<String, dynamic>
  // It also removes the id key and value from the map as it is
  // not needed on the db document fields
  static Map<String, dynamic> cleanMapFormat(Object obj) {
    Map<String, dynamic> objMap = obj as Map<String, dynamic>;
    objMap.remove('id');

    return objMap;
  }
}
