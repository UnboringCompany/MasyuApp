import 'package:masyu_app/objects/joueur.dart';

import 'grille.dart';

class Partie {
  Grille grille;
  int chrono;
  Joueur player;
  int scorePartie;
  int nbIndices;

  Partie(
      this.grille, this.chrono, this.player, this.scorePartie, this.nbIndices);

  Partie.fromJson(Map<String, dynamic> json)
      : grille = Grille.fromJson(json['grille']),
        chrono = 0,
        player = Joueur.fromJson(json['player']),
        scorePartie = 0,
        nbIndices = 0;

  Map<String, dynamic> toJson() => {
        'grille': grille,
        'chrono': chrono,
        'player': player,
        'scorePartie': scorePartie,
        'nbIndices': nbIndices,
      };

  void updateScoreJoueur() {
    player.score += scorePartie;
    if (grille.isValid()) {
      player.partieGagne += 1;
      player.score = player.score + scorePartie;
    } else {
      player.partiePerdu += 1;
      player.score = player.score - scorePartie;
      if (player.score < 0) {
        player.score = 0;
      }
    }
  }

  void startPartie() {
    grille.generate();
    chrono = 0;
    if (grille.getSize() == 6) {
      scorePartie = 40;
    } else if (grille.getSize() == 8) {
      scorePartie = 60;
    } else if (grille.getSize() == 10) {
      scorePartie = 80;
    }
  }

  void save() {
    //TODO
  }

  void valider() {
    if (grille.isValid()) {
      scorePartie = scorePartie - (chrono ~/ 12);
      scorePartie = scorePartie - (5 * nbIndices);
      updateScoreJoueur();
    } else {
      if (grille.getSize() == 6) {
        scorePartie = 25;
      } else if (grille.getSize() == 8) {
        scorePartie = 40;
      } else if (grille.getSize() == 10) {
        scorePartie = 50;
      }
      updateScoreJoueur();
    }
  }

  void charger() {
    //TODO
  }

  @override
  String toString() {
    return 'Partie{grille: $grille, chrono: $chrono, player: $player, scorePartie: $scorePartie}';
  }
}

// CollectionReference students = FirebaseFirestore.instance.collection('students');

// Future<void> addStudent() {
//       // Calling the collection to add a new user
//       return students
//           //adding to firebase collection
//           .add({
//             //Data added in the form of a dictionary into the document.
//             'full_name': fullName, 
//             'grade': grade, 
//             'age': age
//           })
//           .then((value) => print("Student data Added"))
//           .catchError((error) => print("Student couldn't be added."));
// }

// //For setting a specific document ID use .set instead of .add
// users.doc(documentId).set({
//             //Data added in the form of a dictionary into the document.
//             'full_name': fullName, 
//             'grade': grade, 
//             'age': age
//           });


// //For updating docs, you can use this function.
// Future<void> updateUser() {
//   return students
//     //referring to document ID, this can be queried or named when added accordingly
//     .doc(documentId)
//     //updating grade value of a specific student
//     .update({'grade': newGrade})
//     .then((value) => print("Student data Updated"))
//     .catchError((error) => print("Failed to update data"));
// }

// class GetStudentName extends StatelessWidget {
//   final String documentId;

//   GetStudentName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference student = FirebaseFirestore.instance.collection('students');

//     return FutureBuilder<DocumentSnapshot>(
//       //Fetching data from the documentId specified of the student
//       future: students.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        

//         //Error Handling conditions
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         //Data is output to the user
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }
