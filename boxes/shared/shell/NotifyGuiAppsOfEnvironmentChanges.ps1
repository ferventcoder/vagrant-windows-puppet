Write-Host "Sometimes explorer.exe just doesn't get the message that it should update environment variables"

if (-not ("win32.nativemethods" -as [type])) {
    # import sendmessagetimeout from win32
    add-type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern IntPtr SendMessageTimeout(
    IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
    uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
}

$HWND_BROADCAST = [intptr]0xffff;
$WM_SETTINGCHANGE = 0x1a;
$result = [uintptr]::zero

Write-Host "We are going to send the broadcast out to notify all window based apps of the environment block change"
[win32.nativemethods]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE,  [uintptr]::Zero, "Environment", 2, 5000, [ref]$result);

Write-Host "For good measure, we are going to take out explorer"
tskill.exe explorer /a /v
