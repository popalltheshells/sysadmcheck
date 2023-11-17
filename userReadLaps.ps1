# Checks if there are users in the domain who can read LAPS
# Requires the ActiveDirectory module
Import-Module ActiveDirectory

# Define the right we're looking for
$extendedRightName = 'ms-Mcs-AdmPwd'

# Get all OUs in the domain
$allOUs = Get-ADOrganizationalUnit -Filter *

# Check each OU for permissions and output to console
foreach ($OU in $allOUs) {
    $acl = Get-Acl -Path ("AD:\$($OU.DistinguishedName)")
    $accessRules = $acl.Access | Where-Object { $_.ObjectType -eq $extendedRightName }
    foreach ($rule in $accessRules) {
        [PSCustomObject]@{
            OU = $OU.DistinguishedName
            SecurityPrincipal = $rule.IdentityReference
            AccessControlType = $rule.AccessControlType
            Rights = $rule.ActiveDirectoryRights
        }
    }
}
