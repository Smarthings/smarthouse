import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import "./dialogs"

ScrollablePage {
    id: pageSettings
    property string title_page: qsTr("Configurações")

    ColumnLayout {
        id: column
        anchors.fill: parent

        Column {
            id: column_general
            //width: parent.width
            Layout.fillWidth: true
            spacing: 1

            Item {
                width: parent.width
                height: 10
            }
            Text {
                text: qsTr("Geral")
                font.pixelSize: 20
                font.weight: Font.Light
                color: text_primary_color
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Switch {

            }

            Item {
                width: parent.width
                height: 5
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_theme
                    width: parent.width
                    height: parent.height
                    anchors.margins: 5
                    color: background_items

                    ItemDelegate {
                        width: parent.width
                        height: parent.height
                        Column {
                            width: parent.width
                            height: parent.height
                            padding: 10

                            Text {
                                text: qsTr("Tema")
                                color: title_color
                            }
                            Text {
                                text: settings.theme
                                color: text_color
                                font.weight: Font.Light
                            }
                        }

                        onClicked: {
                            dialog_theme.dialog.open()
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_color
                    width: parent.width
                    height: parent.height
                    anchors.margins: 5
                    color: background_items

                    ItemDelegate {
                        width: parent.width
                        height: parent.height
                        Column {
                            width: parent.width
                            height: parent.height
                            padding: 10

                            Text {
                                text: qsTr("Cor do App")
                                color: title_color
                            }
                            Text {
                                text: dialog_color_app.combo.currentText
                                color: text_color
                                font.weight: Font.Light
                            }
                        }
                        onClicked: {
                            dialog_color_app.dialog.open()
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 20
            }

            Text {
                text: qsTr("Servidor")
                font.pixelSize: 20
                font.weight: Font.Light
                color: text_primary_color
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            Item {
                width: parent.width
                height: 5
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_server_address
                    width: parent.width
                    height: 60
                    color: background_items

                    ItemDelegate {
                        width: parent.width
                        height: 60

                        Column {
                            width: parent.width
                            height: parent.height
                            spacing: 6
                            padding: 10

                            Text {
                                text: qsTr("Endereço IP")
                                color: title_color
                            }
                            Text {
                                text: settings.server_address
                                color: text_color
                                font.weight: Font.Light
                            }
                        }
                        onClicked: {
                            dialog_server_addr.dialog.open()
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_server_port
                    width: parent.width
                    height: parent.height
                    color: background_items

                    ItemDelegate {
                        width: parent.width
                        height: 60
                        Column {
                            width: parent.width
                            height: parent.height
                            spacing: 6
                            padding: 10

                            Text {
                                text: qsTr("Porta")
                                color: title_color
                            }
                            Text {
                                text: settings.server_port
                                color: text_color
                                font.weight: Font.Light
                            }
                        }
                        onClicked: {
                            dialog_server_port.dialog.open()
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_server_connect
                    width: parent.width
                    height: parent.height
                    color: "transparent"

                    ItemDelegate {
                        width: parent.width
                        height: 60
                        Column {
                            width: parent.width
                            height: parent.height

                            Button {
                                id: button_connect_server
                                width: parent.width
                                height: parent.height
                                text: (isConnect == true)? qsTr("Desconectar") : qsTr("Conectar")
                                Material.background: (isConnect == true)? Material.Red : Material.Green
                                Material.foreground: "#fff"

                                Component.onCompleted: {
                                    console.log("Connection: " + isConnect)
                                }

                                onClicked: {
                                    if(isConnect == true)
                                        tcpClient.disconnect();
                                    else
                                    {
                                        tcpClient.server_address = settings.server_address
                                        tcpClient.server_port = settings.server_port
                                        tcpClient.startConnection()
                                    }
                                }
                            }
                        }
                        onClicked: {

                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 20
            }

            Text {
                text: qsTr("Interface Gráfica")
                font.pixelSize: 20
                font.weight: Font.Light
                color: text_primary_color
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Item {
                width: parent.width
                height: 5
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_gui_size_nodes
                    width: parent.width
                    height: 60
                    color: background_items

                    ItemDelegate {
                        width: parent.width
                        height: parent.height

                        Column {
                            width: parent.width
                            height: parent.height
                            spacing: 6
                            padding: 10

                            Text {
                                text: qsTr("Tamanho dos Acessórios")
                                color: title_color
                            }
                            Text {
                                text: settings.size_nodes
                                color: text_color
                                font.weight: Font.Light
                            }
                        }
                        onClicked: {
                            dialog_size_nodes.dialog.open()
                        }
                    }
                }
            }
        }

        DialogTheme {
            id: dialog_theme
        }

        DialogColorApp {
            id: dialog_color_app
        }

        DialogServerAddress {
            id: dialog_server_addr
        }

        DialogServerPort {
            id: dialog_server_port
        }

        DialogSizeNodes {
            id: dialog_size_nodes
        }
    }
}
