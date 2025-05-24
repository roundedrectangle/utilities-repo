/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>
  */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../elements"

CoverBackground {
    id: cover_background
    onStatusChanged: status == Cover.Active ? accel.acel_ativo = true : accel.acel_ativo = false
    Column {
        anchors.fill: parent
        anchors.topMargin: Theme.paddingSmall

        spacing: Theme.paddingSmall

        Label {
            id: label_measures
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Angles:")
        }

        Item {
            height: label_x.height; width: parent.width

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: label_x

                    //width: parent.width/2
                    visible: config.style == "regular" || config.uni_style == "Both" || config.uni_style == "X"
                    text: "X: " + (accel.x_acel - accel.x_acel_cal).toFixed(accel.precisao)
                }

                Label {
                    id: label_y

                    //width: parent.width/2
                    visible: config.style == "regular" || config.uni_style == "Both" || config.uni_style == "Y"
                    text: "Y: " + (accel.y_acel - accel.y_acel_cal).toFixed(accel.precisao)
                }
            }
        }
    /*    Image {
            id: image
            //width: 160
            //height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            y: 185
            opacity: 0.3
            source: Qt.resolvedUrl("image://theme/Vatupassi")
        }
    */
        Big_circle {
            visible: config.style == "regular"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
            }
        }
        Uni_circle {
            visible: config.style == "unidimensional"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
            }
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                accel.x_acel_cal = accel.x_acel
                accel.y_acel_cal = accel.y_acel
            }
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-location"
            onTriggered: {
                accel.x_acel_cal = 0
                accel.y_acel_cal = 0
            }
        }

        /*CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        }*/
    }
}


