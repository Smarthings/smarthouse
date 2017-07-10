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
            ListElement { name: "Node 1"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 2"; status_node: 0; icon_type: "lamp"; type_node: 01; }
            ListElement { name: "Node 3"; status_node: 0; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 4"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 5"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 6"; status_node: 0; icon_type: "lamp"; type_node: 01; }
            ListElement { name: "Node 7"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 8"; status_node: 0; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 9"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 10"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 11"; status_node: 0; icon_type: "fan"; type_node: 01; }
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
                width: gridNodesList.cellWidth
                height: gridNodesList.cellHeight

                Item {
                    width: parent.width
                    height: parent.height

                    GroupBox {
                        id: groupbox_node
                        width: parent.width - 5
                        anchors.centerIn: parent
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
                                color: 'transparent'
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

                        Component.onCompleted: {
                            console.log(groupbox_node.height);
                        }

                        Row {
                            id: row_node
                            anchors.fill: parent

                            SmartIcon {
                                id: smarticon_node
                                iconName: (icon_type == "")? "lamp": icon_type
                                iconSize: 50
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
                                            y: switch_node.checked? parent.height - 1 - height: 1
                                            width: 80
                                            height: 38
                                            radius: 3
                                            color: Material.accent
                                            opacity: switch_node.checked? 1.0 : 0.10
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
                                    stepSize: 10
                                    value: 0
                                    to: 100
                                    anchors.right: parent.right
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

