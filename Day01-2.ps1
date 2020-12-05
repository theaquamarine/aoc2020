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
