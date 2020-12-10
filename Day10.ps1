function Day10-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int[]] $PuzzleInput
    )

    $outlet = 0
    $device = ($PuzzleInput | Sort -Descending)[0] + 3
    $joltages = @($outlet,$device)+$PuzzleInput
    $count= @(0,0,0,0)

    # relies on all joltages being valid + used?
    foreach ($joltage in $joltages) {
        if ($joltages -contains ($joltage+1)) {
            $count[1]++
        } elseif ($joltages -contains ($joltage+2)) {
            $count[2]++
        } elseif ($joltages -contains ($joltage+3)) {
            $count[3]++
        } else {
            # break
        }
    }

    $result = $count[1] * $count[3]
    Write-Output $result
}

function Day10-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int[]] $PuzzleInput
    )

    $outlet = 0
    $device = ($PuzzleInput | Sort -Descending)[0] + 3
    $joltages = @($outlet,$device)+$PuzzleInput | sort
    $count = @{}
    $joltages | % {$count[$_] = 0}
    $count[$device] = 1

    # iterate BACKWARDS, counting paths in a dag
    for ($i=$joltages.Length-1; $i -ge 0; $i--) {
        $joltage = $joltages[$i]
        $count[$joltage] += $count[$joltage+1]
        $count[$joltage] += $count[$joltage+2]
        $count[$joltage] += $count[$joltage+3]
    }

    Write-Output $count[$outlet]
}

# $DebugPreference = 'Continue'

$puzzleinput = @"
16
10
15
5
1
11
7
19
6
12
4
"@

Describe "Day10-1" {
    It "Returns expected output" {
        Day10-1 ($puzzleinput -split '\r?\n') | Should -Be 35 #@(0,7,0,5)
    }

    It "Returns expected output 2" {
        $puzzleinput = @"
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"@
        Day10-1 ($puzzleinput -split '\r?\n') | Should -Be 220 #@(0,22,0,10)
    }
    
    It "Solves Day10-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day10-1 $puzzleinput | Should -Be 2080
    }
}

Describe "Day10-2" {
    It "Returns expected output" {
        Day10-2 ($puzzleinput -split '\r?\n') | Should -Be 8
    }
    
    It "Returns expected output 2" {
        $puzzleinput = @"
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"@
        Day10-2 ($puzzleinput -split '\r?\n') | Should -Be 19208
    }
    
    It "Solves Day10-2" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day10-2 $puzzleinput | Should -Be 6908379398144
    }
}
