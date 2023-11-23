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

fn solve(filename string) ! {
	lines := os.read_lines(filename)!
	string_bags := array_split(lines, '')
	int_bags := string_bags.map(array_to_int(it))
	bags := int_bags.map(arrays.sum(it)!)
	result := arrays.max(bags)!

	println('${filename} = ${result}')
}


fn main() {
	solve('01/test.txt')!
	solve('01/input.txt')!
}
