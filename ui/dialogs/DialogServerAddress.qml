import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    property alias dialog: dialog_server_addr
    Dialog {
        id: dialog_server_addr
        title: qsTr("Procurar Central")
        modal: true

        x: Math.round((window.width - width) /2)
        y: 50
        width: 300

        contentItem: Rectangle {
            color: "transparent"
            implicitWidth: parent.width
            implicitHeight: 250

            Column {
                width: parent.width
                spacing: 10
                //padding: 10
                Button {
                    id: button_network_discovery
                    text: qsTr("Descoberta de rede")
                    font.weight: Font.Light
                    width: parent.width
                    Material.background: button_primary_color
                    Material.foreground: button_foreground_color

                    onClicked: {
                        networkDiscovery.SearchSmarthingsServer()
                    }
                }

                ComboBox {
                    id: combobox_server_address
                    width: parent.width
                    visible: !radio_settings_manual.checked
                    model: networkDiscovery.serverDiscovery
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                SwitchDelegate {
                    id: radio_settings_manual
                    text: qsTr("Configuração manual")
                    font.weight: Font.Light
                    width: parent.width
                    onClicked: {
                        if (radio_settings_manual.checked == true)
                        {
                            button_network_discovery.enabled = false
                            combobox_server_address.enabled = false
                            textfield_server_addr.visible = true
                        }
                        else
                        {
                            button_network_discovery.enabled = true
                            combobox_server_address.enabled = true
                            textfield_server_addr.visible = false
                        }
                    }
                }
                TextField {
                    id: textfield_server_addr
                    width: parent.width
                    placeholderText: qsTr("Endereço IP")
                    text: settings.server_address
                    font.weight: Font.Light
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: false
                }
                Button {
                    id: button_server_addr_save
                    width: parent.width
                    text: qsTr("Salvar")
                    font.weight: Font.Light
                    Material.background: button_success_color
                    Material.foreground: button_foreground_color
                    onClicked: {
                        if (radio_settings_manual.checked == false)
                            settings.server_address = combobox_server_address.currentText
                        else
                            settings.server_address = textfield_server_addr.text
                        dialog_server_addr.close()
                    }
                }
            }
        }
    }

}
