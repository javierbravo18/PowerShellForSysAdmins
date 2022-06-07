# PowerShell DSC script to be used in Azure. Used to ensure the Registry Key values specified are persistent in the machines to which this policy is applied to in Azure.

Configuration RegistryKeyValuesDSC
{
    Import-DSCResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DSCResource -ModuleName 'AuditPolicyDSC'
    Import-DSCResource -ModuleName 'SecurityPolicyDSC'

    #1

    Node localhost
    {
    Registry "CCE-36325-9: Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'"
        {
            ValueName = 'RequireSecuritySignature'
            ValueType = 'DWORD'
            Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters'
            ValueData = 1
        }


    }

    #2

    Node localhost
    {
    Registry "CCE-36000-8 Ensure 'Disallow WinRM from storing RunAs credentials' is set to 'Enabled'"
        {
            ValueName = 'DisableRunAs'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
            ValueData = 1
        }


    }

    #3

    Node localhost
    {
    Registry "CCE-37526-1 Ensure 'Setup: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'"
        {
            ValueName = 'MaxSize'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup"
            ValueData = 32768
        }


    }

    #4

    Node localhost
    {
    Registry "CCE-36077-6 Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)"
        {
            ValueName = 'RestrictAnonymous'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueData = 1
        }


    }

    #5

    Node localhost
    {
    Registry "CCE-37636-8 Ensure 'Disallow Autoplay for non-volume devices' is set to 'Enabled'"
        {
            ValueName = 'NoAutoplayfornonVolume'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer"
            ValueData = 1
        }


    }

    #6

    Node localhost
    {
    Registry "CCE-36021-4 Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
        {
            ValueName = 'RestrictNullSessAccess'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters"
            ValueData = 1
        }


    }

    #7

    Node localhost
    {
    Registry "CCE-38239-0 Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'"
        {
            ValueName = 'EnableFirewall'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile"
            ValueData = 1
        }


    }

    #8

    Node localhost
    {
    Registry "CCE-37864-6 Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'"
        {
            ValueName = 'RequireSecuritySignature'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters"
            ValueData = 1
        }


    }

    #9

    Node localhost
    {
    Registry "CCE-38332-3 Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'"
        {
            ValueName = 'DefaultOutboundAction'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile"
            ValueData = 0
        }


    }

    #10

    Node localhost
    {
    Registry "CCE-36173-3 Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM & NTLM'"
        {
            ValueName = 'LmCompatibilityLevel'
            ValueType = 'DWORD'
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueData = 5
        }


    }
}
