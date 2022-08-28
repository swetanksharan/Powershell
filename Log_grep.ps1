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

$path = Join-Path -Path "\\" -ChildPath $file
$fullpath = Join-Path -Path $path -ChildPath "*\*\*.log" 

#$path = Join-Path -Path "C:\Users\UT392A" -ChildPath $file
#$fullpath = Join-Path -Path $path -ChildPath "*.txt"

$date = Get-Date -Format "yyyyMMdd"

New-Item -Path "\\" -Name "$file"  -ItemType "directory"


 
 $childpath = Get-ChildItem -Path $fullpath
 foreach($a in $childpath){
 $childpath1 = $a.BaseName
 Write-Host $childpath1
#$path = Join-Path -Path "\\" -ChildPath $file
#$fullpath = Join-Path -Path $path -ChildPath "\\"


#$fullpath = Join-Path -Path $path -ChildPath "Imp.txt"

#Join-Path "\\" $file "Imp.txt" -Resolve

$finalpath = Split-Path -Path $fullpath -Leaf -Resolve
#Foreach-Object {  $content = Get-Content $_.FullName 
 #$content
 $dest="\\Log\$file\$childpath1.txt"
 if(Test-Path $dest ){
 $i=0
 While(Test-path $dest ){
 $i +=1
 $dest="\\Log\$file\$childpath1$i.txt"
 }
 }
 Else {
 New-Item -ItemType File -Path $dest -Force
}
 Get-ChildItem -Path $a  -Filter *.log  |Get-Content |Select-String -Pattern "unable to open file" -List | Out-File -FilePath "$dest" 
 }
 
