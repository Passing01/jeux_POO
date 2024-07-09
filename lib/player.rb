# Définition de la classe Player
class Player
    # Définition d'un accesseur pour les attributs name et life_points
    attr_accessor :name, :life_points
  
    # Méthode d'initialisation de la classe Player
    def initialize(name)
      # Initialisation des attributs name et life_points
      @name = name
      @life_points = 10
    end
  
    # Méthode pour afficher l'état du joueur
    def show_state
      # Affichage du nom et des points de vie du joueur
      puts "#{@name} a #{@life_points} points de vie"
    end
  
    # Méthode pour infliger des dégâts au joueur
    def gets_damage(damage)
      # Réduction des points de vie du joueur en fonction des dégâts subis
      @life_points -= damage
      # Si les points de vie sont inférieurs ou égaux à 0, on affiche un message indiquant que le joueur a été tué
      if @life_points <= 0
        puts "le joueur #{@name} a été tué !"
      end
    end
  
    # Méthode pour attaquer un autre joueur
    def attacks(other_player)
      # Affichage d'un message indiquant que le joueur attaque un autre joueur
      puts "#{@name} attaque #{other_player.name}"
      # Calcul des dégâts infligés par le joueur
      damage = compute_damage
      # Affichage des dégâts infligés
      puts "il lui inflige #{damage} points de dommages"
      # Réduction des points de vie de l'autre joueur en fonction des dégâts subis
      other_player.gets_damage(damage)
    end
  
    # Méthode pour calculer les dégâts infligés par le joueur
    def compute_damage
      # Génération d'un nombre aléatoire entre 1 et 6 pour les dégâts
      rand(1..6)
    end
  end
  

# Définition de la classe HumanPlayer qui hérite de la classe Player
class HumanPlayer < Player
    # Définition d'un accesseur pour l'attribut weapon_level
    attr_accessor :weapon_level
  
    # Méthode d'initialisation de la classe HumanPlayer
    def initialize(name)
      # Initialisation des attributs name, life_points et weapon_level
      @name = name
      @life_points = 100
      @weapon_level = 1
    end
  
    # Méthode pour afficher l'état du joueur
    def show_state
      # Affichage du nom, des points de vie et du niveau de l'arme du joueur
      puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end
  
    # Méthode pour calculer les dégâts infligés par le joueur
    def compute_damage
      # Calcul des dégâts en fonction du niveau de l'arme du joueur
      rand(1..6) * @weapon_level
    end
  
    # Méthode pour rechercher une arme
    def search_weapon
      # Génération d'un nouveau niveau d'arme aléatoire
      new_weapon_level = rand(1..6)
      puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
      # Si le nouveau niveau d'arme est supérieur au niveau actuel, on met à jour l'attribut weapon_level
      if new_weapon_level > @weapon_level
        @weapon_level = new_weapon_level
        puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      else
        puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
      end
    end
  
    # Méthode pour rechercher un pack de soin
    def search_health_pack
      # Génération d'une valeur aléatoire pour le pack de soin
      pack_value = rand(1..6)
      # Si la valeur est 1, on affiche un message indiquant qu'aucun pack n'a été trouvé
      if pack_value == 1
        puts "Tu n'as rien trouvé..."
      # Si la valeur est comprise entre 2 et 5, on ajoute 50 points de vie au joueur
      elsif pack_value >= 2 && pack_value <= 5
        @life_points += 50
        if @life_points > 100
          @life_points = 100
        end
        puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      # Si la valeur est 6, on ajoute 80 points de vie au joueur
      else
        @life_points += 80
        if @life_points > 100
          @life_points = 100
        end
        puts "Waow, tu as trouvé un pack de +80 points de vie !"
      end
    end
  end
  

