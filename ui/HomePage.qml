import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./components/"

ScrollablePage {
    id: homePage
    /*property bool statusConn: tcpClient.status_conn
    property int numberNodes: tcpClient.tcpStringList.length
    property int updateNodes: tcpClient.nodesUpdate/

    /*Grid {
        id: grid_items
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        columns: 3
        spacing: 6

        Rectangle { color: "#aa6666"; width: 90; height: 90 }
        Rectangle { color: "#aaaa66"; width: 90; height: 90 }
        Rectangle { color: "#9999aa"; width: 90; height: 90 }
        Rectangle { color: "#6666aa"; width: 90; height: 90 }
    }*/

    Rectangle {
        id: rectangle_root
        width: parent.width
        height: homePage.height
        color: "transparent"

        ListModel {
            id: appModel
            ListElement { name: "Node 1"; status_node: 0; icon_type: ""; type_node: 00; }
            ListElement { name: "Node 2"; status_node: 0; icon_type: "lamp"; type_node: 01; }
            ListElement { name: "Node 3"; status_node: 0; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 4"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 5"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 6"; status_node: 0; icon_type: ""; type_node: 01; }
            ListElement { name: "Node 7"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 8"; status_node: 0; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 9"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 10"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 11"; status_node: 0; icon_type: ""; type_node: 01; }
            ListElement { name: "Node 12"; status_node: 0; icon_type: "fan"; type_node: 01; }
        }

        GridView {
            id: gridNodesList
            cellWidth: size_nodes
            cellHeight: 160
            anchors.fill: parent
            focus: true
            //model: tcpClient.nodesList
            model: appModel

            delegate: Item {
                id: item_content
                width: gridNodesList.cellWidth - 5
                height: gridNodesList.cellHeight

                Item {
                    width: parent.width
                    height: parent.height

                    GroupBox {
                        id: groupbox_node
                        width: parent.width - 5
                        title: name

                        background: Item {
                            id: groupbox_item
                            width: parent.width
                            height: parent.height - (groupbox_node.topPadding) + 10
                            y: groupbox_node.topPadding - groupbox_node.padding

                            Rectangle {
                                id: groupbox_rectangle
                                width: parent.width
                                height: parent.height
                                color: background_items
                                border.color: line_color
                                radius: 3
                            }

                            DropShadow {
                                anchors.fill: groupbox_item
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 3
                                samples: 10
                                color: shadow_color
                                source: groupbox_rectangle
                            }
                        }

                        Row {
                            id: row_node
                            anchors.fill: parent

                            Column {
                                width: parent.width - column_switch.width
                                height: parent.height

                                SmartIcon {
                                    id: smarticon_node
                                    iconName: (icon_type == "")? "microchip": icon_type
                                    iconSize: 50
                                }

                                Item {
                                    width: parent.width
                                    height: row_node.height - smarticon_node.height
                                    SmartIcon {
                                        id: smarticon_alarm
                                        iconName: "alarm"
                                        anchors {
                                            right: parent.right
                                            left: parent.left
                                            bottom: parent.bottom
                                        }
                                        button: true
                                    }
                                }
                            }

                            Column {
                                id: column_switch
                                enabled: (type_node == 00)? true : false
                                visible: (type_node == 00)? true : false
                                width: parent.width - smarticon_node.width

                                Switch {
                                    id: switch_node
                                    width: 90
                                    height: 110
                                    anchors.right: parent.right
                                    text: switch_node.checked ? "On" : "Off"

                                    indicator: Rectangle {
                                        implicitHeight: 80
                                        implicitWidth: 80
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
                                            width: 80
                                            height: 38
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
                                enabled: (type_node == 01)? true : false
                                visible: (type_node == 01)? true : false
                                width: parent.width - smarticon_node.width

                                Label {
                                    id: label_range
                                    width: parent.width
                                    height: 20
                                    text: (dial_range.position * 100).toFixed(0) + "%"
                                    horizontalAlignment: Text.AlignRight
                                }

                                Dial {
                                    id: dial_range
                                    width: 90
                                    height: 90
                                    anchors.right: parent.right

                                    stepSize: 10
                                    value: 0
                                    to: 100

                                    onAngleChanged: {
                                        console.log(dial_range.angle)
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

    function completeZero(str) {
        while (str.length < 3)
            str = "0" + str;
        return str.toUtf8();
    }
}

