import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan
ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1100
    height: 700
    title: qsTr("Hello World")

    Qan.GraphView {
        anchors.fill: parent
        resizeHandlerColor: Material.accent
        gridThickColor: Material.theme === Material.Dark ? "#4e4e4e" : "#c1c1c1"
        graph: Qan.Graph {
            id: graph
            // ...
//            selectionColor: Material.accent
//            connectorColor: Material.accent
//            connectorEdgeColor: Material.accent
            Component.onCompleted: {    // Qan.Graph.Component.onCompleted()
                var n3 = graph.insertNode();
                n3.label = "N3"; n3.item.x = 500; n3.item.y = 100;
            }
            // ...
        } // Qan.Graph
        // ...
    } // Qan.Gr
}
