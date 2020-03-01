###################################
##      Подключенные хидеры      ##
###################################

!include "MUI.nsh"
!include "FileFunc.nsh"
!include "GothicFixesCommon.nsh"

###################################
##            Основное           ##
###################################

!define MOD_NAME "Gothic 2 Steam Fix"
!define MOD_VERSION "03.2020"
!define MOD_DETAILED_VERSION "20.3.1.0"
!define MOD_AUTHOR "D36"

Name "${MOD_NAME}"
OutFile "Gothic_2_Steam_Fix_${MOD_VERSION}.exe"

VIProductVersion "${MOD_DETAILED_VERSION}"
VIAddVersionKey "FileVersion" "${MOD_DETAILED_VERSION}"
VIAddVersionKey "LegalCopyright" "© ${MOD_AUTHOR}"
VIAddVersionKey "FileDescription" "${MOD_NAME} Install"
VIAddVersionKey "ProductVersion" "${MOD_VERSION}"

###################################
##      Настройки интерфейса     ##
###################################

!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "logo_int.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "pic_int.bmp"

Caption "${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TITLE "$\t   $\n$\tGothic 2 Steam Fix"
!define MUI_TEXT_WELCOME_INFO_TEXT "'Gothic 2 Steam Fix' is an all-in-one solution of the most known 'Gothic II: Gold Edition' problems on modern PCs. This pack includes official 2.6 patch, latest versions of SystemPack and Player Kit and fully compatible with english, german, french, italian, spanish and polish versions of the game."

!define MUI_TEXT_DIRECTORY_SUBTITLE " "
DirText $DirectoryText

!define MUI_TEXT_INSTALLING_TITLE "Please wait..."
!define MUI_TEXT_INSTALLING_SUBTITLE " "

!define MUI_TEXT_FINISH_INFO_TITLE "$\t   $\n$\tInstallation complete!"
!define MUI_TEXT_FINISH_INFO_TEXT "You can now launch the game using your Steam account."

BrandingText " "

###################################
##     Страницы  инсталлятора    ##
###################################

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

###################################
##             Языки             ##
###################################

!insertmacro MUI_LANGUAGE "English"

###################################
##          Инсталляция          ##
###################################

