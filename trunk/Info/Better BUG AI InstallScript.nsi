;BTS Install Script
;Written by phungus420, NikNaks, Jean Elcard, and Emperor Fool

;--------------------------------
;Include Modern UI

!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "FileSearch.nsh"

;--------------------------------
;Constants
;These are the variables you need to define for your mod

!define NAME "Better BUG AI" ;Full Name of Mod
!define VERSION "1.00a (2010-05-13)" ;Mod Version Number - reflecting Better BTS AI Version
!define VERSION_VERBOSE "* Better BTS AI 1.00a r557$\n* BULL 1.1+ r178$\n* BUG 4.3 r2212"

!define MOD_LOC "Better BUG AI" ;Name of Mod Folder
!define SHORT_NAME "Better BUG AI" ;Shorthand/nick of your mod

#!define MYBTSDIR "T:\CIV4\Civilization 4\Beyond the Sword" ;Path where your Beyond the Sword .exe is
!define MYCLSDIR "T:\CIV4\Civilization 4\Beyond the Sword\oldmods\Better BUG AI\${MOD_LOC}" ;Path where your mod is (Leave ${MOD_LOC} on the end of the path).  You can remove the above constant (MYBTSDIR) if you aren't compiling the mod from it's normal location

!define RAW_ICON "Info\oxygen_bugbuster.ico"	;place your icon in your mod folder change che_guevara to the icon's name
  
!define URL "http://forums.civfanatics.com/showthread.php?t=354019" ;Web address where you want internet link in the Start Menu shorcut folder to link to


;User Settings are installed sperately. Remember to move these out of the main mod folder when compiling installer
!define SETTINGS_FOLDER "UserSettings" ;Mod's user settings folder

#!define MOD_ADDITION1 "RevDCM Source" ;Name of Add On Folder
#!define ADDON1_TEXT "Installs ${MOD_ADDITION1}.  For Modders interested in the Source Code." ;Text used to describe the add on, keep it short.
#!define MOD_ADDITION2 ;Uncomment text definition below and all references in the code to section3 and MOD_ADDITION2 if you want your installer to install a second add on.
#!define ADDON2_TEXT "Installs ${MOD_ADDITION2} as an optional add on."

#!define MYFILESDIR "C:\Documents and Settings\P\My Documents\My Games\Beyond the Sword" ;Root Location where non main mod folders are found
;Notice that the constants below all reference MYFILESDIR.  This is not necessary, you can put your add ons wherever you want, I just do this to keep things organized
!define SETTINGS_LOC "T:\CIV4\Civilization 4\Beyond the Sword\oldmods\Better BUG AI\${SETTINGS_FOLDER}" ;Location of the UserSettings folder for you mod
#!define ADDITION1_LOC "${MYCLSDIR}\AddOns\${MOD_ADDITION1}" ;Location of Add On 1
#!define ADDITION2_LOC "${MYFILESDIR}\AddOns\${MOD_ADDITION2}" ;Uncomment if you are adding a second add on
 
;You should not need to change anything below this line
;-----------------------------------------
!define CIV_EXE_FILE "Civ4BeyondSword.exe"
!define CIV_INI_FILE "CivilizationIV.ini"
!define ICON "${MYCLSDIR}\${RAW_ICON}" 
!define MUI_ICON "${ICON}"
  
;Registry Constants
!define MACHINE_REG_ROOT "HKLM"
!define USER_REG_ROOT "HKCU"
!define LONG_HKLM "HKEY_LOCAL_MACHINE"
!define LONG_HKCU "HKEY_CURRENT_USER"
!define FIRAXIS "Firaxis Games"
!define FIRAXIS_REG_KEY "Software\${FIRAXIS}"
!define BTS "Beyond the Sword"
!define BTSREG_STANDARD "Sid Meier's Civilization 4 - ${BTS}"
!define BTS_SHORT "BtS"
!define BTS_VERSION "3.19"
!define COMPLETE_REG "Sid Meier's Civilization 4 Complete"
!define GOLD_REG "Sid Meier's Civilization 4 Gold"
!define GLOBAL_DEFINES "Assets\XML\GlobalDefines.xml"
!define GD_VERSION "<iDefineIntVal>319</iDefineIntVal>"
  
