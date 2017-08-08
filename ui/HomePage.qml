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

    property variant stopwatch: tcpClient.stopwatchList

    Rectangle {
        id: rectangle_root
        width: parent.width
        height: homePage.height
        color: "transparent"

        ListModel {
            id: appModel
            ListElement { name: "Node 1"; status: 1; icon_type: ""; type: 00; }
            ListElement { name: "Node 2"; status: 0; icon_type: "lamp"; type: 01; }
            ListElement { name: "Node 3"; status: 50; icon_type: "fan"; type: 01; }
            ListElement { name: "Node 4"; status: 0; icon_type: "lamp"; type: 00; }
            ListElement { name: "Node 5"; status: 0; icon_type: "lamp"; type: 00; }
            ListElement { name: "Node 6"; status: 0; icon_type: ""; type: 01; }
            ListElement { name: "Node 7"; status: 0; icon_type: "lamp"; type: 00; }
            ListElement { name: "Node 8"; status: 100; icon_type: "fan"; type: 01; }
            ListElement { name: "Node 9"; status: 0; icon_type: "lamp"; type: 00; }
            ListElement { name: "Node 10"; status: 0; icon_type: "lamp"; type: 00; }
            ListElement { name: "Node 11"; status: 0; icon_type: ""; type: 01; }
            ListElement { name: "Node 12"; status: 0; icon_type: "fan"; type: 01; }
        }

        GridView {
            id: gridNodesList
            cellWidth: settings.size_nodes
            cellHeight: settings.size_nodes
            anchors.fill: parent
            focus: true

            anchors.leftMargin: size_nodes

            //model: appModel
            model: tcpClient.nodesList

            delegate: Item {
                id: item_content
                width: gridNodesList.cellWidth -10
                height: gridNodesList.cellHeight -10

                property string icon_type: "lamp"

                Rectangle {
                    id: rectangle_box
                    anchors.fill: parent
                    color: (model.modelData.range > 0)? Qt.rgba(Material.accent.r,
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
                                //iconColor: (status == 0)? Material.foreground : Material.accent
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

                            Column {
                                id: column_footer
                                anchors.centerIn: parent

                                Text {
                                    id: text_name
                                    text: model.modelData.name
                                    color: text_color
                                    font.weight: Font.Light
                                    font.pixelSize: 13
                                }
                            }

                            Row {
                                anchors.top: column_footer.bottom
                                anchors.topMargin: 4
                                width: parent.width

                                Item {
                                    id: item_footer_stopwatch
                                    width: parent.width /2
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    visible: false

                                    SmartIcon {
                                        id: icon_footer_block
                                        iconName: "clock"
                                        iconSize: 12
                                        iconColor: text_color
                                        opacity: 0.4
                                    }
                                    Text {
                                        id: text_footer_block
                                        text: "(00)"
                                        font.weight: Font.Light
                                        font.pixelSize: 10
                                        opacity: 0.4
                                        color: text_color
                                        anchors.left: icon_footer_block.right
                                    }
                                }
                                Item {
                                    width: parent.width /2
                                    anchors.right: parent.right
                                    Text {
                                        width: parent.width -5
                                        text: text_node(model.modelData.range, model.modelData.type)
                                        font.weight: Font.Light
                                        font.pixelSize: 10
                                        color: text_color
                                        opacity: 0.4
                                        horizontalAlignment: Text.AlignRight
                                    }
                                }

                                /*Text {
                                    text: "Text"
                                    font.weight: Font.Light
                                    font.pixelSize: 10
                                    opacity: 0.4

                                    width: parent.width /2
                                }
                                Text {
                                    text: text_node(model.modelData.range, model.modelData.type);
                                    font.weight: Font.Light
                                    font.pixelSize: 10
                                    opacity: 0.4

                                    width: (parent.width /2) - 10
                                    horizontalAlignment: Text.AlignRight
                                }*/
                            }

                            /*Text {
                                id: text_name
                                anchors.centerIn: parent
                                text: model.modelData.name
                                //text: name
                                color: text_color
                                font.weight: Font.Light
                                font.pixelSize: 12
                            }
                            Text {
                                text: text_node(model.modelData.range, model.modelData.type);
                                //text: text_node(range, type);
                                color: text_color
                                font.weight: Font.Light
                                font.pixelSize: 10
                                opacity: 0.4
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5
                                anchors.right: parent.right
                                anchors.rightMargin: 5
                            }*/
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
                            if (model.modelData.status != 0) {
                                if (model.modelData.type == 0) {
                                    if (model.modelDatarange > 0) {
                                        model.modelDatarange = 0
                                    } else {
                                        model.modelData.range = 1
                                    }
                                }
                                if (model.modelData.type == 1) {
                                    if (model.modelData.range > 0) {
                                        model.modelData.range = 0
                                    } else {
                                        model.modelData.range = 100
                                    }
                                }
                                var prepareRange = (model.modelData.range <= 1)? model.modelData.range: model.modelData.range -1;
                                tcpClient.setSendCommandNode({
                                                                 "name": model.modelData.name,
                                                                 "action": {
                                                                     "range": completeZero(prepareRange, 2)
                                                                 }
                                                             });
                            }
                        }

                        onClicked: {
                            stackView.push("qrc:/ui/NodePage.qml",
                                           {
                                               id: index,
                                               name: model.modelData.name,
                                               status: model.modelData.status,
                                               range: model.modelData.range,
                                               type: model.modelData.type,
                                               icon_type: icon_type
                                           })
                            window.header.title_page = model.modelData.name
                        }
                    }
                }
            }
        }

        Connections {
            target: homePage
            onStopwatchChanged: {
                getStopwatch();
                //console.log(stopwatch[0].name, stopwatch[0].range, stopwatch[0].start, stopwatch[0].end);
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
            if (type == 0) {
                text = qsTr("ON")
            }
            if (type == 1) {
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

