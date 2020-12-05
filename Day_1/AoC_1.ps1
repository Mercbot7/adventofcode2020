## Stage 1
$nums = Get-Content ~/repos/github.com/adventofcode2020/Day_1/input_1.txt | ForEach-Object{[int]$_} | Sort-Object
[int]$total = 2020
$product = $null
for ($i = 0; $i -lt $nums.count; $i++) {

    for ($t = 0; $t -lt $nums.count; $t++ ) {

        if (($i -ne $t)) {
            [int]$sum = ([int]$nums[$i] + [int]$nums[$t])

            # if ($sum -lt 2050) {
            #     Write-host "We are adding num[ $($nums[$i]) ] + subnum[ $($nums[$t]) ] + subsubnum[ $($nums[$y]) ] with sum[ $($sum) ]"
            # }  
            
            if ($sum -eq $total) {
                Write-host "We found the sum of $total"
                [int]$product = ([int]$nums[$i] * [int]$nums[$t])
                Write-host "The product is $product"
                break;
            }
        }
    }
    if ($product -gt 0) {break;}
}


## Stage 2
$nums = Get-Content ~/Desktop/input.txt | ForEach-Object{[int]$_} | Sort-Object
[int]$total = 2020
$product = $null
for ($i = 0; $i -lt $nums.count; $i++) {

    for ($t = 0; $t -lt $nums.count; $t++ ) {
        if (($i -ne $t)) {
            for ($y = 0; $y -lt $nums.count; $y++ ) {

                if ( ($i -ne $t) -and ($i -ne $y ) -and ($t -ne $y )) {

                    [int]$sum = ([int]$nums[$i] + [int]$nums[$t]) + [int]$nums[$y]

                    # if ($sum -lt 2050) {
                    #     Write-host "We are adding num[ $($nums[$i]) ] + subnum[ $($nums[$t]) ] + subsubnum[ $($nums[$y]) ] with sum[ $($sum) ]"
                    # }  
                    
                    if ($sum -eq $total) {
                        Write-host "We found the sum of $total"
                        [int]$product = ([int]$nums[$i] * [int]$nums[$t]) * [int]$nums[$y]
                        Write-host "The product is $product"
                        break;
                    }
                }
            }
            if ($product -gt 0) {break;}
        }
    }
    if ($product -gt 0) {break;}
}