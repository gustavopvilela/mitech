import 'package:mitech/database/sqflite_database.dart';
//import 'package:consultorio/models/consultorioModel.dart';
import 'package:mitech/models/bookmarked_posts_model.dart';

class BookmarkedPostsController {
  Future<int> insert(BookmarkedPostsModel object) async {
    int id = await BookmarkedPosts.instance.insert(
      object.toJson(),
      BookmarkedPosts.bookmarkedPostsTable
    );
    
    print('Inserted row: id $id');
    return id;
  }
  
  Future<int> update(BookmarkedPostsModel object) async {
    final affectedRows = await BookmarkedPosts.instance.update(
      object.toJson(),
      BookmarkedPosts.bookmarkedPostsTable
    );
    
    print('Updated $affectedRows row(s)');
    return affectedRows;
  }
  
  Future<int> delete(int id) async {
    //final id = await BookmarkedPosts.instance.queryRowCount(BookmarkedPosts.bookmarkedPostsTable);
    final deletedRow = await BookmarkedPosts.instance.delete(
      id,
      BookmarkedPosts.bookmarkedPostsTable
    );
    
    print('Deleted $deletedRow row(s): row $id');
    return deletedRow;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final allRows = await BookmarkedPosts.instance.queryAllRows(
      BookmarkedPosts.bookmarkedPostsTable
    );
    
    print('Consulta todas as linhas:');
    for (var row in allRows) {
      print(row);
    }
    return allRows;
  }

  Future<List<BookmarkedPostsModel>> getAllList() async {
    final allRows = await BookmarkedPosts.instance.queryAllRows(
      BookmarkedPosts.bookmarkedPostsTable
    );
    
    List<BookmarkedPostsModel> listing = List.generate(allRows.length, (i) {
      return BookmarkedPostsModel(
          allRows[i]['id'],
          allRows[i]['title'],
          allRows[i]['subtitle'],
          allRows[i]['imageUrl'],
          allRows[i]['link'],
      );
    });
    
    return listing;
  }

  Future<BookmarkedPostsModel> get(int id) async {
    String sql = ""
        "SELECT * "
        "FROM bookmarkedposts "
        "WHERE id = $id;";
    
    final allRows = await BookmarkedPosts.instance.querySQL(sql);
    List<BookmarkedPostsModel> listing = List.generate(allRows.length, (i) {
      return BookmarkedPostsModel(
        allRows[i]['id'],
        allRows[i]['title'],
        allRows[i]['subtitle'],
        allRows[i]['imageUrl'],
        allRows[i]['link'],
      );
    });
    
    late BookmarkedPostsModel c;
    try {
      c = listing.elementAt(0);
    }
    catch (_) {}
    
    return c;
  }
}