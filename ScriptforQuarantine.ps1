	1. Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.RecipientAddress -eq "abq-sandia-orders@borderstates.com" -and $_.SenderAddress -eq "purchasing-notifi@sandia.gov"}
		# Sandia seems to send most of their orders between 10:45-11:15AM, so it might be best to run this line around 11:30AM so they can be released same day
		# This will need to be done until INC0529931 is resolved.
	
   2.    $badadr = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.SenderAddress -like "<>"} | select -ExpandProperty Identity
	Delete-QuarantineMessage -Identities $badadr -Identity 000

	3. $bseadr = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.SenderAddress -like "*borderstates.com" -or $_.SenderAddress -like "*border-states.com"} | select -ExpandProperty Identity
	Delete-QuarantineMessage -Identities $bseadr -Identity 000

	4. $lenadr = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.SenderAddress.Substring($_.SenderAddress.length-3,1) -eq "."} | select -ExpandProperty Identity
	Delete-QuarantineMessage -Identities $lenadr -Identity 000

	5. $senadr = Get-QuarantineMessage -PageSize 1000 | Group {$_.SenderAddress.Substring($_.SenderAddress.Indexof("@"))}  | Where { $_.Count -ge 5 }
	for ($num1 = 0;$num1 -lt $senadr.Count;$num1++)
	{
		$senadrdel = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.SenderAddress -like "*"+ $senadr[$num1].Name} | select -ExpandProperty Identity
		Delete-QuarantineMessage -Identities $senadrdel -Identity 000

	}

	6. $phrase = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.Subject -like "*urgent*" -or $_.Subject -like "*Password*" -or $_.Subject -like "*Action Required*" -or $_.Subject -like "*immediate*" -or $_.Subject -like "*Voice Mail*" -or $_.Subject -like "*Deactivation*" -or $_.Subject -like "*mailbox*" -or $_.Subject -eq ""}| select -ExpandProperty Identity
	Delete-QuarantineMessage -Identities $phrase -Identity 000


	7. $subcnt = Get-QuarantineMessage -PageSize 1000 | Group {($_.Subject)} | Where { $_.Count -ge 4 }
	for ($num2 = 0;$num2 -lt $subcnt.Count;$num2++)
	{
		$subdel = Get-QuarantineMessage -PageSize 1000 | where {$_.Released -like "False" -and $_.Subject -eq $subcnt[$num2].Name} | select -ExpandProperty Identity
		Delete-QuarantineMessage -Identities $subdel -Identity 000

	}
