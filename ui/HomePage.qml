import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

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
            ListElement { name: "Node 1"; status_node: 0 }
            ListElement { name: "Node 2"; status_node: 0 }
            ListElement { name: "Node 3"; status_node: 0 }
            ListElement { name: "Node 4"; status_node: 0 }
            ListElement { name: "Node 5"; status_node: 0 }
            ListElement { name: "Node 6"; status_node: 0 }
            ListElement { name: "Node 7"; status_node: 0 }
            ListElement { name: "Node 8"; status_node: 0 }
            ListElement { name: "Node 9"; status_node: 0 }
            ListElement { name: "Node 10"; status_node: 0 }
            ListElement { name: "Node 11"; status_node: 0 }
            ListElement { name: "Node 12"; status_node: 0 }
        }
        GridView {
            id: gridNodesList
            cellWidth: size_nodes
            cellHeight: 100
            anchors.fill: parent
            focus: true
            model: tcpClient.nodesList

            //highlight: Rectangle {
            //    id: index_rec
            //    width: 100
            //    height: 100
            //    color: Material.color(settings.color_theme, Material.Shade50)
            //    Component.onCompleted: {
            //        console.log(index_rec.color)
            //        console.log(Material.color(settings.color_theme))
            //    }
            //}

            delegate: Item {
                id: item_content
                width: gridNodesList.cellWidth
                height: gridNodesList.cellHeight

                Rectangle {
                    id: rectangle_item
                    anchors.fill: item_content
                    color: background_items
                    border.width: 1
                    border.color: line_color
                    radius: 3
                }

                DropShadow {
                    anchors.fill: item_content
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 3.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_item
                }

                Image {
                    id: icon
                    width: 50
                    height: 50
                    source: "../img/lamp.png"
                    anchors {
                        top: parent.top
                        topMargin: 10
                        left: parent.left
                        leftMargin: 10
                    }
                }

                Text {
                    text: model.modelData.name + ", " + size_nodes
                    font.weight: Font.Light
                    color: title_color
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                /*
                id: item_content
                width: gridNodesList.cellWidth - 10
                height: gridNodesList.cellHeight - 10
                enabled: (model.modelData.status == 1)? true : false
                Rectangle {
                    id: rectangle_item
                    anchors.fill: item_content
                    color: background_items
                    border.width: 1
                    border.color: line_color
                    radius: 3
                }
                DropShadow {
                    anchors.fill: item_content
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 3.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_item
                }

                Image {
                    id: icon
                    width: parent.width - 50
                    height: parent.height - 50
                    source: (model.modelData.range > 000)? "../img/torch-on.png" : "../img/torch-off.png"
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        topMargin: 5
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (model.modelData.range == 0) {
                                model.modelData.range = 1
                            } else {
                                model.modelData.range = 0;
                            }
                            var command = "#" + completeZero(model.modelData.range) + "0" + model.modelData.name + ":"
                            tcpClient.setSendCommandNode(command)
                        }
                    }
                }

                Text {
                    text: model.modelData.name
                    font.weight: Font.Light
                    color: title_color
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                //MouseArea {
                //    anchors.fill: parent
                //    onClicked: parent.GridView.view.currentIndex = index
                //}
                */
            }
        }
    }
    /*Component.onCompleted: {
        //tcpClient.getNodesFromServer();
        gridNodesList.model = tcpClient.nodesList
    }*/

    function completeZero(str) {
        while (str.length < 3)
            str = "0" + str;
        return str;
    }
}

