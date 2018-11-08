Import-Module ActiveDirectory
$groupGl = Get-ADGroup -Filter "*" | Where {$_.Name -like "GL*"} | Remove-ADGroup 
$groupGG = Get-ADGroup -Filter "*" | Where {$_.Name -like "GG*"} | Remove-ADGroup 
if(Test-Path "C:\\Shared")
{
    Remove-Item -Recurse -Force "C:\\Shared"
}

$domain = Read-Host "Entrez votre domaine: "
$domain = $domain.Split(".")

Read-Host "Appuyez sur Enter pour continuer ou CTRL-C pour annuler (en cas de faute de frappe)"

if(!(Test-Path "C:\\Shared"))
{
    New-Item "C:\Shared" -ItemType "directory" -ErrorAction SilentlyContinue   
}
if(!(Test-Path "C:\Shared\Commun"))
{
    New-Item "C:\Shared\Commun" -ItemType "directory" -ErrorAction SilentlyContinue
}
$parentsOU = Get-ADOrganizationalUnit -Filter 'Name -like "*"' -SearchScope OneLevel
$indexDC = 0
foreach($pa in $parentsOU)
{
    if($pa.Name -like "Domain Controllers")
    {
        break
    }
    $indexDC+=1;
}
# Removing "Domain Controllers" OU
$parentsOU = @($parentsOU | Where-Object { $_ -ne $parentsOU[$indexDC] })


#Creating groups
Write-Host "Creating groups ...." 

New-ADGroup -Path "DC=$($domain[0]),DC=$($domain[1])" -Name "GG-AllUsers" -GroupScope Global -GroupCategory Security 
# Adding all users in global group "AllUsers"
$allUsers = Get-ADUser -Filter "*"

foreach($user in $allUsers)  {

    if($user.Name -notlike "Guest" -and $user.Name -notlike "DefaultAccount" -and $user.Name -notlike "krbtgt") {
        Add-ADGroupMember -Identity "GG-AllUsers" -Members $user
    }

}
New-ADGroup -Path "DC=$($domain[0]),DC=$($domain[1])" -Name "GL-AllUsers-R" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue
New-ADGroup -Path "DC=$($domain[0]),DC=$($domain[1])" -Name "GL-AllUsers-RW" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue
Add-ADGroupMember -Identity "GL-AllUsers-R" -Members "GG-AllUsers" -ErrorAction SilentlyContinue
Add-ADGroupMember -Identity "GL-AllUsers-RW" -Members "GG-AllUsers" -ErrorAction SilentlyContinue


foreach($parentOU in $parentsOU) {

    if(!(Test-Path "C:\Shared\$($parentOU.Name)"))
    {
        New-Item "C:\Shared\$($parentOU.Name)" -ItemType "directory" -ErrorAction SilentlyContinue
    }
    # Creating global group for OU and inserting users
    New-ADGroup -Path "OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GG-$($parentOU.Name)" -GroupScope Global -GroupCategory Security -ErrorAction SilentlyContinue
    
    $users = Get-ADUser -Filter "*" -SearchBase "OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -SearchScope OneLevel

    foreach($user in $users) {
    
        Add-ADGroupMember -Identity "GG-$($parentOU.Name)" -Members $user

    }
# Creating local groups for OU
    New-ADGroup -Path "OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GL-$($parentOU.Name)-R" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue
    New-ADGroup -Path "OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GL-$($parentOU.Name)-RW" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue



    # Adding global group in local group
    Add-ADGroupMember -Identity "GL-$($parentOU.Name)-R" -Members "GG-$($parentOU.Name)" -ErrorAction SilentlyContinue
    Add-ADGroupMember -Identity "GL-$($parentOU.Name)-RW" -Members "GG-$($parentOU.Name)" -ErrorAction SilentlyContinue

    $childsOU = Get-ADOrganizationalUnit -Filter * -SearchBase $parentOU.DistinguishedName 

# Removing parent OU from childs
    $childsOU = @($childsOU | Where-Object { $_ -ne $childsOU[0] })

    if($childsOU.Count -gt 1) {


        foreach($childOU in $childsOU) {
            if(!(Test-Path "C:\Shared\$($parentOU.Name)\$($childOU.Name)"))
            {
                New-Item "C:\Shared\$($parentOU.Name)\$($childOU.Name)" -ItemType "directory" -ErrorAction SilentlyContinue
            }
            # Creating global group for OU and inserting users
            New-ADGroup -Path "OU=$($childOU.Name),OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GG-$($childOU.Name)" -GroupScope Global -GroupCategory Security -ErrorAction SilentlyContinue


            $users = Get-ADUser -Filter "*" -SearchBase "OU=$($childOU.Name),OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -SearchScope OneLevel

            foreach($user in $users) {
    
                Add-ADGroupMember -Identity "GG-$($childOU.Name)" -Members $user

            }

            # Creating local groups for OU
            New-ADGroup -Path "OU=$($childOU.Name),OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GL-$($childOU.Name)-R" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue            
            New-ADGroup -Path "OU=$($childOU.Name),OU=$($parentOU.Name),DC=$($domain[0]),DC=$($domain[1])" -Name "GL-$($childOU.Name)-RW" -GroupScope DomainLocal -GroupCategory Security -ErrorAction SilentlyContinue

            # Adding global group in local group
            Add-ADGroupMember -Identity "GL-$($childOU.Name)-R" -Members "GG-$($childOU.Name)" -ErrorAction SilentlyContinue
            Add-ADGroupMember -Identity "GL-$($childOU.Name)-RW" -Members "GG-$($childOU.Name)" -ErrorAction SilentlyContinue

        } 
    }
}

