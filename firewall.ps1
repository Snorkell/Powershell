Write-Host "Welcome to the firewall assistant script"
Read-Host "Appuyez sur une touche pour continuer"
Write-Host "Please select which option you want to use"
Write-Host "1. Open port"
Write-Host "2. Close port"
$choiceOne = Read-Host "Choice "
switch($choiceOne)
{
    1 {open}
    2 {close}
    default {}
}
function open
{
    Write-Host "Which type of rule do you want to open ?"
    Write-Host "1.Inbound"
    Write-Host "2.Outbound"
    $choiceTwo = Read-Host "Choice "
    switch($choiceTwo)
    {
        1{openInbound}
        2{openOutbound}
        default{}
    }
}
function close
{
    Write-Host "Which type of rule do you want to close ?"
    Write-Host "1.Inbound"
    Write-Host "2.Outbound"
    $choiceTwo = Read-Host "Choice "
    switch($choiceTwo)
    {
        1{closeInbound}
        2{closeOutbound}
        default{}
    }
}

function openInbound
{
    $input = ""
    $ListofPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofOpenedPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofPortToClose= New-Object System.Collections.Generic.List[System.Object]
    while($input -notlike 'Done')
    {
        Write-Host "Please enter the port number you want to close (Type 'Done' when you're done)" 
        $input = Read-Host "Port"
        if($input -notlike "Done"){
            $ListofPort.Add($input)
        }
    }
    Write-Host "Gathering firewall rules ...." 
    $rulesInbound = Get-NetFirewallRule | Where { $_.Enabled –eq ‘false’ –and $_.Direction –eq ‘Inbound’ } | Select Name

    foreach($r in $rulesInbound)
    {
        $openedPort = Get-NetFirewallPortFilter | Where {$_.InstanceID -eq $r.Name} | Select InstanceID, LocalPort
        $ListofOpenedPort.Add($openedPort)
    }

    foreach($l in $ListofOpenedPort)
    {
        foreach($p in $ListofPort)
        {
            if($l.LocalPort -like $p)
            {
                $closingPort = $l.InstanceID
                $ListofPortToClose.Add($closingPort)
            }
        }
    }
    Write-Host "Do you want to open every inbound rules ?"
    Write-Host "1.Yes"
    Write-Host "2.No, I'll specify which ones"
    $x = Read-Host "Choice"
    Write-Host "------"
    switch($x)
    {
        1
        {
            foreach($a in $ListofPortToClose)
            {
                Enable-NetFirewallRule -Name $a
            }
        }
        2
        {
            $specificPortListToClose = New-Object System.Collections.Generic.List[System.Object]
            $specificPortList = New-Object System.Collections.Generic.List[System.Object]
            $portIndex = New-Object System.Collections.Generic.List[System.Object]
            $counter = 0
            foreach($l in $ListofOpenedPort)
            {
                foreach($p in $ListofPort)
                {
                    if($l.LocalPort -like $p)
                    {
                        $counter+=1
                        $specificPortList.Add($l.InstanceID)
                        Write-Host "$($counter).$($l.InstanceID) : $($l.LocalPort)"
                        
                    }
                }
            }
            
            $inputPort = ""
            while($inputPort -notlike 'Done')
            {
                Write-Host "Please enter the port index you want to close (Type 'Done' when you're done)" 
                $inputPort = Read-Host "Port"
                if($inputPort -notlike "Done"){
                    if($inputPort -in 1..$specificPortList.Count){
                        $portIndex.Add($inputPort)
                    }
                    else
                    {
                        Write-Host "$($inputPort) is not in the list"
                    }
                    
                }
            }
            foreach($in in $portIndex)
            {
                $x =[int]::parse($in)
                $specificPortListToClose.Add($specificPortList[$x-1])
            }
            foreach($a in $specificPortListToClose)
            {
                Enable-NetFirewallRule -Name $a
                Write-Host "Ports successfully Opened"
            }
        }
    }

    
}

