/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Matt Vogt <matthew.vogt@jollamobile.com>
** All rights reserved.
** 
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
** 
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: palettePage

    QtObject {
        id: colorChoices

        property var colors: [
            "#e60003", "#e6007c", "#e700cc", "#9d00e7",
            "#7b00e6", "#5d00e5", "#0077e7", "#01a9e7",
            "#00cce7", "#00e696", "#00e600", "#99e600",
            "#e3e601", "#e5bc00", "#e78601"].map(function(color) { return Theme.rgba(color, 1.0) })

        property var primaryColor: [
            "#000000", "#111111", "#222222", "#333333",
            "#444444", "#555555", "#666666", "#777777",
            "#999999", "#aaaaaa", "#bbbbbb", "#cccccc",
            "#dddddd", "#eeeeee", "#ffffff"].map(function(color) { return Theme.rgba(color, 1.0) })
        property var secondaryColor: primaryColor.map(function(color) { return Theme.rgba(color, 1.0) })
        property var highlightColor: colors
        property var secondaryHighlightColor: colors
        property var highlightBackgroundColor: colors
        property var highlightDimmerColor: colors
        property var overlayBackgroundColor: primaryColor
        property var backgroundGlowColor: [ Theme.rgba("#000000", 0.0) ].concat(colors)
        property var errorColor: colors
    }

    QtObject {
        id: transforms

        function invert(color) {
            return Qt.rgba(1 - color.r, 1 - color.g, 1 - color.b, color.a)
        }

        function invertLightColors(color) {
            return palettePage.palette.colorScheme === Theme.DarkOnLight ? invert(color) : color
        }

        property var primaryColor: function(color) { return invertLightColors(color) }
        property var secondaryColor: function(color) { return invertLightColors(color) }
        property var highlightColor: function(color) { return Theme.highlightFromColor(color, palettePage.palette.colorScheme) }
        property var secondaryHighlightColor: function(color) { return Theme.secondaryHighlightFromColor(color, palettePage.palette.colorScheme) }
        property var highlightBackgroundColor: function(color) { return Theme.highlightBackgroundFromColor(color, palettePage.palette.colorScheme) }
        property var highlightDimmerColor: function(color) { return Theme.highlightDimmerFromColor(color, palettePage.palette.colorScheme) }
        property var overlayBackgroundColor: function(color) { return invertLightColors(color) }
        property var backgroundGlowColor: function(color) {
            return !Qt.colorEqual(color, "#00000000")
                    ? Theme.highlightFromColor(color, palettePage.palette.colorScheme)
                    : color
        }
        property var errorColor: function(color) { return color }
    }

    Rectangle {
        id: solidBackground
        anchors.fill: parent
        visible: palettePage.palette.colorScheme !== Theme.colorScheme
        color: transforms.invert(palettePage.palette.primaryColor)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {
            MenuItem {
                text: "Reset"
                onClicked: {
                    palettePage.palette.colorScheme = undefined
                    palettePage.palette.primaryColor = undefined
                    palettePage.palette.secondaryColor = undefined
                    palettePage.palette.highlightColor = undefined
                    palettePage.palette.secondaryHighlightColor = undefined
                    palettePage.palette.highlightBackgroundColor = undefined
                    palettePage.palette.highlightDimmerColor = undefined
                    palettePage.palette.overlayBackgroundColor = undefined
                    palettePage.palette.backgroundGlowColor = undefined
                    palettePage.palette.errorColor = undefined
                }
            }
        }

        VerticalScrollDecorator {}
        Column {
            id: column
            width: parent.width

            PageHeader { title: "Palette" }

            ComboBox {
                label: "Color scheme"
                currentIndex: palettePage.colorScheme + 1
                menu: ContextMenu {
                    MenuItem {
                        text: "Theme"
                        onClicked: palettePage.palette.colorScheme = undefined
                    }
                    MenuItem {
                        text: "Light on dark"
                        onClicked: palettePage.palette.colorScheme = Theme.LightOnDark
                    }
                    MenuItem {
                        text: "Dark on light"
                        onClicked: palettePage.palette.colorScheme = Theme.DarkOnLight
                    }
                }
            }

            ComboBox {
                label: "Background"

                menu: ContextMenu {
                    MenuItem {
                        text: "Constrasting"
                        onClicked: solidBackground.visible = Qt.binding(function() { return palettePage.palette.colorScheme !== Theme.colorScheme })
                    }
                    MenuItem {
                        text: "Solid"
                        onClicked: solidBackground.visible = true
                    }
                    MenuItem {
                        text: "Application"
                        onClicked: solidBackground.visible = false
                    }
                }
            }

            SectionHeader {
                text: "Colors"
            }

            Repeater {
                model: ListModel {
                    ListElement { name: "Primary"; property: "primaryColor" }
                    ListElement { name: "Secondary"; property: "secondaryColor" }
                    ListElement { name: "Highlight"; property: "highlightColor" }
                    ListElement { name: "Secondary Highlight"; property: "secondaryHighlightColor" }
                    ListElement { name: "Highlight Background"; property: "highlightBackgroundColor" }
                    ListElement { name: "Highlight Dimmer"; property: "highlightDimmerColor" }
                    ListElement { name: "Overlay Background"; property: "overlayBackgroundColor" }
                    ListElement { name: "Background Glow"; property: "backgroundGlowColor" }
                    ListElement { name: "Error"; property: "errorColor" }
                }
                delegate: ListItem {

                    onClicked: {
                        var obj = pageStack.animatorPush("Sailfish.Silica.ColorPickerPage", {
                            color: palettePage.palette[property],
                            colors: colorChoices[property].map(transforms[property])

                        })
                        obj.pageCompleted.connect(function(page) {
                            page.colorClicked.connect(function(color) {
                                color = transforms[property](color)
                                palettePage.palette[property] = Qt.binding(function() {
                                    return transforms[property](color)
                                })
                                pageStack.pop()
                            })
                        })
                    }

                    menu: ContextMenu {
                        MenuItem {
                            text: "Reset"
                            onClicked: palettePage.palette[property] = undefined
                        }
                    }

                    Rectangle {
                        id: colorIndicator

                        x: Theme.horizontalPageMargin
                        width: height
                        height: parent.height
                        color: palettePage.palette[property]
                    }
                    Label {
                        x: colorIndicator.x + colorIndicator.width + Theme.paddingMedium

                        width: parent.width - x - Theme.horizontalPageMargin
                        height: parent.height

                        text: name
                        verticalAlignment: Text.AlignVCenter
                    }

                }
            }

            SectionHeader {
                text: "Buttons"
            }
            Column {
                width: parent.width
                spacing: Theme.paddingMedium
                Row {
                    id: iconButtons
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter
                    property bool playing
                    IconButton {
                        icon.source: "image://theme/icon-l-clear"
                    }
                    IconButton {
                        id: pause
                        icon.source: "image://theme/icon-l-pause"
                        onClicked: iconButtons.playing = false
                        enabled: iconButtons.playing
                    }
                    IconButton {
                        id: play
                        icon.source: "image://theme/icon-l-play"
                        onClicked: iconButtons.playing = true
                        enabled: !iconButtons.playing
                    }
                }
                ButtonLayout {
                    Button {
                        text: "Call"
                    }
                    Button {
                        text: "SMS"
                    }
                }
                Row {
                    spacing: Theme.itemSizeSmall
                    anchors.horizontalCenter: parent.horizontalCenter
                    Switch {
                        icon.source: "image://theme/icon-m-shuffle"
                        enabled: false
                    }
                    Switch {
                        icon.source: "image://theme/icon-m-repeat"
                    }
                    Switch {
                        icon.source: "image://theme/icon-m-share"
                        onCheckedChanged: { busy = true; busyTimer.start() }
                        Timer {
                            id: busyTimer
                            interval: 4200
                            onTriggered: parent.busy = false
                        }
                    }
                }
                IconTextSwitch {
                    text: "Switch with an icon"
                    description: "This switch has both a textual label and an icon."
                    icon.source: "image://theme/icon-m-gps"
                }
            }

            SectionHeader {
                text: "Sliders"
            }
            Slider {
                width: parent.width
                value: 0.5
            }

            SectionHeader {
                text: "Progress Indicators"
            }

            Column {
                width: parent.width
                spacing: Theme.paddingMedium
                Row {
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter

                    BusyIndicator {
                        running: true
                        size: BusyIndicatorSize.Medium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ProgressCircle {
                        id: progressCircle

                        Timer {
                            interval: 32
                            repeat: true
                            onTriggered: progressCircle.value = (progressCircle.value + 0.005) % 1.0
                            running: Qt.application.active
                        }
                    }
                }

                ProgressBar {
                    id: progressBar
                    width: parent.width
                    maximumValue: 100
                    valueText: value
                    label: "Progress"
                    Timer {
                        interval: 100
                        repeat: true
                        onTriggered: progressBar.value = (progressBar.value + 1) % 100
                        running: Qt.application.active
                    }
                }
            }

            SectionHeader {
                text: "Text Input"
            }
            Column {
                width: parent.width
                spacing: Theme.paddingMedium
                TextField {
                    focus: true
                    label: "Normal"
                    placeholderText: label
                    width: parent.width
                    EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    EnterKey.onClicked: passwordField.focus = true
                }

                PasswordField {
                    id: passwordField
                    width: parent.width
                    EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    EnterKey.onClicked: numberField.focus = true
                }
                TextArea {
                    width: parent.width
                    height: Screen.height / 4
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                    label: "Multi-line with fixed height"
                    placeholderText: label
                }
                TextField {
                    placeholderText: "Field with inline combo box"
                    width: parent.width
                    labelComponent: MiniComboBox {
                        menu: ContextMenu {
                            MenuItem { text: "First option" }
                            MenuItem { text: "Second option that has an excessively long text in it" }
                            MenuItem { text: "Third selectable option" }
                        }
                    }
                }
                TextField {
                    width: parent.width
                    inputMethodHints: Qt.ImhNoPredictiveText
                    validator: RegExpValidator { regExp: /^[a-zA-Z]{3,}$/ }
                    label: "Validated input"
                    placeholderText: "Enter three or more characters"
                    EnterKey.enabled: acceptableInput
                    EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    EnterKey.onClicked: hiddenField.focus = true
                }
            }
        }
    }
}
