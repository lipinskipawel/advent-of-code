package main

import (
	"fmt"
	"bufio"
	"strings"
	"strconv"
	"os"
)

func check(e error) {
        if e != nil {
                panic(e)
        }
}

func main() {
	reports := [][]int {
	        {7, 6, 4, 2, 1},
	        {1, 2, 7, 8, 9},
	        {9, 7, 6, 2, 1},
	        {1, 3, 2, 4, 5},
	        {8, 6, 4, 4, 1},
	        {1, 3, 6, 7, 9},
	}
	reports = readLineByLine("input.txt")

	save := saveReports(reports, true)
	fmt.Println("Number of save reports: ", save)

	save = saveReports(reports, false)
	fmt.Println("Number of save reports with removing levels: ", save)
}

func saveReports(reports [][]int, removedLevel bool) int {
	saveReports := 0
	for _, report := range reports {
		save := checkReport(report)
		if save {
			saveReports += 1
		} else {
			if !removedLevel {
				for n := range report {
					r := removeLevel(report, n)
					save := checkReport(r)
					if save {
						saveReports += 1
						break
					}
				}
			}
		}
	}
	return saveReports
}

func checkReport(report []int) bool {
	isAsc := report[0] < report[1]
	for i := 0; i < len(report) - 1; i++ {

		diff := report[i] - report[i + 1]

		if isAsc {
			if diff >= -3 && diff <= -1 {
				continue
			}
			return false
		} else {
			if diff <= 3 && diff >= 1 {
				continue
			}
			return false
		}
	}
	return true
}

func removeLevel(s []int, index int) []int {
	res := make([]int, 0)
	res = append(res, s[:index]...)
	return append(res, s[index+1:]...)
}

func readLineByLine(fileToOpen string) ([][]int) {
        file, err := os.Open(fileToOpen)
        check(err)
        defer file.Close()

        reports := make([][]int, 0, 256)

        scanner := bufio.NewScanner(file)
        for scanner.Scan() {
                line := scanner.Text()
                words := strings.Fields(line)

		level := make([]int, 0, 8)
		for _, n := range words {
			num,_ := strconv.Atoi(n)
			level = append(level, num)
		}

                reports = append(reports, level)
        }

        return reports
}

