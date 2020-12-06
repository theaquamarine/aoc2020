function Test-BirthYearIsValid {
    param ($yr)
    $yr -match '\d{4}' -and $yr -ge 1920 -and $yr -le 2002
}

function Test-IssueYearIsValid {
    param ($yr)
    $yr -match '\d{4}' -and $yr -ge 2010 -and $yr -le 2020
}

function Test-ExpiryYearIsValid {
    param ($yr)
    $yr -match '\d{4}' -and $yr -ge 2020 -and $yr -le 2030
}

function Test-HeightIsValid {
    param ($hgt)
    $isvalid = $false
    if ($hgt -like '*cm') {
        $hgt = $hgt -replace 'cm'
        $isvalid = $hgt -ge 150 -and $hgt -le 193
    } elseif ($hgt -like '*in') {
        $hgt = $hgt -replace 'in'
        $isvalid = $hgt -ge 59 -and $hgt -le 76
    }
    $isvalid
}

function Test-HairColourIsValid ($hcl) {
    $hcl -match '#[0-9a-f]{6}'
}

function Test-EyeColourIsValid ($ecl) {
    $ecl -in 'amb','blu','brn','gry','grn','hzl','oth'
}

function Test-PassportIdIsValid ($passportid) {
    [string]$passportid -match '^\d{9}$'
}

function Test-PassportIsValid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$Passport
    )

    # $passportFields= 'byr','iyr','eyr','hgt','hcl','ecl','pid','cid'
    $requiredFields = 'byr','iyr','eyr','hgt','hcl','ecl','pid'
    
    $isvalid = -not ($requiredFields | ? {$Passport -notmatch $_})
    # if (-not ($requiredFields | ? {$Passport -notmatch $_})) {$false}
    # else {
    if ($isvalid) {
        $fields = $Passport -split ' '
        switch -wildcard ($fields) {
            'byr:*' {$isvalid = $isvalid -and (Test-BirthYearIsValid ($_ -split ':')[1])} # 1920-2002
            'iyr:*' {$isvalid = $isvalid -and (Test-IssueYearIsValid ($_ -split ':')[1])} # 2010-2020
            'eyr:*' {$isvalid = $isvalid -and (Test-ExpiryYearIsValid ($_ -split ':')[1])} # 2020-2030
            'hgt:*' {$isvalid = $isvalid -and (Test-HeightIsValid ($_ -split ':')[1])} #150-193cm or 59-76in
            'hcl:*' {$isvalid = $isvalid -and (Test-HairColourIsValid ($_ -split ':')[1])}
            'ecl:*' {$isvalid = $isvalid -and (Test-EyeColourIsValid ($_ -split ':')[1])}
            'pid:*' {$isvalid = $isvalid -and (Test-PassportIdIsValid ($_ -split ':')[1])}
            # cid:* {;}
        }
    }

    $isvalid
}
function Day04-2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$Passports
    )

    $passports | ? {Test-PassportIsValid $_} | Measure | Select -ExpandProperty Count
}

BeforeAll {
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
        $passports = Get-Content .\Day04.txt -Raw
        $passports = $passports -split '\n\n' -replace '\n',' '
        Day04-2 $passports | Should -Be 114
    }
}
