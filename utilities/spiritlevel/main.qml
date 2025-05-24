/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>

*/
import QtQuick 2.5
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import QtSensors 5.0
import "pages"
import "utils/localdb.js" as Db

FirstPage {
    id: app_window
    QtObject {
        id:config
        //"text":x.isOpen?qsTr("Open"):qsTr("Closed")
        property bool first_use: true
        property string contrast: "high" //Db.getProp("contrast") // "high" // or "high"
        property string uni_style: "both" // Db.getProp("uni_style") // "both" // or  X or Y
        property string style: "regular" //Db.getProp("style") // "regular" // or "unidimensional"
        property real x_cal: 0.0 // Db.getProp("x_cal") //0.0  //x_acel_cal
        property real y_cal: 0.0 // Db.getProp("y_cal") //0.0  //x_acel_cal
        onFirst_useChanged: changed()
        onContrastChanged: changed()
        onUni_styleChanged: changed()
        onStyleChanged: changed()
        onX_calChanged: changed()
        onY_calChanged: changed()

        signal changed()
    }
    Connections {
        target: config
        onChanged: {
            /*
            console.log("changed")
            console.log(config.uni_style)
            console.log(config.style)
            console.log(config.contrast)
            console.log(config.x_cal)
            console.log(config.y_cal)
            */
            Db.setProp("contrast",config.contrast)
            Db.setProp("uni_style",config.uni_style)
            Db.setProp("style",config.style)
            Db.setProp("x_cal",config.x_cal)
            Db.setProp("y_cal",config.y_cal)
        }
    }
    property string contrast: config.contrast
    /*
    onReleased: {
        Database.setProp('saveFps',String(sliderValue))
        saveFps = sFps.sliderValue
    }
    Component.onCompleted: {
        value = Database.getProp('saveFps')
        if (value < 1 )
            value = 5
        saveFps = value
    }*/
    Component.onCompleted:
    {
        var fuse = Db.getProp('first_use')
        if( fuse !== "false" ) {
           // init the db
            //console.log(fuse)
            Db.setProp("first_use","false")
            Db.setProp("contrast","high")
            Db.setProp("uni_style","both")
            Db.setProp("style","regular")
            config.x_cal = accel.x_acel_cal
            config.y_cal = accel.y_acel_cal
            Db.setProp("x_cal",config.x_cal)
            Db.setProp("y_cal",config.y_cal)
        }
        if( fuse === "false" ) {
            //console.log(fuse)
            var contrast = Db.getProp("contrast")
            var style = Db.getProp("style")
            var uni_style = Db.getProp("uni_style")
            var x_cal = Db.getProp("x_cal")
            var y_cal = Db.getProp("y_cal")

            // FIRST uni_style
            config.uni_style = uni_style
            config.contrast = contrast
            config.style = style

            config.x_cal = x_cal
            accel.x_acel_cal = x_cal
            config.y_cal = y_cal
            accel.y_acel_cal = y_cal

        }
    }

    Accelerometer {
        id: accel
        active: (Qt.application.active || acel_ativo)

        property bool acel_ativo: true
        property int filter: 6
        property int precisao: 1

        property real x_acel: 0
        property real x_acel_cal: 0
        property real y_acel: 0
        property real y_acel_cal: 0

        onReadingChanged: {
            var aux = (accel.reading.x * 9.174);
            aux = aux > 90 ? 90 : aux
            x_acel = (((filter - 1) * x_acel + aux) / filter).toFixed(precisao)
            aux = (accel.reading.y * 9.174);
            aux = aux > 90 ? 90 : aux
            y_acel = (((filter - 1) * y_acel + aux) / filter).toFixed(precisao)
        }
        onX_acel_calChanged:
        {
            config.x_cal = x_acel_cal
        }
        onY_acel_calChanged:
        {
            config.y_cal = y_acel_cal
        }
    }
}


