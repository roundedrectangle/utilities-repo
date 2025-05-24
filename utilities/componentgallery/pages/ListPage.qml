/****************************************************************************************
**
** Copyright (C) 2013-2019 Jolla Ltd.
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

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root

    property bool deletingItems

    SilicaListView {
        id: listView

        anchors.fill: parent
        model: listModel

        header: PageHeader {
            title: "List and menus"
        }

        ViewPlaceholder {
            enabled: (listModel.populated && listModel.count === 0) || root.deletingItems
            text: "No content"
            hintText: "Pull down to add content"
        }

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: "Clear"
                visible: listView.count
                onClicked: {
                    root.deletingItems = true
                    var remorse = Remorse.popupAction(
                                root, "Cleared",
                                function() {
                                    listModel.clear()
                                })
                    remorse.canceled.connect(function() { root.deletingItems = false })
                }
            }
            MenuItem {
                text: "Add Items"
                visible: !listView.count
                onClicked: listModel.addItems()
            }
            MenuItem {
                text: "Toggle busy menu"
                onClicked: pullDownMenu.busy = !pullDownMenu.busy
            }
            MenuLabel {
                text: "Menu label"
            }
        }

        delegate: ListItem {

            function remove() {
                remorseDelete(function() { listModel.remove(index) })
            }

            onClicked: {
                if (!menuOpen && pageStack.depth == 2) {
                    pageStack.animatorPush(Qt.resolvedUrl("ListPage.qml"))
                }
            }

            ListView.onRemove: animateRemoval()
            enabled: !root.deletingItems
            opacity: enabled ? 1.0 : 0.0
            Behavior on opacity { FadeAnimator {}}

            menu: Component {
                ContextMenu {
                    MenuItem {
                        text: "Delete"
                        onClicked: remove()
                    }
                    MenuItem {
                        text: "Second option"
                    }
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                anchors.verticalCenter: parent.verticalCenter
                text: (model.index+1) + ". " + model.text
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.Capitalize
            }
        }
        VerticalScrollDecorator {}
    }

    ListModel {
        id: listModel

        property bool populated

        Component.onCompleted: addItems()

        function addItems() {
            var entries = 40
            var spaceIpsumWords = ["Since", "long", "run", "every", "planetary", "civilization", "endangered", "impacts", "space", "every", "surviving",
                                   "civilization", "obliged", "become", "spacefaring", "because", "exploratory", "romantic", "zeal", "most", "practical",
                                   "reason", "imaginable", "staying", "alive", "long-term", "survival", "stake", "have", "basic", "responsibility", "species",
                                   "venture", "other", "worlds", "one", "small", "step", "man", "one", "giant", "leap", "mankind", "powered", "flight",
                                   "total", "about", "eight", "half", "minutes", "seemed", "gone", "lash", "gone", "from", "sitting", "still", "launch",
                                   "pad", "Kennedy", "Space", "Center", "traveling", "17500", "miles", "hour", "eight", "half", "minutes", "still",
                                   "recall", "making", "some", "statement", "air", "ground", "radio", "benefit", "fellow", "astronauts", "who", "also",
                                   "program", "long", "time", "well", "worth", "took", "been", "wait", "mind-boggling"]

            for (var index = 0; index < entries; index++) {
                listModel.append({"text": spaceIpsumWords[index*2] + " " + spaceIpsumWords[index*2+1]})
            }
            for (index = 0; index < entries; index++) {
                listModel.append({"text": spaceIpsumWords[index*2] + " " + spaceIpsumWords[index*2+1]})
            }
            root.deletingItems = false
            populated = true
        }
    }
}
