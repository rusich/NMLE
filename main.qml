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

    menuBar: MenuBar {
        id: mainMenu
        scale: 1
        topPadding: scale * -20
        height: scale*40
        Menu {
            title: qsTr("&File")
            Action { text: qsTr("&New...")  }
            Action { text: qsTr("&Open...") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("Save &As...") }
            MenuSeparator { }
            Action { text: qsTr("&Quit") }
        }
        Menu {
            title: qsTr("&Edit")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Help")
            Action { text: qsTr("&About") }
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
                Menu {
                    id: contextMenu

                    MenuItem {
                        text: qsTr("Copy")
                        enabled: true
                        //            enabled: textArea.selectedText
                        //onTriggered: textArea.copy()
                    }
                    MenuItem {
                        text: qsTr("Cut")
                        //            enabled: textArea.selectedText
                        //            onTriggered: textArea.cut()
                    }
                    MenuItem {
                        text: qsTr("Paste")
                        //            enabled: textArea.canPaste
                        //            onTriggered: textArea.paste()
                    }

                    MenuSeparator {}

                    MenuItem {
                        text: qsTr("Font...")
                        //            onTriggered: fontDialog.open()
                    }

                    MenuItem {
                        text: qsTr("Color...")
                        //            onTriggered: colorDialog.open()
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
