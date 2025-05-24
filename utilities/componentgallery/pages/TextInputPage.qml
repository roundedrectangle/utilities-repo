/****************************************************************************************
**
** Copyright (C) 2013-2017 Jolla Ltd.
** Copyright (C) 2020 Open Mobile Platform LLC.
** Contact: Joona Petrell <joona.petrell@jollamobile.com>
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

import QtQuick 2.6
import Sailfish.Silica 1.0

Page {
    id: textInputPage

    property var textAlignment: undefined
    property int editorStyle: fillSwitch.checked ? TextEditor.FilledBackground : TextEditor.UnderlineBackground

    SilicaFlickable {
        id: flickable

        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader { title: "Text input" }

            SectionHeader {
                text: "Text fields"
            }

            TextField {
                focus: true
                label: "Normal"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: passwordField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            PasswordField {
                id: passwordField
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: numberField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: numberField
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Number"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: phoneField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: phoneField
                inputMethodHints: Qt.ImhDialableCharactersOnly
                label: "Phone number"
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            SectionHeader {
                text: "Search field"
            }

            SearchField {
            }

            SectionHeader {
                text: "Text area"
            }

            TextArea {
                id: textArea
                label: "Multi-line text"

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextArea {
                height: Screen.height / 4
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                label: "Multi-line with fixed height"

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            SectionHeader {
                text: "Extending fields"
            }

            Label {
                width: parent.width - 2*x
                x: Theme.horizontalPageMargin
                wrapMode: Text.Wrap
                text: "You can extend text field with additional actions and indications"
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                bottomPadding: Theme.paddingMedium
            }

            TextField {
                label: "Email"
                leftItem: Icon {
                    source: "image://theme/icon-m-mail"
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: clearableField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: clearableField

                label: "Clear button"

                rightItem: IconButton {
                    onClicked: clearableField.text = ""

                    width: icon.width
                    height: icon.height
                    icon.source: "image://theme/icon-splus-clear"
                    opacity: clearableField.text.length > 0 ? 1.0 : 0.0
                    Behavior on opacity { FadeAnimation {} }
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: mandatoryField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: mandatoryField

                label: "Mandatory"

                rightItem: Icon {
                    source: "image://theme/icon-splus-asterisk"
                    color: Theme.highlightColor
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: comboBoxField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: comboBoxField

                placeholderText: "Inline combo boxes"
                labelComponent: Row {
                    spacing: Theme.paddingSmall
                    width: parent.width

                    MiniComboBox {
                        menu: ContextMenu {
                            MenuItem { text: "Phone" }
                            MenuItem { text: "Email" }
                            MenuItem { text: "Chat" }
                        }
                    }

                    MiniComboBox {
                        menu: ContextMenu {
                            MenuItem { text: "Personal" }
                            MenuItem { text: "Work" }
                            MenuItem { text: "Other" }
                        }
                    }
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: replyField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            PasswordField {
                id: passwordStrength

                property var colors: ["#e70043", "#e7ae37", "#07a032", "#07a032"]
                property var statuses: ["Very weak", "Weak", "So-so", "Good", "Great"]

                // Disclaimer! This is an UI example only, lacks real password strength indicator,
                // which depends on use case -specific security requirements
                property int progress: Math.min(text.length/4, statuses.length - 1)

                background: Row {
                    x: passwordStrength.textLeftMargin
                    anchors.top: passwordStrength.contentItem.bottom

                    width: parent.width - x - passwordStrength.textRightMargin
                    spacing: Theme.paddingSmall
                    height: 4*Math.round(Theme.pixelRatio)

                    Repeater {
                        id: repeater
                        model: passwordStrength.colors

                        Rectangle {
                            property bool active: passwordStrength.progress > model.index
                            color: {
                                if (active) {
                                    return modelData
                                } else if (passwordStrength.activeFocus) {
                                    return palette.highlightColor
                                } else {
                                    return palette.secondaryColor
                                }
                            }

                            Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }}
                            width: (parent.width - (repeater.count - 1) * spacing) / repeater.count
                            height: {
                                if (active) {
                                    return parent.height
                                } else {
                                    return Math.round(Theme.pixelRatio)
                                            + (passwordStrength.activeFocus ? Math.round(Theme.pixelRatio)
                                                                              + (palette.colorScheme === Theme.DarkOnLight ? 1 : 0)
                                                                            : 0)
                                }
                            }
                        }
                    }
                }

                labelComponent: Row {
                    width: parent.width

                    TextEditorLabel {
                        id: passwordStrengthLabel

                        editor: passwordStrength
                        width: parent.width - strengthLabel.width
                    }

                    Label {
                        id: strengthLabel

                        text: passwordStrength.statuses[passwordStrength.progress]
                        color: passwordStrength.colors[Math.max(0, passwordStrength.progress - 1)]
                        opacity: passwordStrengthLabel.opacity
                        font.pixelSize: Theme.fontSizeSmall
                    }
                }
            }

            TextArea {
                id: replyField

                label: "SMS"
                placeholderText: "Send message"
                hideLabelOnEmptyField: false

                textRightMargin: Theme.horizontalPageMargin + sendButton.width + Theme.paddingLarge

                backgroundStyle: textInputPage.editorStyle
                horizontalAlignment: textAlignment

                Button {
                    id: sendButton
                    parent: replyField
                    width: Theme.iconSizeMedium + 2 * Theme.paddingSmall
                    height: width

                    anchors {
                        right: parent.right
                        rightMargin: Theme.horizontalPageMargin
                    }

                    y: replyField.contentItem.y + replyField.contentItem.height - height/2
                    icon.source: "image://theme/icon-m-send"
                }
            }

            SectionHeader {
                text: "Enter key"
            }

            Label {
                width: parent.width - 2*x
                x: Theme.horizontalPageMargin
                wrapMode: Text.Wrap
                text: "Remember to define enter key behavior for your text fields, for example allow moving the focus to the next field when displaying multiple fields."

                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                bottomPadding: Theme.paddingMedium
            }

            ComboBox {
                id: enterKeyCombobox
                readonly property bool iconMode: currentIndex === 1
                readonly property bool textMode: currentIndex === 2

                width: parent.width
                label: "Mode"
                currentIndex: 1

                menu: ContextMenu {
                    MenuItem { text: "None" }
                    MenuItem { text: "Icon" }
                    MenuItem { text: "Text" }
                }
            }

            Row {
                width: parent.width
                TextSwitch {
                    id: enabled; checked: true; text: "Enabled"; width: parent.width/2
                }
                TextSwitch {
                    id: highlighted; text: "Highlighted"; width: parent.width/2
                }
            }

            TextField {
                label: "Change options above"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.iconSource: enterKeyCombobox.iconMode ? "image://theme/icon-m-enter-next" : ""
                EnterKey.text: enterKeyCombobox.textMode ? "Text" : ""
                EnterKey.enabled: enabled.checked
                EnterKey.highlighted: highlighted.checked
                EnterKey.onClicked: parent.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            SectionHeader {
                text: "Guiding user"
            }

            TextField {
                label: "Hint included"
                description: "Sometimes simple placeholder text is not enough for the user to understand what is required and you need to display a longer hint text below."
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: validatedField.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: validatedField

                inputMethodHints: Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp: /^[a-zA-Z]{6,}$/ }
                label: "Username"
                errorHighlight: false
                onActiveFocusChanged: if (!activeFocus) errorHighlight = !acceptableInput
                onAcceptableInputChanged: if (acceptableInput) errorHighlight = false

                description: {
                    if (errorHighlight) {
                        if (text.length === 0) {
                            return "Username is required"
                        } else {
                            return "Enter six or more characters"
                        }
                    }
                    return ""
                }

                EnterKey.enabled: acceptableInput
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: wrappingField.focus = true

                rightItem: Icon {
                    color: Theme.errorColor
                    highlightColor: Theme.errorColor
                    source: "image://theme/icon-splus-error"

                    opacity: validatedField.errorHighlight ? 1.0 : 0.0
                    Behavior on opacity { FadeAnimation {} }
                }

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            SectionHeader {
                text: "Other"
            }

            TextField {
                enabled: false
                label: "Disabled"
                text: label

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: wrappingField

                label: "Wrapping"
                text: "It is better to enable wrapping for the field if you expect long input"
                wrapMode: TextInput.Wrap

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: hiddenField.focus = true
            }

            TextField {
                readOnly: true
                label: "Read-only"
                text: label

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                readOnly: true
                focusOnClick: true
                label: "Read only, but focusable"
                text: label
                EnterKey.onClicked: parent.focus = true

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            TextField {
                id: hiddenField
                placeholderText: "Label hidden"
                labelVisible: false
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false

                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }

            SectionHeader {
                text: "Editor modes"
            }

            ComboBox {
                width: parent.width
                label: "Horizontal alignment"
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0:
                        textAlignment = undefined
                        break
                    case 1:
                        textAlignment = TextInput.AlignLeft
                        break
                    case 2:
                        textAlignment = TextInput.AlignRight
                        break
                    case 3:
                        textAlignment = TextInput.AlignHCenter
                        break
                    }
                }

                menu: ContextMenu {
                    MenuItem { text: "Follows text" }
                    MenuItem { text: "Left" }
                    MenuItem { text: "Right" }
                    MenuItem { text: "HorizontalCenter" }
                }
            }
            TextSwitch {
                id: fillSwitch

                text: "With filled backgrounds"
                description: "Filled background might be useful on TextAreas or bigger forms with lots of entries"
                onCheckedChanged: if (checked) scrollTimer.restart()

                Timer {
                    id: scrollTimer
                    interval: 1
                    // changing the fill mode on increases the heights of the editor.
                    // work around switch getting out of the view
                    // TODO: suffers from a quick flash of wrong position but perhaps this is good
                    // enough for testing purposes
                    onTriggered: flickable.contentY = flickable.contentHeight - flickable.height
                }
            }
        }
    }
}

