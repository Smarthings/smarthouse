import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./components"


ScrollablePage {
    id: nodePage

    property int id
    property int stopwatch_time: (tcpClient.getNodes[id].time !== undefined && tcpClient.getNodes[id].time > 9)? tcpClient.getNodes[id].time : 0
    //property int timestamp_end: (tcpClient.getNodes[id].end !== undefined && tcpClient.getNodes[id].end > 0)? tcpClient.getNodes[id].end : 0
    property int range: tcpClient.getNodes[id].range
    property string icon_type: "lamp"

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
                                iconSize: parent.height -5
                                itemWidth: parent.width
                                itemHeight: parent.height
                                iconColor: Material.foreground
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

                            SmartIcon{
                                id: button_clock
                                iconName: "clock"
                                iconSize: parent.height -5
                                itemWidth: parent.width
                                itemHeight: parent.height
                                iconColor: Material.foreground

                                button: true
                                z: 10

                                mouseArea: mouseAreaClock
                                MouseArea {
                                    id: mouseAreaClock
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {

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

                        property int time: 0
                        function timeStopwatch()
                        {
                            //var get_time = functions.getTimeDifNow(tcpClient.getNodes[id].end);
                            //time--;
                            //tcpClient.getNodes = [{"id": id, "time": time}];

                            var str_time = new Date(time * 1000);
                            smarttumblerstopwatch.setHours.currentIndex = str_time.getUTCHours();
                            smarttumblerstopwatch.setMinutes.currentIndex = str_time.getUTCMinutes();
                            smarttumblerstopwatch.setSeconds.currentIndex = str_time.getUTCSeconds();
                            if (time < 1) {
                                timer_stopwatch.running = false;
                                return;
                            }
                        }

                        Timer {
                            id: timer_stopwatch
                            interval: 1000
                            repeat: true
                            running: false
                            onTriggered: column_stopwatch.timeStopwatch()
                        }

                        SmartTumblerStopWatch {
                            id: smarttumblerstopwatch
                            itemWidth: parent.width
                            itemHeight: 120
                            anchors.leftMargin: 6
                            anchors.left: parent.left
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
                                iconName: (icon_type == "")? "microchip" : icon_type
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

                                Item {
                                    id: column_message
                                    width: parent.width
                                    height: parent.height
                                    visible: (tcpClient.getNodes[id].status == 0)? true : false

                                    Text {
                                        id: text_message
                                        text: qsTr("Este acessório está indisponível")
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        wrapMode: Text.Wrap
                                        width: parent.width
                                        height: parent.height
                                        font.pixelSize: 24
                                        color: Material.accent
                                    }
                                }

                                Item {
                                    id: column_buttons
                                    width: parent.width
                                    height: parent.height
                                    visible: (tcpClient.getNodes[id].status == 0)? false : true

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Column {
                                            id: column_switch
                                            width: parent.width
                                            height: parent.height
                                            enabled: (tcpClient.getNodes[id].type == 1)? true : false
                                            visible: (tcpClient.getNodes[id].type == 1)? true : false

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
                                            enabled: (tcpClient.getNodes[id].type == 2)? true : false
                                            visible: (tcpClient.getNodes[id].type == 2)? true : false

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
                }
            }

            Item {
                id: item_stopwatch_button
                width: parent.width
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                visible: item_stopwatch.visible

                Button {
                    id: button_stopwatch
                    width: parent.width
                    height: 50

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    text: (timer_stopwatch.running == true)? qsTr("Cancelar") : qsTr("Iniciar");
                    Material.background: (timer_stopwatch.running == true)?
                                             Material.Red :
                                             Material.Green

                    onClicked: {
                        var time = getTimeSeconds(
                            "1970-01-01 "
                            + completeZero(smarttumblerstopwatch.getHours, 2) + ":"
                            + completeZero(smarttumblerstopwatch.getMinutes, 2) + ":"
                            + completeZero(smarttumblerstopwatch.getSeconds, 2)
                        );
                        sendCommandStopwatchNode(time);
                    }
                }
            }
        }

        Connections {
            enabled: (tcpClient.getNodes[id].type == 1)? true : false
            target: smartswitch._switch
            onCheckedChanged: getChangedSwitchNode();
        }

        Connections {
            enabled: (tcpClient.getNodes[id].type == 2)? true : false
            target: smartdial._dial
            onPressedChanged: getChangeDialNode();
        }

        Connections {
            target: nodePage
            //onTimestamp_endChanged: timer_stopwatch.running = true;
            onStopwatch_timeChanged: {
                column_stopwatch.time = stopwatch_time;
                timer_stopwatch.running = true;
            }

            onRangeChanged: {
                smartdial.setValue = parseInt(range);
                smartswitch.setValue = parseInt(range);
            }
        }
        Component.onCompleted: {
            if (stopwatch_time > 0) {
                column_stopwatch.time = stopwatch_time;
                timer_stopwatch.running = true;
            }

            /*if (timestamp_end > 0) {
                timer_stopwatch.running = true
            }*/
        }
    }

    function sendCommandStopwatchNode(time)
    {
        var value, prepareRange;
        if (tcpClient.getNodes[id].type == 1) {
            value = (smartswitch._switch.checked)? "100" : "00";
            prepareRange = (value == "100")? "99" : "00";
        } else if (tcpClient.getNodes[id].type == 2) {
            value = (smartdial._dial.value * 100).toFixed(0);
            prepareRange = (value <= 1)? value : value -1;
        }

        tcpClient.setSendCommandNode({
            "name": tcpClient.getNodes[id].name,
            "stopwatch": {
                "time": time,
                "action": {
                    "range": completeZero(prepareRange, 2)
                }
            }
        });
    }

    function sendCommandRangeNode(value)
    {
        tcpClient.setSendCommandNode({
             "name": tcpClient.getNodes[id].name,
             "action": {
                 "range": completeZero(value, 2)
             }
         });
    }

    function getChangedSwitchNode()
    {
        if (smarttumblerstopwatch.getHours == 0 &&
                smarttumblerstopwatch.getMinutes == 0 &&
                smarttumblerstopwatch.getSeconds == 0) {
            var value = (smartswitch._switch.checked)? "100" : "00";
            if (value != tcpClient.getNodes[id].range) {
                var prepareRange = (value == "100")? "99" : "00";
                sendCommandRangeNode(prepareRange);
            }
        }
    }

    function getChangeDialNode()
    {
        if (smarttumblerstopwatch.getHours == 0 &&
                smarttumblerstopwatch.getMinutes == 0 &&
                smarttumblerstopwatch.getSeconds == 0) {
            var value = (smartdial._dial.value * 100).toFixed(0);
            if (value != tcpClient.getNodes[id].range) {
                var prepareRange = (value <= 1)? value : value -1;
                sendCommandRangeNode(prepareRange);
            }
        }
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
