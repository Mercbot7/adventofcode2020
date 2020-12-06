$inputs = Get-Content ~/repos/github.com/adventofcode2020/Day_6/input_6.txt -raw

$groups = $inputs -split "`n`n"

### Part 1
$groupcounts = 0

foreach ($group in $groups) {
    $allanswers = ($group -replace "[^a-z|A-Z]","").ToLower().ToCharArray() | Sort-Object | Get-Unique
    $groupcounts += $allanswers.length
}
Write-host "Total Unique Group Answers: $groupcounts"

### Part 2
$groupcounts = 0
foreach ($group in $groups) {
    $allanswers = ($group -replace "[^a-z|A-Z]","").ToLower().ToCharArray() | Sort-Object | Get-Unique
    
    [string]$groupanswers = ""

    $agroups = $group -split "`n"
    #$agroups | ForEach-Object {$groupanswers += [string]::Join("",($_.ToLower().ToCharArray() | Sort-Object | Get-Unique))}
    foreach ($answer in $allanswers) {
        $answercount = 0
        foreach ($agroup in $agroups) {
            if ($agroup.ToCharArray() -contains $answer) {
                $answercount++
            }
        }

        if ($answercount -eq $agroups.length) {
            $groupanswers += $answer
        }
    }
    $groupcounts += $groupanswers.length
}
Write-host "Cumulative Unique Group Answers: $groupcounts"
