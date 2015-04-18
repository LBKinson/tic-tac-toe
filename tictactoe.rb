class TicTacToe
	attr_reader :playerA, :playerB, :win_conditions
	attr_accessor :grid, :turns, :playing

	Player = Struct.new(:symbol)

	def initialize
		@playing = true
		@grid = (1..9).to_a
		@turns = 0
		@playerA = Player.new("X")
		@playerB = Player.new("O")
		winning_TTT
	end

	def winning_TTT
		row1 = grid.each_index.select { |i| (i+1) <= 3 }
		row2 = grid.each_index.select { |i| (i+1) > 3 && (i+1) < 7 }
		row3 = grid.each_index.select { |i| (i+1) >= 7 }
		col1 = grid.each_index.select { |i| (i+1) == 1 || (i+1) == 4 || (i+1) == 7 }
		col2 = grid.each_index.select { |i| (i+1) == 2 || (i+1) == 5 || (i+1) == 8 }
		col3 = grid.each_index.select { |i| (i+1) == 3 || (i+1) == 6 || (i+1) == 9 }
		diagonal1 = grid.each_index.select { |i| (i+1) == 1 || (i+1) == 5 || (i+1) == 9 }
		diagonal2 = grid.each_index.select { |i| (i+1) == 3 || (i+1) == 5 || (i+1) == 7 }
		@win_conditions = [row1,row2,row3,col1,col2,col3,diagonal1,diagonal2]
	end

	def play_game
		loop do
			game_loop
			break unless play_again?
		end
		puts "Byeeee. Thanks for playing!"
	end



	private

	def start_game
		reset_board
		reset_turns
		puts "\nWant to play a game? Great. Here's some tic-tac-toe!\n"
	end

	def game_loop
		start_game
		until game_over?
			self.turns += 1
			puts "\nYo, Player #{player_turn}! Choose a square:"
			display_board
			set_move(real_move)
		end
		game_over_message
		display_board

		#player1_turn
		#player2_turn
	end

	def display_board
		grid.each_with_index do |square, index|
			if (index+1) % 3 == 0
				print " #{square} \n"
				print "-----------\n" if index != 8
			else
				print " #{square} |"
			end
		end
	end

	def player_turn
		# alternate between players on each turn
		turns % 2 != 0 ? playerA.symbol : playerB.symbol
	end

	# def reset_board
	# 	self.grid = (1..9).to_a
	# end

	# def player1_turn
	# 	board
	# 	puts "Ready player 1... Pick a square"
	# 		# check to see if input is a number
	# 	player1_select = gets.chomp.match(/\d/)[0]
	# 	puts "your selection: #{player1_select}"
	# end

	# def player2_turn
	# 	board
	# 	puts "Player 2, you're up! Pick a square"
	# 	player2_select = gets.chomp.match(/\d/)[0]
	# end

	def pick_square
		begin
			# check if input is a number
			square = gets.chomp.match(/\d/)[0]
		rescue
			puts "Nice try, buddy. Please pick a square!"
			display_board
			retry
		end
		return square.to_i - 1
	end

	def real_move
		loop do
			square = pick_square
			if square_already_selected?(square)
				puts "\nSilly Rabbit, that square has already been used! Try another:"
				display_board
			else
				return square
			end
		end
	end

	def set_move(square)
		grid[square] = player_turn
	end

	def square_already_selected?(square)
		grid[square] == "X" || grid[square] == "O"
	end

	def reset_board
		self.grid = (1..9).to_a
	end

	def reset_turns
		self.turns = 0
	end

	def game_over_message
		puts "\nPlayer #{player_turn} wins!" if winner?
		puts "\nThe game ends in a tie!" if tie? && !winner?
	end

	def game_over?
		winner? || tie?
	end

	def winner?
		# Check if any of the win conditions are met
		win_conditions.any? { |condition| condition.all? { |i| grid[i] == "X" } || condition.all? { |i| grid[i] == "O" } }
	end

	def tie?
		# check if the board is full without any winning conditions met
		win_conditions.all? { |condition| condition.all? { |i| grid[i] == "X" || grid[i] == "O" } }
	end

	# def play
	# 	reset_board
	# 	board
	# end

	def play_again?
		puts "\nPlay again? (Y/N):"
		prompt = gets.chomp
		return prompt.to_s.downcase == "y"
	end

end

game = TicTacToe.new
game.play_game