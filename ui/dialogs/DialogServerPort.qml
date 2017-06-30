import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    property alias dialog: dialog_server_port

    Dialog {
        id: dialog_server_port
        title: qsTr("Porta de configuração")
        modal: true

        x: Math.round((window.width - width) /2)
        y: 50
        width: 300

        contentItem: Rectangle {
            color: "transparent"
            implicitWidth: parent.width
            implicitHeight: 100

            Column {
                width: parent.width
                spacing: 10

                TextField {
                    id: textfield_server_port
                    width: parent.width
                    placeholderText: qsTr("Porta: 9932 [Padrão]")
                    text: settings.server_port
                    font.weight: Font.Light
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Button {
                    id: button_server_port_save
                    width: parent.width
                    text: qsTr("Salvar")
                    font.weight: Font.Light
                    Material.background: button_success_color
                    Material.foreground: button_foreground_color
                    onClicked: {
                        settings.server_port = textfield_server_port.text
                        dialog_server_port.close()
                    }
                }
            }
        }
    }
}
