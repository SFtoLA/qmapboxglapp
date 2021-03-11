import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0 as C2
import QtQuick.Layouts 1.0
import QtLocation 5.6
import QtPositioning 5.5

Row {
    property var map_plugin
    property alias startCoordinate: tempGeocodeModel.startCoordinate
    property alias endCoordinate: tempGeocodeModel.endCoordinate

    layoutDirection: Qt.LeftToRight
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    Button {
        id: sliderToggler
        width: 32
        height: 96
        checkable: true
        checked: true
        anchors.verticalCenter: parent.verticalCenter

        style: ButtonStyle {
            background: Rectangle {
                color: "transparent"
            }
        }

        property real shear: 0.333
        property real buttonOpacity: 0.5

        // an arrow from two sheared rectangles
        Rectangle {
            width: 16
            height: 48
            color: "seagreen"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.top
            anchors.left: sliderToggler.checked ? parent.left : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d: sliderToggler.checked ? 1.0 : -1.0
                matrix: Qt.matrix4x4(1.0, d * sliderToggler.shear, 0.0,
                                     0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
                                     0.0, 0.0, 0.0, 0.0, 1.0)
            }
        }
        Rectangle {
            width: 16
            height: 48
            color: "seagreen"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.verticalCenter
            anchors.right: sliderToggler.checked ? parent.right : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d: sliderToggler.checked ? -1.0 : 1.0
                matrix: Qt.matrix4x4(1.0, d * sliderToggler.shear, 0.0,
                                     0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
                                     0.0, 0.0, 0.0, 0.0, 1.0)
            }
        }
    }

    Rectangle {
        id: sliderContainer
        height: parent.height
        width: 450
        visible: sliderToggler.checked
        color: Qt.rgba(1, 1, 1, 0.5)

        RouteAddressForm {
            id: routeAddressForm

            signal showMessage(string topic, string message)
            signal showRoute(variant startCoordinate, variant endCoordinate)
            signal closeForm

            anchors.fill: parent

            GeocodeModel {
                id: tempGeocodeModel

                property int success: 0
                property variant startCoordinate
                property variant endCoordinate

                plugin: map_plugin

                onCountChanged: {
                    if (success == 1 && count == 1) {
                        query = toAddress
                        update()
                    }
                }

                onStatusChanged: {
                    if ((status == GeocodeModel.Ready) && (count == 1)) {
                        success++
                        if (success == 1) {
                            startCoordinate.latitude = get(
                                        0).coordinate.latitude
                            startCoordinate.longitude = get(
                                        0).coordinate.longitude
                        }
                        if (success == 2) {
                            endCoordinate.latitude = get(0).coordinate.latitude
                            endCoordinate.longitude = get(
                                        0).coordinate.longitude
                            success = 0
                            if (startCoordinate.isValid
                                    && endCoordinate.isValid)
                                showRoute(startCoordinate, endCoordinate)
                            else
                                goButton.enabled = true
                        }
                    } else if ((status == GeocodeModel.Ready)
                               || (status == GeocodeModel.Error)) {
                        var st = (success == 0) ? "start" : "end"
                        success = 0
                        if ((status == GeocodeModel.Ready) && (count == 0)) {
                            showMessage(qsTr("Geocode Error"),
                                        qsTr("Unsuccessful geocode"))
                            goButton.enabled = true
                        } else if (status == GeocodeModel.Error) {
                            showMessage(qsTr("Geocode Error"),
                                        qsTr("Unable to find location for the")
                                        + " " + st + " " + qsTr("point"))
                            goButton.enabled = true
                        } else if ((status == GeocodeModel.Ready)
                                   && (count > 1)) {
                            showMessage(qsTr("Ambiguous geocode"),
                                        count + " " + qsTr(
                                            "results found for the") + " " + st + " " + qsTr(
                                            "point, please specify location"))
                            goButton.enabled = true
                        }
                    }
                    console.log(startCoordinate)
                    console.log(endCoordinate)
                }
            }

            goButton.onClicked: {
                tempGeocodeModel.reset()
                fromAddress.country = fromCountry.text
                fromAddress.street = fromStreet.text
                fromAddress.city = fromCity.text
                toAddress.country = toCountry.text
                toAddress.street = toStreet.text
                toAddress.city = toCity.text
                tempGeocodeModel.startCoordinate = QtPositioning.coordinate()
                tempGeocodeModel.endCoordinate = QtPositioning.coordinate()
                tempGeocodeModel.query = fromAddress
                tempGeocodeModel.update()
                goButton.enabled = false
            }

            clearButton.onClicked: {
                fromStreet.text = ""
                fromCity.text = ""
                fromCountry.text = ""
                toStreet.text = ""
                toCity.text = ""
                toCountry.text = ""
            }

            cancelButton.onClicked: {
                closeForm()
            }

            Component.onCompleted: {
                fromStreet.text = fromAddress.street
                fromCity.text = fromAddress.city
                fromCountry.text = fromAddress.country
                toStreet.text = toAddress.street
                toCity.text = toAddress.city
                toCountry.text = toAddress.country
            }
        }
    }

    Address {
        id: toAddress
        street: "Holmenkollveien 140"
        city: "Oslo"
        country: "Norway"
        postalCode: "0791"
    }

    Address {
        id: fromAddress
        street: "Holmenkollveien 140"
        city: "Oslo"
        country: "Norway"
        postalCode: "0791"
    }

}
