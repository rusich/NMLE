import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import "./components"
import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan

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
        visible: true
        SmallMenu {
            title: qsTr("&File")
            SmallMenuItem { text: qsTr("&New..."); onTriggered: console.log("New")  }
            SmallMenuItem { text: qsTr("&Open...");  }
            SmallMenuItem { text: qsTr("&Save") }
            SmallMenuItem { text: qsTr("Save &As...") }
            SmallMenuSeparator { }
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
                onClicked: contextMenu.popup()
            }
        }
    }

    RowLayout {
        id: workArea
        anchors.fill: parent
        spacing: 0

        SidePanel {
            id: leftPanel
            BlocksLibrary {

            }

ListView {
                    id: selectionListView
                    x: 0
                    y: 600
                    width: 200
                    height: 200
                    clip: true

                    model: graphView.selectedNodes      // <---------
                    spacing: 4; focus: true; flickableDirection : Flickable.VerticalFlick
                    highlightFollowsCurrentItem: false
                    highlight: Rectangle {
                        x: 0; y: ( selectionListView.currentItem !== null ? selectionListView.currentItem.y : 0 );
                        width: selectionListView.width; height: selectionListView.currentItem.height
                        color: "lightsteelblue"; opacity: 0.7; radius: 5
                    }
                    delegate: Item {
                        id: selectedNodeDelegate
                        width: ListView.view.width; height: 30;
                        Text { text: "Label: " + itemData.label }       // <----- itemData is a Qan.Node, node
                                                                        // label could be accessed directly
                        MouseArea {
                            anchors.fill: selectedNodeDelegate
                            onClicked: { selectedNodeDelegate.ListView.view.currentIndex = index }
                        }
                    }
                }

        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth:  true
            clip: true

            Qan.GraphView {
                id: graphView
                anchors.fill: parent

                navigable   : true
                graph: Qan.Graph {
                    id: graph
                    Component.onCompleted: {    // Qan.Graph.Component.onCompleted()
                        var n3 = graph.insertNode();
                        n3.label = "N3"; n3.item.x = 500; n3.item.y = 100;
                        //                        var n3p1 = graph.insertInPort(n3, Qan.NodeItem.Left);

                        //                        n3p1.label = "IN #1";

                        //                        var n3p1 = graph.insertInPort(n3, Qan.NodeItem.Top);
                        //                        n3p1.label = "OUT #1";
                        //                        var n3p2 = graph.insertInPort(n3, Qan.NodeItem.Bottom);
                        //                        n3p2.label = "OUT #2";

                        //                        var e = graph.insertEdge(n2, n3);
                        //                        graph.bindEdgeDestination(e, n2p3);  // Bind our edge source to node N2 port P3 (OUT #1)
                        //                        graph.bindEdgeDestination(e, n3p1);  // Bind our edge destination to node N3 port P1 (IN #1)
                    }
                } // Qan.Graph: topology
            } // Qan.GraphView
        }
    }
    SmallMenu {
        id: contextMenu
        SmallMenuItem {
            text: qsTr("&Copy")
            enabled: true
            onTriggered:  graph.insertNode()
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



    footer: TabBar {
        // ...
    }
}
