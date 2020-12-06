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
