import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

Item {
    id: item_content

    property alias backgroundColor: rectangle_box.color
    property alias nodeName: text_name.text
    property alias nodeRange: text_range.text
    property alias nodeNotification: item_notification //text_notification.text
    property string icon_type: "lamp"
    property alias nodeBlock: rectangle_box

    Rectangle {
        id: rectangle_box
        anchors.fill: parent
        radius: 10
        border.color: line_color
        opacity: 0.80

        Column {
            id: column_item
            anchors.fill: parent
            Item {
                id: item_block
                width: parent.width
                height: parent.height /2

                SmartIcon {
                    id: smarticon
                    iconName: (icon_type == "")? "microchip": icon_type
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

                Column {
                    id: column_footer
                    anchors.centerIn: parent

                    Text {
                        id: text_name
                        color: text_color
                        font.weight: Font.Light
                        font.pixelSize: 13
                    }
                }

                Row {
                    anchors.top: column_footer.bottom
                    anchors.topMargin: 4
                    width: parent.width

                    Item {
                        id: item_notification
                        width: parent.width /2
                        height: 15

                        /*Text {
                            id: text_notification
                            width: parent.width
                            font.weight: Font.Light
                            font.pixelSize: 10
                            color: text_color
                            opacity: 0.4
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                        }*/
                    }

                    Item {
                        width: parent.width /2
                        anchors.right: parent.right
                        Text {
                            id: text_range
                            width: parent.width -5
                            font.weight: Font.Light
                            font.pixelSize: 10
                            color: text_color
                            opacity: 0.4
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                }
            }
        }
    }
}
