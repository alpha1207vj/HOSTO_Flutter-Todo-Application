import "package:isar_community/isar.dart";
import "package:intl/intl.dart";
import "package:equatable/equatable.dart";

part 'task_model.g.dart';



@Collection(ignore: {'copyWith', 'props'})// Syntaxe utilisee pour preciser a Isar de transformer cette classe en table de BD
// ignore: must_be_immutable
class TaskModel extends Equatable{

  //Attributes of the class
  final String title;
  final bool isCompleted ;
  final String? description;
  final DateTime? date;
  Id id = Isar.autoIncrement;

  TaskModel({//Constructor
    required this.title,
    this.isCompleted = false,
    this.description,
    DateTime? date ,
  }): date = date ?? DateTime.now() ;//Syntaxe utilisee pour contourner l'immutabilite du keyword final . ne pouvant pas definir en constructeur on le fait ainsi
  // de maniere a dire si une valeur est entre prend , sinon prends la valeur de data actuelle

   
  TaskModel copyWith
  (
  //Methode utiliser pour la modification d'instance , c'est a dire que concretement apres modification d'une tache , copywith prend
  //de l'ancienne instance avec les modifs pour creer une nouvelle instance en memoire
    {
      String? title,
      bool? isCompleted,
      String? description,
      DateTime? date 
    })
  {
    return TaskModel(

      title :  title ?? this.title,
      isCompleted : isCompleted ?? this.isCompleted,
      description :  description ?? this.description,
      date : date ?? this.date
    );
  }
  
  String get dateFormatee {
    return DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());//Getter utilise pour concretement faciliter la lisibite dnas le ui 
  }
  @override
  List<Object?> get props => [id, title];
}