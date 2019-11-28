###################################
##      ѕодключенные хидеры      ##
###################################

!include "MUI.nsh"
!include "FileFunc.nsh"
!include "GothicFixesCommon.nsh"
!include "FloatOp.nsh"
!include "LogicLib.nsh"

###################################
##            ќсновное           ##
###################################

!define MOD_NAME " "
!define MOD_VERSION "0.1"
!define MOD_DETAILED_VERSION "0.1.0.0"
!define MOD_AUTHOR "me"

Name "${MOD_NAME}"
OutFile "resratiotest.exe"

VIProductVersion "${MOD_DETAILED_VERSION}"
VIAddVersionKey "FileVersion" "${MOD_DETAILED_VERSION}"
VIAddVersionKey "LegalCopyright" "© ${MOD_AUTHOR}"
VIAddVersionKey "FileDescription" "${MOD_NAME} Install"
VIAddVersionKey "ProductVersion" "${MOD_VERSION}"

!insertmacro MUI_PAGE_INSTFILES

###################################
##             языки             ##
###################################

!insertmacro MUI_LANGUAGE "English"

###################################
##          »нсталл€ци€          ##
###################################

Section "Main" SecMain
	SectionIn RO


SectionEnd

###################################
##            ‘ункции            ##
###################################

Function .onInit
	System::Call 'user32::GetSystemMetrics(i 0) i .r0'
	System::Call 'user32::GetSystemMetrics(i 1) i .r1'
	StrCpy $RESX $0
	StrCpy $RESY $1
	FloatOp::D $RESX $RESY ${VAR_4}
	MessageBox MB_OK|MB_ICONEXCLAMATION "$RESX/$RESY=$4"
	${If} $4 >= 1.6
	MessageBox MB_OK "Widescreen"
	${EndIf}
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\System\Gothic2.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd