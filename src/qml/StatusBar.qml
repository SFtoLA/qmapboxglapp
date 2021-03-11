import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: statusBar

    height: 40

    Image {
        anchors.fill: parent

        source: "qrc:simple-bottom-background.png"
    }

    RowLayout {
        anchors.fill: parent
        DateAndTime {
            Layout.leftMargin: 10
            Layout.bottomMargin: 15
            Layout.alignment : Qt.AlignLeft
        }
    }
}
