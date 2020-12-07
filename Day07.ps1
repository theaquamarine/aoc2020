function Day07-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $cancontain = @{}

    foreach ($rule in $PuzzleInput) {
        $colour, $contents = $rule -split 'contain'
        $colour = ($colour -replace 'bags').trim()

        $contentslist = ($contents -split ',' -replace '\d' -replace 'bags?' -replace '\.').trim()
        
        $contentslist | % {
            # check if key exists, append if not.
            if ($cancontain[$_]) {
                $cancontain[$_] += $colour
            } else {
                $cancontain[$_] = ,$colour
            }
        }
    }

    function Get-Containers ($colour) {
        $cancontain[$colour] | ? {$_} | % {Write-Output $_; Get-Containers $_}
    }

    # colours which can contain 'shiny gold'
    Get-Containers 'shiny gold' | Sort -Unique | Measure | Select -Expand Count
}

function Day07-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $contains = @{}

    foreach ($rule in $PuzzleInput) {
        $colour, $contents = $rule -split 'contain'
        $colour = ($colour -replace 'bags').trim()

        $contains[$colour] = ($contents -split ',' -replace 'bags?' -replace '\.').trim() | 
            ? {$_ -match "(?<n>\d+) (?<c>.*)"} | 
            % {(,"$($matches.c)")*($matches.n)}
    }

    function Get-Contents ($colour) {
        # if ($contains[$colour]) {
            $contains[$colour] | ? {$_} | % {Write-Output $_; Get-Contents $_}
        # } #else {'1'}
    }

    Get-Contents 'shiny gold' | Measure | Select -Expand Count
}

# $DebugPreference = 'Continue'

Describe "Day07-1" {
    It "Returns expected output" {
        $puzzleinput = @"
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"@

        Day07-1 ($puzzleinput -split '\r?\n') | Should -Be 4
    }
    
    It "Solves Day07-1" {
        $puzzleinput = (Get-Content ($PSCommandPath.Replace('.ps1', '.txt')) -Raw) -split '\r?\n\r?\n'
        Day07-1 ($puzzleinput -split '\r?\n') | Should -Be 211
    }
}

Describe "Day07-2" {
    It "Returns expected output" {
        $puzzleinput = @"
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"@

        Day07-2 ($puzzleinput -split '\r?\n') | Should -Be 126
    }
    
    It "Solves Day07-2" {
        $puzzleinput = (Get-Content ($PSCommandPath.Replace('.ps1', '.txt')) -Raw) -split '\r?\n\r?\n'
        Day07-2 ($puzzleinput -split '\r?\n') | Should -Be 12414
    }
}
