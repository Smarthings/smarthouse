import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./components/"

ScrollablePage {
    id: homePage

    Rectangle {
        id: rectangle_root
        width: parent.width
        height: homePage.height
        color: "transparent"

        GridView {
            id: grid_nodesList
            cellWidth: settings.size_nodes
            cellHeight: settings.size_nodes
            anchors.fill: parent
            anchors.leftMargin: size_nodes
            focus: true

            model: tcpClient.getNodes
            delegate: SmartNode {
                id: smart_node
                width: grid_nodesList.cellWidth -10
                height: grid_nodesList.cellHeight -10

                nodeName: model.modelData.name
                nodeRange: text_node(model.modelData.range, model.modelData.type)
                backgroundColor: (model.modelData.range > 0)? Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.05) :
                                                              background_nodes
                nodeNotification.children: Item {
                    width: parent.width
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    SmartIcon {
                        iconName: "alarm"
                        iconSize: 12
                        visible: (model.modelData.time !== undefined && model.modelData.time > 0)? true : false
                    }
                }

                states: [
                    State {
                        when: mouserArea_node.pressed
                        PropertyChanges {
                            target: smart_node.nodeBlock
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
                        var range_value;
                        if (model.modelData.status != 0) {
                            if (model.modelData.range > 0) {
                                range_value = 0
                            } else {
                                range_value = 99
                            }
                            tcpClient.setSendCommandNode({
                                "name": model.modelData.name,
                                "action": {
                                    "range": completeZero(range_value, 2)
                                }
                            });
                        }
                    }

                    onClicked: {
                        stackView.push("qrc:/ui/Node.qml", {id: index})
                        window.header.title_page = model.modelData.name
                    }
                }
            }
        }
    }

    function getStopwatch()
    {
        for (var i = 0; i < stopwatch.length; i++) {
            var key = search(stopwatch[i].name, tcpClient.nodesList, "name");
            //console.log(gridNodesList.model[key].name);
            //gridNodesList.model[key].item_footer_stopwatch = true;
        }
    }

    function search(str, list, key)
    {
        console.log("search", str, key);
        for (var i = 0; i < list.length; i++) {
            if (list[i][key] == str) {
                return i;
            }
        }
        return -1;
    }

    function text_node (range, type)
    {
        var text = "";
        if (range == 0) {
            text = qsTr("OFF");
        } else {
            if (type == 1) {
                text = qsTr("ON")
            }
            if (type == 2) {
                text = qsTr("ON") + " " + range + "%"
            }
        }
        return text;
    }

    function completeZero(str, length) {
        while (str.length < length)
            str = "0" + str;
        return str.toString();
    }
}

