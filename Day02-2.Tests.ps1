BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    # $DebugPreference = 'Continue'
}

Describe "Day02-2" {
    It "Matches Password Policies" {
        Test-PasswordDatabaseEntry "1-3 a: abcde" | Should -Be $true
        Test-PasswordDatabaseEntry "1-3 b: cdefg" | Should -Be $false
        Test-PasswordDatabaseEntry "2-9 c: ccccccccc" | Should -Be $false
    }

    It "Returns expected output" {
        $puzzleinput = "1-3 a: abcde",
            "1-3 b: cdefg",
            "2-9 c: ccccccccc"
        Day02-2 $puzzleinput | Should -Be 1
    }

    It "Solves Day02-2" {
        Day02-2 (gc .\Day02-input.txt) | Should -Be 346
    }
}
