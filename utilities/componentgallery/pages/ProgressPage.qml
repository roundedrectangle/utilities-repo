/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Bea Lam <bea.lam@jollamobile.com>
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
    BusyLabel {
        // In real use case replace with a more descriptive title
        text: "Loading page"
        running: simulatedLoading.running
    }

    Timer {
        // When loading takes more than a second start with a busy indication
        id: simulatedLoading
        interval: 1500
        running: true
    }

    SilicaFlickable {
        opacity: simulatedLoading.running ? 0.0 : 1.0
        Behavior on opacity { FadeAnimator { duration: 400 } }

        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            spacing: Theme.paddingLarge
            width: parent.width

            PageHeader { title: "Progress Indicators" }

            SectionHeader { text: "Busy indicator" }

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                BusyIndicator {
                    running: true
                    size: BusyIndicatorSize.ExtraSmall
                    anchors.verticalCenter: parent.verticalCenter
                }
                BusyIndicator {
                    running: true
                    size: BusyIndicatorSize.Small
                    anchors.verticalCenter: parent.verticalCenter
                }
                BusyIndicator {
                    running: true
                    size: BusyIndicatorSize.Medium
                    anchors.verticalCenter: parent.verticalCenter
                }
                BusyIndicator {
                    running: true
                    size: BusyIndicatorSize.Large
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            SectionHeader { text: "Progress bar" }
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
            ProgressBar {
                width: parent.width
                indeterminate: true
                label: "Indeterminate"
            }
            SectionHeader { text: "Progress circle" }
            ProgressCircle {
                id: progressCircle

                anchors.horizontalCenter: parent.horizontalCenter

                Timer {
                    interval: 32
                    repeat: true
                    onTriggered: progressCircle.value = (progressCircle.value + 0.005) % 1.0
                    running: Qt.application.active
                }
            }
        }
    }
}
