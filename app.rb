
  # Chargement des fichiers nécessaires
  require_relative 'lib/game'
  require_relative 'lib/player'
  
  # Création de deux instances de la classe Player
  player1 = Player.new("José")
  player2 = Player.new("Josiane")
  
  # Création d'une instance de la classe Game avec les deux joueurs
  game = Game.new(player1, player2)
  # Lancement du combat entre les deux joueurs
  game.fight
  