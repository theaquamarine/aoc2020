function Day06-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $Responses
    )
    
    $Responses | % {
        $_.replace(' ','').ToCharArray() | Sort -Unique | Measure 
    } | Measure -Sum -Property Count | Select -Expand Sum
}

BeforeAll {
    # $DebugPreference = 'Continue'

    $responses = @"
abc

a
b
c

ab
ac

a
a
a
a

b
"@
}

Describe "Day06-1" {
    It "Returns expected output" {
        $responses = $responses -split '\r\n\r\n' -replace '\r\n',' '
        Day06-1 $responses | Should -Be 11
    }
    
    It "Solves Day06-1" {
        $responses = (Get-Content .\Day06-input.txt -Raw) -split '\n\n' -replace '\n',' '
        Day06-1 $responses | Should -Be 6748
    }
}
