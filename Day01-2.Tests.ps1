BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Day01-2" {
    It "Returns expected output" {
        $puzzleinput = 1721, 979, 366, 299, 675, 1456
        Day01-2 $puzzleinput | Should -Be 241861950
    }

    It "Solves Day01-2"{
        Day01-2 (gc .\Day01-input.txt) | Should -Be 49214880
    }
}
