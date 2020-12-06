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
