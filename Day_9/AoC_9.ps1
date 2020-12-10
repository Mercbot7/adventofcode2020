$Day = 9
$inputs = Get-Content "~/repos/github.com/adventofcode2020/Day_$Day/input_$Day.txt"

[int]$block = 25

function Compare-TwoNumbers ($n1, $n2, $eval) {
    $return = $false;
    if (($n1 + $n2) -eq $eval) {
        return $true
    }
    return $return;
}

function Get-Block ($blocknums) {
    $returnobj = New-Object PSObject -Property @{
        evalnum = $blocknums[-1];
        truecomps = @()
    }
    $evalblock = $blocknums[0..($blocknums.count - 2)]
    foreach ($subnum in $evalblock) {
        foreach ($suboobie in $evalblock) {
            if ($suboobie -ne $subnum) {
                if (([int64]$subnum + [int64]$suboobie) -eq [int64]$blocknums[-1]) {
                    $returnobj.truecomps +=  New-Object psobject -Property @{
                        n1 = $subnum;
                        n2 = $suboobie;
                    }
                }
            }
        }
    }
    return $returnobj
}

for ($i = $block; $i -le $inputs.count; $i++) {
    $blockeval = Get-Block -blocknums $inputs[($i - $block)..$i]

    if ($blockeval.truecomps.count -lt 1) {
        [int64]$part1answer = $blockeval.evalnum;
        break;
    }
}

$part1answer
## Part 2

[System.Collections.ArrayList]$contiguousblocks = $inputs | Select-Object
$counter = 0

while ((($contiguousblocks[0..$counter] | Measure-Object -sum).sum -ne $part1answer) -and ($contiguousblocks.count -gt 1)) {
    if (($contiguousblocks[0..$counter] | Measure-Object -sum).sum -lt $part1answer) {
        $counter++
    }
    else {
        
        $contiguousblocks.RemoveAt(0)
        $counter = 0
        $contiguousblocks.count
    }
}

$finalblock = $contiguousblocks[0..$counter] | ForEach-Object {[int64]$_} | Sort-Object
$answer = [int64]$finalblock[0] + [int64]$finalblock[-1]

$answer
