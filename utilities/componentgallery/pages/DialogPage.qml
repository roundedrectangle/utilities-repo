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
    id: root

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader { title: "Dialogs" }

            ValueButton {
                property date selectedDate

                function openDateDialog() {
                    var obj = pageStack.animatorPush("Sailfish.Silica.DatePickerDialog",
                                                     { date: selectedDate })

                    obj.pageCompleted.connect(function(page) {
                        page.accepted.connect(function() {
                            value = page.dateText
                            selectedDate = page.date
                        })
                    })
                }

                label: "Date"
                value: Qt.formatDate(new Date())
                width: parent.width
                onClicked: openDateDialog()
            }

            ValueButton {
                id: timeButton
                property int selectedHour
                property int selectedMinute

                function openTimeDialog() {
                    var obj = pageStack.animatorPush("Sailfish.Silica.TimePickerDialog", {
                                                    hourMode: (comboBoxHoursMode.checked ? DateTime.TwentyFourHours : DateTime.TwelveHours),
                                                    hour: selectedHour,
                                                    minute: selectedMinute
                                                })

                    obj.pageCompleted.connect(function(page) {
                        page.accepted.connect(function() {
                            selectedHour = page.hour
                            selectedMinute = page.minute
                        })
                    })
                }

                label: "Time"
                value: {
                    var time = new Date(0, 0, 0, selectedHour, selectedMinute, 0)
                    var type = comboBoxHoursMode.checked ? Formatter.TimeValueTwentyFourHours
                                                         : Formatter.TimeValueTwelveHours
                    return Format.formatDate(time, type)
                }
                width: parent.width
                onClicked: openTimeDialog()
            }

            TextSwitch {
                id: comboBoxHoursMode
                checked: true
                text: "24 Hours"
            }

            SectionHeader { text: "Color" }

            BackgroundItem {
                id: colorPickerButton
                Row {
                    x: Theme.horizontalPageMargin
                    height: parent.height
                    spacing: Theme.paddingMedium
                    Rectangle {
                        id: colorIndicator

                        width: height
                        height: parent.height
                        color: "#e60003"
                    }
                    Label {
                        text: "Color"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                    var obj = pageStack.animatorPush("Sailfish.Silica.ColorPickerPage", { color: colorIndicator.color })
                    obj.pageCompleted.connect(function(page) {
                        page.colorClicked.connect(function(color) {
                            colorIndicator.color = color
                            pageStack.pop()
                        })
                    })
                }
                Component {
                    id: colorPickerPage
                    ColorPickerPage {}
                }
            }

            Item { width: parent.width; height: Theme.paddingLarge }

            SectionHeader { text: "Wizards" }

            Column {
                width: parent.width
                spacing: -Theme.paddingSmall

                Button {
                    id: wizard

                    property string selection

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Start wizard"
                    onClicked: pageStack.animatorPush(firstWizardPage)
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: wizard.selection
                    color: palette.highlightColor
                }

                Component {
                    id: firstWizardPage

                    Dialog {
                        canAccept: selector.currentIndex >= 0
                        acceptDestination: secondWizardPage

                        onAcceptPendingChanged: {
                            if (acceptPending) {
                                // Tell the destination page what the selected category is
                                acceptDestinationInstance.category = selector.value
                            }
                        }

                        Flickable {
                            // ComboBox requires a flickable ancestor
                            width: parent.width
                            height: parent.height
                            interactive: false

                            Column {
                                width: parent.width

                                DialogHeader {
                                    title: "Food category"
                                }

                                ComboBox {
                                    id: selector

                                    width: parent.width
                                    label: 'Category:'
                                    currentIndex: -1

                                    menu: ContextMenu {
                                        Repeater {
                                            model: [ 'Fruit', 'Vegetable' ]

                                            MenuItem {
                                                text: modelData
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Component {
                    id: secondWizardPage

                    Dialog {
                        canAccept: selector.currentIndex >= 0
                        acceptDestination: root
                        acceptDestinationAction: PageStackAction.Pop

                        property string category

                        ListModel {
                            id: fruitModel
                            ListElement {
                                name: 'Apple'
                            }
                            ListElement {
                                name: 'Banana'
                            }
                            ListElement {
                                name: 'Cantaloupe'
                            }
                        }

                        ListModel {
                            id: vegetableModel
                            ListElement {
                                name: 'Asparagus'
                            }
                            ListElement {
                                name: 'Broccoli'
                            }
                            ListElement {
                                name: 'Carrot'
                            }
                        }

                        Flickable {
                            // ComboBox requires a flickable ancestor
                            width: parent.width
                            height: parent.height
                            interactive: false

                            Column {
                                width: parent.width

                                DialogHeader {
                                    title: "Select " + category.toLowerCase()
                                }

                                ComboBox {
                                    id: selector

                                    width: parent.width
                                    label: 'Selection:'
                                    currentIndex: -1

                                    menu: ContextMenu {
                                        Repeater {
                                            model: category === 'Fruit' ? fruitModel : vegetableModel

                                            MenuItem {
                                                text: modelData
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        onAccepted: {
                            wizard.selection = selector.value
                        }
                    }
                }
            }
        }
    }
}

