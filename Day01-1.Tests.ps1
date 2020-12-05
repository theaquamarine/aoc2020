BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Day01-1" {
    It "Returns expected output" {
        $puzzleinput = 1721, 979, 366, 299, 675, 1456
        Day01-1 $puzzleinput | Should -Be 514579
    }

    It "Solves Day01-1"{
        Day01-1 (gc .\Day01-input.txt) | Should -Be 1020099
    }
}
