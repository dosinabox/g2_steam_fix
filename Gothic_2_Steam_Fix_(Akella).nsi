Unicode true
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
!define MOD_VERSION "12.2021"
!define MOD_DETAILED_VERSION "21.12.19.0"
!define MOD_AUTHOR "D36"
!define SCRIPTPATCH_VERSION "27"

Name "${MOD_NAME}"
OutFile "Gothic_2_Steam_Fix_RU_Akella_${MOD_VERSION}.exe"

VIProductVersion "${MOD_DETAILED_VERSION}"
VIAddVersionKey "FileVersion" "${MOD_DETAILED_VERSION}"
VIAddVersionKey "LegalCopyright" "© ${MOD_AUTHOR}"
VIAddVersionKey "FileDescription" "Установщик ${MOD_NAME}"
VIAddVersionKey "ProductVersion" "${MOD_VERSION}"

###################################
##      Настройки интерфейса     ##
###################################

!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "logo.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "pic.bmp"

Caption "${MOD_NAME} (Акелла)"
!define MUI_TEXT_WELCOME_INFO_TITLE "$\t   $\n$\t${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TEXT "Данный сборник исправлений предназначен для установки на чистую Steam-версию Gothic II: Gold Edition без других патчей и модов."

!define MUI_TEXT_DIRECTORY_SUBTITLE " "
DirText $DirectoryText

!define MUI_TEXT_COMPONENTS_TITLE "Выбор компонентов для установки"
!define MUI_TEXT_COMPONENTS_SUBTITLE " "
!define MUI_COMPONENTSPAGE_TEXT_TOP "Выберите компоненты ${MOD_NAME}, которые вы хотите установить. Нажмите кнопку 'Установить' для продолжения."
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "Компоненты для установки:"
!define MUI_COMPONENTSPAGE_SMALLDESC

!define MUI_TEXT_INSTALLING_TITLE "Копирование файлов и настройка..."
!define MUI_TEXT_INSTALLING_SUBTITLE " "

!define MUI_TEXT_FINISH_INFO_TITLE "$\t   $\n$\tУстановка завершена!"
!define MUI_TEXT_FINISH_INFO_TEXT "Теперь игру можно запустить из Steam. Установка дополнительных обновлений или патчей не требуется и не рекомендуется.$\n$\nПриятной игры!"

BrandingText " "

###################################
##     Страницы  инсталлятора    ##
###################################

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

###################################
##             Языки             ##
###################################

!insertmacro MUI_LANGUAGE "Russian"

###################################
##          Инсталляция          ##
###################################

Section "Основные патчи и обновления" SecMain
	SectionIn RO

	Delete "$INSTDIR\VDFS.dmp"
	Delete "$INSTDIR\System\dinput.dll"
	Delete "$INSTDIR\Data\SystemPack.vdf"
	Delete "$INSTDIR\_work\data\Video\Logo2.bik"

	SetOutPath "$INSTDIR"
	File "vcredist_2010_x86.exe"
	Exec "vcredist_2010_x86.exe /q /norestart"

	SetOutPath "$INSTDIR"
	File "Union.url"

	SetOutPath "$INSTDIR\_work\data\Video"
	File "Logo1.bik"

	SetOutPath "$INSTDIR\Data"
	File "Union.vdf"

	SetOutPath "$INSTDIR\System"
	Rename $INSTDIR\system\Gothic2.exe $INSTDIR\system\GothicMod.exe
	File "Gothic.ini"
	File "Gothic2.exe"
	File "GothicGame.ini"
	File "GothicGame.rtf"
	File "Shw32.dll"
	File "SystemPack.ini"
	File "Union.patch"
	File "vdfs32g.dll"

	SetOutPath "$INSTDIR\System\autorun"
	File "AutoScreenRes.dll"

SectionEnd


Section /o "Поддержка геймпада" SecAdditional_1

	SetOutPath "$INSTDIR\Data\Plugins"
	File "zGamePad.vdf"

SectionEnd


SectionGroup /e "Русификация от Акеллы" Group1

Section "Текст и субтитры" SecAdditional_2

	Delete "$INSTDIR\Data\Textures_multilingual_Jowood.vdf"
	Delete "$INSTDIR\Data\Textures_Addon_Menu_English.vdf"
	Delete "$INSTDIR\Data\Textures_Fonts_Apostroph.vdf"
	Delete "$INSTDIR\_work\data\video\Addon_Title.bik"

	SetOutPath "$INSTDIR\_work\data\scripts\_compiled"
	File "GOTHIC.DAT"
	File "MENU.DAT"

	SetOutPath "$INSTDIR\_work\data\scripts\content\cutscene"
	File "OU.BIN"

	SetOutPath "$INSTDIR\_work\data\Music\NewWorld"
	File "KAS_Loop_DayStd.sgt"

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


Section "Озвучка и видео" SecAdditional_3
	
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
##     Описание компонентов      ##
###################################

LangString DESC_SecMain ${LANG_RUSSIAN} "Основные компоненты сборника (Union 1.0l, vcredist, стартер модов)."
LangString DESC_Group1 ${LANG_RUSSIAN} "Выбор компонентов русификации игры."
LangString DESC_SecAdditional_1 ${LANG_RUSSIAN} "Выберите эту опцию, если хотите играть на геймпаде."
LangString DESC_SecAdditional_2 ${LANG_RUSSIAN} "Выберите эту опцию, если хотите установить русский текст и субтитры от Акеллы."
LangString DESC_SecAdditional_3 ${LANG_RUSSIAN} "Выберите эту опцию, если хотите установить русскую озвучку и видео от Акеллы."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
!insertmacro MUI_DESCRIPTION_TEXT ${Group1} $(DESC_Group1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_1} $(DESC_SecAdditional_1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_2} $(DESC_SecAdditional_2)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_3} $(DESC_SecAdditional_3)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

###################################
##            Функции            ##
###################################

Function .onInit
	SetSilent normal
	StrCpy $DirectoryText "Обнаружена установленная Steam-версия Gothic II: Gold Edition. Нажмите кнопку 'Далее' для продолжения или 'Обзор ...' для выбора другой папки."
	SetRegView 32
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	SetRegView 64
	ReadRegStr $INSTDIR HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 39510" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	InstallPathIsFound:
	IfFileExists "$INSTDIR\System\Gothic2.exe" InstallPathIsGood
	StrCpy $INSTDIR "$PROGRAMFILES\Steam\steamapps\common\Gothic II"
	StrCpy $DirectoryText "Нажмите кнопку 'Обзор ...' и укажите папку, в которой установлена Gothic II: Gold Edition. Как правило, это Steam\steamapps\common\Gothic II.$\n$\nЗатем нажмите кнопку 'Далее' для продолжения."
	InstallPathIsGood:
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\System\Gothic2.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd
