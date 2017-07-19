import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: item

    property int itemWidth: 0
    property int itemHeight: 0
    property string textColor: Material.foreground
    property variant hours: []
    property variant minutes: []
    property variant seconds: []
    property variant setHours: tumbler_hours
    property variant setMinutes: tumbler_minutes
    property variant setSeconds: tumbler_seconds
    property int getHours: tumbler_hours.currentIndex.toString()
    property int getMinutes: tumbler_minutes.currentIndex.toString()
    property int getSeconds: tumbler_seconds.currentIndex.toString()

    width: (itemWidth > 0)? itemWidth: parent.width
    height: (itemHeight > 0)? itemHeight: 100

    Component {
        id: component_text_delegate

        Text {
            text: completeZero(modelData, 2);
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: textColor
            opacity: 1.0 - Math.abs(Tumbler.displacement);
            font.pixelSize: 72
            font.weight: Font.Light
        }
    }

    Row {
        anchors.fill: parent
        Tumbler {
            id: tumbler_hours
            model: (hours.length > 0)? hours : 24
            width: parent.width /3 - 4
            height: parent.height

            delegate: component_text_delegate
        }
        Text {
            id: text_hour
            width: 1
            height: parent.height
            text: ":"
            color: textColor
            font.pixelSize: 42
            font.weight: Font.Light
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Tumbler {
            id: tumbler_minutes
            model: (minutes.length > 0)? minutes : 60
            width: parent.width /3 - 4
            height: parent.height

            delegate: component_text_delegate
        }
        Text {
            id: text_minutes
            width: 1
            height: parent.height
            text: ":"
            color: textColor
            font.pixelSize: 42
            font.weight: Font.Light
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Tumbler {
            id: tumbler_seconds
            model: (seconds.length > 0)? seconds : 60
            width: parent.width /3 - 4
            height: parent.height

            delegate: component_text_delegate
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
