function ConvertTo-SeatID ($seat) {
    [System.Convert]::ToInt32(($seat -replace 'F|L',0 -replace 'B|R',1),2)
}

function Day05-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$seats
    )

    $seats | % {ConvertTo-SeatID $_} | Sort -Descending | Select -First 1
}

function Day05-2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$seats
    )

    $taken = $seats | % {ConvertTo-SeatID $_}
    0..832 # All seats
    | ? {$_ -notin $taken}
    | ? {($_ + 1) -in $taken } | ? {($_ - 1) -in $taken } # Seats +/- 1 are taken
}

Describe "Day05-1" {
    It "Returns expected output" {
        # ConvertTo-RowNumber 'FBFBBFFRLR' | Should -Be 44
        Day05-1 'FBFBBFFRLR' | Should -Be 357
        Day05-1 'BFFFBBFRRR' | Should -Be 567
        Day05-1 'FFFBBBFRRR' | Should -Be 119
        Day05-1 'BBFFBBFRLL' | Should -Be 820
    }

    It "Solves Day05-1" {
        Day05-1 (Get-Content .\Day05.txt) | Should -Be 832
    }

    It "Solves Day05-2" {
        Day05-2 (Get-Content .\Day05.txt) | Should -Be 517
    }
}
