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
            spacing: 10

            Item {
                id: item_root
                width: parent.width
                height: 200
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10

                Rectangle {
                    anchors.fill: parent
                    color: background_nodes
                    radius: 10
                    border.color: line_color
                    opacity: 0.80

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

                                    SmartSwitch {
                                        id: smartswitch
                                        switchWidth: 100
                                        switchHeight: 100

                                        itemWidth: parent.width
                                        itemHeight: parent.height
                                    }
                                }

                                Column {
                                    id: column_range
                                    width: parent.width
                                    height: parent.height
                                    enabled: (type_node == 01)? true : false
                                    visible: (type_node == 01)? true : false

                                    SmartDial {
                                        id: smartdial
                                        dialWidth: 100
                                        dialHeight: 100

                                        itemWidth: parent.width
                                        itemHeight: parent.height
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: item_functions_buttons
                width: parent.width
                height: 50

                Rectangle {
                    anchors.fill: parent
                    border.color: line_color
                    opacity: 0.80

                    Row {
                        anchors.fill: parent
                        spacing: 10

                        Item {
                            width: 80
                            height: parent.height

                            SmartIcon {
                                id: button_alarm
                                iconName: "alarm"
                                iconSize: parent.height - 5
                                itemWidth: parent.width
                                itemHeight: parent.height
                                button: true
                                z: 10

                                mouseArea: mouseAreaAlarm
                                MouseArea {
                                    id: mouseAreaAlarm
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        console.log("")
                                    }
                                }
                            }
                        }

                        Item {
                            width: 80
                            height: parent.height

                            SmartIcon {
                                id: button_clock
                                iconName: "clock"
                                iconSize: parent.height - 5
                                itemWidth: parent.width
                                itemHeight: parent.height
                                button: true
                                z: 10

                                mouseArea: mouseAreaClock
                                MouseArea {
                                    id: mouseAreaClock
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        console.log("OnClicked")
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: item_functions
                width: parent.width
                height: 100
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                visible: false

                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    border.color: line_color
                    opacity: 0.80
                }
            }
        }
    }
}
