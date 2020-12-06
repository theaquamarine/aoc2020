BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $DebugPreference = 'Continue'

    $passports = @"
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007

pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
"@
}

Describe "Day04-2" {
    It "Returns expected output" {
        Test-BirthYearIsValid 2002 | Should -Be $true
        Test-BirthYearIsValid 2003 | Should -Be $false

        Test-HeightIsValid '60in' | Should -Be $true
        Test-HeightIsValid '190cm' | Should -Be $true
        Test-HeightIsValid '190in' | Should -Be $false
        Test-HeightIsValid '190' | Should -Be $false

        Test-HairColourIsValid '#123abc' | Should -Be $true
        Test-HairColourIsValid '#123abz' | Should -Be $false
        Test-HairColourIsValid '123abc' | Should -Be $false

        Test-EyeColourIsValid 'brn' | Should -Be $true
        Test-EyeColourIsValid 'wat' | Should -Be $false

        Test-PassportIDIsValid '000000001' | Should -Be $true
        Test-PassportIDIsValid '0123456789' | Should -Be $false

        $passports = $passports -split '\r\n\r\n' -replace '\r\n',' '
        Day04-2 $passports | Should -Be 4
    }
    
    It "Solves Day04-2" {
        $passports = Get-Content .\Day04-input.txt -Raw
        $passports = $passports -split '\n\n' -replace '\n',' '
        Day04-2 $passports | Should -Be 114
    }
}
