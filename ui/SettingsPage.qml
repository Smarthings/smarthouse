import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "./dialogs"

//import QtQuick.Dialogs 1.2

//import Qt.labs.settings 1.0

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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: shadow_color
                            anchors.top: parent.top
                        }
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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: line_color
                            anchors.bottom: parent.bottom
                        }

                        onClicked: {
                            dialog_theme.dialog.open()
                        }
                    }
                }
                DropShadow {
                    anchors.fill: rectangle_theme
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 2.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_theme
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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: shadow_color
                            anchors.top: parent.top
                        }
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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: line_color
                            anchors.bottom: parent.bottom
                        }

                        onClicked: {
                            dialog_color_app.dialog.open()
                        }
                    }
                }
                DropShadow {
                    anchors.fill: rectangle_color
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 2.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_color
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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: shadow_color
                            anchors.top: parent.top
                        }
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
                DropShadow {
                    anchors.fill: rectangle_server_address
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 2.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_server_address
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
                DropShadow {
                    anchors.fill: rectangle_server_port
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 2.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_server_port
                }
            }

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: rectangle_server_connect
                    width: parent.width
                    height: parent.height
                    color: background_items

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
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: line_color
                            anchors.bottom: parent.bottom
                        }
                        onClicked: {

                        }
                    }
                }
                DropShadow {
                    anchors.fill: rectangle_server_connect
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 2.0
                    samples: 17
                    color: shadow_color
                    source: rectangle_server_connect
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

        /*Label {
            Layout.fillWidth: true
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            text: "Geral"
        }*/

        /*Column {
            spacing: 20
            width: parent.width

            Label {
                width: parent.width
                wrapMode: Label.Wrap
                text: qsTr("Tema")
            }

            ComboBox {
                id: combo_theme
                model: ["Light", "Dark"]
                currentIndex: (settings.theme === "Light")? 0 : 1
                width: column.width
                anchors.horizontalCenter: parent.horizontalCenter

                onCurrentIndexChanged: {
                    if (combo_theme.currentIndex == 0)
                        settings.theme = "Light"
                    else
                        settings.theme = "Dark"
                }
            }

            Label {
                width: parent.width
                wrapMode: Label.Wrap
                text: qsTr("Geral")
                font.pixelSize: 18
                color: window.color_smarthouse
            }
            Rectangle {
                width: parent.width
                height: 2
                color: window.color_smarthouse
            }

            ListModel {
                id: listModel
                ListElement {
                    title_field: "Endereço IP"
                    value_field: "127.0.0.1"
                }
            }

//            Component {
//                id: component_root
//                ItemDelegate {
//                    width: parent.width
//                    Row {
//                        id: row_root
//                        width: parent.width
//                        height: parent.height
//                        spacing: 5
//                        Rectangle {
//                            width: parent.width /2
//                            height: parent.height
//                            color: "transparent"
//                            Text {
//                                text: title_field
//                                anchors.verticalCenter: parent.verticalCenter
//                                anchors.left: parent.left
//                                anchors.leftMargin: 20
//                                color: window.color_smarthouse
//                            }
//                        }
//                        Rectangle {
//                            width: parent.width /2
//                            height: parent.height
//                            color: "transparent"
//                            Text {
//                                text: value_field
//                                anchors.verticalCenter: parent.verticalCenter
//                                anchors.right: parent.right
//                                anchors.rightMargin: 20
//                                color: window.color_smarthouse
//                            }
//                        }
//                    }
//                }
//            }

//            ListView {
//                id: listView_root
//                width: parent.width
//                model: listModel
//                delegate: component_root
//            }
        }*/
    }
}
