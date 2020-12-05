function Test-SquareHasTree {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Row,
        [Parameter(Mandatory)]
        [int]$Index
    )

    $Index = $Index % $Row.Length
    if ($Row[$Index] -eq '#') {$true} else {$false}
}

function Day03-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string[]]$Map,
        [Parameter(Mandatory)] [int]$SlopeX,
        [Parameter()] [int]$SlopeY = 1
    )

    begin {
        $XPosition = 0
        $TreesEncountered = 0
    }

    process {
        foreach ($Row in $Map) {
            if (Test-SquareHasTree $Row $XPosition) {$TreesEncountered++}
            $XPosition += $SlopeX
        }
    }

    end {
        $TreesEncountered
    }
}
