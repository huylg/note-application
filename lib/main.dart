import 'package:flutter/material.dart';
import 'package:note_application/bloc/bloc_provider.dart';
import 'package:note_application/bloc/note_bloc.dart';
import 'package:note_application/ui/note_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

	@override
	Widget build(BuildContext context){
		return MaterialApp(
				title: 'Notes',
				theme: ThemeData(
						primarySwatch: Colors.blue,
				),
				home: BlocProvider(
						bloc: NoteBloc(),
						child: NotePage(title: 'Notes'),
				),
		);
	}
}

