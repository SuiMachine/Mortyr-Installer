;  Mortyr (2093-1944) Alternate installer
;  Created 2016 Suicide Machine.
;  Based on a code of Triangle717's Lego Racer Alternative Installer.
;  <http://triangle717.wordpress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, 
; this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define MyAppInstallerName "Mortyr (2093-1944) - Alternate Installer"
#define MyAppInstallerVersion "1.0.0"
#define MyAppName "Mortyr"
#define MyAppNameNoR "Mortyr"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Interplay Entertainment"
#define MyAppExeName "Mortyr.exe"

[Setup]
AppID={#MyAppInstallerName}{#MyAppInstallerVersion}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1998 {#MyAppPublisher}
LicenseFile=license.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={sd}\Games\{#MyAppNameNoR}
DefaultGroupName={#MyAppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Mortyr.ico
WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=True
; Location of the compiled Exe
OutputDir=bin
OutputBaseFilename={#MyAppNameNoR} Alternate Installer {#MyAppInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Mortyr.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=480947180
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finish.
PrivilegesRequired=admin
ShowLanguageDialog=yes
ShowUndisplayableLanguages=yes
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName} {#MyAppInstallerVersion}
; WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
English.DiskSpaceMBLabel=At least 474 MB of free disk space is required.

[Types]
Name: "Full"; Description: "Full Installation"; Flags: iscustom  

[Files]
; Root folder
Source: "{code:GetSourceDrive}DATA1.CAB"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall
Source: "{code:GetSourceDrive}DATA1.HDR"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall
Source: "{code:GetSourceDrive}MORTYR.ICO"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}DATA\*"; DestDir: "{app}\DATA\"; Flags: external ignoreversion

; Install stuff
Source: "Stuff\i5comp\i5comp.exe"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Stuff\i5comp\ZD51145.DLL"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Stuff\fix_paths.cmd"; DestDir: "{app}\DATA\"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Mortyr.ico";Comment: "Start Mortyr";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{uninstallexe}";
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Mortyr.ico"; Comment: "Mortyr"; Tasks: desktopicon


[Tasks]
; Create a desktop icon, run with administrator rights
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}";

[Run]
; From to to bottom: Extract the CAB, run game 
; (depending on user's choice on the videos).
Filename: "{app}\i5comp.exe"; Parameters: "x ""{app}\DATA1.CAB"""; Flags: runascurrentuser
Filename: "{app}\data\fix_paths.cmd"; Parameters: ""; Flags: runascurrentuser

[UninstallDelete]
Type: files; Name: "{app}\{#MyAppExeName}"
Type: files; Name: "{app}\DATA\cdrom.std"
Type: files; Name: "{app}\DATA\IMDP35.DLL"
Type: files; Name: "{app}\DATA\IMONL5.DLL"
Type: files; Name: "{app}\DATA\IMONLGS5.DLL"
Type: files; Name: "{app}\DATA\server.std"
Type: files; Name: "{app}\DATA\user.std"
Type: files; Name: "{app}\DATA\ic.set"
Type: files; Name: "{app}\DATA\error.txt"
Type: files; Name: "{app}\IMMULTR5.DLL"
Type: files; Name: "{app}\IMONL5.DLL"
Type: files; Name: "{app}\IMONLGS5.DLL"
Type: files; Name: "{app}\Mortyr.exe"
Type: files; Name: "{app}\IMONLGS5.DLL"
Type: files; Name: "{app}\MSS16.DLL"
Type: files; Name: "{app}\MSS32.DLL"
Type: files; Name: "{app}\MSSA3D.M3D"
Type: files; Name: "{app}\MSSB16.TSK"
Type: files; Name: "{app}\MSSDS3DH.M3D"
Type: files; Name: "{app}\MSSDS3DS.M3D"
Type: files; Name: "{app}\MSSEAX.M3D"
Type: files; Name: "{app}\IMONLGS5.DLL"
Type: files; Name: "{app}\MSSFAST.M3D"
Type: files; Name: "{app}\MSSRSX.M3D"
Type: files; Name: "{app}\Server.exe"
Type: files; Name: "{app}\readme.txt"

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up 
// and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
