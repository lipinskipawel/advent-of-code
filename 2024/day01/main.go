package main

import (
        "bufio"
        "strings"
        "strconv"
        "cmp"
        "os"
        "fmt"
        "slices"
)

func check(e error) {
        if e != nil {
                panic(e)
        }
}

func main() {
        // first := []int{3, 4, 2, 1, 3, 3}
        // second := []int{4, 3, 5, 3, 9, 3}

        first, second := readLineByLine("input.txt")
        sortedFirst, sortedSecond := sortBothSlices(first, second)

        differences := make([]int, len(sortedFirst))
        for n := range len(first) {
                differences[n] = abs(sortedFirst[n], sortedSecond[n])
        }
        fmt.Println("Total difference: ", reduce(differences))


        similarities := make([]int, len(first))
        for n := range len(first) {
                f := first[n]
                times := 0
                for m := range len(second) {
                        if second[m] == f {
                                times += 1
                        }
                }
                similarities[n] = f * times
                times = 0
        }
        fmt.Println("Similarity score: ", reduce(similarities))
}

func sortBothSlices(first, second []int) ([]int, []int) {
        slices.SortFunc(first, func(a, b int) int {
                return cmp.Compare(a, b)
        })
        slices.SortFunc(second, func(a, b int) int {
               return cmp.Compare(a, b)
        })
        return first, second
}

func abs(a, b int) int {
        if (a < b) {
                return b - a;
        }
        return a - b;
}

func reduce(diffs []int) int {
        total := 0
        for _, num := range diffs {
                total += num
        }
        return total
}

func readLineByLine(fileToOpen string) ([]int, []int) {
        file, err := os.Open(fileToOpen)
        check(err)
        defer file.Close()

        left := make([]int, 256)
        right := make([]int, 256)

        scanner := bufio.NewScanner(file)
        for scanner.Scan() {
                line := scanner.Text()
                splitted := strings.Fields(line)
                first, _ := strconv.Atoi(strings.Trim(splitted[0], " "))
                second, _ := strconv.Atoi(strings.Trim(splitted[1], " "))

                left = append(left, first)
                right = append(right, second)
        }

        return left, right
}

