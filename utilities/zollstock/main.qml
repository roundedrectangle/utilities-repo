import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

import "pages"

MainPage {
     ConfigurationGroup {
        id: settings
        path: "/apps/harbour-zollstock"
        synchronous: true

        property int maximumLength: 2000
        property real scalingFactor: 1.0

        onScalingFactorChanged: Helper.scalingFactor = scalingFactor
        Component.onCompleted: Helper.scalingFactor = scalingFactor
    }
}
