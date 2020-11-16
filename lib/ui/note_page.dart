import 'package:flutter/material.dart';
import 'package:note_application/bloc/view_note_bloc.dart';
import 'package:note_application/ui/detail_note_page.dart';
import 'package:note_application/models/note.dart';
import 'package:note_application/bloc/bloc_provider.dart';
import 'package:note_application/bloc/note_bloc.dart';
class NotePage extends StatefulWidget{

    final String title;

    NotePage({
        Key k,
        this.title,
    }): super(key: k);

    @override
    _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage>{

    NoteBloc _bloc;

    @override
    void initState(){
        super.initState();
        _bloc = BlocProvider.of<NoteBloc>(context);
    }

    void _navigateToNote(Note note) async{
        
        final bool update = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                                bloc: ViewNoteBloc(),
                                child: ViewNotePage(note: note),),
        ),
        );

        if(update != null){
            _bloc.getNotes();
        }
    }

    void _addNote() async {
        Note note = new Note(content: '');

        _bloc.inAddNote.add(note);

    }


    @override
    Widget build(BuildContext context){
        return Scaffold(

                appBar:  AppBar(title: Text(widget.title)),
                body: Container(
                        child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                            child: StreamBuilder<List<Note>>(
                                                    stream: _bloc.notes,
                                                    builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot){
                                                        if(snapshot.hasData){
                                                            if(snapshot.data.length == 0){
                                                                return Text('No notes');
                                                            }

                                                            List<Note> notes = snapshot.data;

                                                            return ListView.builder(
                                                                    itemCount: notes.length,
                                                                    itemBuilder: (BuildContext context, int index){

                                                                        Note note = notes[index];

                                                                        return GestureDetector(
                                                                                onTap: (){
                                                                                    _navigateToNote(note);
                                                                                },
                                                                                child: Container(
                                                                                               height: 40,
                                                                                               child: Text(
                                                                                                       note.content + ' ' + note.id.toString(),
                                                                                                       style: TextStyle(
                                                                                                               fontSize: 18
                                                                                                       ),
                                                                                               ),
                                                                                       ),
                                                                        );



                                                                    },
                                                                    );

                                                        }

                                                        return Center(
                                                                child: CircularProgressIndicator(),
                                                        );

                                                    },
                                                    ),
                                                    ),
                                                    ],
                                                    ),
                                                    ),
                                                    floatingActionButton: FloatingActionButton(
                                                            onPressed: _addNote,
                                                            child: Icon(Icons.add ),
                                                    ),
                                                    );
    }

}

