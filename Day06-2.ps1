function Day06-2 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $Responses
    )
    
    $Responses | % {
        $lines = ($_.trim() -split '\n').Count
        $_.ToCharArray() | ? {$_ -match '[a-z]'} | Group-Object | ? Count -eq $lines | Measure
    } | Measure -Sum -Property Count| Select -Expand Sum
}
