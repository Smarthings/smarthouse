import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
//import QtQuick.Controls.Styles 1.4

import "./components/"

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
                        color: 'transparent'
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

                    SmartIcon {
                        id: node_icon
                        iconName: "lamp"
                        iconSize:  50
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
                    SmartIcon {
                        id: node_icon2
                        iconName: "lamp"
                        iconSize: 50
                    }

                    Column {
                        id: column2
                        width: parent.width - node_icon2.width

                        Switch {
                            id: control
                            width: 90
                            height: 90
                            anchors.right: parent.right
                            text: control.checked ? "On" : "Off"

                            indicator: Rectangle {
                                implicitWidth: 80
                                implicitHeight: 80
                                x: control.leftPadding
                                y: parent.height / 2 - height / 2
                                radius: 3
                                color: "transparent"
                                border.color: Material.accent

                                Component.onCompleted: {
                                    console.log(control.leftPadding, parent.height);
                                }

                                Rectangle {
                                    id: switch_rectangle
                                    x: 0
                                    y: control.checked ? parent.height - 1 - height : 1
                                    width: 80
                                    height: 38
                                    radius: 3
                                    color: Material.accent
                                    opacity: control.checked? 1.0 : 0.10
                                }

                                DropShadow {
                                    anchors.fill: switch_rectangle
                                    horizontalOffset: 1
                                    verticalOffset: 1
                                    radius: 3
                                    samples: 10
                                    color: window.shadow_color
                                    source: switch_rectangle
                                }
                            }

                            contentItem: Text {
                                text: control.text
                                font: control.font
                                color: Material.accent
                                anchors.top: parent.top
                                anchors.topMargin: (control.checked)? (switch_rectangle.height / 2) :
                                                                      (switch_rectangle.height + switch_rectangle.height / 2)
                                horizontalAlignment: Text.AlignHCenter
                                z: 2
                            }
                        }
                    }
                }
            }
        }


        Column {
            width: 200

            GroupBox {
                id: node_group3
                width: parent.width
                title: "Node"

                background: Item {
                    id: item_groupbox3
                    width: parent.width
                    height: parent.height - (node_group3.topPadding) + 10
                    y: node_group3.topPadding - node_group3.padding

                    Rectangle {
                        id: rectangle_groupbox3
                        width: parent.width
                        height: parent.height
                        color: 'transparent'
                        border.color: window.line_color
                        radius: 5.0
                    }

                    DropShadow {
                        anchors.fill: item_groupbox3
                        horizontalOffset: 1
                        verticalOffset: 1
                        radius: 5.0
                        samples: 10
                        color: window.shadow_color
                        source: rectangle_groupbox3
                    }
                }

                Row {
                    id: row3
                    anchors.fill: parent
                    SmartIcon {
                        id: node_icon3
                        iconName: "lamp"
                        iconSize: 50
                    }

                    Column {
                        id: column3
                        width: parent.width - node_icon3.width

                        Dial {
                            id: node_range3
                            width: 90
                            height: 90
                            stepSize: 10.0
                            value: 5.0
                            to: 100.0
                            anchors.right: parent.right
                            anchors.rightMargin: 10

                            background: Rectangle {
                                x: node_range3.width / 2 - width / 2
                                y: node_range3.height / 2 - height / 2
                                width: Math.max(64, Math.min(node_range3.width, node_range3.height))
                                height: width
                                color: "transparent"
                                radius: width / 2
                                border.color: node_range3.pressed ? "#17a81a" : "#21be2b"
                                opacity: node_range3.enabled ? 1 : 0.3
                            }

                            handle: Rectangle {
                                id: handleItem
                                x: node_range3.background.x + node_range3.background.width / 2 - width / 2
                                y: node_range3.background.y + node_range3.background.height / 2 - height / 2
                                width: 16
                                height: 16
                                color: node_range3.pressed ? "#17a81a" : "#21be2b"
                                radius: 8
                                antialiasing: true
                                opacity: node_range3.enabled ? 1 : 0.3
                                transform: [
                                    Translate {
                                        y: -Math.min(node_range3.background.width, node_range3.background.height) * 0.4 + handleItem.height / 2
                                    },
                                    Rotation {
                                        angle: node_range3.angle
                                        origin.x: handleItem.width / 2
                                        origin.y: handleItem.height / 2
                                    }
                                ]
                            }
                        }
                        Label {
                            id: range_label3
                            width: parent.width
                            text: (node_range3.position * 100).toFixed(0) + "%"
                            horizontalAlignment: Text.AlignRight
                            anchors.rightMargin: 10
                        }
                    }
                }
            }
        }

    }


}