#ACL Variables

$readOnly = [System.Security.AccessControl.FileSystemRights]"ReadAndExecute"
$readWrite = [System.Security.AccessControl.FileSystemRights]"Modify"
$fullControl = [System.Security.AccessControl.FileSystemRights]"FullControl"

$inheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
$propagationFlag = [System.Security.AccessControl.PropagationFlags]::None

$type = [System.Security.AccessControl.AccessControlType]::Allow

$groupRAll = Get-ADGroup -Filter * | Where {$_.Name -like "GL-AllUsers-R"}
$accessControlEntryRAll = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRAll.Name, $readOnly, $inheritanceFlag, $propagationFlag, $type)

$groupRW = Get-ADGroup -Filter * | Where {$_.Name -like "Administrators"}
$accessControlEntryRW = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRW.Name, $fullControl, $inheritanceFlag, $propagationFlag, $type)

$groupRWDirection = Get-ADGroup -Filter * | Where {$_.Name -like "GL-Direction-RW"}
$accessControlEntryRWDirection = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRWDirection.Name, $readWrite, $inheritanceFlag, $propagationFlag, $type)

$aclInheritance = Get-Acl -Path "C:\Shared"
$aclInheritance.SetAccessRuleProtection($True,$True)
Set-Acl "C:\Shared" $aclInheritance
$objACL = Get-Acl "C:\Shared"
$objACL.Access | %{ $objACL.RemoveAccessRule($_) }
$objACL.SetAccessRule($accessControlEntryRAll)
$objACL.SetAccessRule($accessControlEntryRW)
$objACL.SetAccessRule($accessControlEntryRWDirection)
Set-Acl "C:\Shared" $objACL

$aclInheritance = Get-Acl -Path "C:\Shared\Commun"
$aclInheritance.SetAccessRuleProtection($True,$True)
Set-Acl -Path "C:\Shared\Commun" -AclObject $aclInheritance

# Adding permission to Commun
$objACL = Get-Acl "C:\Shared\Commun"
$objACL.Access | %{ $objACL.RemoveAccessRule($_) }
$objACL.SetAccessRule($accessControlEntryRAll)
$objACL.SetAccessRule($accessControlEntryRW)
$objACL.SetAccessRule($accessControlEntryRWDirection)
Set-Acl "C:\Shared\Commun" $objACL

