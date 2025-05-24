/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
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

    property bool newUser

    canAccept: usernameField.acceptableInput && passwordField.acceptableInput && (!newUser || confirmPasswordField.acceptableInput)

    onAcceptBlocked: {
        if (!usernameField.acceptableInput) {
            usernameField.errorHighlight = true
        }

        if (!passwordField.acceptableInput) {
            passwordField.errorHighlight = true
        }

        if (newUser && !confirmPasswordField.acceptableInput) {
            confirmPasswordField.errorHighlight = true
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            bottomPadding: Theme.paddingLarge

            DialogHeader {
                acceptText: newUser ? "Create" : "Sign-in"
                title: "Add account to get cool features"
            }

            TextSwitch {
                automaticCheck: false
                checked: !newUser
                text: "I have an account"
                description: "Select this if you want to sign-in to existing account"
                onClicked: newUser = false
            }

            TextSwitch {
                automaticCheck: false
                checked: newUser
                text: "I am a new user"
                description: "Select this if you haven't used the account yet on any other devices"
                onClicked: newUser = true
            }

            TextField {
                id: usernameField

                onActiveFocusChanged: if (!activeFocus) errorHighlight = !acceptableInput
                onAcceptableInputChanged: if (acceptableInput) errorHighlight = false

                label: "Username"
                description: errorHighlight ? "Username is too short" : ""
                acceptableInput: text.length > 3
                focus: true

                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: passwordField.focus = true
            }

            PasswordField {
                id: passwordField

                onActiveFocusChanged: if (!activeFocus) errorHighlight = !acceptableInput
                onAcceptableInputChanged: if (acceptableInput) errorHighlight = false

                description: errorHighlight ? "Password is too short" : ""
                acceptableInput: text.length > 3

                EnterKey.enabled: newUser || passwordField.acceptableInput
                EnterKey.iconSource: "image://theme/icon-m-enter-" + (newUser ? "next" : "accept")
                EnterKey.onClicked: {
                    if (newUser) {
                        confirmPasswordField.focus = true
                    } else {
                        dialog.accept()
                    }
                }
            }

            PasswordField {
                id: confirmPasswordField

                readonly property bool partialMatch: passwordField.text.substr(0, text.length) === text

                onActiveFocusChanged: if (!activeFocus) errorHighlight = !acceptableInput
                onAcceptableInputChanged: if (acceptableInput) errorHighlight = false
                onPartialMatchChanged: if (activeFocus) errorHighlight = !partialMatch

                enabled: newUser
                acceptableInput: passwordField.text === text
                Behavior on opacity { FadeAnimator {}}
                opacity: newUser ? 1.0 : 0.0

                label: "Re-enter password"
                description: errorHighlight ? "Passwords do not match" : ""

                EnterKey.enabled: passwordField.acceptableInput && acceptableInput
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: dialog.accept()
            }
        }
    }
}
