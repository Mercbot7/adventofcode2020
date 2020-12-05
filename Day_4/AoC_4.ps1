$inputs = Get-Content ~/Desktop/AoC/Day_3/input_3.txt

$slopes = @(@(1,1),@(3,1),@(5,1),@(7,1),@(1,2))

$answer = 0

$trees = @();

for ($s = 0; $s -lt $slopes.count; $s++) {
    $slopetrees = 0;

    # $x is the left right and $y is the up down so $inputs[$y][$x]
    for ($($x = 0; $y = 0); $y -lt $inputs.count; $($x += $slopes[$s][0]; $y += $slopes[$s][1])) {
        if ($inputs[$y][$(if ($x -lt $inputs[$y].length) {$x} else {$x % $inputs[$y].length})] -eq '#') {
            $slopetrees++;
        } 
    }
    $trees += New-Object -TypeName PSObject -Property @{
        slope_number = $s + 1;
        description = "$($slopes[$s][0]),$($slopes[$s][1])";
        tree_count = $slopetrees;
    }
}

foreach ($tree in $trees) {
    if ($answer -gt 0) {
        $answer = $answer * $tree.tree_count;
    }
    else {
        $answer = $tree.tree_count
    }
}