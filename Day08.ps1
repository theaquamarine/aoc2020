function Day08-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $instructions
    )

    $current = 0
    $accumulator = 0
    $visited = @{}

    while ($current -lt $instructions.Length) {
        $function, $value = $instructions[$current] -split ' '
        Write-Debug "$current : $function $value"
        if ($visited[$current]) {Write-Output $accumulator; break}
        else {$visited[$current] = $true}

        switch ($function) {
            'acc' {$accumulator += [int]($value -replace '\+'); $current++}
            'jmp' {$current += [int]($value -replace '\+')}
            'nop' {$current++}
            Default {;}
        }
    }
}

$DebugPreference = 'Continue'

Describe "Day08-1" {
    It "Returns expected output" {
        $puzzleinput = @"
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"@
        Day08-1 ($puzzleinput -split '\r?\n') | Should -Be 5
    }
    
    It "Solves Day08-1" {
        $puzzleinput = (Get-Content ($PSCommandPath.Replace('.ps1', '.txt')) -Raw) -split '\r?\n\r?\n'
        Day08-1 ($puzzleinput -split '\r?\n') | Should -Be 1179
    }
}
