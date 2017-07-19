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
                        height: smarttumblerstopwatch.height /*+ text_stopwatch.height */+ button_stopwatch.height + 10
                        spacing: 5

                        property int hours: smarttumblerstopwatch.getHours;
                        property int minutes: smarttumblerstopwatch.getMinutes;
                        property int seconds: smarttumblerstopwatch.getSeconds;
                        property int timeseconds: 0

                        function timeChanged()
                        {
                            if (timeseconds == 0) {
                                timer_stopwatch.running = false;
                                resetStopwatch();
                                console.log("Executar função");
                                return;
                            }
                            timeseconds--;
                            var str_time = new Date(timeseconds * 1000);
                            hours = str_time.getUTCHours();
                            minutes = str_time.getUTCMinutes();
                            seconds = str_time.getUTCSeconds();
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
                            visible: (timer_stopwatch.running == true)? false : true
                        }

                        SmartTumblerStopWatch {
                            id: stopwatch_running
                            itemWidth: parent.width
                            itemHeight: 80
                            textColor: (timer_stopwatch.running == true)? Material.accent : Material.foreground
                            visible: (timer_stopwatch.running == true)? true : false
                            seconds: [column_stopwatch.seconds]
                            minutes: [column_stopwatch.minutes]
                            hours: [column_stopwatch.hours]
                        }

                        /*Text {
                            id: text_stopwatch
                            text: completeZero(column_stopwatch.hours, 2) + ":" +
                                  completeZero(column_stopwatch.minutes, 2) + ":" +
                                  completeZero(column_stopwatch.seconds, 2)
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 72
                            font.weight: Font.Light
                            color: (timer_stopwatch.running == true)? Material.accent : Material.foreground
                        }*/
                        Button {
                            id: button_stopwatch
                            width: parent.width

                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.right: parent.right
                            anchors.rightMargin: 5

                            height: 50
                            text: (timer_stopwatch.running == true)? qsTr("Cancelar") : qsTr("Iniciar");
                            Material.background: (timer_stopwatch.running == true)?
                                                     Material.Red :
                                                     Material.Green

                            onClicked: {
                                column_stopwatch.timeseconds =
                                        getTimeSeconds(
                                            "1970-01-01 "
                                            +completeZero(smarttumblerstopwatch.getHours, 2)+":"
                                            +completeZero(smarttumblerstopwatch.getMinutes, 2)+":"
                                            +completeZero(smarttumblerstopwatch.getSeconds, 2)
                                            +" -0000"
                                            );

                                if (timer_stopwatch.running == true) {
                                    timer_stopwatch.running = false;
                                    timer_stopwatch.repeat = false;
                                    resetStopwatch();
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
    function resetStopwatch() {
        column_stopwatch.timeseconds = 0;
        column_stopwatch.hours = 0;
        column_stopwatch.minutes = 0;
        column_stopwatch.seconds = 0;
        smarttumblerstopwatch.setHours.currentIndex = 0;
        smarttumblerstopwatch.setMinutes.currentIndex = 0;
        smarttumblerstopwatch.setSeconds.currentIndex = 0
    }

    function getTimeSeconds(str) {
        var time = new Date(str + " -0000");
        return time.getTime() /1000;
    }

    function completeZero(str, length) {
        str = str.toString();
        while (str.length < length) {
            str = "0" + str;
        }
        return str;
    }
}
