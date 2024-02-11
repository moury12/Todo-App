import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model/task_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database?> get database async {
    if (_database != null) return _database;

    // If _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    String path = join(await getDatabasesPath(), 'theme.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Settings (
        id INTEGER PRIMARY KEY,
        constant TEXT,
        status INTEGER
      )
    ''');
      await db.execute('''
        CREATE TABLE Tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            due_date_time TEXT,
            priority_title TEXT,
            reminder_date_time TEXT,
            is_completed INTEGER,
            is_running INTEGER,
            is_expired INTEGER
          )
        ''');
    });
  }

  static Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db!.insert('Tasks', task.toMap());
  }

  static Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('Tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id : maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        dueDateTime: maps[i]['due_date_time'],
        priorityTitle: maps[i]['priority_title'],
        reminderDateTime: maps[i]['reminder_date_time'],
        isCompleted: maps[i]['is_completed'] == 1,
        isRunning: maps[i]['is_running'] == 1,
        isExpired: maps[i]['is_expired'] == 1,
      );
    });
  }

  static Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db!.update(
      'Tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteTask(int id) async {
    final db = await database;
    return await db!.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> saveSettings(String constant, bool status) async {
    final Database? db = await database;
    if (db != null) {

      List<Map<String, dynamic>> existingData = await db.query('Settings', where: 'constant = ?', whereArgs: [constant]);
      if (existingData.isEmpty) {
        // If the constant does not exist, insert new data
        await db.insert(
          'Settings',
          {
            'constant': constant,
            'status': status ? 1 : 0,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore conflicts to prevent insertion of duplicate data
        );
      } else {
        // If the constant exists, update the status
        await db.update(
          'Settings',
          {'status': status ? 1 : 0},
          where: 'constant = ?',
          whereArgs: [constant],
        );
      }
    }
  }

  static Future<Map<String, bool>> getSettings() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('Settings');

    Map<String, bool> settingsMap = {};
    for (var map in maps) {
      settingsMap[map['constant'] as String] = map['status'] == 1;
    }

    return settingsMap;
  }



}
