$outfile = ".\SqlMapper.cs.pp"
if(Test-Path $outfile) {
	Write-Host "Deleting" $outfile 	
	Remove-Item $outfile
}

Write-Host "Preparing" $outfile 	
$contents = Get-Content "SqlMapper.cs"
Add-Content $outfile "// <auto-generated />"
for ($i=0; $i -lt $contents.Length; $i++) {
	$line = $contents[$i]
	if($line.StartsWith("namespace")) {
		Add-Content $outfile "namespace `$rootnamespace`$.Dapper"
	}
	else {
		Add-Content $outfile $line
	}
}

Write-Host "Creating Nuget Package"
nuget pack dapper.nuspec