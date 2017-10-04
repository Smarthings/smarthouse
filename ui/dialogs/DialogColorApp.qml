import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

Item {
    property alias dialog: dialog_color_app
    property alias combo: comboBox

    Dialog {
        id: dialog_color_app
        title: qsTr("Cor do Aplicativo")
        modal: true

        x: Math.round((window.width - width) / 2)
        y: 50
        width: 300

        contentItem: Rectangle {
            color: "transparent"
            implicitWidth: parent.width

            Column {
                width: parent.width
                spacing: 10

                ComboBox {
                    id: comboBox
                    width: parent.width
                    currentIndex: settings.color_theme
                    displayText: comboBox.currentText
                    Material.foreground: "#fff"
                    model: ListModel {
                        ListElement { name: "Red" }
                        ListElement { name: "Pink" }
                        ListElement { name: "Purple" }
                        ListElement { name: "DeepPurple" }
                        ListElement { name: "Indigo" }
                        ListElement { name: "Blue" }
                        ListElement { name: "LightBlue" }
                        ListElement { name: "Cyan" }
                        ListElement { name: "Teal" }
                        ListElement { name: "Green" }
                        ListElement { name: "LightGreen" }
                        ListElement { name: "Lime" }
                        ListElement { name: "Yellow" }
                        ListElement { name: "Amber" }
                        ListElement { name: "Orange" }
                        ListElement { name: "DeepOrange" }
                        ListElement { name: "Brown" }
                        ListElement { name: "Grey" }
                        ListElement { name: "BlueGrey" }
                    }

                    delegate: ItemDelegate {
                        id: delegate
                        text: modelData
                        width: comboBox.width
                        Material.foreground: Material.color(index)
                    }

                    Material.background: comboBox.currentIndex

                    onCurrentIndexChanged: {
                        settings.color_theme = comboBox.currentIndex
                    }
                }
            }
        }

    }


}
