import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Item {
    id: panel
    width: 300
    property bool rightPanel: false
    property alias color: bg.color
    Layout.fillHeight: true
    Layout.fillWidth:  false
    Layout.preferredWidth: width

    Rectangle {
        id: bg
        color: "yellow"
        anchors.fill: parent
    }

    Rectangle {
        id: panelResizer
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 3
        color: Qt.darker(parent.color)
        Component.onCompleted: {
            if(rightPanel)
                anchors.left = bg.left
            else
                anchors.right = bg.right
        }

        MouseArea {
            id: widthChanger
            anchors.fill: parent
            cursorShape: Qt.SizeHorCursor
            property real prevMove: 0
            preventStealing: false
            drag{ target: parent; axis: Drag.XAxis; smoothed: true }
            onMouseXChanged: {
                if(drag.active)
                {
                    if(panel.rightPanel) {
                        panel.width -= mouseX/3;
                    }
                    else
                        panel.width += mouseX;
                }
            }
        }
    }

}
