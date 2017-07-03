import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

ScrollablePage {
    id: nodePage

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Column {
            width: 200

            GroupBox {
                id: node_group
                width: parent.width
                title: "Node"

                background: Item {
                    id: item_groupbox
                    width: parent.width
                    height: parent.height - (node_group.topPadding) + 10
                    y: node_group.topPadding - node_group.padding

                    Rectangle {
                        id: rectangle_groupbox
                        width: parent.width
                        height: parent.height
                        color: window.background_items
                        border.color: window.line_color
                        radius: 5.0
                    }

                    DropShadow {
                        anchors.fill: item_groupbox
                        horizontalOffset: 1
                        verticalOffset: 1
                        radius: 5.0
                        samples: 10
                        color: window.shadow_color
                        source: rectangle_groupbox
                    }
                }

                Row {
                    id: row
                    anchors.fill: parent
                    Image {
                        id: node_icon
                        source: "../img/icons/"+settings.theme+"/lamp50x50.png"
                    }

                    Column {
                        id: column
                        width: parent.width - node_icon.width

                        Dial {
                            id: node_range
                            width: 90
                            height: 90
                            stepSize: 10.0
                            value: 5.0
                            to: 100.0
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                        }
                        Label {
                            id: range_label
                            width: parent.width
                            text: (node_range.position * 100).toFixed(0) + "%"
                            horizontalAlignment: Text.AlignRight
                            anchors.rightMargin: 10
                        }
                    }
                }
            }
        }

        Column {
            width: 200

            GroupBox {
                id: node_group2
                width: parent.width
                title: "Node"

                background: Item {
                    id: item_groupbox2
                    width: parent.width
                    height: parent.height - (node_group2.topPadding) + 10
                    y: node_group.topPadding - node_group2.padding

                    Rectangle {
                        id: rectangle_groupbox2
                        width: parent.width
                        height: parent.height
                        color: window.background_items
                        border.color: window.line_color
                        radius: 5.0
                    }

                    DropShadow {
                        anchors.fill: item_groupbox2
                        horizontalOffset: 1
                        verticalOffset: 1
                        radius: 5.0
                        samples: 10
                        color: window.shadow_color
                        source: rectangle_groupbox2
                    }
                }

                Row {
                    id: row2
                    anchors.fill: parent
                    Image {
                        id: node_icon2
                        source: "../img/icons/"+settings.theme+"/lamp50x50.png"
                    }

                    Column {
                        id: column2
                        width: parent.width - node_icon2.width

                        Switch {
                            id: control
                            width: 90
                            height: 90
                            anchors.right: parent.right

                            indicator: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 26
                                x: control.leftPadding
                                y: parent.height / 2 - height / 2
                                radius: 13
                                color: control.checked ? "#17a81a" : "#ffffff"
                                border.color: control.checked ? "#17a81a" : "#cccccc"

                                Rectangle {
                                    x: control.checked ? parent.width - width : 0
                                    width: 26
                                    height: 26
                                    radius: 13
                                    color: control.down ? "#cccccc" : "#ffffff"
                                    border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
                                }
                            }

                            contentItem: Text {
                                text: control.text
                                font: control.font
                                opacity: enabled ? 1.0 : 0.3
                                color: control.down ? "#17a81a" : "#21be2b"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: control.indicator.width + control.spacing
                            }
                        }
                    }
                }
            }
        }

        /*Column {
            width: 200
            Switch {

                style: SwitchStyle {
                    groove: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 20
                            radius: 9
                            border.color: control.activeFocus ? "darkblue" : "gray"
                            border.width: 1
                    }
                }
             }
        }*/


    }


}
