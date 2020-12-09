function Test-NumberIsValid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int64[]] $Preamble,
        [Parameter(Mandatory)]
        [int64] $Target
    )
    $ret = $false

    for ($i = 0; $i -lt $Preamble.Length; $i++) {
        $Need = $Target - $Preamble[$i]
        if ($Preamble.Contains($Need) -and $Preamble.IndexOf($Need) -ne $i) {
            $ret = $true
        }
    }
    
    $ret
}

function Day09-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput,
        [int] $PreambleLength = 25
    )
    
    
    for ($current = $PreambleLength; $current -lt $PuzzleInput.Length; $current++) {
        $validNumbers = $PuzzleInput[($current-$PreambleLength)..($current-1)]
        # do the correct test, 
        if (-not(Test-NumberIsValid -Preamble $validNumbers -Target $PuzzleInput[$current])) {
            Write-Output $PuzzleInput[$current]; break
        } #else {
        #     $validNumbers = $PuzzleInput[($current-$PreambleLength)..$current]
        # }
    }

    # throw [NotImplementedException]'Day09-1 is not implemented.'
}

function Day09-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int64[]] $PuzzleInput,
        [Parameter()]
        $Target
    )

    :outer for ($start = 0; $start -lt $PuzzleInput.Length; $start++) {
        $acc = 0
        for ($current = $start; $current -lt $puzzleinput.Length -and $acc -lt $target; $current++) {
            $acc += $PuzzleInput[$current]
            if ($acc -eq $target) { 
                $range = $PuzzleInput[$start..$current] | Sort-Object
                Write-Output ($range[0] + $range[-1])
                break outer
            }
        }
    }
}

# $DebugPreference = 'Continue'

$puzzleinput = @"
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"@

Describe "Day09-1" {
    It "Returns expected output" {
        Day09-1 ($puzzleinput -split '\r?\n') 5 | Should -Be 127
    }
    
    It "Solves Day09-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day09-1 $puzzleinput | Should -Be 1504371145
    }
}

Describe "Day09-2" {
    It "Returns expected output" {
        Day09-2 ($puzzleinput -split '\r?\n') -Target 127 | Should -Be 62
    }
    
    It "Solves Day09-2" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day09-2 $puzzleinput 1504371145 | Should -Be 183278487
    }
}
