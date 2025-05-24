/****************************************************************************************
**
** Copyright (C) 2020 Open Mobile Platform LLC.
**
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

Dialog {
    id: dialog

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            bottomPadding: Theme.paddingLarge

            DialogHeader {
                acceptText: "Save"
                title: "Example form"
            }

            TextField {
                id: firstNameField

                focus: true
                label: "First name"
                placeholderText: label
                leftItem: Icon {
                    id: contactIcon
                    source: "image://theme/icon-m-contact"
                }
                rightItem: ClearFieldButton {
                    editor: firstNameField
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: lastNameField.focus = true
            }

            TextField {
                id: lastNameField

                label: "Last name"
                placeholderText: label
                leftItem: Item {
                    width: contactIcon.width
                    height: contactIcon.height
                }
                rightItem: ClearFieldButton {
                    editor: lastNameField
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: phoneField.focus = true
            }

            SectionHeader {
                text: "Contact"
            }

            TextField {
                id: phoneField
                inputMethodHints: Qt.ImhDialableCharactersOnly
                label: "Phone number"
                placeholderText: label
                leftItem: Icon {
                    source: "image://theme/icon-m-call"
                }
                rightItem: ClearFieldButton {
                    editor: phoneField
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: emailField.focus = true
            }

            TextField {
                id: emailField
                label: "Email"
                placeholderText: label
                leftItem: Icon {
                    source: "image://theme/icon-m-mail"
                }
                rightItem: ClearFieldButton {
                    editor: emailField
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: urlField.focus = true
            }

            SectionHeader {
                text: "Other"
            }

            TextField {
                id: urlField
                label: "Website"
                placeholderText: label
                inputMethodHints: Qt.ImhUrlCharactersOnly
                leftItem: Icon {
                    source: "image://theme/icon-m-website"
                }
                rightItem: ClearFieldButton {
                    editor: urlField
                }

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: noteField.focus = true
            }

            TextArea {
                id: noteField
                label: "Note"
                placeholderText: label
                leftItem: Icon {
                    source: "image://theme/icon-m-note"
                }
                rightItem: ClearFieldButton {
                    editor: noteField
                }
            }
        }
    }
}
