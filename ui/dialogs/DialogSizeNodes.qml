import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../components/"

Item {
    property alias dialog: dialog_size_nodes

    Dialog {
        id: dialog_size_nodes
        title: qsTr("Tamanho dos acessórios")
        modal: true

        x: Math.round((window.width - width) /2)
        y: 50
        width: 300

        contentItem: Rectangle {
            color: "transparent"
            implicitWidth: parent.width
            implicitHeight: 350

            Column {
                width: parent.width
                spacing: 10

                Slider {
                    id: slider_size_nodes
                    width: parent.width
                    orientation: Qt.Horizontal

                    from: 100
                    to: 280
                    value: settings.size_nodes
                    stepSize: 5.0

                    onValueChanged: {
                        settings.size_nodes = (slider_size_nodes.value).toFixed(0)
                    }
                }
                Text {
                    id: text_label
                    text: (slider_size_nodes.value).toFixed(0)
                    color: text_color
                }

                Item {
                    id: item_node_example
                    width: parent.width
                    height: (slider_size_nodes.value).toFixed(0)

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "transparent"

                        Rectangle {
                            id: rectangle_box
                            width: (slider_size_nodes.value).toFixed(0) -10
                            height: width
                            color: background_nodes
                            radius: 10
                            border.color: line_color
                            opacity: 0.80

                            anchors.centerIn: parent

                            Column {
                                id: column_item
                                anchors.fill: parent

                                Item {
                                    id: item_block
                                    width: parent.width
                                    height: parent.height /2

                                    SmartIcon {
                                        id: smarticon
                                        iconName: "lamp"
                                        iconSize: Math.min(item_block.width, item_block.height)
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
                                        anchors.centerIn: parent
                                        text: qsTr("Exemplo")
                                        color: text_color
                                        font.weight: Font.Light
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
