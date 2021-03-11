import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

import com.mapbox.cheap_ruler 1.0
import "qrc:/qml"

ApplicationWindow {
    id: window

    property var carSpeed: 100 // Km/h
    property var navigating: true

    title: "Mapbox GL Demo"
    width: 768
    height: 1024
    visible: true

    Item {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        StatusBar {
            id: statusBar

            anchors.left: parent.left
            anchors.right: parent.right

            z: 1
        }

        MapWindow {
            id: mapWindow

            anchors.top: statusBar.bottom
            anchors.bottom: bottomBar.top
            anchors.left: parent.left
            anchors.right: parent.right

            z: 0

            carSpeed: window.carSpeed
            navigating: window.navigating
            traffic: bottomBar.traffic
            night: bottomBar.night
        }

        BottomBar {
            id: bottomBar

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            z: 1
        }
    }
}
