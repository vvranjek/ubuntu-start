#!/bin/bash
# ===================================================================
# zonColor Themes Pack Project - http://www.fandigital.com
# Beautiful themes, your own colors, unlimited!
# -------------------------------------------------------------------
# zonColor Cursor-Theme - Copyright (C) 2012 Zon Saja
# ===================================================================



# VARIABLES

# About script
zcBN=$(basename "$0"); zcDR=$(dirname "$0"); zcFP=$(cd "$zcDR" && pwd);
if (test -z "$zcCaller"); then zcCaller=$(ps ax | grep "^ *$PPID" | awk '{print $NF}'); fi;

# App and Environmment Variables
CurrentSessionName="this desktop";
CanEnableSettings=false;
LxdeSession=false;
LxAppearanceReady=false;
ZenityReady=false; MateDialogReady=false; XmessageReady=false; NotifySendReady=false;
XdgOpenReady=false;

# Input-based variables

# Internal variables
ThemeFolderFP=$(cd "$zcFP/.." && pwd);
ThemeName=$(basename "$ThemeFolderFP");
SourceDir=$(cd "$zcFP/../.." && pwd);
CursorTheme="$ThemeName";
CommonTheme="zoncolor";
UTDName=".icons"; UTDPath="$HOME/$UTDName";
OUTDName=".local/share/icons"; OUTDPath="$HOME/$OUTDName";
STDPath="/usr/share/icons";
TargetDir="$UTDPath";
ResetString="@RESET";



# FUNCTIONS

# Session
CheckSession () {
	if ((pidof "gnome-session" >/dev/null 2>&1) || \
		(pidof "gdm-simple-slave" >/dev/null 2>&1) || \
		(pidof "x-session-manager" >/dev/null 2>&1) || \
		(pidof "gnome-settings-daemon" >/dev/null 2>&1) || \
		(pidof "xfce4-session" >/dev/null 2>&1) || \
		(pidof "mate-session" >/dev/null 2>&1) || \
		(pidof "mate-settings-daemon" >/dev/null 2>&1)
		); then
		CanEnableSettings=true;
	elif (pidof "lxsession" >/dev/null 2>&1); then
		LxdeSession=true;
	fi;
}
EnableInSessionErrorMsg () {
	SessionErrorMsgText=$(printf "Sorry, cannot set/enable settings under $CurrentSessionName session.");
	echo -e "$SessionErrorMsgText";
	#if ($XmessageReady); then xmessage "$SessionErrorMsgText" & sleep 1; fi;
}

# Apps
CheckApps () {
	if (command -v zenity >/dev/null 2>&1); then ZenityReady=true; fi;
	if (command -v matedialog >/dev/null 2>&1); then MateDialogReady=true; fi;
	if ($ZenityReady); then ZorMDapp="zenity"; elif ($MateDialogReady); then ZorMDapp="matedialog"; fi;
	if (command -v xmessage >/dev/null 2>&1); then XmessageReady=true; fi;
	if (command -v notify-send >/dev/null 2>&1); then NotifySendReady=true; fi;
	if (command -v xdg-open >/dev/null 2>&1); then XdgOpenReady=true; fi;
	if (command -v lxappearance >/dev/null 2>&1); then LxAppearanceReady=true; fi;
}

# Folder clean up
CleanUpFolderContent () {
	# Usage: CleanUpFolderContent "<FOLDER>";
	local CurDir=$(pwd);
	cd "$1";
	find . -type d -name "*source*" -exec rm -r {} \+;
	find . -type f -name "*source*" -exec rm {} \+;
	find . -type f -name "*symlink*" -exec rm {} \+;
	find . -type f -name "*.sh" -exec chmod +x {} \+;
	find . -type f -name "*.desktop" -exec chmod +x {} \+;
	cd "$CurDir";
}

