### Phase_1
$entries = Import-Csv ~/Desktop/AoC/Day_2/input_2.csv

[int]$valid = 0
[int]$invalid = 0

foreach ($entry in $entries) {

    [int]$charcount = [regex]::matches($entry.password,$entry.character).count

    $charrange = $entry.policy -split "-" | ForEach-Object {[int]$_} | Sort-Object

    if (($charcount -ge $charrange[0]) -and ($charcount -le $charrange[1])) {
        $valid++
    }
    else {
        $invalid++
    }
}


### Phase_2

$entries = Import-Csv ~/Desktop/AoC/Day_2/input_2.csv

[int]$valid = 0
[int]$invalid = 0

foreach ($entry in $entries) {

    #[int]$charcount = [regex]::matches($entry.password,$entry.character).count

    $charrange = $entry.policy -split "-" | ForEach-Object {[int]$_} | Sort-Object
    $firstchar = $entry.password.chars(($charrange[0] - 1))
    $secondchar = $entry.password.chars(($charrange[1] - 1))

    if (($firstchar -ne $secondchar) -and (($firstchar -eq $entry.character) -or ($secondchar -eq $entry.character))) {
        $valid++
    }
    else {
        $invalid++
    }
}