;CurrentVersion variable values
!define UNKNOWN "unkown"
!define NULL "null"

;--------------------------------
;General

;Name and file

Name "${NAME}"
!ifdef ICON
Icon "${ICON}"
!endif
OutFile "${NAME} ${VERSION} Setup.exe" 

;Default installation folder
InstallDir ""

;Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------
;Custom Varaiables

Var INSTDIR1 ;Install directory
Var StartMenuFolder ;Needed for the StartMenuShortcut creation, also stores default location where start menu shortcut should be created (firaxis games/${MOD_LOC})
Var CivRootDir ;Used for locating the My Documents path where Civ4 is, and the BtS ini file
Var CurrentVersion ;used to verify the version of BtS is up to date (version 3.19)
Var WelcomePageText ;Used to store the Welcome page text
Var DirectoryPageText ;Used to store the directory page text
  
Var CurrentPage ;important for directory verification
  
;-------------------------------------------------------


;Search Registry and find a valid BtS install directory
Function findINSTDIR1

	Push $0

	#look for standard Civ4:BTS install (local machine registry)
	ReadRegStr $0 ${MACHINE_REG_ROOT} "${FIRAXIS_REG_KEY}\${BTSREG_STANDARD}" 'INSTALLDIR'
	

	${If} ${FileExists} $0
		StrCpy $INSTDIR1 $0
		${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
			Push $INSTDIR1\${GLOBAL_DEFINES}
			Push ${GD_VERSION}
			Call FileSearch
			Pop $0
			Pop $1
			${If} $0 > "0"
				StrCpy $CurrentVersion "true"
				Goto done
			${Else}
				StrCpy $CurrentVersion "false"
				Goto done
			${EndIf}
		${Else}
			StrCpy $CurrentVersion "${UNKNOWN}"
			Goto done
		${EndIf}
	${EndIf}

	#Try Standard BtS install, but look in the Current User Registry
	ReadRegStr $0 ${USER_REG_ROOT} "${FIRAXIS_REG_KEY}\${BTSREG_STANDARD}" 'INSTALLDIR'
	${If} ${FileExists} $0
		StrCpy $INSTDIR1 $0
		${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
			Push $INSTDIR1\${GLOBAL_DEFINES}
			Push ${GD_VERSION}
			Call FileSearch
			Pop $0
			Pop $1
			${If} $0 > "0"
				StrCpy $CurrentVersion "true"
				Goto done
			${Else}
				StrCpy $CurrentVersion "false"
				Goto done
			${EndIf}
		${Else}
			StrCpy $CurrentVersion "${UNKNOWN}"
			Goto done
		${EndIf}
	${EndIf}
	
	# Civ4 Complete (local machine registry check)
	ReadRegStr $0 ${MACHINE_REG_ROOT} "${FIRAXIS_REG_KEY}\${COMPLETE_REG}" 'INSTALLDIR'
	${If} ${FileExists} $0
		StrCpy $0 "$0\${BTS}"
		${If} ${FileExists} $0
			StrCpy $INSTDIR1 $0
			${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
				Push $INSTDIR1\${GLOBAL_DEFINES}
				Push ${GD_VERSION}
				Call FileSearch
				Pop $0
				Pop $1
				${If} $0 > "0"
					StrCpy $CurrentVersion "true"
					Goto done
				${Else}
					StrCpy $CurrentVersion "false"
					Goto done
				${EndIf}
			${Else}
				StrCpy $CurrentVersion "${UNKNOWN}"
				Goto done
			${EndIf}
		${EndIf}
	${EndIf}

	# Civ4 Complete (Current User registry check)
	ReadRegStr $0 ${USER_REG_ROOT} "${FIRAXIS_REG_KEY}\${COMPLETE_REG}" 'INSTALLDIR'
	${If} ${FileExists} $0
		StrCpy $0 "$0\${BTS}"
		${If} ${FileExists} $0
			StrCpy $INSTDIR1 $0
			${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
				Push $INSTDIR1\${GLOBAL_DEFINES}
				Push ${GD_VERSION}
				Call FileSearch
				Pop $0
				Pop $1
				${If} $0 > "0"
					StrCpy $CurrentVersion "true"
					Goto done
				${Else}
					StrCpy $CurrentVersion "false"
					Goto done
				${EndIf}
			${Else}
				StrCpy $CurrentVersion "${UNKNOWN}"
				Goto done
			${EndIf}
		${EndIf}
	${EndIf}

	# Civ4 Gold (Local machine registry check)
	ReadRegStr $0 ${MACHINE_REG_ROOT} "${FIRAXIS_REG_KEY}\${GOLD_REG}" 'INSTALLDIR'
	${If} ${FileExists} $0
		StrCpy $0 "$0\${BTS}"
		${If} ${FileExists} $0
			StrCpy $INSTDIR1 $0
			${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
				Push $INSTDIR1\${GLOBAL_DEFINES}
				Push ${GD_VERSION}
				Call FileSearch
				Pop $0
				Pop $1
				${If} $0 > "0"
					StrCpy $CurrentVersion "true"
					Goto done
				${Else}
					StrCpy $CurrentVersion "false"
					Goto done
				${EndIf}
			${Else}
				StrCpy $CurrentVersion "${UNKNOWN}"
				Goto done
			${EndIf}
		${EndIf}
	${EndIf}

	# Civ4 Gold (current user registry check)
	ReadRegStr $0 ${USER_REG_ROOT} "${FIRAXIS_REG_KEY}\${GOLD_REG}" 'INSTALLDIR'
	${If} ${FileExists} $0
		StrCpy $0 "$0\${BTS}"
		${If} ${FileExists} $0
			StrCpy $INSTDIR1 $0
			${If} ${FileExists} "$INSTDIR1\${GLOBAL_DEFINES}"
				Push $INSTDIR1\${GLOBAL_DEFINES}
				Push ${GD_VERSION}
				Call FileSearch
				Pop $0
				Pop $1
				${If} $0 > "0"
					StrCpy $CurrentVersion "true"
					Goto done
				${Else}
					StrCpy $CurrentVersion "false"
					Goto done
				${EndIf}
			${Else}
				StrCpy $CurrentVersion "${UNKNOWN}"
				Goto done
			${EndIf}
		${EndIf}
	${EndIf}
	
	;No BtS registry found, give CurrentVersion a null value (allows installation to continue, but warns User BtS was not found on the computer)
	StrCpy $CurrentVersion "${NULL}"
	Goto done

	done:
		Pop $0
FunctionEnd


;Look for valid BtS folder in My Documents Path
Function findCivRootDir
	Call findINSTDIR1

	Push $0
	
	Push $R0
	Push $R1
	
	ReadRegStr $R0 HKLM \
	"SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
	StrCpy $R1 $R0 1
	IntCmp $R1 6 lbl_winnt_vista_7 lbl_winnt_xp lbl_winnt_vista_7
	
	#Invalid command? wtf
	#${VersionCompare} $R0 "6.0" $R1
	#IntCmp $R1 2 lbl_winnt_xp lbl_winnt_vista_7
	
	lbl_winnt_xp:
	StrCpy $0 "$INSTDIR1\Mods\${MOD_LOC}"
	StrCpy $CivRootDir $0
	Goto civRootDirEnd
	
	lbl_winnt_vista_7:
	
	# locate the Civ4:BTS INI folder
	StrCpy $0 "$DOCUMENTS\My Games\${BTS}"
	${If} ${FileExists} "$0\${CIV_INI_FILE}"
		StrCpy $CivRootDir "$0\BUG Mod"
	${Else}
		;Civ4 config not found, use My Games folder instead, as BUG searches here, if this folder exists
		StrCpy $0 "$DOCUMENTS\My Games"
		${If} ${FileExists} $0
			StrCpy $CivRootDir "$0\BUG Mod"
		;Neither a valid BtS or My Games folder found in the users My Documents directory, UserSettings folder will be installed into the main mod's folder
		${Else}
			StrCpy $0 "$INSTDIR1\Mods\${MOD_LOC}"
			StrCpy $CivRootDir $0
		${EndIf}
	${EndIf}
	
	civRootDirEnd:
	Pop $0
	Pop $R0
FunctionEnd

 
;Depending on Registry checks, set welcome text
Function setWelcomePageText
	Call findINSTDIR1

	${If} $CurrentVersion == "true" ;BtS found and everything apears normal
		StrCpy $WelcomePageText "This wizard will guide you through the installation of \
		${NAME} (${VERSION}),  $\n$\n\
		consisting of: $\n\
		${VERSION_VERBOSE} $\n$\n\
		Please ensure that Civilization 4 is not running while installing, \
		otherwise the installation may not work as expected.  $\n$\n\
		Click $\"Next$\" to continue."
	${ElseIf} $CurrentVersion == "${UNKNOWN}" ;BtS directory found, but setup could not figure out the version
		StrCpy $WelcomePageText "This wizard will guide you through the installation of \
		${NAME} (${VERSION}).  $\n$\n\
		Autodetection found a Civilization IV registry, \
		but could not find a Global Defines file in the  ${BTS_SHORT} directory.  \
		Setup could not verify the ${BTS_SHORT} version or the install path.  \
		${NAME} requires that ${BTS_SHORT} be updated to version ${BTS_VERSION}, \
		attempting to launch ${SHORT_NAME} on a non updated version \
		will result in an immediate crash to desktop.  $\n$\n\
		The ${BTS_SHORT} ${BTS_VERSION} patch can be downloaded easily from the downloads section \
		of the civfanatics website (www.civfanatics.com).  \
		The patch is also simple to find by using Google, or other internet search engine.  $\n$\n\
		Click $\"Next$\" to continue"
	${ElseIf} $CurrentVersion == "${NULL}" ;No BtS installation found on the computer
		StrCpy $WelcomePageText "This wizard will guide you through the installation of \
		${NAME} (${VERSION}).  $\n$\n\
		Autodetection has completely failed to locate a valid Civilization 4 registry; \
		so you will need to manually set some items that the installer would normally handle automatically.  \
		${NAME} requires that ${BTS} be updated to version ${BTS_VERSION}, \
		attempting to launch ${SHORT_NAME} on a non updated version \
		will result in an immediate crash to desktop.  \
		The ${BTS_SHORT} ${BTS_VERSION} patch can be downloaded easily from the downloads section \
		of the civfanatics website (www.civfanatics.com).  \
		The patch is also simple to find by using Google, or other internet search engine.  $\n$\n\
		Click $\"Next$\" to continue"
	${Else} ;This shouldn't happen
		StrCpy $WelcomePageText "An unexpected error has occured!!!"
	${EndIf}
FunctionEnd


;Depending on Registry checks, set instructions
Function setDirectoryPageText
	Call findINSTDIR1

	${If} $CurrentVersion == "true" ;BtS is updated to 3.19, everything is gravy
		StrCpy $DirectoryPageText "Autodetection successfully located a ${BTS} registry, \
		and a Global Defines entry indictation ${BTS} has been properly updated to ${BTS_VERSION}.  \
		Setup has used the registry key to automatically set the installation path for ${MOD_LOC}, \
		and will install ${NAME} in the Mods folder of the folder below. $\n$\n\
		Simply click $\"Next$\" to begin installation."
	${ElseIf} $CurrentVersion == "${UNKNOWN}" ;Can't tell if BtS is updated to 3.19
		StrCpy $DirectoryPageText "Setup will install ${MOD_LOC} in the mods folder of the directory below.  $\n\
		Autodetection could not locate the ${BTS_SHORT} Global Defines file.  \
		To verify the install path is correct, \
		a ${BTS_SHORT}.exe must be present in the install directory.  \
		${NAME} requires that ${BTS_SHORT} be updated to version ${BTS_VERSION}, \
		attempting to launch ${SHORT_NAME} on a non updated version \
		will result in an immediate crash to desktop.  $\n$\n\
		Click $\"Next$\" to begin installation."
	${ElseIf} $CurrentVersion == "${NULL}" ;Setup could not find BtS, user must manually set everything
		StrCpy $DirectoryPageText "Autodetection failed to detect a valid Civilization 4 registry, \
		so you will need to manually set the install path in the line below.  \
		Setup will install ${NAME} in the Mods folder of the directory you set.  \
		To verify that the install path is correct, \
		Setup will also check for the existence of the ${BTS_SHORT}.exe.  \
		If Setup does not detect the ${BTS_SHORT}.exe in your selected install path, \
		it will not allow installation to continue.  \
		${NAME} requires that ${BTS_SHORT} be updated to version ${BTS_VERSION}, \
		attempting to launch ${SHORT_NAME} on a non updated version \
		will result in an immediate crash to desktop.  \
		Click $\"Next$\" to begin installation."
	${Else} ;This shouldn't happen
		StrCpy $DirectoryPageText "An unexpected error has occured!!!"
	${EndIf}
FunctionEnd


;--------------------------------
;Initialize Installer
  
Function .onInit
	Call findINSTDIR1
	Call findCivRootDir
	Call setDirectoryPageText
	Call setWelcomePageText
	Call preStartMenu

	StrCpy $INSTDIR "$INSTDIR1"

	${If} $CurrentVersion == "false" ;Registry Check succeded, but BtS is not updated to the current BtS version
		;Cancel installation and tell user to update BtS and run the installer again
		MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
		"The installer has detected a ${BTS} registry key; \
		however it has also found that ${BTS} has not been updated to version ${BTS_VERSION}.  $\n$\n\
		The ${BTS_SHORT} ${BTS_VERSION} patch can be downloaded directly from:  $\n\
		http://www.firaxis.com/downloads/Patch/Civ4BeyondTheSwordPatch3.19.exe  $\n\
		The patch is also easy to find by simply searching with Google, or other internet search engine.  $\n$\n\
		${NAME} requires that ${BTS} be updated to the current official version of ${BTS_VERSION}.  \
		Please update your copy of ${BTS_SHORT} to ${BTS_VERSION}, and then run this installer again.  $\n$\n\
		The installation of ${SHORT_NAME} will now abort." \
		IDOK quit
		Abort
		
		quit:
		Abort

	${Else}	;BtS is either updated to the current version, or the registry check failed
		${If} $CivRootDir == "$INSTDIR1\Mods\${MOD_LOC}"		;No valid UserSettings install location was found, tell user the subsequent issues (will need to launch as an administrator)
			IntCmp $R1 6 0 continue 0
			MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
			"Setup will install the UserSettings folder in the main ${NAME} install directory.  $\n$\n\
			If ${MOD_LOC} is installed in the Program Files directory (default ${BTS} installation), \
			and you are using Vista or Windows 7, you will need to launch ${SHORT_NAME} as an administrator.  \
			This is because the UI stores user settings \
			in .ini files which are saved and altered as per your preferences.  \
			Vista and Windows 7 only allow .ini files to be altered in the program files directory \
			if the aplication has admin rights.  $\n$\n\
			To launch ${NAME} as an adminstrator, right click on the lauch shortcut(s) for ${SHORT_NAME}, \
			which Setup will create and select $\"Launch as Admin$\"." \
			IDOK continue
			Abort
		${EndIf}

	;Check to see if the mod is already installed
	continue:
	;Check and remove shortcuts in main program files directory if any exist
		${If} ${FileExists} "$SMPROGRAMS\${NAME}.lnk"
			DeleteRegKey ${LONG_HKCU} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}StartMenu"
			Delete "$SMPROGRAMS\${NAME}.lnk"
			Delete "$SMPROGRAMS\${SHORT_NAME} Info.url"
			Delete "$SMPROGRAMS\Uninstall.lnk"
		${EndIf}

		ReadRegStr $R0 ${MACHINE_REG_ROOT} \
		"Software\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}" \
		"UninstallString"
		
		#Just overwrite if the mod is already installed
		Goto done
		
		StrCmp $R0 "" done

		MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
		"${NAME} is already installed. $\n$\nDo you wish to uninstall?" \
		IDOK uninst
		Abort

		;Run the uninstaller if you find a Registry Key for the mod
		uninst:
		ClearErrors
		ExecWait '"$INSTDIR\Mods\${MOD_LOC}\Uninstall.exe" _?=$INSTDIR'
		Delete "$INSTDIR\Mods\${MOD_LOC}\Uninstall.exe"
	${EndIf}

	done:
FunctionEnd

;--------------------------------
;Interface Settings

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE

ShowInstDetails show
ShowUninstDetails show

;--------------------------------
;Pages

!define MUI_CUSTOMFUNCTION_GUIINIT myOnGUIInit

; INSTALLER PAGES:

!define MUI_WELCOMEPAGE_TITLE "Welcome to the Setup of ${SHORT_NAME} (${VERSION})"
!define MUI_WELCOMEPAGE_TEXT $WelcomePageText
	
!insertmacro MUI_PAGE_WELCOME

!define MUI_COMPONENTSPAGE_SMALLDESC
!insertmacro MUI_PAGE_COMPONENTS

!define MUI_DIRECTORYPAGE_VARIABLE $INSTDIR1
!define MUI_PAGE_CUSTOMFUNCTION_PRE onInitDirectoryPage1
!define MUI_PAGE_HEADER_TEXT "${SHORT_NAME} (${VERSION})"
!define MUI_PAGE_HEADER_SUBTEXT "Please locate your $\"${BTS}$\" folder"
!define MUI_DIRECTORYPAGE_TEXT_TOP $DirectoryPageText
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION "Your $\"${BTS}$\" folder:"
!insertmacro MUI_PAGE_DIRECTORY
  
;Setup all the Start Menu Shortcut selection stuff
Page custom StartMenuShortcut
!define MUI_PAGE_CUSTOMFUNCTION_PRE preStartMenu
!define MUI_STARTMENUPAGE_DEFAULTFOLDER $StartMenuFolder
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR1\Civ4BeyondSword.exe"
	!define MUI_FINISHPAGE_RUN_PARAMETERS "mod=$\"${MOD_LOC}$\""
	!define MUI_FINISHPAGE_RUN_NOTCHECKED
!insertmacro MUI_PAGE_FINISH

;UN INSTALLER PAGES:

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages (Currently the installer is only in English)

!insertmacro MUI_LANGUAGE "English"

LangString DESC_Section1 ${LANG_ENGLISH} "Installs ${NAME} for ${BTS}."
#LangString DESC_Section2 ${LANG_ENGLISH} "${ADDON1_TEXT}"
#LangString DESC_Section3 ${LANG_ENGLISH} "${ADDON2_TEXT}" ;uncomment if you are adding a second add on
LangString DESC_Section4 ${LANG_ENGLISH} "Start Menu Shortcut Setup"
LangString DESC_Section5 ${LANG_ENGLISH} "Creates a shortcut on the Desktop, allowing you to launch the mod \
										without the need to load BtS first."
LangString DESC_Section6 ${LANG_ENGLISH} "Creates a shortcut on the Quick Launch bar, allowing you to launch \
										the mod directly from the task bar."

;--------------------------------
;Installer Sections	

;the mod files itself:
Section /o "${MOD_LOC}" Section1
	SectionIn RO ;Locks selection
	${If} ${FileExists} "$INSTDIR1\Mods\${MOD_LOC}\Assets\Python"
		MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
			"Setup has detected an existing Python folder in $INSTDIR1\Mods\${MOD_LOC}\Assets\ $\n\
			and will now proceed to delete its contents to avoid problems with leftover python modules from earlier versions." \
		IDOK continue
		Abort
		continue:
		RMDir /r "$INSTDIR1\Mods\${MOD_LOC}\Assets\Python"
	${EndIf}
	SetOutPath "$INSTDIR1\Mods\${MOD_LOC}" ;${MOD_LOC} is used so that the intall directory only pertains to the Mod's folder (essential for uninstalling and patching, etc)
	File /r "${MYCLSDIR}\*.*" ;*.* is used because the contents, and not the main folder of the install is installed, because as stated above the mod's folder itself is the install directory
	WriteINIStr "$INSTDIR1\Mods\${MOD_LOC}\${SHORT_NAME} Info.url" "InternetShortcut" "URL" "${URL}"

	; write uninstall information to the registry
	WriteRegStr ${MACHINE_REG_ROOT} "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}" "DisplayName" "${NAME}"
	WriteRegStr ${MACHINE_REG_ROOT} "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}" "UninstallString" "$INSTDIR1\Mods\${MOD_LOC}\Uninstall.exe"
	WriteRegStr ${MACHINE_REG_ROOT} "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}" "ModInstDir" "$INSTDIR1\Mods\${MOD_LOC}"
	WriteUninstaller "$INSTDIR1\Mods\${MOD_LOC}\Uninstall.exe"

	; Install UserSettings folder outside Program Files directory
	${If} ${FileExists} "$CivRootDir\${SETTINGS_FOLDER}"
		# don't overwrite if userSettings already exist
	${Else}
		SetOutPath "$CivRootDir"
		File /r "${SETTINGS_LOC}"
	${EndIf}
	WriteRegStr ${USER_REG_ROOT} "Software\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}UserSettings" "UserSettings" "$CivRootDir"

SectionEnd


;Installs Add On MOD_ADDITION1
#Section /o "${MOD_ADDITION1}" Section2
#	SetOutPath "$INSTDIR1\Mods\${MOD_LOC}"
#	File /r "${ADDITION1_LOC}"
#SectionEnd


;Installs Add On MOD_ADDITION2, Uncoment sction if you are adding a second add on to your installer
#Section /o "${MOD_ADDITION2}" Section3
#	SetOutPath "$INSTDIR1\Mods\${MOD_LOC}"
#	File /r "${ADDITION2_LOC}\*.*" ;The \*.* indicates only the contents of the folder will be installed.  Remove the *.* if you want the add on installed inside it's folder.
#SectionEnd


;Start Menu stuff
Section "Start Menu Shortcut" Section4
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
	Call preStartMenu
	CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
	CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${NAME}.lnk" "$INSTDIR1\Civ4BeyondSword.exe" "mod=$\"${MOD_LOC}$\"" # "$INSTDIR\Mods\${MOD_LOC}\${RAW_ICON}" 0
	WriteINIStr "$SMPROGRAMS\$StartMenuFolder\${SHORT_NAME} Info.url" "InternetShortcut" "URL" "${URL}"
	CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR1\Mods\${MOD_LOC}\Uninstall.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
	WriteRegStr ${USER_REG_ROOT} "Software\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}StartMenu" "StartMenuFolder" "$SMPROGRAMS\$StartMenuFolder"
SectionEnd


;Desktop shortcut
Section "Desktop Shortcut" Section5
	CreateShortCut "$DESKTOP\${NAME}.lnk" "$INSTDIR1\Civ4BeyondSword.exe" "mod=$\"${MOD_LOC}$\"" # "$INSTDIR\Mods\${MOD_LOC}\${RAW_ICON}" 0
SectionEnd


;Quick Launch shortcut
Section "Quick Launch Shortcut" Section6
	CreateShortCut "$QUICKLAUNCH\${SHORT_NAME}.lnk" "$INSTDIR1\Civ4BeyondSword.exe" "mod=$\"${MOD_LOC}$\"" # "$INSTDIR\Mods\${MOD_LOC}\${RAW_ICON}" 0
SectionEnd


;--------------------------------
;Place descriptions of Installation items
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section1}  $(DESC_Section1)
	#!insertmacro MUI_DESCRIPTION_TEXT ${Section2}  $(DESC_Section2)
	#!insertmacro MUI_DESCRIPTION_TEXT ${Section3}  $(DESC_Section3) ;Uncomment if you are adding a second add on
	!insertmacro MUI_DESCRIPTION_TEXT ${Section4}  $(DESC_Section4)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section5}  $(DESC_Section5)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section6}  $(DESC_Section6)
!insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;Uninstaller Section
  
;Initialize the Uninstaller
Function un.onInit

	;get mod install paths from the registy
	ReadRegStr $0 ${LONG_HKLM} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}" "ModInstDir" ;Main mod install directory
	ReadRegStr $R1 ${LONG_HKCU} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}StartMenu" "StartMenuFolder" ;Start menu shortcuts folder
	ReadRegStr $R2 ${LONG_HKCU} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}UserSettings" "UserSettings" ;User Settings folder
