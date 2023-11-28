import os
import arrays

fn array_split[T](a []T, separator T) [][]T {
	mut r := [ []T {} ]
	for v in a {
		if v == separator {
			r << []T {}
		} else {
			r.last() << v
		}
	}
	return r
}

fn array_to_int[T](a []T) []int {
	return a.map(it.int())
}


fn bags(filename string) ![]int {
	lines := os.read_lines(filename)!
	string_bags := array_split(lines, '')
	int_bags := string_bags.map(array_to_int(it))
	bags := int_bags.map(arrays.sum(it)!)

	return bags
}


fn solve_part1(filename string) !int {
	result := arrays.max(bags(filename)!)!

	return result
}


fn solve_part2(filename string) !int {
	mut sorted_bags := bags(filename)!
	sorted_bags.sort(a > b)
	sorted_bags.trim(3)
	result := arrays.sum(sorted_bags)!

	return result
}


fn solve(filename string) ! {
	println('${filename} part 1 = ${solve_part1(filename)}')
	println('${filename} part 2 = ${solve_part2(filename)}')
}


fn main() {
	solve('01/test.txt')!
	solve('01/input.txt')!
}
