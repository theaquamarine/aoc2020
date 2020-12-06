BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $DebugPreference = 'Continue'

    $passports = @"
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"@
}

Describe "Day04-1" {
    It "Returns expected output" {
        $passports = $passports -split '\r\n\r\n' -replace '\r\n',' '
        Day04-1 $passports | Should -Be 2
    }
    
    It "Solves Day04-1" {
        $passports = Get-Content .\Day04-input.txt -Raw
        $passports = $passports -split '\n\n' -replace '\n',' '
        Day04-1 $passports | Should -Be 196
    }
}