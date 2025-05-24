/****************************************************************************************
**
** Copyright (c) 2020 Open Mobile Platform LLC.
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
    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column

            width: parent.width

            PageHeader {
                title: "In-app notifications"
            }

            Label {
                width: parent.width
                leftPadding: Theme.horizontalPageMargin
                rightPadding: Theme.horizontalPageMargin

                text: "Notify component is used to display useful feedback to actions performed within an app. Tap the items below to see examples how to use Notify"
                color: palette.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
            }

            Row {
                height: Theme.itemSizeLarge
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.itemSizeSmall

                IconButton {
                    icon.source: "image://theme/icon-m-select-all"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: Notices.show("Copied", Notice.Short, Notice.Left)
                }
                IconButton {
                    icon.source: "image://theme/icon-m-send"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: Notices.show("Sending message failed", Notice.Short, Notice.Center)
                }
                IconButton {
                    icon.source: "image://theme/icon-m-call-recording-on"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: Notices.show("Recording disabled by Device Manager", Notice.Long, Notice.Right)
                }
            }

            ListItem {
                onClicked: alarmNotice.show()

                Icon {
                    id: alarmIcon
                    x: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://theme/icon-m-alarm"
                }
                Label {
                    truncationMode: TruncationMode.Fade
                    anchors {
                        left: alarmIcon.right
                        leftMargin: Theme.paddingMedium
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Theme.horizontalPageMargin
                    }
                    text: "Add reminder"
                }

                Notice {
                    id: alarmNotice

                    text: "Reminder set for 11:30"
                }
            }

            ListItem {
                onClicked: documentNotice.show()

                opacity: Theme.opacityLow

                Icon {
                    id: documentIcon
                    x: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://theme/icon-m-file-pdf"
                }
                Column {
                    anchors {
                        left: documentIcon.right
                        leftMargin: Theme.paddingMedium
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Theme.horizontalPageMargin
                    }
                    Label {
                        width: parent.width
                        truncationMode: TruncationMode.Fade

                        text: "Document.pdf"
                    }
                    Label {
                        anchors.right: parent.right
                        text: Format.formatDate(new Date(), Format.Timepoint)
                        font.pixelSize: Theme.fontSizeExtraSmall
                        color: highlighted ? palette.secondaryHighlightColor : palette.secondaryColor
                    }
                }

                Notice {
                    id: documentNotice

                    duration: Notice.Long
                    text: "No permissions to open the document"
                }
            }
        }
    }
}
