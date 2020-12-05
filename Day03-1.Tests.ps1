BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Day03-1" {
    It "Returns expected output" {
        Day03-1 -SlopeX 3 -Map "..##.......",
"#...#...#..",
".#....#..#.",
"..#.#...#.#",
".#...##..#.",
"..#.##.....",
".#.#.#....#",
".#........#",
"#.##...#...",
"#...##....#",
".#..#...#.#" | Should -Be 7
    }

    It "Solves Day03-1" {
        Day03-1 (gc .\Day03-input.txt) -SlopeX 3 | Should -Be 223
    }
}
