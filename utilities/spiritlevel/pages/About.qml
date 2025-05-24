
/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>
  */


import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages"

Page {
    id: about_page
    anchors.centerIn: parent

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: about_column.height
        contentWidth: parent.width
        Column {
            id: about_column
            spacing: Theme.paddingMedium
            width: parent.width
            PageHeader {
                title: "About"
            }
            Label {
                text: "Spiritlevel / Vatupassi"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "0.5"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "Authored by Bruno Luvizotto, 2014\n"+
                                "Updated 2023, poetaster"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                spacing: Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: email_id
                    text: "Source, on github. BSD license."
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeMedium
                    //anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.color = Theme.highlightColor
                        onReleased: parent.color = Theme.primaryColor
                        onClicked: Qt.openUrlExternally("https://github.com/poetaster/spiritlevel")
                    }
                }
            }
        }
    }
}
