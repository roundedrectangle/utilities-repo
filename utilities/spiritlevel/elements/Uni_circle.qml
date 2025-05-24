import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: uni_circle

    property real opacity_circles: contrast == "high" ? .8 : contrast == "low" ? 0.65 : 0.56
    property real opacity_lines: contrast == "high" ? 1 : contrast == "low" ? 0.65 : 0.65
    property real opacity_measure: contrast == "high" ? 1 : contrast == "low" ? 0.65 : 0.65

    width: parent.width
    height: width
    color: "transparent"
    opacity: opacity_circles

    Rectangle {
        id: x_axis_rectangle
        width: parent.width
        height: width / 10.8
        visible: config.uni_style == "both" || config.uni_style == "X"
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        radius: height*0.5
        border.color: "black"
        border.width: 1
        anchors.centerIn: parent
    }
    Rectangle {
        id: y_axis_rectangle
        width: parent.height / 10.8
        height: parent.width
        visible: config.uni_style == "both" || config.uni_style == "Y"
        color: Qt.lighter(Theme.secondaryHighlightColor, 1.2)
        opacity: opacity_circles
        radius: width*0.5
        border.color: "black"
        border.width: 1
        anchors.centerIn: parent
    }
    /*Rectangle {
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
    }*/
    Rectangle {
        id: linha1
        width: x_axis_rectangle.height
        height: 1
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "Y"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: linha1_2
        width: x_axis_rectangle.height
        height: 1
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "Y"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: width * 1.5
    }
    Rectangle {
        id: linha1_3
        width: x_axis_rectangle.height
        height: 1
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "Y"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - width * 1.5
    }
    Rectangle {
        id: linha1_4
        width: x_axis_rectangle.height
        height: 1
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "Y"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: width * .5
    }
    Rectangle {
        id: linha1_5
        width: x_axis_rectangle.height
        height: 1
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "Y"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -width * .5
    }
    Rectangle {
        id: linha2
        width: x_axis_rectangle.height
        height: 1
        rotation: 90
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "X"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: linha2_2
        width: x_axis_rectangle.height
        height: 1
        rotation: 90
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "X"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: width * 1.5
    }
    Rectangle {
        id: linha2_3
        width: x_axis_rectangle.height
        height: 1
        rotation: 90
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "X"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: - width * 1.5
    }
    Rectangle {
        id: linha2_4
        width: x_axis_rectangle.height
        height: 1
        rotation: 90
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "X"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: width * .5
    }
    Rectangle {
        id: linha2_5
        width: x_axis_rectangle.height
        height: 1
        rotation: 90
        color: "black"
        opacity: opacity_lines
        visible: config.uni_style == "both" || config.uni_style == "X"
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -width * .5
    }
    Rectangle {
        id: measure_x
        width: parent.width / 14.0571397419
        height: width
        visible: config.uni_style == "both" || config.uni_style == "X"
        color: (accel.x_acel - accel.x_acel_cal) < 2 && (accel.x_acel - accel.x_acel_cal) > -2 ? Theme.highlightColor : Theme.secondaryColor
        opacity: opacity_measure
        border.color: "black"
        border.width: 1
        radius: width*0.5
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: ((accel.x_acel - accel.x_acel_cal) * (parent.width - measure_x.height) / 180)
        Behavior on anchors.horizontalCenterOffset { NumberAnimation { duration:  (2/accel.dataRate); easing.type: Easing.InOutQuad } }
    }
    Rectangle {
        id: measure_y
        width: parent.width / 14.0571397419
        height: width
        visible: config.uni_style == "both" || config.uni_style == "Y"
        color: (accel.y_acel - accel.y_acel_cal) < 2 && (accel.y_acel - accel.y_acel_cal) > -2 ? Theme.highlightColor : Theme.secondaryColor
        opacity: opacity_measure
        border.color: "black"
        border.width: 1
        radius: width*0.5
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -((accel.y_acel - accel.y_acel_cal) * (parent.width - measure_y.height) / 180)
        Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: (2/accel.dataRate); easing.type: Easing.InOutQuad } }
    }
}
