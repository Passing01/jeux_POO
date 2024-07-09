require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'

# Affichage du titre du jeu
puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

# Demande du nom du joueur humain
puts "Quel est ton prénom ?"
human_player_name = gets.chomp

# Création d'une nouvelle partie avec le nom du joueur humain
my_game = Game.new(human_player_name)

# Boucle principale du jeu
while my_game.is_still_ongoing?
  # Ajout de nouveaux ennemis en vue
  my_game.new_players_in_sight
  # Affichage de l'état des joueurs
  my_game.show_players
  # Affichage du menu des actions possibles
  my_game.menu
  # Récupération du choix de l'utilisateur
  choice = gets.chomp
  # Gestion du choix de l'utilisateur
  my_game.menu_choice(choice)
  # Gestion des attaques des ennemis
  my_game.enemies_attack
end

# Affichage du message de fin de partie
my_game.end
