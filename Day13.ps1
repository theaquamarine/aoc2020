function Day00-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )
    $time = $PuzzleInput[0]

    function WaitTime ([int] $interval) {$interval - ($time % $interval)}
    
    $timetable = @{}
    $PuzzleInput[1..$puzzleinput.Length] -split ',' | ? {$_ -ne 'x'} | % {$timetable[$_] = WaitTime $_}

    $timetable.GetEnumerator() | Sort -Property Value | Select -First 1 | %{Write-Output ([int]$_.Key * $_.Value)}
}

function Day00-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    throw [NotImplementedException]'Day00-2 is not implemented.'
}

# $DebugPreference = 'Continue'

$puzzleinput = @"
939
7,13,x,x,59,x,31,19
"@

Describe "Day00-1" {
    It "Returns expected output" {
        Day00-1 ($puzzleinput -split '\r?\n') | Should -Be 295
    }
    
    It "Solves Day00-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day00-1 $puzzleinput | Should -Be 174
    }
}

# Describe "Day00-2" {
#     It "Returns expected output" {
#         Day00-2 ($puzzleinput -split '\r?\n') | Should -Be 'EXPECTED_OUTPUT'
#     }
    
#     It "Solves Day00-2" {
#         $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
#         Day00-2 $puzzleinput | Should -Be "YOUR_EXPECTED_VALUE"
#     }
# }
