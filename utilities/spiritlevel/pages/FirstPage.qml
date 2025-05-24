/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>
  */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../elements"
import "../pages"

Page {
    id: page
    //onStatusChanged: Qt.application.active ? sensores.acel_on() : sensores.acel_off()
    // To enable PullDownMenu, place our content in a SilicaFlickable


    SilicaFlickable {
        id: flickable
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../pages/About.qml"))
                }
            }
            MenuItem {
                text: "Settings"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../pages/Settings.qml"))
                }
            }
            MenuItem {
                text: qsTr("Reset Calibration")
                onClicked: {
                    accel.x_acel_cal = 0
                    accel.y_acel_cal = 0
                }
            }
            MenuItem {
                text: qsTr("Calibrate")
                onClicked: {
                    accel.x_acel_cal = accel.x_acel
                    accel.y_acel_cal = accel.y_acel
                }
            }
        }
        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Spiritlevel")
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Angles:")
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                x: Theme.paddingLarge + 50
                text: "X: " + (accel.x_acel - accel.x_acel_cal).toFixed(accel.precisao)
                visible: config.style == "regular" || config.uni_style == "both" || config.uni_style == "X"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                x: Theme.paddingLarge + 50
                text: "Y: " + (accel.y_acel - accel.y_acel_cal).toFixed(accel.precisao)
                visible: config.style == "regular" || config.uni_style == "both" || config.uni_style == "Y"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
    }

    Item {
        height: parent.height -column.height
        anchors {
            bottom: parent.bottom
            left: parent.left; right: parent.right
        }

        Big_circle {
            id: big_circle_page
            visible: config.style == "regular"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
                verticalCenter: parent.verticalCenter
            }
        }
        Uni_circle {
            id: uni_circle_page
            visible: config.style == "unidimensional"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
                verticalCenter: parent.verticalCenter
            }
        }
    }
}


