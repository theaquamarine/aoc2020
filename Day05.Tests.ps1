BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
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
        Day05-1 (Get-Content .\Day05-input.txt) | Should -Be 832
    }

    It "Solves Day05-2" {
        Day05-2 (Get-Content .\Day05-input.txt) | Should -Be 517
    }
}
