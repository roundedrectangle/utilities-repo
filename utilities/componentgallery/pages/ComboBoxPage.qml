/****************************************************************************************
**
** Copyright (c) 2013 - 2019 Jolla Ltd.
** Copyright (c) 2020 Open Mobile Platform LLC.
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
        bottomMargin: Theme.paddingLarge

        Column {
            id: column

            width: parent.width
            PageHeader {
                title: "Combo boxes"
            }

            // set currentIndex to change the selected value
            ComboBox {
                label: "Screen brightness"
                currentIndex: 1
                menu: ContextMenu {
                    MenuItem { text: "automatic" }
                    MenuItem { text: "manual" }
                    MenuItem { text: "Long Long Long Long selection" }
                }
            }

            ComboBox {
                label: "A Long Long Long Long Long Label"
                menu: ContextMenu {
                    MenuItem { text: "Short" }
                    MenuItem { text: "Quite the Medium" }
                    MenuItem { text: "Long Long Long Long Long selection" }
                }
            }

            // if there are many options, they will open
            // in a separate dialog
            ComboBox {
                label: "Setting (many options)"
                menu: ContextMenu {
                    MenuItem { text: "option a" }
                    MenuItem { text: "option b" }
                    MenuItem { text: "option c" }
                    MenuItem { text: "option d" }
                    MenuItem { text: "option e" }
                    MenuItem { text: "option f" }
                    MenuItem { text: "option g" }
                    MenuItem { text: "option h" }
                    MenuItem { text: "option i" }
                    MenuItem { text: "option j" }
                    MenuItem { text: "option k" }
                    MenuItem { text: "option l" }
                    MenuItem { text: "option m" }
                    MenuItem { text: "option n" }
                    MenuItem { text: "option o" }
                    MenuItem { text: "option p" }
                    MenuItem { text: "option q" }
                    MenuItem { text: "option r" }
                    MenuItem { text: "option s" }
                    MenuItem { text: "option t" }
                    MenuItem { text: "option u" }
                    MenuItem { text: "option v" }
                    MenuItem { text: "option w" }
                    MenuItem { text: "option x" }
                    MenuItem { text: "option y" }
                    MenuItem { text: "option z" }
                }
            }

            Row {
                width: parent.width
                ComboBox {
                    width: parent.width / 2
                    label: "Half-width combo 1"

                    menu: ContextMenu {
                        MenuItem { text: "an option" }
                        MenuItem { text: "yet another option" }
                        MenuItem { text: "yet another option with a long label" }
                    }
                }

                ComboBox {
                    width: parent.width / 2
                    label: "Half-width combo 2"

                    menu: ContextMenu {
                        MenuItem { text: "an option" }
                        MenuItem { text: "yet another option" }
                        MenuItem { text: "yet another option with a long label" }
                    }
                }
            }
            ComboBox {
                label: "Preferred direction"
                currentIndex: 1

                menu: ContextMenu {
                    MenuItem { text: "Up" }
                    MenuItem { text: "Down" }
                    MenuItem { text: "Left" }
                    MenuItem { text: "Right" }
                }
                description: "This combobox comes with an extra description."
            }

            IconComboBox {
                label: "Selection with icon"
                currentIndex: 1

                menu: ContextMenu {
                    IconMenuItem {
                        text: "Phone"
                        description: "+0000 123 456"
                        icon.source: "image://theme/icon-m-phone"
                    }
                    IconMenuItem {
                        text: "Mail"
                        description: "myemailaddress@address.com"
                        icon.source: "image://theme/icon-m-mail"
                    }
                    IconMenuItem {
                        text: "Message"
                        description: "+0000 123 456"
                        icon.source: "image://theme/icon-m-message"
                    }
                    IconMenuItem {
                        text: "Option with description spanning multiple lines"
                        description: "Slightly longer description also spanning multiple lines"
                        icon.source: "image://theme/icon-m-asterisk"
                    }
                    IconMenuItem {
                        text: "Option without description"
                        icon.source: "image://theme/icon-m-asterisk"
                    }
                    IconMenuItem {
                        text: "Option without description spanning multiple lines"
                        icon.source: "image://theme/icon-m-asterisk"
                    }
                }
            }
        }
    }
}
