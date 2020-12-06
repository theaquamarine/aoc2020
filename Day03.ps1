function Find-TreesOnRoute {
    # This function is also the solution to Day 3 Part 1 on its own
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string[]]$Map,
        [Parameter(Mandatory)] [string]$Slope
    )

    $XPosition = $YPosition = $TreesEncountered = 0
    $xStep, $yStep = $Slope -split ','

    for ($yPosition = 0; $yPosition -lt $Map.Length; $YPosition += $yStep) {
        if ($Map[$YPosition][$XPosition % $Map[$YPosition].Length] -eq '#') {$TreesEncountered++}
        $XPosition += $xStep
    }

    $TreesEncountered
}

function Day03 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string[]]$Map,
        [Parameter(Mandatory)] [string[]]$Slope
    )

    $Slope | % {$total = 1} {$total *= Find-TreesOnRoute -Map $Map -Slope $_} {$total}
}

BeforeAll {
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
        Day03 (gc .\Day03.txt) -Slope '3,1' | Should -Be 223
    }

    It "Returns expected output for Day03-2" {
        Day03 -Slope $slopes -Map $Map | Should -Be 336
    }

    It "Solves Day03-2" {
        Day03 (gc .\Day03.txt) -Slope $slopes | Should -Be 3517401300
    }
}
