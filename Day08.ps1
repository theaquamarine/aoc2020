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
        # Write-Debug "$current : $function $value"
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

function Day08-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $instructions
    )

    $current = 0
    $accumulator = 0
    $visited = @{}

    $nops = for ($i=0;$i -lt $instructions.Length; $i++) {if ($instructions[$i] -like 'nop*') {$i}}
    $i = 0
    while ($accumulator -le 0 -and $i -lt $nops.Length) {
        # replace each jmp with a nop and run to see if it exits
        Write-Debug "Replacing nop $i of $($nops.Length)"
        $instructions[$nops[$i]] = $instructions[$nops[$i]].replace('nop','jmp')
        $current = 0
        $visited = @{}

        while ($current -lt $instructions.Length) {
            $function, $value = $instructions[$current] -split ' '
            if ($null -ne $value) {$value = [int]($value -replace '\+')}
            if ($visited[$current]) {
                $highest = $visited.Keys| sort | select -Last 1; 
                Write-Debug "loop on $current : $function $value ; highest = $highest" 
                $accumulator = 0
                break}
            else {$visited[$current] = $true}

            switch ($function) {
                'acc' {$accumulator += $value; $current++}
                'jmp' {$target = $current + $value; if ($target -gt $instructions.Length) {Write-Output $accumulator; $current++ } else {$current = $target}}
                'nop' {$current++}
                Default {;}
            }
        }

        # put $instructions back as it was
        $instructions[$nops[$i]] = $instructions[$nops[$i]].replace('jmp','nop')
        $i++
    }

    $jmps = for ($i=0;$i -lt $instructions.Length; $i++) {if ($instructions[$i] -like 'jmp*') {$i}}
    $i = 0
    while ($accumulator -le 0 -and $i -lt $jmps.Length) {
        Write-Debug "Replacing jmp $i of $($jmps.Length)"
        # replace each jmp with a nop and run to see if it exits
        $instructions[$jmps[$i]] = $instructions[$jmps[$i]].replace('jmp','nop')
        $current = 0
        $visited = @{}

        while ($current -lt $instructions.Length) {
            $function, $value = $instructions[$current] -split ' '
            if ($null -ne $value) {$value = [int]($value -replace '\+')}
            if ($visited[$current]) {
                $highest = $visited.Keys| sort | select -Last 1; 
                Write-Debug "loop on $current : $function $value ; highest = $highest" 
                $accumulator = 0
                break}
            else {$visited[$current] = $true}

            switch ($function) {
                'acc' {$accumulator += $value; $current++}
                'jmp' {$target = $current + $value; if ($target -gt $instructions.Length) {Write-Output $accumulator; $current++ } else {$current = $target}}
                'nop' {$current++}
                Default {;}
            }
        }

        # put $instructions back as it was
        $instructions[$jmps[$i]] = $instructions[$jmps[$i]].replace('nop','jmp')
        $i++
    }

    Write-Output $accumulator
}

# $DebugPreference = 'Continue'

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

Describe "Day08-2" {
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
        Day08-2 ($puzzleinput -split '\r?\n') | Should -Be 8
    }
    
    It "Solves Day08-2" {
        $puzzleinput = (Get-Content ($PSCommandPath.Replace('.ps1', '.txt')) -Raw) -split '\r?\n\r?\n'
        Day08-2 ($puzzleinput.trim() -split '\r?\n') | Should -Be 1089
    }
}
