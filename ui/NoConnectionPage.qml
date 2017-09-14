import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "./dialogs"
import "./components"

ScrollablePage {
    id: pageNoConnection

    ColumnLayout {
        id: column_root
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: -40
        spacing: 20

        Row {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            SmartIcon {
                id: image_smartphone
                iconName: "smartphone"
                iconSize: 96
            }

            SmartIcon {
                id: image_connectionless
                iconName: "alert"
                iconSize: 48
                itemWidth: 96
                itemHeight: 96
                iconColor: Material.color(Material.Red)
            }

            SmartIcon {
                id: image_smarthouse
                iconName: "home"
                iconSize: 96
            }
        }

        Item {
            width: parent.width
            height: 10
        }

        Row {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                width: 300
                spacing: 20
                Text {
                    text: qsTr("Você não esta conectado!!!")
                    font.pixelSize: 24
                    color: colorChoose
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: qsTr("Verifique as suas configurações")
                    font.pixelSize: 16
                    font.weight: Font.Light
                    color: text_color
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        Item {
            width: parent.width
            height: 10
        }
        Row {
            width: 300
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                width: parent.width
                Item {
                    width: parent.width
                    height: 60

                    Rectangle {
                        id: rectangle_server_address
                        width: parent.width
                        height: 60
                        color: "transparent"

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
                            Rectangle {
                                width: parent.width
                                height: 1
                                color: line_color
                                anchors.bottom: parent.bottom
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
                        color: "transparent"

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
                            Rectangle {
                                width: parent.width
                                height: 1
                                color: line_color
                                anchors.bottom: parent.bottom
                            }
                            onClicked: {
                                dialog_server_port.dialog.open()
                            }
                        }
                    }
                }

                Item {
                    width: parent.width
                    height: 50

                    Button {
                        width: parent.width
                        height: parent.height
                        text: qsTr("Conectar")
                        font.weight: Font.Light
                        Material.background: button_success_color
                        Material.foreground: button_foreground_color

                        onClicked: {
                            tcpClient.server_address = settings.server_address;
                            tcpClient.server_port = settings.server_port;
                            tcpClient.startConnection();
                        }
                    }
                }

                Item {
                    width: parent.width
                    height: 20
                }
            }
        }
        DialogServerAddress {
            id: dialog_server_addr
        }
        DialogServerPort {
            id: dialog_server_port
        }
    }
}
