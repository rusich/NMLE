import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
Rectangle {
    anchors.margins: 3
    anchors.rightMargin: 5
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height / 2

    color: Qt.lighter(Material.primary)
    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 0
        height: 35
        color: Material.primary
        Text {
            font.bold: true
            font.pixelSize: 18
            color: "white"
            clip: true
            text: qsTr("Blocks Library")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
        }
    }

    Rectangle {
        id: searchBox
        color: parent.color
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40

        TextField {
            id: field
            placeholderText: qsTr("Filter")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            font.pixelSize: 14
        }
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: searchBox.bottom
        ListModel {
            id: blocksModel
            ListElement { name: "One"; blockImage: "qrc:/images/qtlogo.png" }
            ListElement { name: "Two"; blockImage: "qrc:/images/qtlogo.png" }
            ListElement { name: "Three"; blockImage: "qrc:/images/qtlogo.png" }
            ListElement { name: "Four"; blockImage: "qrc:/images/qtlogo.png" }
            ListElement { name: "Five"; blockImage: "qrc:/images/qtlogo.png" }
        }

        Component {
            id: blockDeleagte
            Item {

                Column {
                    Image {
                        id: img;
                        source: blockImage; //model
                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            id: dndArea
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            property var dragIndicator
                            onPressed: {
                                dragIndicator = Qt.createQmlObject('import QtQuick 2.0; Image {}',
                                                   mainWindow);
                                var p = img.mapToItem(mainWindow.contentItem, 0, 65);
                                dragIndicator.source = img.source;
                                dragIndicator.x = p.x;
                                dragIndicator.y = p.y;
                                dragIndicator.opacity = 0.7;
                                dragIndicator.Drag.active = true;

                            }

                            drag.target: dragIndicator
                            drag.minimumY: mainMenu.implicitHeight+menuBar.implicitHeight
                            onReleased: {
                                dragIndicator.destroy();
                            }
                            drag.onActiveChanged: {
                                if (!dndArea.drag.active)
                                    dragIndicator.Drag.drop();
                            }
                        }
                    }
                    Text { text: name; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }
        }

        GridView {
            id: blocksList
            anchors.fill: parent
            anchors.margins: 0
            model: blocksModel
            clip: true
            delegate: blockDeleagte
            interactive: false
        }
    }
}

