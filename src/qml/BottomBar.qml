import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: bottomBar

    property alias traffic: trafficButton.checked
    property alias night: nightButton.checked

    height: 175

    Image {
        anchors.fill: parent

        source: "qrc:simple-bottom-background.png"
    }

    RowLayout {
        anchors.fill: parent

        ButtonTool {
            id: trafficButton

            height: parent.height
            Layout.leftMargin: 20
            Layout.alignment: Qt.AlignLeft

            text: "TRAFFIC"
            checked: true
        }

        ButtonTool {
            id: nightButton

            height: parent.height
            Layout.rightMargin: 20
            Layout.alignment: Qt.AlignRight

            text: "NIGHT"
            checked: true
        }
    }
}
