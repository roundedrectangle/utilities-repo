import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: big_circle

    property real opacity_circles: contrast == "high" ? 0.75 : contrast == "low" ? 0.5 : 0.5
    property real opacity_lines: contrast == "high" ? 1 : contrast == "low" ? 0.5 : 0.5
    property real opacity_measure: contrast == "high" ? 1 : contrast == "low" ? 0.5 : 0.5

    width: parent.width
    height: width
    color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
    opacity: opacity_circles
    border.color: "black"
    border.width: 1
    radius: width*0.5
    /*Text {
         //anchor.fill = parent
         color: "red"
         text: "Boom"
    }*/

    Rectangle {
        id: seta1
        width: 6
        height: 12
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        /*Text {
             //anchor.fill = parent
             color: "red"
             text: "Boom"
        }*/
    }
    Rectangle {
        id: seta2
        width: 6
        height: 12
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        /*Text {
             //anchor.fill = parent
             color: "red"
             text: "Boom"
        }*/
    }
    Rectangle {
        id: seta3
        width: 12
        height: 6
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        /*Text {
             //anchor.fill = parent
             color: "red"
             text: "Boom"
        }*/
    }
    Rectangle {
        id: seta4
        width: 12
        height: 6
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }
    Rectangle {
          id: small_circle1
          width: parent.height / 5.466667
          height: width
          color: Qt.darker(Theme.secondaryHighlightColor, 1.2)
          opacity: opacity_circles
          border.color: "black"
          border.width: 1
          radius: width*0.5
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
         id: small_circle2
         width: small_circle1.height / 2
         height: width
         color: Qt.darker(Theme.secondaryHighlightColor, 1.2)
         opacity: opacity_circles
         border.color: "black"
         border.width: 1
         radius: width*0.5
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: linha1
        width: 2
        height: parent.width - seta4.width * 2
        color: "black"
        opacity: opacity_lines
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: linha2
        width: parent.width - seta4.width * 2
        height: 2
        color: "black"
        opacity: opacity_lines
        border.color: "black"
        border.width: 1
        radius: width*0.05
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: measure
        width: small_circle2.height / 1.285714
        height: width
        color: (accel.x_acel - accel.x_acel_cal) < 2 && (accel.x_acel - accel.x_acel_cal) > -2
               && (accel.y_acel - accel.y_acel_cal) < Math.sqrt(Math.pow(2, 2) - Math.pow((accel.x_acel - accel.x_acel_cal), 2))
               && (accel.y_acel - accel.x_acel_cal) > -Math.sqrt(Math.pow(2, 2) - Math.pow((accel.x_acel - accel.x_acel_cal), 2)) ?
                   Theme.highlightColor : Theme.secondaryColor
        opacity: opacity_measure
        border.color: "black"
        border.width: 1
        radius: width*0.5
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -((accel.y_acel - accel.y_acel_cal) * (big_circle.height - measure.height) / 180)
        anchors.horizontalCenterOffset: ((accel.x_acel - accel.x_acel_cal) * (big_circle.height - measure.height) / 180)
        Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: (2/accel.dataRate); easing.type: Easing.InOutQuad } }
        Behavior on anchors.horizontalCenterOffset { NumberAnimation { duration:  (2/accel.dataRate); easing.type: Easing.InOutQuad } }
    }
}