FunctionEnd


Section "-un.StartMenu" SecUnStartMenu
	;Delete Start Menu Shortcut
	RMDir /r "$R1"
	RMDir "$R1"
SectionEnd


Section "-un.UserSettings" SecUnUserSettings
	;Delete UserSettings
	RMDir /r "$R2"
	RMDir "$R2"
SectionEnd


Section "un.Core" SecUnCore
	;Delete everything in the Mod folder
	RMDir /r "$0\*.*"
	;Remove the installation directory
	RMDir "$0"
	;Delete Desktop Shortcut
	Delete "$DESKTOP\${NAME}.lnk"
	;Delete Quicklaunch Shortcut
	Delete "$QUICKLAUNCH\${SHORT_NAME}.lnk"
SectionEnd


;Remove the Registry Keys
Section "-un.Registry" SecUnRegistry
	DeleteRegKey ${LONG_HKLM} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_LOC}"
	DeleteRegKey ${LONG_HKCU} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}StartMenu"
	DeleteRegKey ${LONG_HKCU} "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${SHORT_NAME}UserSettings"
SectionEnd


;Delete yourself Uninstaller
Section "-un.Uninstaller" SecUnUninstaller
	Delete "$0\Uninstall.exe"
SectionEnd


;--------------------------------
;Installer Functions


