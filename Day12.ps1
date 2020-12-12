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

    throw [NotImplementedException]'Day12-2 is not implemented.'
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

# Describe "Day12-2" {
#     It "Returns expected output" {
#         Day12-2 ($puzzleinput -split '\r?\n') | Should -Be 'EXPECTED_OUTPUT'
#     }
    
#     It "Solves Day12-2" {
#         $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
#         Day12-2 $puzzleinput | Should -Be "YOUR_EXPECTED_VALUE"
#     }
# }
