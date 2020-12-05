BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Day02-1" {
    It "Matches Password Policies" {
        Test-PasswordDatabaseEntry "1-3 a: abcde" | Should -Be $true
        Test-PasswordDatabaseEntry "1-3 b: cdefg" | Should -Be $false
        Test-PasswordDatabaseEntry "2-9 c: ccccccccc" | Should -Be $true
    }

    It "Returns expected output" {
        $puzzleinput = "1-3 a: abcde",
            "1-3 b: cdefg",
            "2-9 c: ccccccccc"
        Day02-1 $puzzleinput | Should -Be 2
    }

    It "Solves Day02-1" {
        Day02-1 (gc .\Day02-input.txt) | Should -Be 569
    }
}
