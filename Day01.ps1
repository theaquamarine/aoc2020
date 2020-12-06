function Day01-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int[]] $PuzzleInput
    )
    
    # foreach($i in $PuzzleInput) {
    #     if ($PuzzleInput.Contains(2020-$i)) {$i * $target; break}
    # }

    $PuzzleInput | ? {$PuzzleInput.Contains(2020-$_)} | % {$_ * (2020-$_)} | Select -First 1
}

function Day01-2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int[]] $PuzzleInput
    )
    
    foreach($i in $PuzzleInput) {
        $iTarget = 2020 - $i
        $return = $PuzzleInput | ? {$PuzzleInput.Contains($iTarget-$_)} | % {$_ * ($iTarget-$_)} | Select -First 1
        if ($return) {
            $i * $return
            break
        }
    }

    # $PuzzleInput | ? {$PuzzleInput.Contains(2020-$_)} | % {$_ * (2020-$_)} | Select -First 1
}

Describe "Day01-1" {
    It "Returns expected output" {
        $puzzleinput = 1721, 979, 366, 299, 675, 1456
        Day01-1 $puzzleinput | Should -Be 514579
    }

    It "Solves Day01-1"{
        Day01-1 (gc .\Day01.txt) | Should -Be 1020099
    }
}

Describe "Day01-2" {
    It "Returns expected output" {
        $puzzleinput = 1721, 979, 366, 299, 675, 1456
        Day01-2 $puzzleinput | Should -Be 241861950
    }

    It "Solves Day01-2"{
        Day01-2 (gc .\Day01.txt) | Should -Be 49214880
    }
}
