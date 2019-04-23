#1.These cmdlets need to be ran from one of the cluster nodes

Get-StoragePool –FriendlyName “s2d on s2dcluster” | Remove-StoragePool

Get-VirtualDisk | Remove-VirtualDisk

Disable-ClusterS2D

#2.This needs to be run from the management workstation

Invoke-Command -ComputerName S2D1,S2D2,S2D3,S2D4 -ScriptBlock { Get-Disk | ft }

#3. These cmdlets need to be ran from one of the cluster nodes


Enable-ClusterS2D -CacheMode Disabled -AutoConfig:0 -SkipEligibilityChecks

New-StoragePool -StorageSubSystemFriendlyName *Cluster* -FriendlyName S2D -ProvisioningTypeDefault Fixed -PhysicalDisk (Get-PhysicalDisk | ? CanPool -eq $true)

Get-StorageSubsystem *cluster* | Get-PhysicalDisk | Where MediaType -eq "UnSpecified" | Set-PhysicalDisk -MediaType HDD

