import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

    Item {
    id: item

    property int dialWidth: 90
    property int dialHeight: 90
    property int itemWidth: 0
    property int itemHeight: 0
    property int setValue: 0
    property alias _dial: dial_root

    width: (itemWidth > 0)? itemWidth: dialWidth
    height: (itemHeight > 0)? itemHeight: dialHeight

    Label {
        id: label_root
        width: parent.width
        height: 10
        text: (dial_root.position * 100).toFixed(0) + "%"
        horizontalAlignment: Text.AlignHCenter
        color: Material.foreground
        font.pixelSize: 15
        font.weight: Font.Light
        x: 0
        y: width /2
        z: 2

        states: [
            State {
                when: dial_root.pressed
                PropertyChanges {
                    target: label_root
                    x: -width/2 +15
                    font.pixelSize: 20
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "x"
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }
        ]
    }
    Dial {
        id: dial_root
        width: dialWidth
        height: dialHeight
        anchors.centerIn: parent
        value: range / 100

        background: Rectangle {
            id: rectangle_background
            x: dial_root.width  /2 - width  /2
            y: dial_root.height /2 - height /2

            width: parent.width
            height: parent.height
            radius: width /2
            border.color: Material.accent
            color: Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, dial_root.value)

            states: [
                State {
                    name: "pressed"
                    when: dial_root.pressed
                    PropertyChanges {
                        target: rectangle_background
                        opacity: 1.0
                    }
                    PropertyChanges {
                        target: rectangle_background
                        //color: Material.accent
                    }
                }
            ]
            transitions: [
                Transition {
                    ColorAnimation {
                        duration: 200
                    }
                    NumberAnimation {
                        properties: "opacity"
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }
            ]
        }

        handle: Rectangle {
            id: rectangle_handle
            x: dial_root.background.x + dial_root.background.width /2 - width /2
            y: dial_root.background.y + dial_root.background.height /2 - height /2
            width: 28
            height: 28
            radius: width /2
            color: Material.accent
            border.color: background_items
            border.width: 3
            antialiasing: true
            transform: [
                Translate {
                    y: -Math.min(dial_root.background.width, dial_root.background.height) *0.4 + rectangle_handle.height /2
                },
                Rotation {
                    angle: dial_root.angle
                    origin.x: rectangle_handle.width /2
                    origin.y: rectangle_handle.height /2
                }
            ]

            states: [
                State {
                    when: dial_root.pressed
                    PropertyChanges {
                        target: rectangle_handle
                        //color: Material.background
                    }
                }
            ]

            transitions: [
                Transition {
                    ColorAnimation {
                        duration: 500
                    }
                }
            ]
        }
    }

}
