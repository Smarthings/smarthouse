import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
//import QtQuick.Controls.Styles 1.4

import "./components/"

ScrollablePage {
    id: nodePage

    property string name: ""
    property string status_node: ""
    property string type_node: ""
    property string icon_type: ""

    ColumnLayout {
        id: column_general
        anchors.fill: parent

        Column {
            Layout.fillWidth: true
            spacing: 1

            Item {
                id: item_root
                width: parent.width
                height: 200

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "transparent"

                    Row {
                        anchors.fill: parent

                        Item {
                            width: parent.width /2
                            height: parent.height
                            SmartIcon {
                                id: smarticon
                                iconName: (icon_type == "")? "microchip": icon_type
                                iconSize: Math.min(parent.width, parent.height)
                                itemWidth: parent.width
                                itemHeight: parent.height
                            }
                        }
                        Item {
                            width: parent.width /2
                            height: parent.height

                            Column {
                                width: parent.width
                                height: parent.height

                                Column {
                                    id: column_switch
                                    width: parent.width
                                    height: parent.height
                                    enabled: (type_node == 0)? true: false
                                    visible: (type_node == 0)? true: false

                                    Switch {
                                        id: switch_node
                                        width: Math.min(parent.width, parent.height) -50
                                        height: Math.min(parent.width, parent.height) -50
                                        text: switch_node.checked ? "On" : "Off"

                                        indicator: Rectangle {
                                            implicitHeight: switch_node.width -10
                                            implicitWidth: switch_node.height -10
                                            x: switch_node.leftPadding
                                            y: parent.height / 2 - height / 2
                                            radius: 3
                                            color: "transparent"
                                            border.color: Material.accent

                                            Rectangle {
                                                id: rectangle_switch
                                                x: 0
                                                state: switch_node.checked? "on": "off"
                                                //y: switch_node.checked? parent.height - 1 - height: 1
                                                width: parent.width
                                                height: parent.height /2 -2
                                                radius: 3
                                                color: Material.accent
                                                opacity: switch_node.checked? 1.0 : 0.10

                                                states: [
                                                    State {
                                                        name: "on"
                                                        PropertyChanges {
                                                            target: rectangle_switch
                                                            y: parent.height /2 + 1
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

                                            DropShadow {
                                                anchors.fill: rectangle_switch
                                                horizontalOffset: 1
                                                verticalOffset: 1
                                                radius: 3
                                                samples: 10
                                                color: window.shadow_color
                                                source: rectangle_switch
                                            }
                                        }

                                        contentItem: Text {
                                            text: switch_node.text
                                            font: switch_node.font
                                            color: Material.accent
                                            anchors.top: parent.top
                                            anchors.topMargin: (switch_node.checked)? (rectangle_switch.height / 2):
                                                                                      (rectangle_switch.height + rectangle_switch.height / 2)
                                            horizontalAlignment: Text.AlignHCenter
                                            z: 2
                                        }
                                    }
                                }

                                Column {
                                    id: column_range
                                    width: parent.width
                                    height: parent.height
                                    enabled: (type_node == 01)? true : false
                                    visible: (type_node == 01)? true : false

                                    Label {
                                        id: label_range
                                        width: parent.width
                                        height: 20
                                        text: (dial_range.position * 100).toFixed(0) + "%"
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Dial {
                                        id: dial_range
                                        width: parent.width -50
                                        height: parent.height -50

                                        stepSize: 10
                                        value: 0
                                        to: 100

                                        onAngleChanged: {
                                            //console.log(dial_range.angle)
                                        }

                                        background: Rectangle {
                                            id: rectangle_background

                                            x: dial_range.width /2 - width /2
                                            y: dial_range.height /2 - height /2
                                            width: Math.max(64, Math.min(dial_range.width, dial_range.height))
                                            height: width

                                            color: "transparent"
                                            radius: width /2
                                            border.color: Material.accent
                                            opacity: 0.8

                                            states: [
                                                State {
                                                    name: "pressed"
                                                    when: dial_range.pressed
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
                                            x: dial_range.background.x + dial_range.background.width /2 - width /2
                                            y: dial_range.background.y + dial_range.background.height /2 - height /2
                                            width: 16
                                            height: 16
                                            radius: 8
                                            color: Material.accent
                                            antialiasing: true
                                            transform: [
                                                Translate {
                                                    y: -Math.min(dial_range.background.width, dial_range.background.height) *0.4 + rectangle_handle.height /2
                                                },
                                                Rotation {
                                                    angle: dial_range.angle
                                                    origin.x: rectangle_handle.width /2
                                                    origin.y: rectangle_handle.height /2
                                                }
                                            ]

                                            states: [
                                                State {
                                                    when: dial_range.pressed
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

                            }
                        }
                    }
                }
            }
        }
    }
}
