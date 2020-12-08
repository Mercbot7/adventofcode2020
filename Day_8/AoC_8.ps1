$Day = 8
$inputs = Get-Content "~/repos/github.com/adventofcode2020/Day_$Day/input_$Day.txt"

##Parse Input
$commands = @()
for ($c = 0; $c -lt $inputs.count; $c++) {
    if ($inputs[$c] -match "^(\w{3})\s([+|-])(\d+)$") {
        $commands += New-Object psobject -Property @{
            cmd_index = $c;
            cmd_call = $matches[1];
            cmd_operator = $matches[2];
            cmd_arg = $matches[3]
        }
    }
    else {
        Write-Error "The match failed at $($inputs[$c])"
        break;
    }
}

[int]$accumulator = 0
[string[]]$used_commands = @()
$nextcommandid = 0

while (($used_commands -notcontains [string]$nextcommandid) -and ($nextcommandid -lt $commands.count)) {
    $used_commands += [string]$nextcommandid
    $this_command = $commands[$nextcommandid]
    switch ($this_command.cmd_call) {
        "acc" {
            $acc_cmd = '$accumulator = $accumulator ' + $this_command.cmd_operator + ' ' + $this_command.cmd_arg
            Invoke-Expression $acc_cmd
            $nextcommandid++
        }
        "jmp" {
            $jmp_cmd = '$nextcommandid = $nextcommandid ' + $this_command.cmd_operator + ' ' + $this_command.cmd_arg
            Invoke-Expression $jmp_cmd
        }
        "nop" {
            $nextcommandid++
        }
    }
}
write-host "Part 1 answer is: $accumulator" 

### Part 2
[int]$accumulator = 0
[string[]]$used_commands = @()
$jmp_nop_cmds = $commands | Where-Object {($_.cmd_call -eq "jmp") -or ($_.cmd_call -eq "nop")}
$jmp_nop_cmd_id = 0

while (($used_commands.count -lt $commands.count) -and ($jmp_nop_cmd_id -lt $jmp_nop_cmds.count)) {

    [int]$accumulator = 0
    [string[]]$used_commands = @()

    [array]$iteration_commands = $commands | Select-Object *

    if ($iteration_commands[($jmp_nop_cmds[$jmp_nop_cmd_id].cmd_index)].cmd_call -eq "jmp") {
        $iteration_commands[($jmp_nop_cmds[$jmp_nop_cmd_id].cmd_index)].cmd_call = "nop"      
    }
    else {
        $iteration_commands[($jmp_nop_cmds[$jmp_nop_cmd_id].cmd_index)].cmd_call = "jmp"
    }

    $nextcommandid = 0

    while (($used_commands -notcontains [string]$nextcommandid) -and ($nextcommandid -lt $commands.count)) {
        $used_commands += [string]$nextcommandid
        $this_command = $iteration_commands[$nextcommandid]
        switch ($this_command.cmd_call) {
            "acc" {
                $acc_cmd = '$accumulator = $accumulator ' + $this_command.cmd_operator + ' ' + $this_command.cmd_arg
                Invoke-Expression $acc_cmd
                $nextcommandid++
            }
            "jmp" {
                $jmp_cmd = '$nextcommandid = $nextcommandid ' + $this_command.cmd_operator + ' ' + $this_command.cmd_arg
                Invoke-Expression $jmp_cmd
            }
            "nop" {
                $nextcommandid++
            }
        }
    }

    if ($nextcommandid -ge $commands.count) {
        Write-host "Complete!";
        break;
    }
    $jmp_nop_cmd_id++
}

write-host "Part 2 answer is: $accumulator"