function Day14-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $memory = @{}
    $bitmask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X'
    $maskOn = $null
    $maskOff = $null

    function Mem ([long]$address, [long]$value) {
        $value = $value -bor $maskOn -band (-bnot $maskOff)
        $memory[$address] = $value
    }


    switch -regex ($PuzzleInput) {
        'mask = (?<value>[01X]+)' {
            $bitmask = $matches.value
            $maskOn = [convert]::ToUInt64(($bitmask -replace 'X',0),2)
            $maskOff = [convert]::ToUInt64(($bitmask -replace 1,'X' -replace 0,1 -replace 'X',0),2)
            continue
        }
        'mem\[(?<address>\d+)] = (?<value>\d+)' {Mem $matches.address $matches.value}
    }

    $memory.Values | Measure -Sum | Select -ExpandProperty Sum
}

function Day14-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $PuzzleInput
    )

    $memory = @{}
    $bitmask = ''

    function Mem ($address, [long]$value) {
        # $address = $address -bor $maskOn
        $address = '' + [Convert]::ToString($address,2).PadLeft(36,'0')

        # loop for each variation
        $xes = ($bitmask -replace '[01]').length
        $replacements = [System.Math]::Pow(2,$xes)
        for ($i = 0; $i -lt $replacements; $i++) {

            # set of digits to replace Xes with
            $xstring = [convert]::ToString($i,2).PadLeft($xes,'0')
            $xcounter = 0

            # build real address using decoder rules
            $realaddressstring = for ($j = 0; $j -lt $bitmask.Length; $j++) {
                if ($bitmask[$j] -eq 'X') {
                    $xstring[$xcounter]
                    $xcounter++
                } elseif ($bitmask[$j] -eq '1') {
                    1
                } else {
                    $address[$j]
                }
            }

            $realaddress = [convert]::ToUInt64($realaddressstring -join '', 2)

            $memory[$realaddress] = $value
        }
    }


    switch -regex ($PuzzleInput) {
        'mask = (?<value>[01X]+)' {
            $bitmask = $matches.value
            continue
        }
        'mem\[(?<address>\d+)] = (?<value>\d+)' {Mem $matches.address $matches.value}
    }

    $memory.Values | Measure -Sum | Select -ExpandProperty Sum
}

# $DebugPreference = 'Continue'

$puzzleinput = @"
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"@

Describe "Day14-1" {
    It "Returns expected output" {
        Day14-1 ($puzzleinput -split '\r?\n') | Should -Be 165
    }
    
    It "Solves Day14-1" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day14-1 $puzzleinput | Should -Be 11501064782628
    }
}

Describe "Day14-2" {
    It "Returns expected output" {
        $puzzleinput = @"
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"@
        Day14-2 ($puzzleinput -split '\r?\n') | Should -Be 208
    }
    
    It "Solves Day14-2" {
        $puzzleinput = Get-Content ($PSCommandPath.Replace('.ps1', '.txt'))
        Day14-2 $puzzleinput | Should -Be 5142195937660
    }
}
