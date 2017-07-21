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
    property int updateNodes: tcpClient.nodesUpdate*/

    Rectangle {
        id: rectangle_root
        width: parent.width
        height: homePage.height
        color: "transparent"

        ListModel {
            id: appModel
            ListElement { name: "Node 1"; status_node: 1; icon_type: ""; type_node: 00; }
            ListElement { name: "Node 2"; status_node: 0; icon_type: "lamp"; type_node: 01; }
            ListElement { name: "Node 3"; status_node: 50; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 4"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 5"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 6"; status_node: 0; icon_type: ""; type_node: 01; }
            ListElement { name: "Node 7"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 8"; status_node: 100; icon_type: "fan"; type_node: 01; }
            ListElement { name: "Node 9"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 10"; status_node: 0; icon_type: "lamp"; type_node: 00; }
            ListElement { name: "Node 11"; status_node: 0; icon_type: ""; type_node: 01; }
            ListElement { name: "Node 12"; status_node: 0; icon_type: "fan"; type_node: 01; }
        }

        GridView {
            id: gridNodesList
            cellWidth: settings.size_nodes
            cellHeight: settings.size_nodes
            anchors.fill: parent
            focus: true

            anchors.leftMargin: size_nodes

            Component.onCompleted: {
                //console.log(gridNodesList.cellWidth)
            }

            model: appModel

            delegate: Item {
                id: item_content
                width: gridNodesList.cellWidth -10
                height: gridNodesList.cellHeight -10

                Rectangle {
                    id: rectangle_box
                    anchors.fill: parent
                    color: (status_node > 0)? Qt.rgba(Material.accent.r,
                                                      Material.accent.g,
                                                      Material.accent.b, 0.15) : background_nodes
                    radius: 10
                    border.color: line_color
                    opacity: 0.80

                    Column {
                        id: column_item
                        anchors.fill: parent

                        Item {
                            id: item_block
                            width: parent.width
                            height: parent.height /2

                            SmartIcon {
                                id: smarticon
                                iconName: (icon_type == "")? "microchip": icon_type
                                iconSize: Math.min(item_block.width, item_block.height)
                                //iconColor: (status_node == 0)? Material.foreground : Material.accent
                                itemWidth: parent.width
                                itemHeight: parent.height

                                anchors.top: parent.top
                                anchors.topMargin: 5
                            }
                        }

                        Item {
                            id: item_text
                            width: parent.width
                            height: parent.height /2

                            Text {
                                id: text_name
                                anchors.centerIn: parent
                                text: name
                                color: text_color
                                font.weight: Font.Light
                                font.pixelSize: 12
                            }
                            Text {
                                text: text_node(status_node, type_node);
                                color: text_color
                                font.weight: Font.Light
                                font.pixelSize: 10
                                opacity: 0.4
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5
                                anchors.right: parent.right
                                anchors.rightMargin: 5
                            }
                        }
                    }

                    states: [
                        State {
                            when: mouserArea_node.pressed
                            PropertyChanges {
                                target: rectangle_box
                                opacity: 0.5
                                scale: 1.1
                                z: 100
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            NumberAnimation {
                                properties: "scale, opacity"
                                easing.type: Easing.InOutQuad
                                duration: 100
                            }
                        }
                    ]

                    MouseArea {
                        id: mouserArea_node
                        anchors.fill: parent

                        onPressAndHold: {
                            if (type_node == 0) {
                                if (status_node > 0) {
                                    status_node = 0
                                } else {
                                    status_node = 1
                                }
                            }
                            if (type_node == 1) {
                                if (status_node > 0) {
                                    status_node = 0
                                } else {
                                    status_node = 100
                                }
                            }
                        }

                        onClicked: {
                            stackView.push("qrc:/ui/NodePage.qml",
                                           {
                                               id: index,
                                               name: name,
                                               status_node: status_node,
                                               type_node: type_node,
                                               icon_type: icon_type
                                           })
                            window.header.title_page = name
                        }
                    }
                }
            }
        }
    }

    function text_node (status_node, type_node)
    {
        var text = "";
        if (status_node == 0) {
            text = qsTr("OFF");
        } else {
            if (type_node == 0) {
                text = qsTr("ON")
            }
            if (type_node == 1) {
                text = qsTr("ON") + " " + status_node + "%"
            }
        }
        return text;
    }

    function completeZero(str) {
        while (str.length < 3)
            str = "0" + str;
        return str.toUtf8();
    }
}

