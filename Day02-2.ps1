class PasswordRule {
    [int] $PositionOne
    [int] $PositionTwo
    [string] $letter

    [bool] Allows([string]$password) {
        Write-Debug ("Rule requires {0} at pos {1} xor {2} of {3}" -f $this.letter, $this.PositionOne, $this.PositionTwo, $password)
        return ($password[$this.PositionOne-1] -eq $this.letter -xor $password[$this.PositionTwo-1] -eq $this.letter)
    }

    PasswordRule(
        [string]$range,
        [string]$letter
    ) {
        $this.PositionOne, $this.PositionTwo = $range.Split('-')
        $this.letter = $letter
    }

    PasswordRule([string]$rulespec) {
        $range, $this.letter = $rulespec.Split(' ')
        $this.PositionOne, $this.PositionTwo = $range.Split('-')
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
function Day02-2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]] $PuzzleInput
    )
    
    $PuzzleInput | ? {Test-PasswordDatabaseEntry $_} | Measure | Select -ExpandProperty Count
}

# Day02-1 (gc .\Day02-input.txt) # 569
