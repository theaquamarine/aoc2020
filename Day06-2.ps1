function Day06-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $Responses
    )
    
    $Responses | % {
        $lines = ($_.trim() -split '\n').Count
        $_.ToCharArray() | ? {$_ -match '[a-z]'} | Group-Object | ? Count -eq $lines | Measure
    } | Measure -Sum -Property Count| Select -Expand Sum
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

Describe "Day06-2" {
    It "Returns expected output" {
        $responses = $responses -split '\r\n\r\n' #-replace '\r\n',' '
        Day06-2 $responses | Should -Be 6
    }
    
    It "Solves Day06-2" {
        $responses = (Get-Content .\Day06-input.txt -Raw) -split '\n\n' #-replace '\n',' '
        Day06-2 $responses | Should -Be 3445
    }
}
