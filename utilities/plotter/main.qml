/*
*  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de>
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

PlotterPage {
    // used for popup noticications
    property var notificationObj
    notificationObj: pageStack.currentPage.notification

    // used for settings
    property var settingsObj
}
