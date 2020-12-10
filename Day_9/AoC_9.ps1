$Day = 9
$inputs = Get-Content "~/repos/github.com/adventofcode2020/Day_$Day/input_$Day copy.txt"

[int]$block = 5

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
        lastblocknum = $blocknums[-2]
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

for ($i = 0; $i -le $inputs.count; $i += $block) {
    $blockeval = Get-Block -blocknums $inputs[$i..($i + $block)]
    $blockeval
    # if ($blockeval.truecomps.count -lt 1) {
    #     $blockeval
    # }
}

$bnums = $inputs[0..25]
$bnums[0..($bnums.count - 1)]
$bnums[0..($bnums.count - 2)]
# $anchoref = ($i + $block) - 1
#     $anchornum = $inputs[$anchoref]
#     $subnums = $inputs[$i..$anchoref]
#     $evalnum = $inputs[$block]
#     $anomaly = $null
