$inputs = Get-Content ~/repos/github.com/adventofcode2020/Day_5/input_5.txt

$highest = 0
$totalrows = 128
$totalcolumns = 8

[System.Collections.ArrayList]$allrows = @(0..127)
[System.Collections.ArrayList]$allcolumns = @(0..7)
[array]$allseatids = @()
$myseatid = 0


## Stage 1
foreach ($seatpath in $inputs) {
    $rows = $seatpath[0..6]
    $columns = $seatpath[7..9]

    $seatid = 0

    $rownum = 0
    $columnnum = 0

    $rowrange = 0..($totalrows - 1)
    $columnrange = 0..($totalcolumns - 1)

    foreach ($row in $rows) {
        $rowrangehalf = $rowrange.count / 2
        if ($row -eq "F") {
            $rowrange = $rowrange[0]..$rowrange[($rowrangehalf - 1)]
            
        }
        elseif ($row -eq "B") {
            $rowrange = $rowrange[$rowrangehalf]..$rowrange[-1]
        }
        # write-host "$row : $($rowrange.count) : $($rowrange[0]) - $($rowrange[-1])"
        if ($rowrange.count -eq 1) {
            $rownum = $rowrange[0]
            $allrows.Remove($rownum)
        }
    }

    foreach ($column in $columns) {
        $columnrangehalf = $columnrange.count / 2
        if ($column -eq "L") {
            $columnrange = $columnrange[0]..$columnrange[($columnrangehalf - 1)]
        }
        elseif ($column -eq "R") {
            $columnrange = $columnrange[$columnrangehalf]..$columnrange[-1]
        }
        # write-host "$column : $($columnrange.count) : $($columnrange[0]) - $($columnrange[-1])"
        if ($columnrange.count -eq 1) {
            $columnnum = $columnrange[0]
            $allcolumns.Remove($columnnum)
        }
    }

    $seatid = $rownum * $totalcolumns + $columnnum
    $allseatids += $seatid

    if ([int]$seatid -gt [int]$highest) {
        $highest = $seatid
    }
}
Write-host "The Highest Seat ID is: $highest"

$allseatids = $allseatids | Sort-Object

for ($i = 0; $i -lt $allseatids.count; $i++) {
    if (($allseatids[$i] + 1) -ne ($allseatids[$i + 1]) -and ($null -ne $allseatids[$i + 1])) {
        $myseatid = $allseatids[$i] + 1
    }
}

write-host "My Seat ID is : $myseatid"