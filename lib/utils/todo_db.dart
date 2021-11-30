import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ssqflitetodos/models/todo.dart';

class TodoDB {
  final String dbName;
  Database? _db;
  List<Todo> _todos = [];
  final _streamController = StreamController<List<Todo>>.broadcast();

  TodoDB({required this.dbName});

  Future<bool> close() async {
    final db = _db;
    if (db == null) {
      return false;
    }
    await db.close();
    return true;
  }

  Future<List<Todo>> _fetchTodo() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query(
        'TODO',
        distinct: true,
        columns: [
          'ID',
          'TITLE',
          'DESCRIPTION',
        ],
        orderBy: 'ID',
      );

      final todo = read.map((row) => Todo.fromRow(row)).toList();
      return todo;
    } catch (e) {
      print('Error fetching todo = $e');
      return [];
    }
  }

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/db.sqlite';

    try {
      final db = await openDatabase(path);
      _db = db;

      const create = '''CREATE TABLE IF NOT EXISTS TODO(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TITLE STRING NOT NULL,
        DESCRIPTION NOT NULL
      )''';

      await db.execute(create);

      //read all existing todo from the db
      _todos = await _fetchTodo();
      _streamController.add(_todos);
      return true;
    } catch (e) {
      print('Error =$e');
      return false;
    }
  }

  Stream<List<Todo>> all() =>
      _streamController.stream.map((todos) => todos..sort());

  Future<bool> update(Todo todo) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final updateCount = await db.update(
        'TODO',
        {
          'TITLE': todo.title,
          'DESCRIPTION': todo.description,
        },
        where: 'ID = ?',
        whereArgs: [todo.id],
      );

      if (updateCount == 1) {
        _todos.removeWhere((other) => other.id == todo.id);
        _todos.add(todo);
        _streamController.add(_todos);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('failed to update,error = $e');
      return false;
    }
  }

  Future<bool> delete(Todo todo) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final deleteCount = await db.delete(
        'TODO',
        where: 'ID = ?',
        whereArgs: [todo.id],
      );

      if (deleteCount == 1) {
        _todos.remove(todo);
        _streamController.add(_todos);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Deletion failed with error = $e');
      return false;
    }
  }

  Future<bool> create(String title, String description) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = db.insert('TODO', {
        'TITLE': title,
        'DESCRIPTION': description,
      });
      final todo = Todo(
        id: 1,
        title: title,
        description: description,
      );
      _todos.add(todo);
      _streamController.add(_todos);
      return true;
    } catch (e) {
      print('Error in creating todo = $e');
      return false;
    }
  }
}
