import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    property alias fromStreet: fromStreet
    property alias fromState: fromState
    property alias toStreet: toStreet
    property alias toCity: toCity
    property alias toState: toState
    property alias fromCity: fromCity
    property alias goButton: goButton
    property alias clearButton: clearButton

    Rectangle {
        id: tabRectangle
        y: 20
        height: tabTitle.height * 2
        color: "#46a2da"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Item {
        id: item2
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 75
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle.bottom

        GridLayout {
            id: gridLayout3
            rowSpacing: 10
            rows: 1
            columns: 2
            anchors.fill: parent

            Label {
                id: label1
                text: qsTr("From")
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                Layout.columnSpan: 2
            }

            Label {
                id: label2
                text: qsTr("Street")
            }

            TextField {
                id: fromStreet
                Layout.fillWidth: true
            }

            Label {
                id: label3
                text: qsTr("City")
            }

            TextField {
                id: fromCity
                Layout.fillWidth: true
            }

            Label {
                id: label7
                text: qsTr("State")
            }

            TextField {
                id: fromState
                Layout.fillWidth: true
            }

            Label {
                id: label6
                text: qsTr("To")
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                Layout.columnSpan: 2
            }

            Label {
                id: label4
                text: qsTr("Street")
            }

            TextField {
                id: toStreet
                Layout.fillWidth: true
            }

            Label {
                id: label5
                text: qsTr("City")
            }

            TextField {
                id: toCity
                Layout.fillWidth: true
            }

            Label {
                id: label8
                text: qsTr("State")
            }

            TextField {
                id: toState
                Layout.fillWidth: true
            }

            RowLayout {
                id: rowLayout1
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignRight

                Button {
                    id: goButton
                    text: qsTr("Proceed")
                }

                Button {
                    id: clearButton
                    text: qsTr("Clear")
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.columnSpan: 2
            }
        }
    }
}
