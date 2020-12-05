$inputs = Get-Content ~/repos/github.com/adventofcode2020/Day_4/input_4.txt -raw
$objprops = Get-Content ~/repos/github.com/adventofcode2020/Day_4/props.json | ConvertFrom-Json

$Valid = 0
$Invlaid = 0

$pprecords = $inputs -split "`n`n" | ForEach-Object {$_ -replace "`n"," "}

### Phase 1
foreach ($pprecord in $pprecords) {
    $recordobj = $pprecord -split " " | ConvertFrom-StringData -Delimiter ":"
    $requiredcount = ($objprops | Where-Object {$_.required -eq $true}).count
    $validpropscount = 0
    
    foreach ($objprop in $objprops) {
        if ($objprop.required -eq "True" -and $recordobj.keys -contains $objprop.prop) {
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

### Phase 2
foreach ($pprecord in $pprecords) {
    $recordobj = $pprecord -split " " | ConvertFrom-StringData -Delimiter ":"
    $requiredcount = ($objprops | Where-Object {$_.required -eq $true}).count
    $validpropscount = 0
    
    foreach ($objprop in $objprops) {
        if ($objprop.required -eq "True" -and $recordobj.keys -contains $objprop.prop) {
            switch ($objprop.prop) {
                "byr" {
                    if (([int]$recordobj.byr -ge 1920) -and ([int]$recordobj.byr -le 2002)) {
                        $validpropscount++
                    }
                }
                "iyr" {
                    if (([int]$recordobj.iyr -ge 2010) -and ([int]$recordobj.iyr -le 2020)) {
                        $validpropscount++
                    }
                }
                "eyr" {
                    if (([int]$recordobj.eyr -ge 2020) -and ([int]$recordobj.eyr -le 2030)) {
                        $validpropscount++
                    }
                }
                "hgt" {
                    if ($recordobj.hgt -match "^(\d{2,3})(cm|in)$") {
                        if ((($Matches[2] -eq "in") -and (([int]$Matches[1] -ge 59) -and ([int]$Matches[1] -le 76))) -or  (($Matches[2] -eq "cm") -and (([int]$Matches[1] -ge 150) -and ([int]$Matches[1] -le 193)))) {
                            $validpropscount++
                        }
                    }
                }
                "hcl" {
                    if ($recordobj.hcl -match "^`#[a-z0-9]{6}$") {
                        $validpropscount++
                    }
                }
                "ecl" {
                    if ($recordobj.ecl -match "^amb|blu|brn|gry|grn|hzl|oth$") {
                        $validpropscount++
                    }
                }
                "pid" {
                    if ($recordobj.pid -match "^\d{9}$") {
                        $validpropscount++
                    }
                }
            }
        }
    }

    if ($validpropscount -ge $requiredcount) {
        $Valid++
    }
    else {
        $Invlaid++
    }
}