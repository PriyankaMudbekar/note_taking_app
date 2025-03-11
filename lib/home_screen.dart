
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'note.dart';
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }
  void _loadNotes() async {
    final data = await _dbHelper.getNotes();
    print("Notes from database: $data"); // Debugging
    setState(() {
      _notes = data.map((e) => Note.fromMap(e)).toList();
    });
  }

  void _deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SQLite Notes'),
          backgroundColor: Colors.blue,
        ),
        body: _notes.isEmpty
            ? Center(child: Text('No notes available'))
            : ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            final note = _notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NoteScreen(note: note, isEditing: true),
                ),
              ).then((_) => _loadNotes()),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteNote(note.id!),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(),
            ),
          ).then((_) => _loadNotes()),
        ),
      ),
    );
  }
}