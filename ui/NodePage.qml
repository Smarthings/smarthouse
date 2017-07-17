import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
//import QtQuick.Extras 1.4
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
                    color: background_nodes
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
                                        item_stopwatch.visible = (item_stopwatch.visible == true)? false : true
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
                id: item_stopwatch
                width: parent.width
                height: column_stopwatch.height
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                visible: false

                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    border.color: line_color
                    color: background_nodes
                    opacity: 0.80

                    Column {
                        id: column_stopwatch
                        width: parent.width
                        height: smarttumblerstopwatch.height + text_stopwatch.height + button_stopwatch.height + 10
                        spacing: 5

                        property int hours: 0;
                        property int minutes: 0;
                        property int seconds: 0;

                        function timeChanged()
                        {
                            seconds++;
                            if (seconds == 60) {
                                seconds = 0;
                                minutes++;
                            }
                            if (minutes == 60) {
                                minutes = 0;
                                hours++;
                            }
                        }

                        Timer {
                            id: timer_stopwatch
                            interval: 1000
                            running: false
                            onTriggered: column_stopwatch.timeChanged();
                        }

                        SmartTumblerStopWatch {
                            id: smarttumblerstopwatch
                            itemWidth: parent.width
                            itemHeight: 80
                        }

                        Text {
                            id: text_stopwatch
                            text: completeZero(column_stopwatch.hours, 2) + ":" +
                                  completeZero(column_stopwatch.minutes, 2) + ":" +
                                  completeZero(column_stopwatch.seconds, 2)
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 72
                            font.weight: Font.Light
                            color: (timer_stopwatch.running == true)? Material.accent : Material.foreground
                        }
                        Button {
                            id: button_stopwatch
                            width: parent.width

                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.right: parent.right
                            anchors.rightMargin: 5

                            height: 50
                            text: (timer_stopwatch.running == true)? qsTr("Parar") : qsTr("Iniciar");
                            Material.background: (timer_stopwatch.running == true)?
                                                     Material.Red :
                                                     Material.Green

                            onClicked: {
                                if (timer_stopwatch.running == true) {
                                    timer_stopwatch.running = false;
                                    timer_stopwatch.repeat = false;
                                } else {
                                    timer_stopwatch.running = true;
                                    timer_stopwatch.repeat = true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    function completeZero(str, length) {
        str = str.toString();
        while (str.length < length) {
            str = "0" + str;
        }
        return str;
    }
}
