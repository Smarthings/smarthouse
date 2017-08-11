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

    property int id
    property string name: ""
    property string status: ""
    property string range: ""
    property string type: ""
    property string icon_type: ""

    ColumnLayout {
        id: column_general
        anchors.fill: parent

        Column {
            Layout.fillWidth: true
            spacing: 10

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
                                iconColor: (item_stopwatch.visible == true)? Material.accent : Material.foreground
                                button: true
                                z: 10

                                mouseArea: mouseAreaAlarm
                                MouseArea {
                                    id: mouseAreaAlarm
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        item_stopwatch.visible = (item_stopwatch.visible == true)? false : true
                                        if (item_stopwatch.visible == true) {
                                            item_alarm.visible = false
                                        }
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
                                iconColor: (item_alarm.visible == true)? Material.accent : Material.foreground
                                button: true
                                z: 10

                                mouseArea: mouseAreaClock
                                MouseArea {
                                    id: mouseAreaClock
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        item_alarm.visible = (item_alarm.visible == true)? false : true
                                        if (item_alarm.visible == true) {
                                            item_stopwatch.visible = false
                                        }
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
                        height: smarttumblerstopwatch.height + 10
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
                                getChangedDial();
                                return;
                            }
                            timeseconds--;
                            var str_time = new Date(timeseconds * 1000);

                            smarttumblerstopwatch.setHours.currentIndex = str_time.getUTCHours();
                            smarttumblerstopwatch.setMinutes.currentIndex = str_time.getUTCMinutes();
                            smarttumblerstopwatch.setSeconds.currentIndex = str_time.getUTCSeconds();
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
                            itemHeight: 120
                            textColor: (timer_stopwatch.running == true)? Material.accent : Material.foreground

                            MouseArea {
                                anchors.fill: parent
                                visible: (timer_stopwatch.running == true)? true : false
                            }
                        }
                    }
                }
            }

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
                                    enabled: (tcpClient.getNodes[id].type == 0)? true: false
                                    visible: (tcpClient.getNodes[id].type == 0)? true: false

                                    SmartSwitch {
                                        id: smartswitch
                                        switchWidth: 100
                                        switchHeight: 100
                                        setValue: parseInt(tcpClient.getNodes[id].range)

                                        itemWidth: parent.width
                                        itemHeight: parent.height
                                    }
                                }

                                Column {
                                    id: column_range
                                    width: parent.width
                                    height: parent.height
                                    enabled: (tcpClient.getNodes[id].type == 1)? true : false
                                    visible: (tcpClient.getNodes[id].type == 1)? true : false

                                    SmartDial {
                                        id: smartdial
                                        setValue: parseInt(tcpClient.getNodes[id].range)
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
                id: item_stopwatch_button
                width: parent.width
                height: 50
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                visible: item_stopwatch.visible

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
                        console.log("Button stopwatch Clicked");
                        column_stopwatch.timeseconds = (
                            getTimeSeconds(
                                "1970-01-01 "
                                + completeZero(smarttumblerstopwatch.getHours, 2) + ":"
                                + completeZero(smarttumblerstopwatch.getMinutes, 2) + ":"
                                + completeZero(smarttumblerstopwatch.getSeconds, 2)
                            )
                        );

                        var value = (smartdial._dial.value * 100).toFixed(0);
                        if (value != tcpClient.getNodes[id].range) {
                            tcpClient.getNodes[id].range = value;
                            var prepareRange = (tcpClient.getNodes[id].range <= 1)? tcpClient.getNodes[id].range: tcpClient.getNodes[id].range -1;
                            var sendCommand = {
                                "name": tcpClient.getNodes[id].name,
                                "stopwatch": {
                                    "time": column_stopwatch.timeseconds,
                                    "action": {
                                        "range": completeZero(prepareRange, 2)
                                    }
                                }
                            };
                            tcpClient.setSendCommandNode(sendCommand);
                        }
                    }
                }

            }

            Item {
                id: item_alarm
                width: parent.width
                height: 200
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
                }
            }
        }

        Connections {
            target: smartdial._dial
            onPressedChanged: {
                getChangedDial();
            }
        }

        Connections {
            target: smartswitch._switch
            onCheckedChanged: {
                getChangedSwitch();
            }
        }
    }

    function getChangedDial()
    {
        if (smarttumblerstopwatch.getHours == 0 &&
                smarttumblerstopwatch.getMinutes == 0 &&
                smarttumblerstopwatch.getSeconds == 0) {
            var value = (smartdial._dial.value * 100).toFixed(0);
            if (value != tcpClient.getNodes[id].range) {
                tcpClient.getNodes[id].range = value;
                var prepareRange = (tcpClient.getNodes[id].range <= 1)? tcpClient.getNodes[id].range: tcpClient.getNodes[id].range -1;
                tcpClient.setSendCommandNode({
                                                 "name": tcpClient.getNodes[id].name,
                                                 "action": {
                                                     "range": completeZero(prepareRange, 2)
                                                 }
                                             });
            }
        }
    }

    function getChangedSwitch()
    {
        if (smarttumblerstopwatch.getHours == 0 &&
                smarttumblerstopwatch.getMinutes == 0 &&
                smarttumblerstopwatch.getSeconds == 0) {
            var value = smartswitch._switch.checked
            if (value != tcpClient.getNodes[id].range) {
                tcpClient.getNodes[id].range = value;
                console.log(tcpClient.getNodes[id].range);
            }
        }
    }

    function resetStopwatch()
    {
        column_stopwatch.timeseconds = 0;
        column_stopwatch.hours = 0;
        column_stopwatch.minutes = 0;
        column_stopwatch.seconds = 0;
        smarttumblerstopwatch.setHours.currentIndex = 0;
        smarttumblerstopwatch.setMinutes.currentIndex = 0;
        smarttumblerstopwatch.setSeconds.currentIndex = 0
    }

    function getTimeSeconds(str)
    {
        var time = new Date(str + " -0000");
        return time.getTime() /1000;
    }

    function completeZero(str, length)
    {
        str = str.toString();
        while (str.length < length) {
            str = "0" + str;
        }
        return str;
    }
}
