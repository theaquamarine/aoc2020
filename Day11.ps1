function Day11-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $floor = '.'
    $occupied = '#'
    $empty = 'L'
    function IsFloor ([string] $cell) {$cell -eq $floor}
    function IsOccupied ([string] $cell) {$cell -eq $occupied}
    function IsEmpty ([string] $cell) {$cell -eq $empty}
    function IsSeat ([string] $cell) {IsEmpty $cell -or IsOccupied $cell}
    function AdjacentOccupation ([int] $y, [int] $x, [string[]] $layout) {
        if ($y -gt 0) {
            if ($x -gt 0) {$one = ${layout}?[$y-1]?[$x-1]}
            $two = ${layout}?[$y-1]?[$x]
            $three = ${layout}?[$y-1]?[$x+1]
        }
        if ($x -gt 0) {$four = ${layout}?[$y]?[$x-1]}
        # five = self
        $six = ${layout}?[$y]?[$x+1]
        if ($y -lt ($layout.Length-1)) {
            if ($x -gt 0) {$seven = ${layout}?[$y+1]?[$x-1]}
            $eight = ${layout}?[$y+1]?[$x]
            $nine = ${layout}?[$y+1]?[$x+1]
        }
        $occupied = $one,$two,$three,$four,$six,$seven,$eight,$nine | ? {IsOccupied $_}
        Write-Output $occupied.Length
    }

    function Live ([int] $y, [int] $x, [string[]] $layout) {
        $adjacents = AdjacentOccupation $i $j $layout
        if ((IsEmpty $layout[$y][$x]) -and $adjacents -eq 0) {$occupied}
        elseif ((IsOccupied $layout[$y][$x]) -and $adjacents -ge 4) {$empty}
        else {$layout[$y][$x]}
    }

    $Layout = @() + $puzzleinput
    $hasChanged = $false
    $iteration = 0
    do {
        # Add changes to a new copy to make them "simultaneous"
        $newLayout = @() + $Layout
        $hasChanged = $false

        for ($i = 0; $i -lt $puzzleinput.Length; $i++) {
            $line = ''
            for ($j = 0; $j -lt $puzzleinput[$i].Length; $j++) {
                $line += Live $i $j $layout
            }
            if ($newLayout[$i] -ne $line) {
                $newLayout[$i] = $line
                $hasChanged = $true
                Write-Debug "old $i $($layout[$i])"
                Write-Debug "new $i $line"
            }
        }

        $Layout = @() + $newLayout
        # $layout | %{Write-Debug $_}
        Write-Verbose ("Completed iteration {0}" -f $iteration++)
    } while ($hasChanged -eq $true)

    # $layout | %{Write-Debug $_}
    $layout | % {$_.toCharArray() | ? {$_ -eq $occupied} | Measure} | Measure -Sum -Property Count | select -expand Sum
}

function Day11-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )


    $floor = '.'
    $occupied = '#'
    $empty = 'L'
    function IsFloor ([string] $cell) {$cell -eq $floor}
    function IsOccupied ([string] $cell) {$cell -eq $occupied}
    function IsEmpty ([string] $cell) {$cell -eq $empty}
    function IsSeat ([string] $cell) {(IsEmpty $cell) -or (IsOccupied $cell)}
    function AdjacentOccupation ([int] $y, [int] $x, [string[]] $layout) {
        $directions = (-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)

        # Get the nearest chair in each direction
        $adjacents = foreach ($direction in $directions) {
            $workingx = $x
            $workingy = $y
            do {
                $workingy += $direction[1]
                $workingx += $direction[0]
                if (($workingx -lt 0) -or ($workingy -lt 0) -or ($workingy -ge $layout.Length) -or ($workingx -ge $layout[$workingy].Length)) {
                    $cell = 'L'; break
                } else {
                    $cell = $layout[$workingy][$workingx]
                }
            } while (-not(IsSeat $cell))
            Write-Output $cell
        }

        $occupied = $adjacents | ?{IsOccupied $_}
        Write-Output $occupied.Length
    }

    function Live ([int] $y, [int] $x, [string[]] $layout) {
        if ($layout[$y][$x] -eq $floor) {$floor} else {
            $adjacents = AdjacentOccupation $i $j $layout
            if ((IsEmpty $layout[$y][$x]) -and $adjacents -eq 0) {$occupied}
            elseif ((IsOccupied $layout[$y][$x]) -and $adjacents -ge 5) {$empty}
            else {$layout[$y][$x]}
        }
    }

    $Layout = @() + $puzzleinput
    $hasChanged = $false
    $iteration = 0
    do {
        # Add changes to a new copy to make them "simultaneous"
        $newLayout = @() + $Layout
        $hasChanged = $false

        for ($i = 0; $i -lt $puzzleinput.Length; $i++) {
            $line = ''
            for ($j = 0; $j -lt $puzzleinput[$i].Length; $j++) {
                $line += Live $i $j $layout
            }
            if ($newLayout[$i] -ne $line) {
                $newLayout[$i] = $line
                $hasChanged = $true
                Write-Debug "old $i $($layout[$i])"
                Write-Debug "new $i $line"
            }
        }

        $Layout = @() + $newLayout
        # $layout | %{Write-Debug $_}
        Write-Verbose ("Completed iteration {0}" -f $iteration++)
    } while ($hasChanged -eq $true)

    # $layout | %{Write-Debug $_}
    $layout | % {$_.toCharArray() | ? {$_ -eq $occupied} | Measure} | Measure -Sum -Property Count | select -expand Sum
}

$verbosePreference = 'Continue'
# $DebugPreference = 'Continue'

$puzzleinput = @"
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"@

Describe "Day11-1" {
    It "Returns expected output" {
        Day11-1 ($puzzleinput -split '\r?\n') | Should -Be 37
    }
    
    It "Solves Day11-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day11-1 $puzzleinput | Should -Be 2368
    }
}

Describe "Day11-2" {
    It "Returns expected output" {
        Day11-2 ($puzzleinput -split '\r?\n') | Should -Be 26
    }
    
    It "Solves Day11-2" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day11-2 $puzzleinput | Should -Be 2124
    }
}
