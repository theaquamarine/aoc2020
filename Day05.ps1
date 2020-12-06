function ConvertTo-RowNumber ($row) {
    [System.Convert]::ToInt32(($row -replace 'F',0 -replace 'B',1),2)
}

function ConvertTo-ColumnNumber ($col) {
    [System.Convert]::ToInt32(($col -replace 'L',0 -replace 'R',1),2)
}

function ConvertTo-SeatID ($seat) {
    $row = ConvertTo-RowNumber ($seat[0..6] -join '')
    $col = ConvertTo-ColumnNumber ($seat[7..9] -join '')
    $row * 8 + $col
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
    $free = 0..820 | ? {$_ -notin $taken}
    $free | ? {($_ + 1) -in $taken } | ? {($_ - 1) -in $taken }
}
