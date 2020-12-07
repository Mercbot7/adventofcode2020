$inputs = Get-Content "~/repos/github.com/adventofcode2020/Day_7/input_7.txt"

$bags = @()

[string[]]$shinygolds = $null

function Add-BagParent ($bag) {
    $script:shinygolds += $bag.pbag_name
    $script:bags | Where-Object {$_.children.bag_name -contains $bag.pbag_name} | ForEach-Object {Add-BagParent $_}
}

foreach ($procbag in $inputs) {
    $bagtrim = ($procbag -replace "((bag(s)?\s?)|\.)","").Trim()
    $head_body = $bagtrim -split "contain"
    $head = $head_body[0].Trim() -replace " ","_"
    $children = $head_body[1] -split "," | ForEach-Object {$_.Trim() -replace " ","_"}
    $body = @()
    foreach ($bodyitem in $children) {
        $body += New-Object PSObject -Property @{
            bag_name = ($bodyitem -replace "^((\d)[_])?(.+)$","`$3")
            bag_count =  [int]($($bodyitem -replace "^((\d)[_])?(.+)$","`$2"))
        }
    }
    $bags += New-Object psobject -Property @{
        pbag_name = $head
        children = $body
    }
}

$bags | Where-Object {$_.children.bag_name -contains "shiny_gold"} | ForEach-Object {Add-BagParent $_}

$answer = $shinygolds | Sort-Object | Get-Unique
$answer.Count

### Stage 2
$bag_counter = 0

$shinygoldbag = $bags | Where-Object {$_.pbag_name -eq "shiny_gold"}

function measure-bags ($bag) {
    foreach ($child_bag in $bag.children) {
        $script:bag_counter += $child_bag.bag_count
        if ([int]$child_bag.bag_count -gt 0) {
            for ($i = 0; $i -lt $child_bag.bag_count; $i++) {
                $rbag = $script:bags | Where-Object {$_.pbag_name -eq $child_bag.bag_name}
                measure-bags $rbag
            }
        }
    }
}

measure-bags $shinygoldbag
$bag_counter