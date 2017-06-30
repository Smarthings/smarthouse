import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    property alias dialog: dialog_theme

    Dialog {
        id: dialog_theme
        title: qsTr("Tema")
        modal: true

        x: Math.round((pageSettings.width - width) /2)
        width: 300

        contentItem: Rectangle {
            color: "transparent"
            implicitWidth: parent.width
            implicitHeight: 100

            ListView {
                width: parent.width
                height: 60
                model: ["Light", "Dark"]
                delegate: RadioDelegate {
                    width: parent.width
                    text: modelData
                    font.weight: Font.Light
                    checked: index == (settings.theme == "Light")? 0 : 1
                    onCheckedChanged: {
                        if (index == 0)
                            settings.theme = "Light"
                        else
                            settings.theme = "Dark"
                    }
                    Rectangle {
                        id: line_border
                        width: parent.width
                        height: 1
                        color: line_color
                        anchors.bottom: parent.bottom
                    }
                    DropShadow {
                        anchors.fill: line_border
                        horizontalOffset: 1
                        verticalOffset: 1
                        radius: 2.0
                        samples: 17
                        color: shadow_color
                        source: line_border
                    }
                }
            }
        }
    }
}
