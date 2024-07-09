# Définition de la classe Game
class Game
    # Définition d'un accesseur pour les attributs player1 et player2
    attr_accessor :player1, :player2
  
    # Méthode d'initialisation de la classe Game
    def initialize(player1, player2)
      # Initialisation des attributs player1 et player2
      @player1 = player1
      @player2 = player2
    end
  
    # Méthode pour faire combattre les deux joueurs
    def fight
      # Boucle de combat tant que les deux joueurs ont des points de vie supérieurs à 0
      while @player1.life_points > 0 && @player2.life_points > 0
        # Le joueur 1 attaque le joueur 2
        @player1.attacks(@player2)
        # Le joueur 2 attaque le joueur 1
        @player2.attacks(@player1)
        # Affichage de l'état des deux joueurs
        puts "Voici l'état de nos joueurs :"
        @player1.show_state
        @player2.show_state
      end
    end
  end