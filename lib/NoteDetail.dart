import 'package:basededatos/helper/database_helper.dart';
import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget{
  
 String appBarTitle;
 String sTitle,sDescripcion;
 int id, prioridad;

 NoteDetail(this.appBarTitle,this.sTitle,this.sDescripcion,this.id, this.prioridad);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateNoteDetail(this.appBarTitle,this.sTitle,this.sDescripcion,this.id, this.prioridad);
  }

}

class StateNoteDetail extends State<NoteDetail> {
 String appBarTitle;
 final formKey= GlobalKey<FormState>();
final formKey2= GlobalKey<FormState>();

Helper helper=Helper();
List<Map> Lista; 
int prioridad,id;
String sTitle,sDescripcion;


 
  
StateNoteDetail(this.appBarTitle,this.sTitle,this.sDescripcion,this.id, this.prioridad);
  

  var _priorites=['HIGH','LOW'];
  var ValueSelect='LOW';

  TextEditingController title=TextEditingController();
  TextEditingController descripcion=TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(sTitle!=null && sDescripcion!=null){
      title.text=sTitle;
      descripcion.text=sDescripcion;

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
    body: Padding(padding: EdgeInsets.only(top: 15, right: 10,left: 10),
        child: ListView(
        children: <Widget>[
        Padding(
        padding:EdgeInsets.all(10.0),
        child:ListTile(
          title:
          DropdownButton<String>(
            items: _priorites.map((String Hola){
            return DropdownMenuItem<String>(
              value: Hola,
              child: Text(Hola),
            );
            }).toList(),
   value: ValueSelect,
            onChanged: (valueSelectbyUser){
              //aqui cambiar variable global
              setState(() {
               this.ValueSelect=valueSelectbyUser; 
               if(valueSelectbyUser=='HIGH'){
                 prioridad=1;
               }else{
                 prioridad=0;
               }

              });
},
          ) ,
    )
    ),
Padding(
  padding: EdgeInsets.all(10.0),
  child: Form(
    key: formKey,
    child: TextFormField(
      validator: (val)=>val.isEmpty? "CAMPO VACIO": null,
    controller: title,
    decoration: InputDecoration(
      labelText: "Title",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0)
      )
    ),
  ) ,
  )

),
        Padding(
          padding: EdgeInsets.all(10.0),
          child:Form(
key: formKey2,
child: TextFormField(

  validator:(val2)=>val2.isEmpty? "CAMPO VACIO": null,
            controller: descripcion,
            decoration: InputDecoration(
              labelText: "Descripcion",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          ) ,

          )
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child:Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: ()async{
                      final form =formKey.currentState;
                      final form2 =formKey2.currentState;
                      
if(form.validate()&&form2.validate()){

                      Map<String, dynamic> Tarea=Map();
                      Tarea['title']=title.text;
                      Tarea['descripcion']=descripcion.text;
                      Tarea['prioridad']=prioridad;
                      AlertDialog a = AlertDialog(title: Text("Suscceful"),
                            content: Text("La Nota se Registro"),
                            actions: <Widget>[FlatButton(child: Text("OK"),onPressed: (){
                              Navigator.of(context).pop();

                            },)],
                        );
                      if(id==null){

                      int result =await helper.Insert(Tarea);
                       if(result!=0) {
                        
                        await showDialog(context: context, builder: (_) => a);
                      }
                      }else{
                        List<int> ListaID=List();
                        ListaID.add(id);
                        int result2=await helper.BDUpdate(ListaID, Tarea);
                        if(result2!=0) {
                        
                        await showDialog(context: context, builder: (_) => a);
                      }

                      }
                          
}
Navigator.pop(context);
                    },
                  child: Text("SAVE"),
                  color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,

                  )
                ),

              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child:RaisedButton(
                    onPressed: ()async{

                      AlertDialog a = AlertDialog(title: Text("Suscceful"),
                            content: Text("La Nota se Borro"),
                            actions: <Widget>[FlatButton(child: Text("OK"),onPressed: (){
                              Navigator.of(context).pop();

                            },)],
                        );
                      if(id!=null){
                        List<int> ListaID=List();
                        ListaID.add(id);
                        int result=await helper.BDDelete(ListaID);
                        
                          if(result!=0) {
                        
                        await showDialog(context: context, builder: (_) => a);
                      }

                      }
                   Navigator.pop(context);
                    },
                    child:Text("DELETE") ,

                  )

                ),
              ),
            ],
          ) ,
        ),
    ]
    )
    )
    );
  }
}