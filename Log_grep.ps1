#Author - Swetank Sharan

#Param( 
#[Parameter(Mandatory=$true)]
#[ValidateScript({Test-Path $_ -PathType 'leaf'})]  
#[string] $file
#)

Param(
                [Parameter(Mandatory=$True,Position=1)]
                [string]$file
                )


Write-Host $file

#$path = Join-Path -Path "C:\Users\UT392A.CM" -ChildPath $file -AdditionalChildPaths "Imp.txt"

$path = Join-Path -Path "\\smb61-nas6.par.emea.cib\CCC_LOGS_PRODMCR\CCC-MC" -ChildPath $file
$fullpath = Join-Path -Path $path -ChildPath "*\*\*.log" 

#$path = Join-Path -Path "C:\Users\UT392A" -ChildPath $file
#$fullpath = Join-Path -Path $path -ChildPath "*.txt"

$date = Get-Date -Format "yyyyMMdd"

New-Item -Path "\\smb62-nas6.par.emea.cib\CCC_DATA_UATMCR\Log\" -Name "$file"  -ItemType "directory"


 
 $childpath = Get-ChildItem -Path $fullpath
 foreach($a in $childpath){
 $childpath1 = $a.BaseName
 Write-Host $childpath1
#$path = Join-Path -Path "\\smb61-nas6.par.emea.cib\CCC_LOGS_PRODMCR\CCC-MC" -ChildPath $file
#$fullpath = Join-Path -Path $path -ChildPath "676\8097995551114103946\CMVAPA5634_0.log"


#$fullpath = Join-Path -Path $path -ChildPath "Imp.txt"

#Join-Path "C:\Users\UT392A.CM" $file "Imp.txt" -Resolve

$finalpath = Split-Path -Path $fullpath -Leaf -Resolve
#Foreach-Object {  $content = Get-Content $_.FullName 
 #$content
 $dest="\\smb62-nas6.par.emea.cib\CCC_DATA_UATMCR\Log\$file\$childpath1.txt"
 if(Test-Path $dest ){
 $i=0
 While(Test-path $dest ){
 $i +=1
 $dest="\\smb62-nas6.par.emea.cib\CCC_DATA_UATMCR\Log\$file\$childpath1$i.txt"
 }
 }
 Else {
 New-Item -ItemType File -Path $dest -Force
}
 Get-ChildItem -Path $a  -Filter *.log  |Get-Content |Select-String -Pattern "unable to open file" -List | Out-File -FilePath "$dest" 
 }
 