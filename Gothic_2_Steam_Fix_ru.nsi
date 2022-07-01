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
!define MOD_VERSION "07.2022"
!define MOD_DETAILED_VERSION "22.7.1.0"
!define MOD_AUTHOR "D36"
!define SCRIPTPATCH_VERSION "28"

Name "${MOD_NAME}"
OutFile "Gothic_2_Steam_Fix_RU_${MOD_VERSION}.exe"

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

Caption "${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TITLE "$\t   $\n$\t${MOD_NAME}"
!define MUI_TEXT_WELCOME_INFO_TEXT "Данный сборник исправлений предназначен для установки на чистую русскую Steam-версию Gothic II: Gold Edition без других патчей и модов.$\n$\nВнимание! Начиная с июля 2022 года в сборник не включается русификация, так как она стала официально доступна в Steam-версии игры. Проверьте свойства игры в библиотеке, чтобы сменить её язык, и после обновления продолжайте установку сборника. Если по какой-то причине вам нужна русификация в составе Gothic 2 Steam Fix, то используйте архив версий на GitHub проекта: https://github.com/dosinabox/g2_steam_fix/releases"

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
	File "Changelog_G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.txt"
	File "Union.url"

	SetOutPath "$INSTDIR\_work\data\Video"
	File "Logo1.bik"

	SetOutPath "$INSTDIR\Data"
	File "Union.vdf"
	File "Fonts_Russian.vdf"

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "scriptpatch_v${SCRIPTPATCH_VERSION}.mod"
	File "scriptpatch_v${SCRIPTPATCH_VERSION}_ru.mod"

	SetOutPath "$INSTDIR\launcher"
	File "d3d11.dll"

	SetOutPath "$INSTDIR\System"
	Rename $INSTDIR\system\Gothic2.exe $INSTDIR\system\GothicMod.exe
	File "Gothic.ini"
	File "Gothic2.exe"
	File "GothicGame.ini"
	File "GothicGame.rtf"
	File "msvcp100.dll"
	File "msvcr100.dll"
	File "Shw32.dll"
	File "SystemPack.ini"
	File "Union.patch"
	File "vdfs32g.dll"
	File "G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.ini"
	File "G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}.rtf"

	SetOutPath "$INSTDIR\System\autorun"
	File "AutoScreenRes.dll"

	SetOutPath "$INSTDIR\_work\data\Music\NewWorld"
	File "KAS_Loop_DayStd.sgt"

	CreateDirectory "$INSTDIR\Saves_G2a_NR_ScriptPatch_v${SCRIPTPATCH_VERSION}\current"

SectionEnd


Section "Дополнительная русская озвучка" SecAdditional_1

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "scriptpatch_v${SCRIPTPATCH_VERSION}_speech_add_ru.mod"

SectionEnd


Section "Исправление русской озвучки" SecAdditional_2

	SetOutPath "$INSTDIR\Data"
	File "Speech_RU_Fix.vdf"

	SetOutPath $INSTDIR
	File "Changelog_Speech.txt"

SectionEnd


Section "Широкоформатный монитор" SecAdditional_3

	SetOutPath "$INSTDIR\Data"
	File "Textures_Russian_Widescreen.vdf"

SectionEnd


Section /o "Расширенная Рудниковая долина" SecAdditional_4

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "scriptpatch_v${SCRIPTPATCH_VERSION}_wasteland.mod"

SectionEnd


Section /o "Поддержка геймпада" SecAdditional_5

	SetOutPath "$INSTDIR\Data\Plugins"
	File "zGamePad.vdf"

SectionEnd


###################################
##     Описание компонентов      ##
###################################

LangString DESC_SecMain ${LANG_RUSSIAN} "Основные компоненты сборника (Union 1.0m, стартер модов, оптимизатор лаунчера)."
LangString DESC_SecAdditional_1 ${LANG_RUSSIAN} "Снимите галочку, если установка производится на версию игры без русской озвучки."
LangString DESC_SecAdditional_2 ${LANG_RUSSIAN} "Неофициальное исправление русской озвучки от Акеллы (версия 1.14)."
LangString DESC_SecAdditional_3 ${LANG_RUSSIAN} "Установка фона главного меню и загрузочных экранов для широкоформатных мониторов."
LangString DESC_SecAdditional_4 ${LANG_RUSSIAN} "Мод Wasteland, расширяющий и заполняющий мир Рудниковой долины до размеров Готики 1."
LangString DESC_SecAdditional_5 ${LANG_RUSSIAN} "Выберите эту опцию, если хотите играть на геймпаде."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_1} $(DESC_SecAdditional_1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_2} $(DESC_SecAdditional_2)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_3} $(DESC_SecAdditional_3)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_4} $(DESC_SecAdditional_4)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_5} $(DESC_SecAdditional_5)
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
