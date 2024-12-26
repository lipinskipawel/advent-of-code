package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
	"strconv"
)

type multiplication struct {
	left int
	right int
}

func main() {
	memory := "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
	memory = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
	memory = fromFile("input.txt")

	mulInstructions := parseMul(memory)
	result := executeMultiplication(mulInstructions)
	fmt.Println("Results of multiplications: ", result)

	mulInstructions = parseDoDoNotMul(memory)
	result = executeMultiplication(mulInstructions)
	fmt.Println("Results of multiplications with do/don't: ", result)
}

func parseMul(input string) []multiplication {
	result := make([]multiplication, 0, 8)
	reg, _ := regexp.Compile("mul\\(\\d+,\\d+\\)")
	matched := reg.FindAllString(input, -1)
	if matched == nil {
		return result
	}
	regDigits, _ := regexp.Compile(`\d+`)
	if regDigits == nil {
		return result
	}
	for i := range len(matched) {
		digits := regDigits.FindAllString(matched[i], 2)
		if digits != nil {
			left, _ := strconv.Atoi(digits[0])
			right, _ := strconv.Atoi(digits[1])
			result = append(result, multiplication{left: left, right: right})
		}
	}
	return result
}

func parseDoDoNotMul(input string) []multiplication {
	result := make([]multiplication, 0, 8)
	reg, _ := regexp.Compile("mul\\(\\d+,\\d+\\)|do\\(\\)|don't\\(\\)")
	matched := reg.FindAllString(input, -1)
	if matched == nil {
		return result
	}
	regDigits, _ := regexp.Compile(`\d+`)
	if regDigits == nil {
		return result
	}
	adding := true
	for i := range len(matched) {
		instruction := matched[i]
		if strings.EqualFold(instruction, "do()") {
			adding = true
		}
		if strings.EqualFold(instruction, "don't()") {
			adding = false
		}
		if adding {
			digits := regDigits.FindAllString(matched[i], 2)
			if digits != nil {
				left, _ := strconv.Atoi(digits[0])
				right, _ := strconv.Atoi(digits[1])
				result = append(result, multiplication{left: left, right: right})
			}
		}
	}
	return result
}

func executeMultiplication(muls []multiplication) int {
	sum := 0
	for _, val := range muls {
		sum += val.left * val.right
	}
	return sum
}

func fromFile(fileToOpen string) string {
        content, err := os.ReadFile(fileToOpen)
        check(err)
        return string(content)
}

func check(e error) {
        if e != nil {
                panic(e)
        }
}

