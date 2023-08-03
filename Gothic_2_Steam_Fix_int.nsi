SetCompressor lzma
var DirectoryText

!include "MUI.nsh"

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
!define MOD_VERSION "11.2022"
!define MOD_DETAILED_VERSION "22.11.13.0"
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
!define MUI_TEXT_WELCOME_INFO_TEXT "'Gothic 2 Steam Fix' is an all-in-one solution of the most known 'Gothic II: Gold Edition' problems on modern PCs. This pack includes Union 1.0m with Workshop launcher optimizer and fully compatible with english, german, french, italian, spanish and polish versions of the game."

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
	Delete "$INSTDIR\System\dinput.dll"
	Delete "$INSTDIR\Data\SystemPack.vdf"
	Delete "$INSTDIR\_work\data\Video\Logo1.bik"
	Delete "$INSTDIR\_work\data\Video\Logo2.bik"

	SetOutPath "$INSTDIR\Data"
	File "Textures_Widescreen.vdf"
	File "Union.vdf"

	SetOutPath "$INSTDIR\launcher"
	File "d3d11.dll"

	SetOutPath "$INSTDIR\System"
	File "Gothic.ini"
	File "msvcp100.dll"
	File "msvcr100.dll"
	File "Shw32.dll"
	File "stdhost.exe"
	File "Union.patch"
	File "vdfs32g.dll"
	!insertmacro GMF_File_Rename "SystemPack_int.ini" "SystemPack.ini"

	SetOutPath "$INSTDIR\System\autorun"
	File "AutoScreenRes.dll"

	IfFileExists "$INSTDIR\System\GothicMod.exe" 0 CustomStarterNotFound
	Delete "$INSTDIR\system\Gothic2.exe"
	Rename $INSTDIR\system\GothicMod.exe $INSTDIR\system\Gothic2.exe
	CustomStarterNotFound:

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
