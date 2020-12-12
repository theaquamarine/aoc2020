function Day12-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $x = 0
    $y = 0
    $facing = 'east'

    function TurnLeft ([int]$amount) {
        for (;$amount -gt 0; $amount -= 90) {
            $facing = switch ($facing) {
                'east' {'north'; break}
                'north' {'west'; break}
                'west' {'south'; break}
                'south' {'east'; break}
            }
        }
        $facing
    }

    function TurnRight ([int]$amount) {
        for (;$amount -gt 0; $amount -= 90) {
            $facing = switch ($facing) {
                'east' {'south'; break}
                'south' {'west'; break}
                'west' {'north'; break}
                'north' {'east'; break}
            }
        }
        $facing
    }
    
    foreach ($instruction in $PuzzleInput) {
        $instruction -match '(?<action>\w)(?<value>\d+)' | out-null
        if ($matches.action -eq 'f') {$matches.action = $facing[0]}
        switch ($matches.action) {
            'n' {$y += $matches.value}
            's' {$y -= $matches.value}
            'e' {$x += $matches.value}
            'w' {$x -= $matches.value}
            'l' {$facing = TurnLeft $matches.value}
            'r' {$facing = TurnRight $matches.value}
        }
        Write-Debug ("$instruction : {0} {1} : now at $x,$y facing $facing" -f $matches.action, $matches.value)
    }

    Write-Output ([System.Math]::Abs($x) + [System.Math]::Abs($y))
}

function Day12-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $shipx = 0
    $shipy = 0
    $waypointoffset = 10,1
    $facing = 'east'

    function TurnLeft ([int]$amount) {
        $x = $waypointoffset[0]
        $y = $waypointoffset[1]
        $rads = $amount * [math]::PI / 180
        $newx = [math]::round($x * [math]::Cos($rads) - $y * [math]::sin($rads))
        $newy = [math]::round($x * [math]::sin($rads) + $y * [math]::Cos($rads))
        Write-Debug "Rotating $x,$y ccw by $amount -> $newx,$newy"
        ($newx,$newy)
    }

    function TurnRight ([int]$amount) {
        TurnLeft (-1 * $amount)
    }
    
    foreach ($instruction in $PuzzleInput) {
        $instruction -match '(?<action>\w)(?<value>\d+)' | out-null
        switch ($matches.action) {
            'n' {$waypointoffset[1] += $matches.value}
            's' {$waypointoffset[1] -= $matches.value}
            'e' {$waypointoffset[0] += $matches.value}
            'w' {$waypointoffset[0] -= $matches.value}
            'l' {$waypointoffset = TurnLeft $matches.value}
            'r' {$waypointoffset = TurnRight $matches.value}
            'f' {
                $shipx += $waypointoffset[0] * $matches.value
                $shipy += $waypointoffset[1] * $matches.value
            }
        }
        Write-Debug ("$instruction : {0} {1} : now at $shipx,$shipy waypoint {2},{3}" -f $matches.action, $matches.value, $waypointoffset[0], $waypointoffset[1])
    }

    Write-Output ([System.Math]::Abs($shipx) + [System.Math]::Abs($shipy))
}

# $DebugPreference = 'Continue'

$puzzleinput = @"
F10
N3
F7
R90
F11
"@

Describe "Day12-1" {
    It "Returns expected output" {
        Day12-1 ($puzzleinput -split '\r?\n') | Should -Be 25
    }
    
    It "Solves Day12-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day12-1 $puzzleinput | Should -Be 562
    }
}

Describe "Day12-2" {
    It "Returns expected output" {
        Day12-2 ($puzzleinput -split '\r?\n') | Should -Be 286
    }
    
    It "Solves Day12-2" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day12-2 $puzzleinput | Should -Be 101860
    }
}
