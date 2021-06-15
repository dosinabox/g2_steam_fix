Unicode true
SetCompressor lzma
var DirectoryText

!include "MUI.nsh"
!include "FileFunc.nsh"

###################################
##            �������            ##
###################################

!macro GMF_File_Rename FILENAME_1 FILENAME_2
	File "${FILENAME_1}"
	IfFileExists "${FILENAME_2}" "" +2
	Delete "${FILENAME_2}"
	Rename "${FILENAME_1}" "${FILENAME_2}"
!macroend

###################################
##            ��������           ##
###################################

!define MOD_NAME "Gothic 2 Steam Fix"
!define MOD_VERSION "06.2021"
!define MOD_DETAILED_VERSION "21.6.15.0"
!define MOD_AUTHOR "D36"
!define SCRIPTPATCH_VERSION "26"

Name "${MOD_NAME}"
OutFile "Gothic_2_Steam_Fix_RU_Akella_${MOD_VERSION}.exe"

VIProductVersion "${MOD_DETAILED_VERSION}"
VIAddVersionKey "FileVersion" "${MOD_DETAILED_VERSION}"
VIAddVersionKey "LegalCopyright" "� ${MOD_AUTHOR}"
VIAddVersionKey "FileDescription" "���������� ${MOD_NAME}"
VIAddVersionKey "ProductVersion" "${MOD_VERSION}"

###################################
##      ��������� ����������     ##
###################################

!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "logo.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "pic.bmp"

Caption "${MOD_NAME} (������)"
!define MUI_TEXT_WELCOME_INFO_TITLE "$\t   $\n$\t${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TEXT "������ ������� ����������� ������������ ��� ��������� �� ������ Steam-������ Gothic II: Gold Edition ��� ������ ������ � �����."

!define MUI_TEXT_DIRECTORY_SUBTITLE " "
DirText $DirectoryText

!define MUI_TEXT_COMPONENTS_TITLE "����� ����������� ��� ���������"
!define MUI_TEXT_COMPONENTS_SUBTITLE " "
!define MUI_COMPONENTSPAGE_TEXT_TOP "�������� ���������� ${MOD_NAME}, ������� �� ������ ����������. ������� ������ '����������' ��� �����������."
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "���������� ��� ���������:"
!define MUI_COMPONENTSPAGE_SMALLDESC

!define MUI_TEXT_INSTALLING_TITLE "����������� ������ � ���������..."
!define MUI_TEXT_INSTALLING_SUBTITLE " "

!define MUI_TEXT_FINISH_INFO_TITLE "$\t   $\n$\t��������� ���������!"
!define MUI_TEXT_FINISH_INFO_TEXT "������ ���� ����� ��������� �� Steam. ��������� �������������� ���������� ��� ������ �� ��������� � �� �������������.$\n$\n�������� ����!"

BrandingText " "

###################################
##     ��������  ������������    ##
###################################

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

###################################
##             �����             ##
###################################

!insertmacro MUI_LANGUAGE "Russian"

###################################
##          �����������          ##
###################################

Section "�������� ����� � ����������" SecMain
	SectionIn RO

	Delete "$INSTDIR\VDFS.dmp"
	Delete "$INSTDIR\System\ddraw.dll"
	Delete "$INSTDIR\System\dinput.dll"
	Delete "$INSTDIR\Data\g2a_nr_basepatch.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v21_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v22_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v23_hotfix.vdf"
	Delete "$INSTDIR\Data\g2a_nr_scriptpatch_v24_hotfix.vdf"
	Delete "$INSTDIR\Data\SystemPack.vdf"
	Delete "$INSTDIR\_work\data\Video\Logo2.bik"

	CreateDirectory "$INSTDIR\Data\ModVDF"
	CreateDirectory "$INSTDIR\Saves\current"

	SetOutPath "$INSTDIR"
	File "vcredist_2010_x86.exe"
	Exec "vcredist_2010_x86.exe /q /norestart"

	SetOutPath "$INSTDIR"
	File "Union.url"

	SetOutPath "$INSTDIR\_work\data\Music\NewWorld"
	File "Xardas Tower.sty"
	File "XT_DayStd.sgt"
	File "KAS_Loop_DayStd.sgt"

	SetOutPath "$INSTDIR\_work\data\Video"
	File "Extro_PAL.bik"
	File "Logo1.bik"

	SetOutPath "$INSTDIR\Data"
	File "Union.vdf"

	SetOutPath "$INSTDIR\System"
	!insertmacro GMF_File_Rename "Gothic2.exe" "GothicStarter.exe"
	File "Gothic.ini"
	File "Gothic2.exe"
	File "GothicGame.ini"
	File "GothicGame.rtf"
	File "GothicMod.exe"
	File "Shw32.dll"
	File "SystemPack.ini"
	File "Union.patch"
	File "vdfs32g.dll"

	SetOutPath "$INSTDIR\System\autorun"
	File "AutoScreenRes.dll"

	IfFileExists "$INSTDIR\Manuel\G2_Short_Manual_FRa.pdf" end_of_tests french_not_found
	french_not_found:

	IfFileExists "$INSTDIR\system\gothic2nk.ico" end_of_tests polish_not_found
	polish_not_found:

	IfFileExists "$INSTDIR\Gothic2_Handbuch_GE.pdf" end_of_tests german_not_found
	german_not_found:

	IfFileExists "$INSTDIR\Manuale\G2AddOn_HB_ITA.pdf" fix_subtitles italian_not_found
	italian_not_found:

	IfFileExists "$INSTDIR\G2_Gold_Manual_ESP.pdf" fix_subtitles spanish_not_found
	spanish_not_found:

	IfFileExists "$INSTDIR\Data\Speech_English_Patch_Atari.vdf" fix_subtitles end_of_tests

	fix_subtitles:
	Rename $INSTDIR\_work\data\scripts\content\cutscene\ou.dat $INSTDIR\_work\data\scripts\content\cutscene\ou.bin

	end_of_tests:

SectionEnd


Section /o "���������� ��������� ������" SecAdditional_1

	SetOutPath "$INSTDIR\System"
	!insertmacro GMF_File_Rename "GothicMod_4gb.exe" "GothicMod.exe"

SectionEnd


Section /o "��������� ��������" SecAdditional_2

	SetOutPath "$INSTDIR\Data"
	File "zGamePad.vdf"

SectionEnd


SectionGroup /e "����������� �� ������" Group1

Section "����� � ��������" SecAdditional_3

	Delete "$INSTDIR\Data\Textures_multilingual_Jowood.vdf"
	Delete "$INSTDIR\Data\Textures_Addon_Menu_English.vdf"
	Delete "$INSTDIR\Data\Textures_Fonts_Apostroph.vdf"
	Delete "$INSTDIR\_work\data\video\Addon_Title.bik"

	SetOutPath "$INSTDIR\_work\data\scripts\_compiled"
	File "GOTHIC.DAT"
	File "MENU.DAT"

	SetOutPath "$INSTDIR\_work\data\scripts\content\cutscene"
	File "OU.BIN"

	SetOutPath "$INSTDIR\System"
	File "G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.ini"
	File "G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.rtf"

	SetOutPath "$INSTDIR\Data"
	File "Textures_Russian.vdf"
	File "Fonts_Russian.vdf"

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "g2a_nr_scriptpatch_v${SCRIPTPATCH_VERSION}.mod"
	File "g2a_nr_scriptpatch_v${SCRIPTPATCH_VERSION}_plugins.mod"

	SetOutPath "$INSTDIR"
	File "Changelog_G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.txt"

	CreateDirectory "$INSTDIR\Saves_G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}\current"

SectionEnd


Section "������� � �����" SecAdditional_4
	
	Delete "$INSTDIR\Data\Speech_Addon_Patch.vdf"
	Delete "$INSTDIR\Data\Speech_English_Patch_Atari.vdf"
	Delete "$INSTDIR\Data\Speech_heyou_citygde_engl.vdf"
	Delete "$INSTDIR\Data\Speech_Parlan_engl.vdf"
	Delete "$INSTDIR\Data\Speech_Wegelagerer_Deutsch.vdf"
	Delete "$INSTDIR\Data\Speech2.vdf"
	Delete "$INSTDIR\Data\Speech3.vdf"
	Delete "$INSTDIR\Data\Speech_hotfix.vdf"
	Delete "$INSTDIR\Data\Speech_patch.vdf"
	Delete "$INSTDIR\Data\Speech_Add.vdf"

	SetOutPath "$INSTDIR\Data"
	File "Speech1.vdf"
	File "Speech_Addon.vdf"

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "g2a_nr_scriptpatch_v${SCRIPTPATCH_VERSION}_speech_add.mod"

	SetOutPath "$INSTDIR\_work\data\Video"
	File "DragonAttack.bik"
	File "Extro_AllesWirdGut.bik"
	File "Extro_Xardas.bik"
	File "Intro.bik"
	File "Intro_Addon.bik"
	File "OrcAttack.bik"

	SetOutPath "$INSTDIR"
	File "Changelog_Speech.txt"

SectionEnd

SectionGroupEnd


###################################
##     �������� �����������      ##
###################################

LangString DESC_SecMain ${LANG_RUSSIAN} "�������� ���������� �������� (Union 1.0k, SystemPack 1.9, Player Kit 2.8, ���� 2.6)."
LangString DESC_Group1 ${LANG_RUSSIAN} "����� ����������� ����������� ����."
LangString DESC_SecAdditional_1 ${LANG_RUSSIAN} "������������� 4 �� ����������� ������ ������ 2 ��. ������ ��� 64-������ ������!"
LangString DESC_SecAdditional_2 ${LANG_RUSSIAN} "�������� ��� �����, ���� ������ ������ �� ��������."
LangString DESC_SecAdditional_3 ${LANG_RUSSIAN} "�������� ��� �����, ���� ������ ���������� ������� ����� � �������� �� ������."
LangString DESC_SecAdditional_4 ${LANG_RUSSIAN} "�������� ��� �����, ���� ������ ���������� ������� ������� � ����� �� ������."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
!insertmacro MUI_DESCRIPTION_TEXT ${Group1} $(DESC_Group1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_1} $(DESC_SecAdditional_1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_2} $(DESC_SecAdditional_2)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_3} $(DESC_SecAdditional_3)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_4} $(DESC_SecAdditional_4)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

###################################
##            �������            ##
###################################

Function .onInit
	SetSilent normal
	StrCpy $DirectoryText "���������� ������������� Steam-������ Gothic II: Gold Edition. ������� ������ '�����' ��� ����������� ��� '����� ...' ��� ������ ������ �����."
	SetRegView 32
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	SetRegView 64
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	InstallPathIsFound:
	IfFileExists "$INSTDIR\System\Gothic2.exe" InstallPathIsGood
	StrCpy $INSTDIR "$PROGRAMFILES\Steam\steamapps\common\Gothic II"
	StrCpy $DirectoryText "������� ������ '����� ...' � ������� �����, � ������� ����������� Gothic II: Gold Edition. ��� �������, ��� Steam\steamapps\common\Gothic II.$\n$\n����� ������� ������ '�����' ��� �����������."
	InstallPathIsGood:
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\System\Gothic2.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd
