function ConvertTo-SeatID ($seat) {
    [System.Convert]::ToInt32(($seat -replace 'F|L',0 -replace 'B|R',1),2)
}

function Day05-1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$seats
    )

    $seats | % {ConvertTo-SeatID $_} | Sort -Descending | Select -First 1
}

function Day05-2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$seats
    )

    $taken = $seats | % {ConvertTo-SeatID $_}
    0..832 # All seats
    | ? {$_ -notin $taken}
    | ? {($_ + 1) -in $taken } | ? {($_ - 1) -in $taken } # Seats +/- 1 are taken
}
