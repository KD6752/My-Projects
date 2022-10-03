"""
Name:Kokil Dhakal
Collaborator: None
Source: https://gist.github.com/qianguigui1104/edb3b11b33c78e5894aad7908c773353
Extension  :None
"""
import random

class TicTacToeSim:

    # Part 1
    def __init__(self):
        self.board = [[0,0, 0], [0, 0, 0], [0, 0, 0]]
        self.turn = 1
        self.AI = True
        self.AI_turn = 2

    def change_turn(self):
        # switching turn between  player1 and player 2
        if self.turn == 1:

            self.turn = 2

        else:

            self.turn = 1
        return

    def play_game(self):
        self.get_settings()
        while True:
            self.make_move()
            if self.check_winner():
                print(f"Player {self.turn} wins the game !")
                self.print_board()
                break
            if len(self.get_available_squares()) == 0:  # if there is no space to move i.e tie
                print("It's tie!")
                break
            self.change_turn()
            self.print_board()

    # Part 2
    def print_board(self):
    # 0's are still on the board
    # this loop method is to get 3/3 board with good spaces between them
        for i in self.board:
            print(" " * 7)
            for j in i:
                print(" " + str(j), end="   ")
            print(" ")
        print(" " * 7)

    # Part 3
    # this method is getting move from users as row and column as a input
    def get_move(self):
        move = int(input("row: ")),int(input("col: "))
        return move


    def get_available_squares(self):
        # Get a list of available squares as tuples (row,col)
        # this method gets the total available squares  that has 0 valuse
        available_squares = [(i, j) for i in range(3) for j in range(3) if self.board[i][j] == 0]
        return available_squares


    """this make_move method is  combined version of take turn and make move. this mehtod basically used for making move on the board 
    each of the player once at their turn and also some part of the print board as it is used for assigning player 1 to X and player 2
    to O """
    def make_move(self):
        # Assigning player1 to "X" and Player 2 to "O"
        if self.turn == 1:
            player = "X"
        else:
            player = "O"

        if self.AI:  # if AI is True from input(playing with AI)
            if self.turn == 1:
                # move from player 1 as input
                print("Player 1's turn!")
                move = self.get_move()
                row,col=move #tupple unpacking

            ## row-1 and col-1 is just to make easy to count row and column for palyers.
                while self.board[row - 1][col - 1] != 0:
                    print("occupied already! try again!!")
                    move = self.get_move()
                    row, col = move

                self.board[row - 1][col - 1] = player
            else:
                # move from player 2 as random move
                print("Player 2's turn!")
                move = self.smart_move()
                r, c = move # r for row and c for column from AI move
                self.board[r][c] = player

        else:  # if AI is false i.e playing between two human
            print(f"Player {self.turn}'s turn!")
            move = self.get_move()
            row, col = move

            while self.board[row - 1][col - 1] != 0:
                print("occupied already! try again!!")
                move = self.get_move()
                row, col = move

            self.board[row - 1][col - 1] = player

    # Part 5
    """ This check _winner() method checks for all rows, columns and diagonals for  3 straight O's or X's . if it finds, returns
    True.  """
    def check_winner(self):

        if ((self.board[0][0] == self.board[0][1] == self.board[0][2] != 0 or
             (self.board[1][0] == self.board[1][1] == self.board[1][2] != 0) or #winning rows
             (self.board[2][0] == self.board[2][1] == self.board[2][2] != 0) or

             (self.board[0][0] == self.board[1][0] == self.board[2][0] != 0) or
             (self.board[0][1] == self.board[1][1] == self.board[2][1] != 0) or #winning columns
             (self.board[0][2] == self.board[1][2] == self.board[2][2] != 0) or

             (self.board[0][0] == self.board[1][1] == self.board[2][2] != 0) or #winning diagnals
             (self.board[0][2] == self.board[1][1] == self.board[2][0] != 0))):
            return True

    # Part 6
    def random_move(self):
        """Returns a random move from the list of available squares."""
        available_moves = self.get_available_squares()
        move = random.choice(available_moves)
        return move

    """ This is exhaustive search for all possible available square that can be filled up by AI if two squares of that line
    is already filled up by AI. it is applied to all rows, columns and diagnols.
    """
    def winning_move(self):

        # first row
        if self.board[0][0] == self.board[0][1] == "O" and self.board[0][2] == 0:
            return 0, 2
        elif self.board[0][0] == self.board[0][2] == "O" and self.board[0][1] == 0:
            return 0, 1
        elif self.board[0][2] ==self.board[0][1] == "O" and self.board[0][0] == 0:
            return 0, 0
            # second row
        elif self.board[1][0] == self.board[1][1] == "O" and self.board[1][2] == 0:
            return 1, 2

        elif self.board[1][1] == self.board[1][2] == "O" and self.board[1][0] == 0:
            return 1, 0
        elif self.board[1][2] == self.board[1][0] == "O" and self.board[1][1] == 0:
            return 1, 1
        # row 3
        elif self.board[2][0] == self.board[2][1] == "O" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][1] == self.board[2][2] == "O" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[2][0] ==self.board[2][2] == "O" and self.board[2][1] == 0:
            return 2, 1

        # column 1
        elif self.board[0][0] == self.board[1][0] == "O" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[2][0] == self.board[1][0] == "O" and self.board[0][0] == 0:
            return 0, 0
        elif self.board[0][0] == self.board[2][0] == "O" and self.board[1][0] == 0:
            return 1, 0
        # column 2
        elif self.board[0][1] == self.board[1][1] == "O" and self.board[2][1] == 0:
            return 2, 1
        elif self.board[2][1] == self.board[0][1] == "O" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[1][1] == self.board[2][1] == "O" and self.board[0][1] == 0:
            return 0, 1
            # column 3
        elif self.board[0][2] == self.board[1][2] == "O" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][2] == self.board[0][2] == "O" and self.board[1][2] == 0:
            return 1, 2
        elif self.board[1][2] == self.board[2][2] == "O" and self.board[0][2] == 0:
            return 0, 2
            # diagonals 1
        elif self.board[0][0] == self.board[1][1] == "O" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][2] == self.board[0][0] == "O" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[2][2] == self.board[1][1] == "O" and self.board[0][0] == 0:
            return 0, 0
            # diagonals 2
        elif self.board[0][2] == self.board[1][1] == "O" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[0][2] == self.board[2][0] == "O" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[2][0] == self.board[1][1] == "O" and self.board[0][2] == 0:
            return 0, 2
