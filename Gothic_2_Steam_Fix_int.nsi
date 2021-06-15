SetCompressor lzma
var DirectoryText

!include "MUI.nsh"
!include "FileFunc.nsh"

###################################
##            Макросы            ##
###################################

!macro GMF_File_Rename FILENAME_1 FILENAME_2
	File "${FILENAME_1}"
	IfFileExists "${FILENAME_2}" "" +2
	Delete "${FILENAME_2}"
	Rename "${FILENAME_1}" "${FILENAME_2}"
!macroend

###################################
##            Основное           ##
###################################

!define MOD_NAME "Gothic 2 Steam Fix"
!define MOD_VERSION "06.2021"
!define MOD_DETAILED_VERSION "21.6.15.0"
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
!define MUI_TEXT_WELCOME_INFO_TITLE "$\t   $\n$\t${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TEXT "'Gothic 2 Steam Fix' is an all-in-one solution of the most known 'Gothic II: Gold Edition' problems on modern PCs. This pack includes official 2.6 patch, Union 1.0k, SystemPack 1.9 and Player Kit 2.8 and fully compatible with english, german, french, italian, spanish and polish versions of the game."

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

	Delete "$INSTDIR\VDFS.dmp"
	Delete "$INSTDIR\System\ddraw.dll"
	Delete "$INSTDIR\System\dinput.dll"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v21_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v22_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v23_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v24_hotfix.vdf"
	Delete "$INSTDIR\Data\SystemPack.vdf"
	Delete "$INSTDIR\_work\data\Video\Logo1.bik"
	Delete "$INSTDIR\_work\data\Video\Logo2.bik"

	CreateDirectory "$INSTDIR\Data\ModVDF"
	CreateDirectory "$INSTDIR\Saves\current"

	SetOutPath "$INSTDIR"
	File "vcredist_2010_x86.exe"
	Exec "vcredist_2010_x86.exe /q /norestart"

	SetOutPath "$INSTDIR\_work\data\Music\NewWorld"
	File "Xardas Tower.sty"
	File "XT_DayStd.sgt"

	SetOutPath "$INSTDIR\Data"
	File "Textures_Widescreen.vdf"
	File "Union.vdf"

	SetOutPath "$INSTDIR\System"
	!insertmacro GMF_File_Rename "Gothic2.exe" "GothicStarter.exe"
	File "Gothic.ini"
	File "Gothic2.exe"
	File "GothicMod.exe"
	File "Shw32.dll"
	File "Union.patch"
	File "vdfs32g.dll"
	!insertmacro GMF_File_Rename "SystemPack_int.ini" "SystemPack.ini"
	!insertmacro GMF_File_Rename "GothicGame_original.ini" "GothicGame.ini"
	!insertmacro GMF_File_Rename "GothicGame_original.rtf" "GothicGame.rtf"

	SetOutPath "$INSTDIR\System\autorun"
	File "AutoScreenRes.dll"

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
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\System\Gothic2.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd
