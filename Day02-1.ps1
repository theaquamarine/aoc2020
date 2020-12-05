class PasswordRule {
    [int] $minimum
    [int] $maximum
    [string] $letter

    [bool] Allows([string]$password) {
        $count = ($password.ToCharArray() | ? {$_ -eq $this.letter}).Count
        Write-Debug ("Rule requires {0} - {1} * {2}, input {3} has {4}" -f $this.minimum, $this.maximum, $this.letter, $password, $count)
        return ($count -ge $this.minimum -and $count -le $this.maximum)
    }

    PasswordRule(
        [string]$range,
        [string]$letter
    ) {
        $this.minimum, $this.maximum = $range.Split('-')
        $this.letter = $letter
    }

    PasswordRule([string]$rulespec) {
        $range, $this.letter = $rulespec.Split(' ')
        $this.minimum, $this.maximum = $range.Split('-')
    }
}

function Test-PasswordDatabaseEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$line
    )
    
    process {
        $rule, $password = $line -split ':'
        $rule = [PasswordRule]::new($rule.trim())
        $rule.Allows($password.trim())
    }
}
function Day02-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]] $PuzzleInput
    )
    
    $PuzzleInput | ? {Test-PasswordDatabaseEntry $_} | Measure | Select -ExpandProperty Count
}

# Day02-1 (gc .\Day02-input.txt) # 569
