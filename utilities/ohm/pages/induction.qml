import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    property int resScale: mainapp.smallScreen ? 1 : mainapp.mediumScreen ? 2 : 2

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        contentWidth: page.width
        VerticalScrollDecorator {}
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingSmall
            property real dotspace: resScale === 1 ? Theme.itemSizeSmall / 2.2 : Theme.itemSizeSmall / 2.2 * ( resScale * 0.7)
            property bool defaultdimm: false
            property double calcohm: 0
            property real rings: 4
            property string ohmvalue : " H"
            property int maxDotWidth: Math.min(Screen.width, Screen.height) / rings

            PageHeader {
                title: qsTr("Inductor Colorcode")
            }

            function resolvId(nr) {
                //console.log("resolvid: " + nr);
                switch(nr) {
                case 0 : return "#000000";
                case 1 : return "#854928";
                case 2 : return "#ff0000";
                case 3 : return "#ff9900";
                case 4 : return "#ffff00";
                case 5 : return "#008000";
                case 6 : return "#0000ff";
                case 7 : return "#ee82ee";
                case 8 : return "#808080";
                case 9 : return "#ffffff";
                case -1 : return "#ffd700";
                case -2 : return "#c0c0c0";
                default : return "transparent"
                }
            }
            function setcolor() {
               // console.log("setcolor");
                for (var i = 0; i < column.rings; i++) {
                    colorrings.itemAt(i).color = column.resolvId(storevalues.itemAt(i).val);
                }
            }

            function setpositions() {
                var startpsX = 0
                var startpsY = 0
                var shiftX = 4.9 * resScale
                var ringwidth = 6.2 * resScale
                if (column.rings === 3) {
                    startpsX = 36.4 * resScale
                    startpsY = 27.5 * resScale
                }
                if (column.rings === 4) {
                    startpsX = 31 * resScale
                    startpsY = 29 * resScale
                }
                if (column.rings === 5) {
                    startpsX = 24.6 * resScale
                    startpsY = 29 * resScale
                }
                if (column.rings === 6) {

                }
                for (var i = 0; i < column.rings; i++) {
                    colorrings.itemAt(i).x = startpsX + ((shiftX + ringwidth)*i);
                    //console.log("col: " + colorrings.itemAt(i).color);
                    //console.log("x: " + colorrings.itemAt(i).x);
                    colorrings.itemAt(i).y = startpsY;
                }

            }

            Image {
                id : img
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    topMargin: Theme.paddingSmall /4
                    bottomMargin: Theme.paddingSmall / 4
                }
                fillMode: Image.PreserveAspectFit
                source: {
                    if (mainapp.isLightTheme) {
                        var rev_color = "_rev"
                    } else {
                        var rev_color = ""
                    }
                    return "../img/resistor_4rings" + rev_color + ".png"
                }
                width: 100 * resScale
                height: 100 * resScale
                z : 1
                Repeater {
                    id : colorrings
                    model : column.rings
                    Rectangle {
                        color : "transparent"
                        width : 5.7 * resScale
                        height : 44.5 * resScale
                        z : 100
                    }
                }
            }

            // insert graphic here
            Label {
                id : ohmlabel
                text : qsTr(" H")
                font.pixelSize: Theme.fontSizeMedium
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    topMargin: Theme.paddingSmall /4
                    bottomMargin: Theme.paddingSmall / 4
                }
            }

            Separator {
                id: effect
                color: Theme.primaryColor
                width: page.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
            }

            Item {
                width: 1
                height: Theme.paddingMedium
            }

            function updateRow1(row) {
                for (var i = 0; i < row.model; i++) {
                    //console.log("index is: " + i + " rep.model is: " + row.model)
                    if (i === 0) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                    if ((i === 3) && (row.model === 4)) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                }
            }
            function updateRow4_5(row) {
                for (var i = 0; i < row.model; i++) {
                    //console.log("index is: " + i + " rep.model is: " + row.model)
                    if ((i === 3) && (row.model === 4)) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                }
            }
            function updateRow9(row) {
                for (var i = 0; i < row.model; i++) {
                    //console.log("index is: " + i + " rep.model is: " + row.model)
                    if ((i === 3) && (row.model === 4)) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                }
            }
            function updateRow6_7_8_9_10(row) {
                for (var i = 0; i < row.model; i++) {
                    if ((i == 2) || (i == 3) && (row.model ===4)) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                }
            }

            function updateRow10_11(row) {
                for (var i = 0; i < row.model; i++) {
                    if ((i === 0 || i === 1 ) && (row.model === 4)) {
                        if (!(row.itemAt(i) === null)) {
                            row.itemAt(i).color = "transparent";
                        }
                    }
                }
            }
            function clearcolumn(column) {
                //console.log("column: " + column)
                if (column <= rep00.model) {
                    //console.log("rep00 :" + rep00.model)
                    rep00.itemAt(column).dimmed = true;
                    rep00.itemAt(column).radius = 1.0;
                    rep00.itemAt(column).ratio = 1.0;
                }
                if (column <= rep10.model) {
                    //console.log("rep10 :" + rep10.model)
                    rep10.itemAt(column).dimmed = true;
                    rep10.itemAt(column).radius = 1.0;
                    rep10.itemAt(column).ratio = 1.0;
                }
                if (column <= rep20.model) {
                    //console.log("rep20 :" + rep20.model)
                    rep20.itemAt(column).dimmed = true;
                    rep20.itemAt(column).radius = 1.0;
                    rep20.itemAt(column).ratio = 1.0;
                }
                if (column <= rep30.model) {
                    //console.log("rep30 :" + rep30.model)
                    rep30.itemAt(column).dimmed = true;
                    rep30.itemAt(column).radius = 1.0;
                    rep30.itemAt(column).ratio = 1.0;
                }
                if (column <= rep40.model) {
                    //console.log("rep40 :" + rep40.model)
                    rep40.itemAt(column).dimmed = true;
                    rep40.itemAt(column).radius = 1.0;
                    rep40.itemAt(column).ratio = 1.0;
                }
                if (column <= rep50.model) {
                    //console.log("rep50 :" + rep50.model)
                    rep50.itemAt(column).dimmed = true;
                    rep50.itemAt(column).radius = 1.0;
                    rep50.itemAt(column).ratio = 1.0;
                }
                if (column <= rep60.model) {
                    //console.log("rep60 :" + rep60.model)
                    rep60.itemAt(column).dimmed = true;
                    rep60.itemAt(column).radius = 1.0;
                    rep60.itemAt(column).ratio = 1.0;
                }
                if (column <= rep70.model) {
                    //console.log("rep70 :" + rep70.model)
                    rep70.itemAt(column).dimmed = true;
                    rep70.itemAt(column).radius = 1.0;
                    rep70.itemAt(column).ratio = 1.0;
                }
                if (column <= rep80.model) {
                    //console.log("rep80 :" + rep80.model)
                    rep80.itemAt(column).dimmed = true;
                    rep80.itemAt(column).radius = 1.0;
                    rep80.itemAt(column).ratio = 1.0;
                }
                if (column <= rep90.model) {
                    //console.log("rep90 :" + rep90.model)
                    rep90.itemAt(column).dimmed = true;
                    rep90.itemAt(column).radius = 1.0;
                    rep90.itemAt(column).ratio = 1.0;
                }
                if (column <= rep100.model) {
                    //console.log("rep100 :" + rep100.model)
                    rep100.itemAt(column).dimmed = true;
                    rep100.itemAt(column).radius = 1.0;
                    rep100.itemAt(column).ratio = 1.0;
                }
                if (column <= rep110.model) {
                    //console.log("rep110 :" + rep110.model)
                    rep110.itemAt(column).dimmed = true;
                    rep110.itemAt(column).radius = 1.0;
                    rep110.itemAt(column).ratio = 1.0;
                }
            }
            /* resistor values are stored in this repeater */
            /*  0 = black,
                1 = brown,
                2 = red,
                3 = orange,
                4 = yellow,
                5 = green,
                6 = blue,
                7 = violet,
                8 = grey,
                9 = white
                -1 = gold
                -2 = silver */
            Repeater {
                id : storevalues
                model : column.rings
                Item {
                    property int val: 0
                }
            }
            Text {
                id : transpcolor
                color : "transparent"
            }

            function valueset(colorr,index) {

                var i = 0;
                var color = "" + colorr
                switch (color) {
                case "#000000" : i = 0; /* black */
                    break;
                case "#854928" : i = 1; /* brown */
                   // console.log("brown");
                    break;
                case "#ff0000" : i = 2;
                   // console.log("red") /* red */
                    break;
                case "#ff9900" : i = 3; /* orange */
                    break;
                case "#ffff00" : i = 4; /* yellow */
                    break;
                case "#008000" : i = 5; /* green */
                    break;
                case "#0000ff" : i = 6; /* blue */
                    break;
                case "#ee82ee" : i = 7; /* violett */
                    break;
                case "#808080" : i = 8; /* grey */
                    break;
                case "#ffffff" : i = 9; /* white */
                    break;
                case "#ffd700" : i = -1; /* gold */
                    break;
                case "#c0c0c0" : i = -2; /* silver */
                    break;
                default :
                    break;
                }
                storevalues.itemAt(index).val = i;
                //console.log("index:" + index + " color: " + color + " value: " + storevalues.itemAt(index).val);
                column.ohmvalue = "";
                for (i = 0; i < column.rings; i++) {
                    column.ohmvalue += storevalues.itemAt(i).val;
                }

            }
            function clickhandler(color,index,row) {
                if (color !== transpcolor.color) {
                    column.clearcolumn(index);
                    column.valueset(color,index);
                    column.updateval()
                    column.setcolor()
                    column.setpositions()
                    row.itemAt(index).dimmed = false;
                    row.itemAt(index).ratio = 0.0;
                    row.itemAt(index).radius = 10.0;
                }
            }
            function getunitprefix() {
                var val = 0;
                if (column.rings === 3 || column.rings === 4) {
                    val = storevalues.itemAt(2).val;
                    switch (val) {
                    case 0 : return "µ"
                    case 1 : return "0µ"
                    case 2 : return "m"
                    case 3 : return "m"
                    case 4 : return "0m"
                    case -1 : return "µ"
                    case -2 : return "0n"
                    default : return ""
                    }
                } else {
                    return "";
                }


            }
            function valuehandler() {
                var tmp = 0;
                if (column.rings === 3 || column.rings === 4) {
                    tmp = (storevalues.itemAt(0).val *10) + storevalues.itemAt(1).val;
                    //console.log("tmp: " + tmp)
                    switch (storevalues.itemAt(2).val) {
                    case 2 : tmp = tmp / 10;
                        break;
                    case 5 : tmp = tmp / 10;
                        break;
                    case -1 : tmp = tmp / 10;
                        break;
                    default : break
                    }
                    column.calcohm = tmp;
                }
                if (column.rings === 5 || column.rings === 6) {
                    tmp = (storevalues.itemAt(0).val *100) + (storevalues.itemAt(1).val*10) + storevalues.itemAt(2).val;
                    //console.log("tmp: " + tmp)
                    switch (storevalues.itemAt(3).val) {
                    case 1 : tmp = tmp / 100;
                        break;
                    case 2 : tmp = tmp / 10;
                        break;
                    case 4 : tmp = tmp / 100;
                        break;
                    case 5 : tmp = tmp / 10;
                        break;
                    case -1 : tmp = tmp / 10;
                        break;
                    case -2 : tmp = tmp / 100;
                        break;
                    default : break
                    }
                    column.calcohm = tmp;
                }

            }

            function getprecision() {
                if (column.rings === 4) {
                    switch (storevalues.itemAt(3).val) {
                    case -2 : return "± 10%"
                    case -1 : return "± 5%"
                    case 0 : return "± 20%"
                    case 1 : return "± 1%"
                    case 2 : return "± 2%"
                    case 3 : return "± 3%"
                    case 4 : return "± 4%"
                    default : return ""
                    }
                }
            }

            function updateval() {
                column.valuehandler();
                column.ohmvalue = column.getunitprefix() + "H " + column.getprecision();
                ohmlabel.text = column.calcohm + column.ohmvalue;
            }


            Row { /* row 1, Black Colorvalue */
                id : row0
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater black GlassItem */
                    id : rep00
                    model : column.rings
                    //onModelChanged: column.updateRow1(rep00)
                    GlassItem { /* black GlassItem */
                        color : "#000000"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea00
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep00)
                        }
                    }
                    //                    Component.onCompleted: column.updateRow1(rep00)
                }
            }

            Row { /* row 2, Brown Colorvalue */
                id : row1
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    id : rep10
                    model : column.rings
                    GlassItem {
                        color : "#854928" /* brown */
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea10
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep10)
                        }
                    }
                }
            }
            Row { /* row 3, Red Colorvalue */
                id : row2
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    id : rep20
                    model : (column.rings)
                    GlassItem {
                        color : "#ff0000"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea20
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep20)
                        }
                    }
                }
            }
            Row { /* row 4, Orange Colorvalue */
                id : row3
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater orange */
                    id : rep30
                    model : column.rings
                    //onModelChanged: column.updateRow4_5(rep30)
                    //Component.onCompleted: column.updateRow4_5(rep30)

                    GlassItem {
                        color : "#ff9900" /* orange*/
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea30
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep30)
                        }
                    }
                }
            }
            Row { /* row 5, Yellow Colorvalue */
                id : row4
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, yellow */
                    id : rep40
                    model : (column.rings)
                    //onModelChanged: column.updateRow4_5(rep40)
                    //Component.onCompleted: column.updateRow4_5(rep40)
                    GlassItem {
                        color : "#ffff00"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea40
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep40)
                        }
                    }
                }
            }
            Row { /* row 6, Green Colorvalue */
                id : row5
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater green */
                    id : rep50
                    model : (column.rings)
                    onModelChanged: column.updateRow6_7_8_9_10(rep50)
                    Component.onCompleted: column.updateRow6_7_8_9_10(rep50)
                    GlassItem {
                        color : "#008000"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea50
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep50)
                        }
                    }
                }
            }
            Row { /* row 7, Blue Colorvalue */
                id : row6
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, blue */
                    id : rep60
                    model : (column.rings)
                    onModelChanged: column.updateRow6_7_8_9_10(rep60)
                    Component.onCompleted: column.updateRow6_7_8_9_10(rep60)
                    GlassItem {
                        color : "#0000ff"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea60
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep60)
                        }
                    }
                }
            }
            Row { /* row 8, Violet Colorvalue */
                id : row7
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, violet */
                    id :rep70
                    model : (column.rings)
                    onModelChanged: column.updateRow6_7_8_9_10(rep70)
                    Component.onCompleted: column.updateRow6_7_8_9_10(rep70)
                    GlassItem {
                        color : "#ee82ee"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea70
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep70)
                        }
                    }
                }
            }
            Row { /* row 9, Grey Colorvalue */
                id : row8
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, grey */
                    id : rep80
                    model : (column.rings)
                    onModelChanged: column.updateRow6_7_8_9_10(rep80)
                    Component.onCompleted: column.updateRow6_7_8_9_10(rep80)
                    GlassItem {
                        color : "#808080"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea80
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep80)
                        }
                    }
                }
            }
            Row { /* row 10, White Colorvalue */
                id : row9
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, white */
                    id : rep90
                    model : (column.rings)
                    onModelChanged: column.updateRow6_7_8_9_10(rep90)
                    Component.onCompleted: column.updateRow6_7_8_9_10(rep90)
                    GlassItem {
                        color : "#ffffff"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea90
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep90)
                        }
                    }
                }
            }
            Row { /* row 11, Gold Colorvalue */
                id : row10
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, gold */
                    id : rep100
                    model : (column.rings)
                    onModelChanged: column.updateRow10_11(rep100)
                    Component.onCompleted: column.updateRow10_11(rep100)
                    GlassItem {
                        color : "#ffd700"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea100
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep100)
                        }
                    }
                }
            }
            Row { /* row 12, Silver Colorvalue */
                id : row11
                height: column.dotspace
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater { /* repeater, silver */
                    id : rep110
                    model : (column.rings)
                    onModelChanged: column.updateRow10_11(rep110)
                    Component.onCompleted: column.updateRow10_11(rep110)
                    GlassItem {
                        color : "#c0c0c0"
                        cache: false
                        dimmed : column.defaultdimm
                        width: column.maxDotWidth
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            id : buttonMouseArea110
                            width: parent.width
                            height: column.dotspace + column.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: column.clickhandler(color,index,rep110)
                        }
                    }
                }
            }

            Item {
                width: 1
                height: Theme.paddingLarge
            }
        }
    }

}