class Game
    # Définition des attributs accessibles en lecture et écriture pour la classe Game
    attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight
  
    # Méthode d'initialisation de la classe Game
    def initialize(human_player_name)
      # Création d'un nouvel objet HumanPlayer avec le nom fourni en paramètre
      @human_player = HumanPlayer.new(human_player_name)
      # Initialisation d'un tableau vide pour stocker les ennemis
      @enemies = []
      # Création de 4 ennemis et ajout dans le tableau @enemies
      4.times do |i|
        @enemies << Player.new("Enemy #{i+1}")
      end
      # Initialisation du nombre de joueurs restants avec la taille du tableau @enemies
      @players_left = @enemies.size
      # Initialisation d'un tableau vide pour stocker les ennemis en vue
      @enemies_in_sight = []
    end
  
    # Méthode pour supprimer un joueur du tableau @enemies et décrémenter le nombre de joueurs restants
    def kill_player(player)
      @enemies.delete(player)
      @players_left -= 1
    end
  
    # Méthode pour vérifier si le jeu est toujours en cours
    def is_still_ongoing?
      # Retourne true si le joueur humain et au moins un ennemi ont des points de vie supérieurs à 0, false sinon
      @human_player.life_points > 0 && @players_left > 0
    end
  
    # Méthode pour afficher l'état des joueurs
    def show_players
      # Appel de la méthode show_state pour le joueur humain
      @human_player.show_state
      # Affichage du nombre d'ennemis restants
      puts "Il reste #{@enemies.size} ennemis en vie."
    end
  
    # Méthode pour afficher le menu des actions possibles
    def menu
      puts "Quelle action veux-tu effectuer ?"
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
      # Affichage de la liste des ennemis en vue avec leur nom et leurs points de vie
      @enemies_in_sight.each_with_index do |enemy, index|
        puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
      end
    end
  
    # Méthode pour gérer le choix de l'utilisateur dans le menu
    def menu_choice(choice)
      # Gestion des différents choix possibles
      case choice
      when "a"
        # Recherche d'une nouvelle arme pour le joueur humain
        @human_player.search_weapon
      when "s"
        # Recherche d'un kit de soins pour le joueur humain
        @human_player.search_health_pack
      else
        # Sélection de l'ennemi à attaquer en fonction du choix de l'utilisateur
        selected_enemy = @enemies_in_sight[choice.to_i]
        if selected_enemy
          # Attaque de l'ennemi sélectionné par le joueur humain
          @human_player.attacks(selected_enemy)
          # Suppression de l'ennemi si ses points de vie sont inférieurs ou égaux à 0
          kill_player(selected_enemy) if selected_enemy.life_points <= 0
        else
          # Affichage d'un message d'erreur si le choix de l'utilisateur est invalide
          puts "Action invalide"
        end
      end
    end
  
    # Méthode pour gérer les attaques des ennemis
    def enemies_attack
      # Boucle sur les ennemis en vue
      @enemies_in_sight.each do |enemy|
        # Si l'ennemi a des points de vie supérieurs à 0, il attaque le joueur humain
        enemy.attacks(@human_player) if enemy.life_points > 0
      end
    end
  
    # Méthode pour afficher le message de fin de partie
    def end
      if @human_player.life_points > 0
        # Message de victoire si le joueur humain a des points de vie supérieurs à 0
        puts "BRAVO ! TU AS GAGNE !"
      else
        # Message de défaite si le joueur humain a des points de vie inférieurs ou égaux à 0
        puts "Loser ! Tu as perdu !"
      end
    end
  
    # Méthode pour ajouter de nouveaux ennemis en vue
    def new_players_in_sight
      # Vérification si tous les ennemis sont déjà en vue
      if @enemies_in_sight.size < @players_left
        # Génération d'un nombre aléatoire entre 1 et 6
        roll = rand(1..6)
        if roll == 1
          # Affichage d'un message si aucun nouvel ennemi n'arrive en vue
          puts "Aucun nouvel ennemi n'arrive en vue."
        elsif roll >= 2 && roll <= 4
          # Ajout d'un nouvel ennemi en vue
          new_enemy = @enemies.sample
          @enemies_in_sight << new_enemy
          puts "Un nouvel ennemi arrive en vue : #{new_enemy.name} !"
        else
          # Ajout de deux nouveaux ennemis en vue
          new_enemy1 = @enemies.sample
          new_enemy2 = @enemies.sample
          until new_enemy1 != new_enemy2
            new_enemy2 = @enemies.sample
          end
          @enemies_in_sight << new_enemy1
          @enemies_in_sight << new_enemy2
          puts "Deux nouveaux ennemis arrivent en vue : #{new_enemy1.name} et #{new_enemy2.name} !"
        end
      else
        # Affichage d'un message si tous les ennemis sont déjà en vue
        puts "Tous les ennemis sont déjà en vue."
      end
    end
  end
  
  