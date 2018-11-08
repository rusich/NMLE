import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.3

Pane {
    id: panel
    width: 300
    property bool rightPanel: false
    Layout.fillHeight: true
    Layout.fillWidth:  false
    Layout.preferredWidth: width
    property alias color: bg.color

    background: Rectangle {
        id: bg
        color: "yellow"
        anchors.fill: parent
        Rectangle {
            id: panelResizer
            Component.onCompleted: {
                if(rightPanel)
                    anchors.left = parent.left
                else
                    anchors.right = parent.right
            }

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 2
            color: Qt.darker(parent.color)
            MouseArea {
                id: widthChanger
                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor
                drag.target: this
                drag.smoothed: true
                property real prevMove: 0
                preventStealing: true
                onMouseXChanged: {
                    if(drag.active){
                        if(panel.rightPanel) {
                            if(mouseX<0 && prevMove<0)
                                panel.width -= mouseX;
                            if(mouseX>0 && prevMove>0)
                                panel.width -= mouseX;
                            prevMove = mouseX;
                            console.log(mouseX)
                        }
                        else
                            panel.width += mouseX;
                    }
                }
            }
        }
    }
}
