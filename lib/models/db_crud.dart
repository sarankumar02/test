import 'database_helper.dart';

final dbHelper = DatabaseHelper.instance;

void insert({String name, String image}) async {
  // row to insert
  Map<String, dynamic> row = {
    DatabaseHelper.columnName: name,
    DatabaseHelper.columnImage: image
  };
  final id = await dbHelper.insert(row);
  print('inserted row id: $id');
}

Future query() async {
  final allRows = await dbHelper.queryAllRows();
  // print('query all rows:$allRows');

  return allRows;
}

void update() async {
  // row to update
  Map<String, dynamic> row = {
    DatabaseHelper.columnId: 1,
    DatabaseHelper.columnName: 'Mary',
    DatabaseHelper.columnImage: 32
  };
  final rowsAffected = await dbHelper.update(row);
  print('updated $rowsAffected row(s)');
}

void delete({int id}) async {
  // Assuming that the number of rows is the id for the last row.
  // final id = await dbHelper.queryRowCount();
  final rowsDeleted = await dbHelper.delete(id);
  print('deleted $rowsDeleted row(s): row $id');
}
