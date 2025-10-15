// helpers/sort_helper.dart

//----------------------------------
// Methods
//----------------------------------
List<Map<String, dynamic>> sortList(List<Map<String, dynamic>> list, String field) {
  if (list.isEmpty) {
    return list;
  }

  list.sort((a, b) => b[field].compareTo(a[field]));

  return list;
}
