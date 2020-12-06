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

Describe "Day06-1" {
    It "Returns expected output" {
        $responses = $responses -split '\r\n\r\n' -replace '\r\n',' '
        Day06-1 $responses | Should -Be 11
    }
    
    It "Solves Day06-1" {
        $responses = (Get-Content .\Day06.txt -Raw) -split '\n\n' -replace '\n',' '
        Day06-1 $responses | Should -Be 6748
    }
}

Describe "Day06-2" {
    It "Returns expected output" {
        $responses = $responses -split '\r\n\r\n' #-replace '\r\n',' '
        Day06-2 $responses | Should -Be 6
    }
    
    It "Solves Day06-2" {
        $responses = (Get-Content .\Day06.txt -Raw) -split '\n\n' #-replace '\n',' '
        Day06-2 $responses | Should -Be 3445
    }
}
