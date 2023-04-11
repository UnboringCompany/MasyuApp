import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          'title': 'Masyu',
          'resume': 'Reprendre',
          'challenge': 'Défi contre la montre',
          'new_game': 'Nouvelle partie',
          'size': 'Taille de la grille :',
          'language': 'Français',
          'rules': 'Règles',
          'score': 'Score',
          'back': 'Retour',
          'credits': 'Crédits : Projet réalisé par : Unboring Company',
          'team' : 'Une équipe composée de : Léo WADIN Aurélien HOUDART Damien COLLOT et Elena BEYLAT',
          'goal' : 'But du jeu :',
          'goal_text' : 'Vous devez relier tous les points de la grille pour faire une boucle unique. Vous ne pouvez passer qu\'une fois dans chaque case.',
          'white' : 'Cases blanches :',
          'white_text' : 'Pour passer dans un pion blanc, vous devez avancer en ligne droite. Vous devez tourner de 90° dans la case d\'avant, celle d\'après ou les deux.',
          'black' : 'Cases noires :',
          'black_text' : 'Pour passer dans pion noir, vous devez faire un angle de 90° dans la case qui contient le pion. Vous ne devez surtout pas tourner dans les cases juste avant et juste après.',
          'abandon' : 'Êtes vous sûr de vouloir abandonner ?',
          'abandon_text' : 'Abandonner vous fera perdre des points d\'élo',
          'bravo' : 'Bravo !',
          'bravo_text' : 'Vous avez gagné en 2min 24sec \nVous avez ainsi gagné 24 points',
          'game_over' : 'Dommage !',
          'game_over_text' : 'Vous n\'avez pas trouvé la solution\nVous perdez 15 points',
          'clue' : 'Êtes vous sûr de vouloir un indice ?',
          'clue_text' : 'L\'indice vous fera perdre 5 points sur cette partie',
        },
        'en_UK': {
          'title': 'Masyu',
          'resume': 'Resume',
          'challenge': 'Challenge against the clock',
          'new_game': 'New game',
          'size': 'Grid size :',
          'rules': 'Rules',
          'language': 'English',
          'score': 'Score',
          'back': 'Back',
          'credits': 'Credits : Project made by : Unboring Company',
          'team' : 'A team composed of : Léo WADIN Aurélien HOUDART Damien COLLOT and Elena BEYLAT',
          'goal' : 'Goal of the game :',
          'goal_text' : 'You have to connect all the points of the grid to make a unique loop. You can only go through each case once.',
          'white' : 'White cases :',
          'white_text' : 'To go through a white pawn, you must go straight. You must turn 90° in the case before, the one after or both.',
          'black' : 'Black cases :',
          'black_text' : 'To go through a black pawn, you must make a 90° angle in the case that contains the pawn. You must not turn in the cases just before and just after.',
          'abandon' : 'Are you sure you want to give up ?',
          'abandon_text' : 'Giving up will make you lose elo points',
          'bravo' : 'Good Job !',
          'bravo_text' : 'You won in 2min 24sec \nYou thus won 24 points',
          'game_over' : 'Too bad !',
          'game_over_text' : 'You did not find the solution\nYou lose 15 points',
          'clue' : 'Are you sure you want a clue ?',
          'clue_text' : 'The clue will make you lose 5 points on this game',
        },
        'de_DE':{
          'title': 'Masyu', 
          'resume': 'Übernehmen',
          'challenge': 'Herausforderung gegen die Uhr',
          'new_game': 'Neue Partei',
          'size': 'Rastergröße :',
          'rules': 'Regeln',
          'language': 'Deutsch',
          'score': 'Punktzahl',
          'back': 'Zurück',
          'credits': 'Credits : Projekt von : Unboring Company',
          'team' : 'Ein Team bestehend aus : Léo WADIN Aurélien HOUDART Damien COLLOT und Elena BEYLAT',
          'goal' : 'Ziel des Spiels :',
          'goal_text' : 'Sie müssen alle Punkte der Raster verbinden, um eine einzigartige Schleife zu bilden. Sie können nur einmal durch jede Fall gehen.',
          'white' : 'Weiße Fälle :',
          'white_text' : 'Um durch ein weißes Pferd zu gehen, müssen Sie geradeaus gehen. Sie müssen sich 90° in den Fall vor, den nach oder beide drehen.',
          'black' : 'Schwarze Fälle :',
          'black_text' : 'Um durch ein schwarzes Pferd zu gehen, müssen Sie einen 90°-Winkel in den Fall drehen, der das Pferd enthält. Sie müssen sich nicht in die Fälle drehen, die sich direkt vor und direkt nach befinden.',
          'abandon' : 'Bist du sicher, dass du aufgeben willst ?',
          'abandon_text' : 'Aufgeben wird Sie Elo-Punkte kosten',
          'bravo' : 'Gute Arbeit !',
          'bravo_text' : 'Du hast in 2min 24sec gewonnen \nDu hast also 24 Punkte gewonnen',
          'game_over' : 'Schade !',
          'game_over_text' : 'Sie haben die Lösung nicht gefunden\nDu verlierst 15 Punkte',
          'clue' : 'Bist du sicher, dass du einen Hinweis willst ?',
          'clue_text' : 'Der Hinweis wird Sie 5 Punkte auf diesem Spiel kosten',
        },
        'es_ES' :{
          'title': 'Masyu',
          'resume': 'Reanudar',
          'challenge': 'Reto contra el reloj',
          'new_game': 'Nuevo juego',
          'size': 'Tamaño de la cuadrícula :',
          'rules': 'Reglas',
          'language': 'Español',
          'score': 'Puntuación',
          'back': 'Espalda',
          'credits': 'Créditos : Proyecto realizado por : Unboring Company',
          'team' : 'Un equipo compuesto por : Léo WADIN Aurélien HOUDART Damien COLLOT y Elena BEYLAT',
          'goal' : 'Objetivo del juego :',
          'goal_text' : 'Tienes que conectar todos los puntos de la cuadrícula para formar un único bucle. Solo puedes pasar una vez por cada caso.',
          'white' : 'Casos blancos :',
          'white_text' : 'Para pasar por un peón blanco, debes ir recto. Debes girar 90° en el caso antes, el que viene después o ambos.',
          'black' : 'Casos negros :',
          'black_text' : 'Para pasar a la ficha negra, debe hacer un ángulo de 90° en la casilla que contiene la ficha.No debes girar en las casillas justo antes y justo después.',
          'abandon' : '¿Estás seguro de que quieres abandonar?',
          'abandon_text' : 'Abandonar te hará perder puntos de elo.',
          'bravo' : '¡Bien hecho!',
          'bravo_text' : 'Has ganado en 2min 24seg \nHas ganado 24 puntos.',
          'game_over' : 'Lástima',
          'game_over_text' : 'No has encontrado la solución\nPierdes 15 puntos',
          'clue' : '¿Seguro que quieres una pista?',
          'clue_text' : 'La pista te costará 5 puntos para este juego',
        },
        'ja_JA' : {
          'title' : 'Masyu',
          'resume' : 'レジュメ',
          'challenge' : '時計に挑む',
          'new_game' : '新作ゲーム',
          'size' : 'グリッドサイズ',
          'score' : 'スコア',
          'rules' : 'ルール',
          'back' : 'バック',
          'language' : '日本',
          'credit' : 'クレジット : Unboring Company',
          'team' : 'チーム構成は以下の通りです： Léo WADIN Aurélien HOUDART Damien COLLOT と Elena BEYLAT',
          'goal' : 'ゲームの目標：',
          'goal_text' : 'グリッドのすべての点を接続して、1つのユニークなループを作成する必要があります。各ケースに1回だけ通過できます。',
          'white' : '白いケース：',
          'white_text' : '白い駒を通過するには、直進する必要があります。直前、直後のケースのいずれか、または両方に90°回転します。',
          'black' : '黒いケース：',
          'black_text' : '黒い駒を通過するには、駒を含むケースに90°回転します。直前と直後のケースを回転させる必要はありません。',
          'abandon' : 'あなたはあきらめたいと思いますか？',
          'abandon_text' : 'あきらめると、あなたはeloポイントを失います。',
          'bravo' : 'よくできました！',
          'bravo_text' : 'あなたは2分24秒で勝ちました \nあなたは24ポイントを獲得しました',
          'game_over' : '残念！',
          'game_over_text' : 'あなたは解決策を見つけていません\nあなたは15ポイントを失います',
          'clue' : 'あなたはヒントを必要としていますか？',
          'clue_text' : 'このゲームのために5ポイントを支払うヒント',
        },
      };
}