Section "Main" SecMain
	SectionIn RO

	!insertmacro GMF_Delete "$INSTDIR\delsaves.exe"
	!insertmacro GMF_Delete "$INSTDIR\g2addon-2.6_readme.htm"
	!insertmacro GMF_Delete "$INSTDIR\Readme.txt"
	!insertmacro GMF_Delete "$INSTDIR\Readme_UK.txt"
	!insertmacro GMF_Delete "$INSTDIR\site.url"
	!insertmacro GMF_Delete "$INSTDIR\VDFS.dmp"
	!insertmacro GMF_Delete "$INSTDIR\Data\Breitbild_Patch.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\MENU_AutoScale_G2.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_1.1.0.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_2.0.2.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_2.0.3.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_2.1.0.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_2.2.0.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_2.2.1.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_3_0_1_Cyrillic.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\FONT_High_Resolution_3_0_1_Latin.vdf"
	!insertmacro GMF_Delete "$INSTDIR\Data\g2a_nr_scriptpatch.vdf"
	!insertmacro GMF_Delete "$INSTDIR\System\dmband.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmcompos.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmime.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmloader.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmstyle.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmsynth.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\dmusic.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\MssDS3D.m3d.exe"
	!insertmacro GMF_Delete "$INSTDIR\System\D3dim700.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\D3DImm.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\Vdfs32e.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\Vdfs32e.exe"
	!insertmacro GMF_Delete "$INSTDIR\System\Vdfs32g.exe"
	!insertmacro GMF_Delete "$INSTDIR\System\KillHelp.exe"
	!insertmacro GMF_Delete "$INSTDIR\System\ar.exe"
	!insertmacro GMF_Delete "$INSTDIR\System\AntTweakBar.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\Assimp32.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\d3dcompiler_47.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\ddraw.dll"
	!insertmacro GMF_Delete "$INSTDIR\System\GFSDK_SSAO.win32.dll"
	!insertmacro GMF_Delete "$INSTDIR\_work\Data\Video\Logo1.bik"
	!insertmacro GMF_Delete "$INSTDIR\_work\Data\Video\Logo2.bik"

	CreateDirectory "$INSTDIR\Data\ModVDF"
	CreateDirectory "$INSTDIR\Saves\current"

	SetOutPath "$INSTDIR"
	File "VDFS.cfg"

	SetOutPath "$INSTDIR\_work\data\Music\NewWorld"
	File "Xardas Tower.sty"
	File "XT_DayStd.sgt"

	SetOutPath "$INSTDIR\Data"
	File "Textures_Widescreen.vdf"
	File "SystemPack.vdf"

	SetOutPath "$INSTDIR\System"
	File "Gothic.ini"
	File "Gothic2.exe"
	File "GothicStarter.exe"
	File "Shw32.dll"
	File "vdfs32g.dll"
	!insertmacro GMF_File_Rename "SystemPack_int.ini" "SystemPack.ini"
	!insertmacro GMF_File_Rename "GothicGame_original.ini" "GothicGame.ini"
	!insertmacro GMF_File_Rename "GothicGame_original.rtf" "GothicGame.rtf"
	!insertmacro _ReplaceInFile "Gothic.ini" "1280" "$RESX"
	!insertmacro _ReplaceInFile "Gothic.ini" "1024" "$RESY"

	IfFileExists "$INSTDIR\Manuel\G2_Short_Manual_FRa.pdf" fix_title french_not_found
	french_not_found:

	IfFileExists "$INSTDIR\Manuale\G2AddOn_HB_ITA.pdf" fix_subtitles italian_not_found
	italian_not_found:

	IfFileExists "$INSTDIR\Gothic2_Handbuch_GE.pdf" end_of_tests german_not_found
	german_not_found:

	IfFileExists "$INSTDIR\system\gothic2nk.ico" end_of_tests polish_not_found
	polish_not_found:

	IfFileExists "$INSTDIR\G2_Gold_Manual_ESP.pdf" fix_subtitles spanish_not_found
	spanish_not_found:

	IfFileExists "$INSTDIR\Data\Speech_English_Patch_Atari.vdf" fix_subtitles end_of_tests
	fix_subtitles:

	Rename $INSTDIR\_work\data\scripts\content\cutscene\ou.dat $INSTDIR\_work\data\scripts\content\cutscene\ou.bin
	!insertmacro GMF_Delete "$INSTDIR\_work\data\scripts\content\cutscene\ou.lsc"
	!insertmacro GMF_Delete "$INSTDIR\_work\data\scripts\_compiled\ouinfo.inf"
	goto fix_title

	fix_title:
	SetOutPath "$INSTDIR\Data"
	File "Textures_Addon_Menu_English.vdf"

	end_of_tests:

SectionEnd

###################################
##            Функции            ##
###################################

Function .onInit
	SetSilent normal
	StrCpy $DirectoryText "Gothic II: Gold Edition installation folder is found, press 'Install' button to continue or 'Browse...' to select another install location."
	SetRegView 32
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	SetRegView 64
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	InstallPathIsFound:
	IfFileExists "$INSTDIR\System\Gothic2.exe" InstallPathIsGood
	StrCpy $INSTDIR "$PROGRAMFILES\Steam\steamapps\common\Gothic II"
	StrCpy $DirectoryText "Please select your Gothic II: Gold Edition installation folder (e.g. Steam\steamapps\common\Gothic II)."
	InstallPathIsGood:
	System::Call 'user32::GetSystemMetrics(i 0) i .r0'
	System::Call 'user32::GetSystemMetrics(i 1) i .r1'
	StrCpy $RESX $0
	StrCpy $RESY $1
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\System\Gothic2.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd