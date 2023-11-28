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


fn solve(filename string) ! {
	lines := os.read_lines(filename)!
	rounds := lines.map(as_round(it))
	scores := rounds.map(as_score(it))
	score := arrays.sum(scores)!

	println("${filename} score = ${score}")
}

fn main() {
	solve('02/test.txt')!
	solve('02/input.txt')!
}
