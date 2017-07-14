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
    property int value: 0

    width: (itemWidth > 0)? itemWidth: dialWidth
    height: (itemHeight > 0)? itemHeight: dialHeight

    Label {
        id: label_root
        width: parent.width
        height: 10
        text: (dial_root.position * 100).toFixed(0) + "%"
        horizontalAlignment: Text.AlignHCenter
        color: text_color
        font.pixelSize: 20
        font.weight: Font.Light
        anchors.centerIn: parent
        z: 2

        states: [
            State {
                when: dial_root.pressed
                PropertyChanges {
                    target: label_root
                    color: Material.background
                    font.pixelSize: 30
                }
            }
        ]

        transitions: [
            Transition {
                ColorAnimation {
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

        background: Rectangle {
            id: rectangle_background
            x: dial_root.width  /2 - width  /2
            y: dial_root.height /2 - height /2

            width: parent.width
            height: parent.height
            radius: width /2
            border.color: Material.accent
            opacity: 0.8
            color: "transparent"

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
                        color: Material.accent
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
            width: 16
            height: 16
            radius: width /2
            color: Material.accent
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
                        color: Material.background
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
