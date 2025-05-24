import QtQuick 2.6
import Sailfish.Silica 1.0

IconButton {
    property Item editor
    onClicked: editor.text = ""

    width: icon.width
    height: icon.height
    icon.source: "image://theme/icon-splus-clear"
    opacity: editor.text.length > 0 ? 1.0 : 0.0
    Behavior on opacity { FadeAnimation {} }
}
