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

# Day01-1 (gc .\Day01-input.txt) # 1020099
