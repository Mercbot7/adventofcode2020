$inputs = Get-Content ~/Desktop/AoC/Day_4/input_4.txt -raw

$props = '[
    {"prop" : "byr","required" : "True"},
    {"prop" : "iyr","required" : "True"},
    {"prop" : "eyr","required" : "True"},
    {"prop" : "hgt","required" : "True"},
    {"prop" : "hcl","required" : "True"},
    {"prop" : "ecl","required" : "True"},
    {"prop" : "pid","required" : "True"},
    {"prop" : "cid","required" : "False"}
]'

$objprops = $props | ConvertFrom-json

$Passports = @()
$Valid = 0
$Invlaid = 0

$pprecords = $inputs -split "`n`n" | ForEach-Object {$_ -replace "`n"," "}

foreach ($pprecord in $pprecords) {
    $recordobj = $pprecord -split " " | ConvertFrom-StringData -Delimiter ":"
    $requiredcount = ($objprops | Where-Object {$_.required -eq $true}).count
    $validpropscount = 0
    
    foreach ($objprop in $objprops) {
        if ($objprop.required -eq "True" -and $recordobj.keys -notcontains $objprop.prop) {

        }
        else {

        }
    }

    foreach ($rkey in $recordobj.keys) {
        if ($objprops.prop -contains $rkey) {
            $validpropscount++
        }
    }

    if ($validpropscount -ge $requiredcount) {
        $Valid++
    }
    else {
        $Invlaid++
    }

}

$test = $temppass[0] -split " "

$testobj = $test | ConvertFrom-StringData -Delimiter ":"

get-member -InputObject $testobj