foreach($parentOU in $parentsOU)
{
    
    $aclInheritance = Get-Acl -Path "C:\Shared\$($parentOU.Name)"
    $aclInheritance.SetAccessRuleProtection($True,$True)
    Set-Acl -Path "C:\Shared\$($parentOU.Name)" -AclObject $aclInheritance

    $groupRWAdm = Get-ADGroup -Filter * | Where {$_.Name -like "Administrators"}
    $accessControlEntryRWAdm = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRWAdm.Name, $fullControl, $inheritanceFlag, $propagationFlag, $type)

    $groupRW = Get-ADGroup -Filter * | Where {$_.Name -like "GL-$($parentOU.Name)-RW"}
    $accessControlEntryRW = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRW.Name, $readWrite, $inheritanceFlag, $propagationFlag, $type)
    $groupDirRW = Get-ADGroup -Filter * | Where {$_.Name -like "GL-Direction-RW"}
    $accessControlEntryDirRW = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupDirRW.Name, $readWrite, $inheritanceFlag, $propagationFlag, $type)

    $childsOU = Get-ADOrganizationalUnit -Filter * -SearchBase $parentOU.DistinguishedName 

    # Removing parent OU from childs
    $childsOU = @($childsOU | Where-Object { $_ -ne $childsOU[0] })
	
	$objACL = Get-Acl "C:\Shared\$($parentOU.Name)"
	$objACL.Access | %{ $objACL.RemoveAccessRule($_) }
	$objACL.SetAccessRule($accessControlEntryRWAdm)
	$objACL.SetAccessRule($accessControlEntryRW)
	$objACL.SetAccessRule($accessControlEntryDirRW)

    
    if($childsOU.Count -gt 1) {
        foreach($childOU in $childsOU) {
        $groupR = Get-ADGroup -Filter * | Where {$_.Name -like "GL-$($childOU.Name)-R"}
        $accessControlEntryR = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupR.Name, $readOnly, $inheritanceFlag, $propagationFlag, $type)
        $objACL.SetAccessRule($accessControlEntryR)
        Set-Acl "C:\Shared\$($parentOU.Name)" $objACL
            
        }

        $childs = @()

        foreach($childOU in $childsOU) {
            $childs += $childOU.Name
        }

        foreach($childOU in $childsOU) {
            
            $aclInheritance = Get-Acl -Path "C:\Shared\$($parentOU.Name)\$($childOU.Name)"
            $aclInheritance.SetAccessRuleProtection($True,$True)
            Set-Acl -Path "C:\Shared\$($parentOU.Name)\$($childOU.Name)" -AclObject $aclInheritance

            foreach($child in $childs) {

                $groupRChild = Get-ADGroup -Filter * | Where {$_.Name -like "GL-$($child)-R"}
                $accessControlEntryRChild = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRChild.Name, $readOnly, $inheritanceFlag, $propagationFlag, $type)
                $objACL = Get-Acl "C:\Shared\$($parentOU.Name)\$($childOU.Name)"
                $objACL.SetAccessRule($accessControlEntryRChild)
                Set-Acl "C:\Shared\$($parentOU.Name)\$($childOU.Name)" $objACL
            }

            $groupRChild = Get-ADGroup -Filter * | Where {$_.Name -like "GL-$($childOU.Name)-R"}
            $groupRWChild = Get-ADGroup -Filter * | Where {$_.Name -like "GL-$($childOU.Name)-RW"}
            $accessControlEntryRChild = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRChild.Name, $readOnly, $inheritanceFlag, $propagationFlag, $type)
            $accessControlEntryRWChild = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRWChild.Name, $readWrite, $inheritanceFlag, $propagationFlag, $type)
            $objACL = Get-Acl "C:\Shared\$($parentOU.Name)\$($childOU.Name)"
            $objACL.RemoveAccessRule($accessControlEntryRChild)
            $objACL.SetAccessRule($accessControlEntryRWChild)
	        $objACL.SetAccessRule($accessControlEntryDirRW)

            Set-Acl "C:\Shared\$($parentOU.Name)\$($childOU.Name)" $objACL
        } 
        $childs = @()
    }  
}

$groupRAll = Get-ADGroup -Filter * | Where {$_.Name -like "GL-AllUsers-R"}
$accessControlEntryRAll = New-Object System.Security.AccessControl.FileSystemAccessRule @($groupRAll.Name, $readOnly, $inheritanceFlag, $propagationFlag, $type)
$objACL = Get-Acl "C:\Shared\Direction"
$objACL.RemoveAccessRule($accessControlEntryRAll)
Set-Acl "C:\Shared\Direction" $objACL