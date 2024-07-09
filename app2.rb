
  # Chargement des dépendances et des fichiers nécessaires
  require 'bundler'
  Bundler.require
  require_relative 'lib/game'
  require_relative 'lib/player'
  
  # Affichage d'un message de bienvenue
  puts "-------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
  
  # Demande du nom du joueur
  puts "Quel est ton prénom ?"
  user_name = gets.chomp
  # Création d'une instance de la classe HumanPlayer avec le nom du joueur
  user = HumanPlayer.new(user_name)
  
  # Création de deux instances de la classe Player pour les adversaires
  enemies = [Player.new("Josiane"), Player.new("José")]
  
  # Boucle principale du jeu
  while user.life_points > 0 && enemies.any? { |enemy| enemy.life_points > 0 }
    # Affichage de l'état du joueur
    user.show_state
    # Demande de l'action à effectuer
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    # Affichage de la liste des adversaires
    enemies.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
    end
    # Récupération de l'action choisie par le joueur
    choice = gets.chomp
    # Traitement de l'action choisie
    case choice
    when "a"
      # Recherche d'une arme
      user.search_weapon
    when "s"
      # Recherche d'un pack de soin
      user.search_health_pack
    else
      # Attaque d'un adversaire
      selected_enemy = enemies[choice.to_i]
      if selected_enemy
        user.attacks(selected_enemy)
      else
        puts "Action invalide"
      end
    end
    # Attaque du joueur par les adversaires
    puts "Les autres joueurs t'attaquent !"
    enemies.each do |enemy|
      enemy.attacks(user) if enemy.life_points > 0
    end
  end
  
  # Affichage d'un message de fin de partie
  puts "La partie est finie"
  if user.life_points > 0
    puts "BRAVO ! TU AS GAGNE !"
  else
    puts "Loser ! Tu as perdu !"
  end
  