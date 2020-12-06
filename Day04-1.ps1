function Test-PassportIsValid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$Passport
    )

    # $passportFields= 'byr','iyr','eyr','hgt','hcl','ecl','pid','cid'
    $requiredFields = 'byr','iyr','eyr','hgt','hcl','ecl','pid'
    
    -not ($requiredFields | ? {$Passport -notmatch $_})
}
function Day04-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$Passports
    )

    # $validpassports = $passports | ? {Test-PassportIsValid $_} 
    # $validpassports | Measure | Select -expand Count

    $passports | ? {Test-PassportIsValid $_} | Measure | Select -expand Count
}

BeforeAll {
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
        $passports = Get-Content .\Day04.txt -Raw
        $passports = $passports -split '\n\n' -replace '\n',' '
        Day04-1 $passports | Should -Be 196
    }
}
