import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

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
                }
            }
        }
    }
}
