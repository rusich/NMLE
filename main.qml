import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import "./components"

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1100
    height: 700
    title: qsTr("Hello World")

    Settings {
        category: "MainWindow"
        property alias x: mainWindow.x
        property alias y: mainWindow.y
        property alias width: mainWindow.width
        property alias height: mainWindow.height
        property alias leftPanelWidth: leftPanel.width
    }

    menuBar: SmallMenuBar {
        id: mainMenu
        SmallMenu {
            scale: 0.2
            title: qsTr("&File")
            SmallMenuItem { text: qsTr("&New..."); onTriggered: console.log("New")  }
            SmallMenuItem { text: qsTr("&Open...") }
            SmallMenuItem { text: qsTr("&Save") }
            SmallMenuItem { text: qsTr("Save &As...") }
            MenuSeparator { }
            SmallMenuItem { text: qsTr("&Quit") }
        }
        SmallMenu {
            title: qsTr("&Edit")
            SmallMenuItem { text: qsTr("Cu&t") }
            SmallMenuItem { text: qsTr("&Copy") }
            SmallMenuItem { text: qsTr("&Paste") }
        }
        SmallMenu {
            title: qsTr("&Help")
            SmallMenuItem { text: qsTr("&About") }
            SmallMenuItem { text: qsTr("&About") }
        }

    }
    header: ToolBar {
        id: tb
        height: 40
        RowLayout {
            height: tb.height
            anchors.fill: parent
            ToolButton {
                implicitHeight: parent.height
                text: qsTr("‹")
                //                onClicked: stack.pop()
            }
            Label {
                height: tb.height
                text: "Title"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                implicitHeight: parent.height
                height: tb.height
                text: qsTr("⋮")
                onClicked: mainMenu.popup()
            }
        }
    }

    RowLayout {
        id: workArea
        anchors.fill: parent
        spacing: 0

        SidePanel {
            id: leftPanel
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth:  true
            color: "red"
            MouseArea {
                acceptedButtons: Qt.RightButton
                anchors.fill: parent
                onPressed: {
                    contextMenu.popup();
                    console.log(mouse.button);
                }
                SmallMenu {
                    id: contextMenu
                    SmallMenuItem {
                        text: qsTr("&Copy")
                        enabled: true
                        onTriggered: console.log("Copy")
                        //            enabled: textArea.selectedText
                        //onTriggered: textArea.copy()
                    }
                    SmallMenuItem {
                        text: qsTr("Copy")
                        enabled: true
                        //            enabled: textArea.selectedText
                        //onTriggered: textArea.copy()
                    }

                    SmallMenuSeparator {}

                    SmallMenuItem {
                        text: qsTr("Font...")
                        //            onTriggered: fontDialog.open()
                    }

                }

            }
        }
        SidePanel{
            id: rightPanel
            rightPanel: true
        }

    }


    footer: TabBar {
        // ...
    }
}
