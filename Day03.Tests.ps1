BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    # $DebugPreference = 'Continue'

    $Map = "..##.......",
"#...#...#..",
".#....#..#.",
"..#.#...#.#",
".#...##..#.",
"..#.##.....",
".#.#.#....#",
".#........#",
"#.##...#...",
"#...##....#",
".#..#...#.#"

    $slopes = '1,1','3,1','5,1','7,1','1,2' 
}

Describe "Day03" {
    It "Returns expected output for Day03-1" {
        Day03 -Slope '3,1' -Map $Map | Should -Be 7
    }

    It "Solves Day03-1" {
        Day03 (gc .\Day03-input.txt) -Slope '3,1' | Should -Be 223
    }

    It "Returns expected output for Day03-2" {
        Day03 -Slope $slopes -Map $Map | Should -Be 336
    }

    It "Solves Day03-2" {
        Day03 (gc .\Day03-input.txt) -Slope $slopes | Should -Be 3517401300
    }
}
