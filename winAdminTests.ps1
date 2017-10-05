
# ###################
# CHECK FUNCTIONS
# These functions return true when a challenge has been completed
# ###################

# Return true if bthserv is started
function BTHSERV
{
	return Get-Service bthserv | Where-Object {$_.status -eq "running"}
}

# Return true if Net Logon is stopped
function NETLOGON
{
	return Get-Service bthserv | Where-Object {$_.status -eq "stopped"}
}

# Return true if any adapter named Wi-Fi is down
function WIFIADAPTER
{
	Get-NetAdapter -Name wi-fi | Where-Object {$_.adminstatus -eq "down"}
}

# Return true if any adapter named Wi-Fi is down
function ETHADAPTER
{
	Get-NetAdapter -Name ethernet | Where-Object {$_.adminstatus -eq "down"}
}


# ###################
# SETUP SCRIPT
# Here we setup and manage the random challenge
# ###################
# User introduction
Write-Host "Your challenge is:"

# Get a random challenge number
# minimum is inclusive, maximum is exclusive
$challenge = Get-Random -minimum 1 -maximum 5

switch ($challenge)
	{
		1 {
			# Challenge description
			Write-Host "Start Bluetooth Support Service (bthserv)"
			# Challene check function name
			$checkFunction = "BTHSERV"
		}
		2 {
			# Challenge description
			Write-Host "Disable Net Logon"
			# Challene check function name
			$checkFunction = "NETLOGON"
		}
		3 {
			# Challenge description
			Write-Host "Disable Wi-Fi adapter"
			# Challene check function name
			$checkFunction = "WIFIADAPTER"
		}
		4 {
			# Challenge description
			Write-Host "Disable ethernet adapter"
			# Challene check function name
			$checkFunction = "ETHADAPTER"
		}
		default {
			# Challenge description
			Write-Host "Start Bluetooth Support Service (bthserv)"
			# Challene check function name
			$checkFunction = "BTHSERV"
		}
	}

Write-Host "Waiting for challenge completion..."	
$timer = 0				# Initialize timer

# Loop while the condition is NOT met
while (-Not (Invoke-Expression "$checkFunction"))
{
# Wait for 1 second
Start-Sleep -s 1
$timer++					# Increment timer
}

# Give the user his score
Write-Host "Good job. It took you $timer seconds to complete this challenge."
# Exit the script
read-host "Press ENTER to exit..."