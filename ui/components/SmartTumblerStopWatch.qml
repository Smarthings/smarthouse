import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: item

    property int itemWidth: 0
    property int itemHeight: 0

    width: (itemWidth > 0)? itemWidth: parent.width
    height: (itemHeight > 0)? itemHeight: 100

    Row {
        anchors.fill: parent
        Tumbler {
            id: tumbler_hours
            model: 24
            width: parent.width /3
            height: parent.height
            onCurrentItemChanged: {
                //console.log(tumbler_hours.currentIndex.toString())
            }
        }
        Tumbler {
            id: tumbler_minutes
            model: 60
            width: parent.width /3
            height: parent.height
        }
        Tumbler {
            id: tumbler_seconds
            model: 60
            width: parent.width /3
            height: parent.height
        }
    }
}