# this threat to lose method blocks opponet win if wining_move not available.
    def threat_to_lose(self):

        if self.board[0][0] == self.board[0][1] == "X" and self.board[0][2] == 0:
            return 0, 2
        elif self.board[0][0] == self.board[0][2] == "X" and self.board[0][1] == 0:
            return 0, 1
        elif self.board[0][2] == self.board[0][1] == "X" and self.board[0][0] == 0:
            return 0, 0
            # second row
        elif self.board[1][0] == self.board[1][1] == "X" and self.board[1][2] == 0:
            return 1, 2

        elif self.board[1][1] == self.board[1][2] == "X" and self.board[1][0] == 0:
            return 1, 0
        elif self.board[1][2] == self.board[1][0] == "X" and self.board[1][1] == 0:
            return 1, 1
        # row 3
        elif self.board[2][0] == self.board[2][1] == "X" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][1] == self.board[2][2] == "X" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[2][0] == self.board[2][2] == "X" and self.board[2][1] == 0:
            return 2, 1

        # column 1
        elif self.board[0][0] == self.board[1][0] == "X" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[2][0] == self.board[1][0] == "X" and self.board[0][0] == 0:
            return 0, 0
        elif self.board[0][0] == self.board[2][0] == "X" and self.board[1][0] == 0:
            return 1, 0
        # column 2
        elif self.board[0][1] == self.board[1][1] == "X" and self.board[2][1] == 0:
            return 2, 1
        elif self.board[2][1] == self.board[0][1] == "X" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[1][1] == self.board[2][1] == "X" and self.board[0][1] == 0:
            return 0, 1
            # column 3
        elif self.board[0][2] == self.board[1][2] == "X" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][2] == self.board[0][2] == "X" and self.board[1][2] == 0:
            return 1, 2
        elif self.board[1][2] == self.board[2][2] == "X" and self.board[0][2] == 0:
            return 0, 2
            # diagonals 1
        elif self.board[0][0] == self.board[1][1] == "X" and self.board[2][2] == 0:
            return 2, 2
        elif self.board[2][2] == self.board[0][0] == "X" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[2][2] == self.board[1][1] == "X" and self.board[0][0] == 0:
            return 0, 0
            # diagonals 2
        elif self.board[0][2] == self.board[1][1] == "X" and self.board[2][0] == 0:
            return 2, 0
        elif self.board[0][2] == self.board[2][0] == "X" and self.board[1][1] == 0:
            return 1, 1
        elif self.board[2][0] == self.board[1][1] == "X" and self.board[0][2] == 0:
            return 0, 2

    def smart_move(self):
        """ In this method i am trying get a move from AI which  which should be from available squares, first wins if applicable,
        then blocks if opponent is winning and if both of condition does not match, get a random value from available squres to move.
        """
        move = ()
        if self.winning_move() is not None and self.winning_move() in self.get_available_squares():
            move = self.winning_move()
        elif self.threat_to_lose() is not None and self.threat_to_lose() in self.get_available_squares():
            move = self.threat_to_lose()
        else:
            move = self.random_move()
        return move

    # Part 8
    """ This method for setting up the overall application looking for right input from users and based on that
    changing the setting of game oferall ask two questions validate their answer and change the setting of app"""
    def get_settings(self):
        print("would you like to play with AI ?")
        with_ai = input("True/False: ").capitalize()
        while with_ai not in ["True", "False"]:
            print("Please enter either True or False")
            print("would you like to play wit AI True/False ?")
            with_ai = input("True/False: ").capitalize()
        if with_ai == "True":
            self.AI = True
        else:
            self.AI = False

        print("Do you like to be player 1 or player 2 ?")
        self.turn =input("1/2: ")

        while self.turn not in ["1" , "2"]:
            print("invalid player")
            print("Do you like to be player 1 or player 2 ?")
            self.turn =input("1/2: ")
        print(f"player {self.turn} goes first")
        if self.turn =="1":
            self.turn = 1
        else:self.turn =2



if __name__ == '__main__':
    sim = TicTacToeSim()
    sim.play_game()