# CursorTheme
# UDCT = User's default cursor theme
UDCTDir="$HOME/.local/share/icons/default";
UDCTDirBackup="${UDCTDir}""_zcbackup";
UDCTCommentLine="Comment=zoncolor set";
CreateUDCT () {
	UDCTIndexContent="[Icon Theme]\nInherits=$CursorTheme\n$UDCTCommentLine"
	if ((! grep "$UDCTCommentLine" "$UDCTDir/index.theme" >/dev/null 2>&1) && \
		(! test -d "$UDCTDirBackup")); then
		mv "$UDCTDir" "$UDCTDirBackup" 2>/dev/null;
	fi;
	mkdir -p "$UDCTDir";
	echo -e "$UDCTIndexContent" > "$UDCTDir"/index.theme;
	echo -e "$UDCTIndexContent" > "$UDCTDir"/cursor.theme;
}
RemoveUDCT () {
	if ((grep "$UDCTCommentLine" "$UDCTDir/index.theme" >/dev/null 2>&1) || \
		(test -d "$UDCTDirBackup")); then
		rm -r "$UDCTDir";
	else
		mv "$UDCTDir" "$UDCTDirBackup" 2>/dev/null;
	fi;
}
EnableCursorTheme () {
	CreateUDCT;
	gsettings set org.gnome.desktop.interface cursor-theme "$CursorTheme" >/dev/null 2>&1;
	gsettings set org.mate.peripherals-mouse cursor-theme "$CursorTheme" >/dev/null 2>&1;
	gconftool --type String --set /desktop/gnome/peripherals/mouse/cursor_theme "$CursorTheme" >/dev/null 2>&1;
	gconftool-2 --type String --set /desktop/gnome/peripherals/mouse/cursor_theme "$CursorTheme" >/dev/null 2>&1;
	mateconftool-2 --type String --set /desktop/mate/peripherals/mouse/cursor_theme "$CursorTheme" >/dev/null 2>&1;
	xfconf-query -c xsettings -p /Gtk/CursorThemeName -n -t string -s "$CursorTheme" >/dev/null 2>&1;
}
ResetCursorTheme () {
	RemoveUDCT;
	gsettings reset org.gnome.desktop.interface cursor-theme >/dev/null 2>&1;
	gsettings reset org.mate.peripherals-mouse cursor-theme >/dev/null 2>&1;
	gconftool --unset /desktop/gnome/peripherals/mouse/cursor_theme >/dev/null 2>&1;
	gconftool-2 --unset /desktop/gnome/peripherals/mouse/cursor_theme >/dev/null 2>&1;
	mateconftool-2 --unset /desktop/mate/peripherals/mouse/cursor_theme >/dev/null 2>&1;
	xfconf-query -c xfce4-desktop -p /Gtk/CursorThemeName -r >/dev/null 2>&1;
}

# Install theme if not already
InstallTheme () {
	if ((! test -d "$UTDPath/$1") && \
		(! test -d "$OUTDPath/$1") && \
		(! test -d "$STDPath/$1")
		); then
		mkdir -p "$TargetDir";
		cp -r "$SourceDir/$1" "$TargetDir";
		CleanUpFolderContent "$TargetDir/$1";
		echo "'$1' theme installed.";
	fi;
}

# Create symlink if not already (for backward compatibility)
CreateSymlink () {
	if (! test -L "$TargetDir"); then
		if (! readlink "$OUTDPath" | grep -q "$UTDName"); then
			TimeStamp=$(date -u +%Y%m%d%H%M%S); OUTDBackupName="$OUTDName-backup_$TimeStamp";
			mkdir -p "$TargetDir";
			cp -r "$OUTDPath"/* "$TargetDir" >/dev/null 2>&1;
			mv "$HOME/$OUTDName" "$HOME/$OUTDBackupName" >/dev/null 2>&1;
			ln -s "$TargetDir" "$HOME/$OUTDName";
		fi;
	fi;
}



# EXECUTION

if (test "$1" = "$ResetString"); then
	ResetCursorTheme;
else
	if (! test "$ThemeName" = "$CommonTheme"); then InstallTheme "$CommonTheme"; fi;
	InstallTheme "$ThemeName";
	#CreateSymlink;
	CheckApps;
	CheckSession;
	if (! $CanEnableSettings); then
		if ($LxdeSession); then
			if ($LxAppearanceReady) && (! pidof lxappearance); then
				nohup lxappearance >/dev/null 2>&1 & sleep 1;
			fi;
		else
			EnableInSessionErrorMsg;
		fi;
	fi;
	EnableCursorTheme;
fi;

exit
