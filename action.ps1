# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdate
######################################################
# Form mapping
$formObject = @{
    UserPrincipalName = $form.UserPrincipalName
    Title             = $form.Title
    Department        = $form.Department
    OfficePhone       = $form.OfficePhone
}

try {
    Write-Information "Executing ActiveDirectory action: [UpdateAccount] for: [$($formObject.UserPrincipalName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $user = Get-ADUser -Filter "userPrincipalName -eq '$($formObject.UserPrincipalName)'"
    if ($user) {
        $null = Set-ADUser -Identity $user @formObject
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "ActiveDirectory action: [UpdateAccount] for: [$($formObject.UserPrincipalName)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action: [UpdateAccount] for: [$($formObject.UserPrincipalName)] executed successfully"
    } elseif (-not($user)) {
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
    }
} catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateAccount'
        System            = 'ActiveDirectory'
        TargetDisplayName = $($formObject.UserPrincipalName)
        TargetIdentifier  = ($user).SID.value
        Message           = "Could not execute ActiveDirectory action: [UpdateAccount] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute ActiveDirectory action: [UpdateAccount] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
}
######################################################