function openOutbound
{
    $input = ""
    $ListofPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofOpenedPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofPortToClose= New-Object System.Collections.Generic.List[System.Object]
    while($input -notlike 'Done')
    {
        Write-Host "Please enter the port number you want to close (Type 'Done' when you're done)" 
        $input = Read-Host "Port"
        if($input -notlike "Done"){
            $ListofPort.Add($input)
        }
    }
    Write-Host "Gathering firewall rules ...." 
    $rulesOutbound = Get-NetFirewallRule | Where { $_.Enabled –eq ‘false’ –and $_.Direction –eq ‘Outbound’ } | Select Name

    foreach($r in $rulesOutbound)
    {
        $openedPort = Get-NetFirewallPortFilter | Where {$_.InstanceID -eq $r.Name} | Select InstanceID, LocalPort
        $ListofOpenedPort.Add($openedPort)
    }

    foreach($l in $ListofOpenedPort)
    {
        foreach($p in $ListofPort)
        {
            if($l.LocalPort -like $p)
            {
                $closingPort = $l.InstanceID
                $ListofPortToClose.Add($closingPort)
            }
        }
    }
    Write-Host "Do you want to open every inbound rules ?"
    Write-Host "1.Yes"
    Write-Host "2.No, I'll specify which ones"
    $x = Read-Host "Choice"
    Write-Host "------"
    switch($x)
    {
        1
        {
            foreach($a in $ListofPortToClose)
            {
                Enable-NetFirewallRule -Name $a
            }
        }
        2
        {
            $specificPortListToClose = New-Object System.Collections.Generic.List[System.Object]
            $specificPortList = New-Object System.Collections.Generic.List[System.Object]
            $portIndex = New-Object System.Collections.Generic.List[System.Object]
            $counter = 0
            foreach($l in $ListofOpenedPort)
            {
                foreach($p in $ListofPort)
                {
                    if($l.LocalPort -like $p)
                    {
                        $counter+=1
                        $specificPortList.Add($l.InstanceID)
                        Write-Host "$($counter).$($l.InstanceID) : $($l.LocalPort)"
                        
                    }
                }
            }
            
            $inputPort = ""
            while($inputPort -notlike 'Done')
            {
                Write-Host "Please enter the port index you want to close (Type 'Done' when you're done)" 
                $inputPort = Read-Host "Port"
                if($inputPort -notlike "Done"){
                    if($inputPort -in 1..$specificPortList.Count){
                        $portIndex.Add($inputPort)
                    }
                    else
                    {
                        Write-Host "$($inputPort) is not in the list"
                    }
                    
                }
            }
            foreach($in in $portIndex)
            {
                $x =[int]::parse($in)
                $specificPortListToClose.Add($specificPortList[$x-1])
            }
            foreach($a in $specificPortListToClose)
            {
                Enable-NetFirewallRule -Name $a
                Write-Host "Ports successfully Opened"
            }
        }
    }

    
}
function closeInbound
{
    $input = ""
    $ListofPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofOpenedPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofPortToClose= New-Object System.Collections.Generic.List[System.Object]
    while($input -notlike 'Done')
    {
        Write-Host "Please enter the port number you want to close (Type 'Done' when you're done)" 
        $input = Read-Host "Port"
        if($input -notlike "Done"){
            $ListofPort.Add($input)
        }
    }
    Write-Host "Gathering firewall rules ...." 
    $rulesInbound = Get-NetFirewallRule | Where { $_.Enabled –eq ‘true’ –and $_.Direction –eq ‘Inbound’ } | Select Name

    foreach($r in $rulesInbound)
    {
        $openedPort = Get-NetFirewallPortFilter | Where {$_.InstanceID -eq $r.Name} | Select InstanceID, LocalPort
        $ListofOpenedPort.Add($openedPort)
    }

    foreach($l in $ListofOpenedPort)
    {
        foreach($p in $ListofPort)
        {
            if($l.LocalPort -like $p)
            {
                $closingPort = $l.InstanceID
                $ListofPortToClose.Add($closingPort)
            }
        }
    }
    Write-Host "Do you want to open every inbound rules ?"
    Write-Host "1.Yes"
    Write-Host "2.No, I'll specify which ones"
    $x = Read-Host "Choice"
    Write-Host "------"
    switch($x)
    {
        1
        {
            foreach($a in $ListofPortToClose)
            {
                Enable-NetFirewallRule -Name $a
            }
        }
        2
        {
            $specificPortListToClose = New-Object System.Collections.Generic.List[System.Object]
            $specificPortList = New-Object System.Collections.Generic.List[System.Object]
            $portIndex = New-Object System.Collections.Generic.List[System.Object]
            $counter = 0
            foreach($l in $ListofOpenedPort)
            {
                foreach($p in $ListofPort)
                {
                    if($l.LocalPort -like $p)
                    {
                        $counter+=1
                        $specificPortList.Add($l.InstanceID)
                        Write-Host "$($counter).$($l.InstanceID) : $($l.LocalPort)"
                        
                    }
                }
            }
            
            $inputPort = ""
            while($inputPort -notlike 'Done')
            {
                Write-Host "Please enter the port index you want to close (Type 'Done' when you're done)" 
                $inputPort = Read-Host "Port"
                if($inputPort -notlike "Done"){
                    if($inputPort -in 1..$specificPortList.Count){
                        $portIndex.Add($inputPort)
                    }
                    else
                    {
                        Write-Host "$($inputPort) is not in the list"
                    }
                    
                }
            }
            foreach($in in $portIndex)
            {
                $x =[int]::parse($in)
                $specificPortListToClose.Add($specificPortList[$x-1])
            }
            foreach($a in $specificPortListToClose)
            {
                Enable-NetFirewallRule -Name $a
                Write-Host "Ports successfully closed"
            }
        }
    }
}
function closeOutbound
{
    $input = ""
    $ListofPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofOpenedPort= New-Object System.Collections.Generic.List[System.Object]
    $ListofPortToClose= New-Object System.Collections.Generic.List[System.Object]
    while($input -notlike 'Done')
    {
        Write-Host "Please enter the port number you want to close (Type 'Done' when you're done)" 
        $input = Read-Host "Port"
        if($input -notlike "Done"){
            $ListofPort.Add($input)
        }
    }
    Write-Host "Gathering firewall rules ...." 
    $rulesInbound = Get-NetFirewallRule | Where { $_.Enabled –eq ‘true’ –and $_.Direction –eq ‘Outbound’ } | Select Name

    foreach($r in $rulesInbound)
    {
        $openedPort = Get-NetFirewallPortFilter | Where {$_.InstanceID -eq $r.Name} | Select InstanceID, LocalPort
        $ListofOpenedPort.Add($openedPort)
    }

    foreach($l in $ListofOpenedPort)
    {
        foreach($p in $ListofPort)
        {
            if($l.LocalPort -like $p)
            {
                $closingPort = $l.InstanceID
                $ListofPortToClose.Add($closingPort)
            }
        }
    }
    Write-Host "Do you want to open every inbound rules ?"
    Write-Host "1.Yes"
    Write-Host "2.No, I'll specify which ones"
    $x = Read-Host "Choice"
    Write-Host "------"
    switch($x)
    {
        1
        {
            foreach($a in $ListofPortToClose)
            {
                Enable-NetFirewallRule -Name $a
            }
        }
        2
        {
            $specificPortListToClose = New-Object System.Collections.Generic.List[System.Object]
            $specificPortList = New-Object System.Collections.Generic.List[System.Object]
            $portIndex = New-Object System.Collections.Generic.List[System.Object]
            $counter = 0
            foreach($l in $ListofOpenedPort)
            {
                foreach($p in $ListofPort)
                {
                    if($l.LocalPort -like $p)
                    {
                        $counter+=1
                        $specificPortList.Add($l.InstanceID)
                        Write-Host "$($counter).$($l.InstanceID) : $($l.LocalPort)"
                        
                    }
                }
            }
            
            $inputPort = ""
            while($inputPort -notlike 'Done')
            {
                Write-Host "Please enter the port index you want to close (Type 'Done' when you're done)" 
                $inputPort = Read-Host "Port"
                if($inputPort -notlike "Done"){
                    if($inputPort -in 1..$specificPortList.Count){
                        $portIndex.Add($inputPort)
                    }
                    else
                    {
                        Write-Host "$($inputPort) is not in the list"
                    }
                    
                }
            }
            foreach($in in $portIndex)
            {
                $x =[int]::parse($in)
                $specificPortListToClose.Add($specificPortList[$x-1])
            }
            foreach($a in $specificPortListToClose)
            {
                Enable-NetFirewallRule -Name $a
                Write-Host "Ports successfully closed"
            }
        }
    }    
}
