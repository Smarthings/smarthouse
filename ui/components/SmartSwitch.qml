import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: item

    property int switchWidth: 90
    property int switchHeight: 90
    property int itemWidth: 0
    property int itemHeight: 0
    property bool check: switch_root.checked
    property int value: 0

    Component.onCompleted: {
        if (value == 0) {
            switch_root.checked = false
        } else {
            switch_root.checked = true
        }
    }

    width: (itemWidth > 0)? itemWidth: switchWidth
    height: (itemHeight > 0)? itemHeight: switchHeight

    Switch {
        id: switch_root
        width: switchWidth
        height: switchHeight
        text: (switch_root.checked)? "On" : "Off"
        anchors.centerIn: parent

        indicator: Rectangle {
            implicitHeight: switch_root.height -10
            implicitWidth: switch_root.width -10
            x: switch_root.leftPadding
            y: parent.height /2 - height /2
            radius: 10
            border.color: Material.accent
            color: "transparent"

            Rectangle {
                id: rectangle_switch
                x: 0
                state: switch_root.checked? "on" : "off"
                width: parent.width
                height: parent.height /2 -2
                radius: 10
                color: Material.accent
                opacity: switch_root.checked? 1.0: 0.25

                states: [
                    State {
                        name: "on"
                        PropertyChanges {
                            target: rectangle_switch
                            y: parent.height /2 +1
                        }
                    },
                    State {
                        name: "off"
                        PropertyChanges {
                            target: rectangle_switch
                            y: 1
                        }
                    }
                ]

                transitions: [
                    Transition {
                        NumberAnimation {
                            properties: "y"
                            easing.type: Easing.InOutQuad
                            duration: 200
                        }
                    }
                ]
            }
        }

        contentItem: Text {
            text: switch_root.text
            font: switch_root.font
            color: Material.accent
            anchors.top: parent.top
            anchors.topMargin: (switch_root.checked)? (rectangle_switch.height /2):
                                                      (rectangle_switch.height + rectangle_switch.height /2)
            horizontalAlignment: Text.AlignHCenter
            z: 2
        }
    }
}
