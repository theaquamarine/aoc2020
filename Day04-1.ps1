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
