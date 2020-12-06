function Day06-1 {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $Responses
    )
    
    $Responses | % {
        $_.replace(' ','').ToCharArray() | Sort -Unique | Measure 
    } | Measure -Sum -Property Count | Select -Expand Sum
}