;Don't launch the Start Menu Shortcut Setup if it's not selected
Function preStartMenu

	${Unless} ${SectionIsSelected} ${Section4}
		Abort
	${EndUnless}
	Push $0
	StrCpy $0 "$SMPROGRAMS\${FIRAXIS}"
	${If} ${FileExists} $0
		StrCpy $0 "${FIRAXIS}\${NAME}"
		StrCpy $StartMenuFolder $0
	${Else}
		StrCpy $0 "${NAME}"
		StrCpy $StartMenuFolder $0
	${EndIf}
	Pop $0
FunctionEnd


;Sets the section1 install (which is locked by the RO flag in it's section) to True, so that section1 is always installed
Function myOnGUIInit
	SectionGetFlags ${Section1} $0
	IntOp $R0 $0 | ${SF_SELECTED}
	SectionSetFlags ${Section1} $R0
FunctionEnd


;Don't allow installation if the BtS.exe isn't found
Function .onVerifyInstDir

	StrCmp $CurrentPage "DirectoryPage1" check1 valid
	check1:
		IfFileExists "$INSTDIR1\${CIV_EXE_FILE}" valid invalid
	valid:
		Return
	invalid:
		Abort
FunctionEnd


;Organize the Initialization, and setup what to do if the Civilization Registry is or isn't found
Function onInitDirectoryPage1
	
	StrCpy $CurrentPage "DirectoryPage1"
	;Section 1 selected?
	SectionGetFlags ${Section1} $0
	IntOp $R0 $0 & ${SF_SELECTED}
	IntCmp $R0 ${SF_SELECTED} checkRegEntry
		Abort ;skip page
	checkRegEntry:
		StrCmp $INSTDIR "" 0 checkDefaultLocation
		StrCpy $INSTDIR1 "" ;we know nothing
		Return
	checkDefaultLocation:
		StrCpy $INSTDIR1 "$INSTDIR" ;found it!
FunctionEnd


;Rocking Code, needed for StartMenuShortcut to work
Function StartMenuShortcut
  
	Abort
FunctionEnd