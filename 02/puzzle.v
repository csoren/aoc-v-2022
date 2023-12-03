import os
import arrays

struct Round {
	elf int
	me int
}


fn as_move(move string, first u8) int {
	return move[0] - first + 1
}


fn as_round(str string) &Round {
	moves := str.split(' ')
	return &Round {
		elf: as_move(moves[0], `A`)
		me: as_move(moves[1], `X`)
	}
}


fn as_score(round &Round)  int {
	if round.elf == round.me { return 3 + round.me }
	else if round.elf == round.me - 1 || (round.elf == round.me + 2) { return 6 + round.me }
	else { return 0 + round.me }
}


fn read_rounds(filename string) ![]&Round {
	lines := os.read_lines(filename)!
	result := lines.map(as_round(it))
	return result
}


fn solve_part1(filename string) !int {
	rounds := read_rounds(filename)!
	scores := rounds.map(as_score(it))
	score := arrays.sum(scores)!

	return score
}


fn select_move(round Round) Round {
	move := match round.me {
		3 { if round.elf == 3 { 1 } else { round.elf + 1 } }
		2 { round.elf }
		1 { if round.elf == 1 { 3 } else { round.elf - 1 } }
		else { panic('This shouldn\'t happen') }
	}
	return Round { 
		...round
		me: move
	}
}


fn solve_part2(filename string) !int {
	input := read_rounds(filename)!
	scores := input.map(as_score(select_move(it)))
	score := arrays.sum(scores)!

	return score
}


fn solve(filename string) ! {
	println("${filename} part 1 = ${solve_part1(filename)!}")
	println("${filename} part 2 = ${solve_part2(filename)!}")
}


fn main() {
	solve('02/test.txt')!
	solve('02/input.txt')!
}
