winrm quickconfig

Install-Module -Name PSDesiredStateConfiguration

Set-Location "C:\DSC\Disable-Spooler-Service"

 
Configuration ServiceExample
{
    param 
    ( 
        #[string[]]$ComputerName='localhost'
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    # Import-DSCResource -Name Service

    #Node "$ComputerName"
    Node $AllNodes.NodeName
    {
 
        Service ServiceExample
        {
            Name        = "Spooler"
            StartupType = "Disabled" # Automatic, Disabled, and Manual
            State       = "Stopped"
        }
    }
}
 
$Servers = @{
	AllNodes = @(
        @{ NodeName = 'maca-jump-01p'},
        @{ NodeName = 'maca-swad-07p'},
		@{ NodeName = 'maca-swad-08p'},
        @{ NodeName = 'maca-swad-06p'},
        @{ NodeName = 'MACA-WAD-06P'},
        @{ NodeName = 'MACA-WAD-12P'},
        @{ NodeName = 'MACA-NWAD-04P'},
        @{ NodeName = 'MACA-NWAD-05P'},
        @{ NodeName = 'MACA-DWAD-03P'},
        @{ NodeName = 'MACA-DWAD-04P'},
        @{ NodeName = 'MACA-MWAD-06P'},
        @{ NodeName = 'MACA-MWAD-05P'},
        @{ NodeName = 'MAAA-WAD-03P'},
        @{ NodeName = 'MAAA-WAD-04P'},
        @{ NodeName = 'MABA-WAD-03P'},
        @{ NodeName = 'MABA-WAD-04P'},
        @{ NodeName = 'MAQA-WAD-01P'},
        @{ NodeName = 'MAQA-WAD-02P'}
        @{ NodeName = 'MACA-SCAD-01P'},
        @{ NodeName = 'MACA-SCAD-02P'}

	)
}


# create mof
ServiceExample -Configuration $Servers -outputpath C:\DSC\Disable-Spooler-Service

# load configuration from mof
Start-DscConfiguration -Path C:\DSC\Disable-Spooler-Service -ComputerName $AllNodes.NodeName -Wait -Verbose -Force
 
# check configuration
Get-DscConfiguration