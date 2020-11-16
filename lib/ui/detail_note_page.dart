import 'package:flutter/material.dart';
import 'package:note_application/bloc/bloc_provider.dart';
import 'package:note_application/bloc/view_note_bloc.dart';
import 'package:note_application/models/note.dart';


class ViewNotePage extends StatefulWidget{

    final Note note;

    ViewNotePage({
        Key key,
        this.note,
    }): super(key: key);

    @override
    _ViewNotePageState createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage>{


    ViewNoteBloc _viewNoteBloc;
    TextEditingController _noteController = TextEditingController();

    @override
    void initState(){

        super.initState();

        _viewNoteBloc = BlocProvider.of<ViewNoteBloc>(context);
        _noteController.text = widget.note.content;
    }

    void _saveNote() async {

        widget.note.content = _noteController.text;

        _viewNoteBloc.inSaveNote.add(widget.note);

        _viewNoteBloc.saved.listen((saved){
            if(saved){
                Navigator.of(context).pop(true);
            }
        });

    }

    void _deleteNote(){

        _viewNoteBloc.inDeleteNote.add(widget.note.id);

        _viewNoteBloc.deleted.listen((deleted){
            if(deleted){
                Navigator.of(context).pop(true);
            }
        });
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
                appBar: AppBar(

                        title: Text('Note' + widget.note.id.toString()),
                        actions: [
                            IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: _saveNote,
                            ),
                            IconButton(

                                    icon: Icon(Icons.delete),
                                    onPressed: _deleteNote,
                            ),
                        ],
                ),
                body: Container(
                        child: TextField(
                                maxLines: null,
                                controller: _noteController,
                        ),
                ),
        );
    }
    
}

