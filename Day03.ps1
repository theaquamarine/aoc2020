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
