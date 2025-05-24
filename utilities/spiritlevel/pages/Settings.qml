/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>
  */
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: settings_page
    SilicaFlickable {
        id: settings_flickable
        anchors.fill: parent
        Component.onCompleted:
        {
            if(config.contrast === "low")
                contrast_combo.currentIndex = 0
            else if (config.contrast === "high")
                contrast_combo.currentIndex = 1

            if(config.style === "regular")
            {
                regular_switch.checked = true
                unidimensional_switch.checked = false
            }
            else if(config.style === "unidimensional")
            {
                regular_switch.checked = false
                unidimensional_switch.checked = true
            }

            if(config.uni_style === "both")
                unidimensional_combo.currentIndex = 0;
            else if(config.uni_style === "X")
                unidimensional_combo.currentIndex = 1;
            else if(config.uni_style === "Y")
                unidimensional_combo.currentIndex = 2;
        }

        Column {
            id: column
            width: settings_page.width
            spacing: Theme.paddingSmall
            PageHeader {
                title: qsTr("Settings")
            }
            SectionHeader {
                text: "Style"
            }
            TextSwitch {
                id: regular_switch
                text: "Regular style"
                checked: config.style == "regular" ? true : false
                automaticCheck: false
                onClicked:
                {
                    if(checked)
                    {
                        config.style == "unidimensional"
                    }
                    else
                    {
                        config.style = "regular";
                        checked = true;
                        unidimensional_switch.checked = false;
                    }
                }
            }
            TextSwitch {
                id: unidimensional_switch
                text: "Unidimensional style"
                checked: config.style == "unidimensional" ? true : false
                automaticCheck: false
                onClicked:
                {
                    if(checked)
                    {

                    }
                    else
                    {
                        config.style = "unidimensional";
                        checked = true;
                        regular_switch.checked = false;
                    }
                }
            }
            ComboBox {
                id: unidimensional_combo
                width: settings_page.width
                label: "Axis"
                currentIndex: 0
                enabled: unidimensional_switch.checked
                menu: ContextMenu {
                    MenuItem { text: "Both" }
                    MenuItem { text: "X axis" }
                    MenuItem { text: "Y axis" }
                }
                onCurrentIndexChanged:
                {
                    if(currentIndex == 0)
                        config.uni_style = "both"
                    else if(currentIndex == 1)
                        config.uni_style = "X"
                    else if(currentIndex == 2)
                        config.uni_style = "Y"
                }
            }
            ComboBox {
                id: contrast_combo
                width: settings_page.width
                label: "Contrast"
                currentIndex: 0

                menu: ContextMenu {
                    MenuItem { text: qsTr("Regular contrast") }
                    MenuItem { text: qsTr("High contrast") }
                }
                onCurrentIndexChanged:
                {
                    if(currentIndex == 0)
                        config.contrast = "low";
                    if(currentIndex == 1)
                        config.contrast = "high";
                }
            }
        }
    }
}
