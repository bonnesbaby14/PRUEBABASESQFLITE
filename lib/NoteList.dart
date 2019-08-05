import 'package:basededatos/NoteDetail.dart';
import 'package:basededatos/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return NoteListState();
  }
}


class NoteListState extends State<NoteList>{
 int count=0;
Helper DB=Helper();
List<Map<String,dynamic>> ListMaps=List<Map<String,dynamic>>();


String sTitle,sDescripcion;

 Future <void> refrescar()async{
   Update();
await Future.delayed(Duration(seconds:2));
setState(() {
 getNoteListView(); 
});
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Update();
  }
Color getColor(int prioridad){
  if(prioridad==1){
return Color(0xff962E40);
  }else{
return Color(0xffffffff);
  }
  }

  Icon getIcon(int prioridad){
  if(prioridad==1){
return Icon(Icons.style);
  }else{
return Icon(Icons.store);
  }

  }


  @override
  Widget build(BuildContext context) {
 

    // TODO: implement build
    return Scaffold(
    appBar: AppBar(
      title: Text("Notes"),
    ),
body: RefreshIndicator(child: getNoteListView(),
onRefresh:refrescar,
),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          
          
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NoteDetail("Add Note",null,null,null,null);
          }));
        },
      tooltip: 'Add user',
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),

      ),
    );
  }

ListView getNoteListView(){
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(itemCount: count,
    itemBuilder: (BuildContext context, int position){
     
return Card(
color: Colors.white,
  elevation: 2.0,
  child: ListTile(
    leading: CircleAvatar(
      child: getIcon(ListMaps[position]['prioridad']),
      backgroundColor: getColor(ListMaps[position]['prioridad']),
    ),
    title: Text(ListMaps[position]['title'], style: titleStyle,),
    subtitle: Text(ListMaps[position]['descripcion']),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){

            return NoteDetail("Edit Note",ListMaps[position]['title'],ListMaps[position]['descripcion'],ListMaps[position]['_id'],ListMaps[position]['prioridad']);
          }
       ) );

    },
  ),
);
    },
    );
}




//funciones 
void Update()async {
  int dato = await DB.Count();

 this.ListMaps=await DB.Select();
  if (dato == null) {
    this.count = 0;
  } else {
    this.count = dato;
  }
  
}



}