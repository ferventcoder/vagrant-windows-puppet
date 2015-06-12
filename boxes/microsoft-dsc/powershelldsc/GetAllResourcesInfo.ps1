
$resources = Get-DSCResource

foreach ($resource in $resources) {
  if ($resource.Name -ne "File") {continue}
  Write-Host "dsc_$($resource.Name) { 'title':"

  foreach ($property in $resource.Properties) {
    $name = $property.Name.ToLower()
    if ($name -eq "dependson") {continue}
    $isRequired = $property.IsMandatory
    $isStringValue = $false
    $isBool = $false
    $type = $property.PropertyType
    if ($type -eq '[string]') {
      $isStringValue = $true
    }
    if ($type -eq '[bool]') {
      $isBool = $true
    }

    $values = $property.Values

    $possibleValues = '<'
    $counter = 0
    foreach ($value in $values) {
      if ($counter -ne 0) {
        $possibleValues += '|'
      }
      if ($isStringValue) {
        if ($name -eq 'ensure' -and $value -eq 'Present') {
          $possibleValues +="['$value']"
        } else {
        $possibleValues +="'$value'"
        }
      } else {
        $possibleValues +="$value"
      }
      $counter +=1
    }
    $possibleValues +='>'

    $rightValue = ''

    if ($possibleValues.Length -le 3) {
      if ($isStringValue) {
        $rightValue = "<''>"
      }
      if ($isBool) {
        $rightValue = "<true|[false]>"
      }
    } else {
      $rightValue = $possibleValues
    }
    if ($isRequired) {
      $rightValue += ' [REQUIRED]'
    }

    Write-Host "  $($property.Name.ToLower()) => $rightValue"

  }
  Write-Host "}"
  Write-Host ""
}

