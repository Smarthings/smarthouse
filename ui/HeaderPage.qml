import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

import "./components/"

Rectangle {
    id: root
    property string title_page: ""

    width: parent.width
    height: 60
    color: colorChoose

    Keys.onPressed: {
        if (event.key == Qt.Key_Backspace || event.key == Qt.Key_Return)
            if (stackView.depth > 1)
                stackView.pop()
    }

    Rectangle {
        id:  header_main
        width: parent.width
        height: parent.height - line_header.height
        color: "transparent"

        Row {
            id: row_header_main
            width: parent.width
            height: parent.height - line_header.height
            spacing: 5

            visible: (stackView.depth > 1)? false : true

            Item {
                id: logo_img
                width: 60
                height: parent.height

                Rectangle {
                    width: 50
                    height: 50
                    radius: 60
                    anchors.centerIn: parent

                    SmartIcon {
                        iconName: "home"
                        iconSize: 40
                        iconColor: Material.accent
                        itemWidth: parent.width
                        itemHeight: parent.height
                    }
                }
            }

            Text {
                id: header_title
                width: parent.width - logo_img.width - drawer_button.width - 20
                height: parent.height
                text: qsTr("SmartHouse")
                color: "#ffffff"
                font.pixelSize: 20
                font.weight: Font.Light
                verticalAlignment: Qt.AlignVCenter
            }

            ToolButton {
                id: drawer_button
                width: 50
                height: parent.height
                contentItem: Item {
                    width: parent.width
                    height: parent.height

                    anchors.centerIn: parent

                    SmartIcon {
                        iconName: "menu"
                        iconSize: 24
                        iconColor: "#ffffff"
                        itemWidth: parent.width
                        itemHeight: parent.height
                    }
                }
                onClicked:
                    menu_item.open()

                Menu {
                    id: menu_item
                    x: parent.width - width
                    y: 20
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: qsTr("Configurações")
                        font.weight: Font.Light
                        onTriggered: {
                            stackView.push("qrc:/ui/SettingsPage.qml")
                            title_page = qsTr("Configurações")
                        }
                    }
                    MenuItem {
                        text: qsTr("Sem Conexão")
                        font.weight: Font.Light
                        onTriggered: {
                            stackView.push("qrc:/ui/NoConnectionPage.qml")
                            title_page = qsTr("Sem Conexão")
                        }
                    }
                    MenuItem {
                        text: qsTr("Exemplo de Nodes")
                        font.weight: Font.Light
                        onTriggered: {
                            stackView.push("qrc:/ui/NodePage.qml")
                            title_page = qsTr("Nodes - Exemplos")
                        }
                    }
                    MenuItem {
                        text: qsTr("Lista de Ícones")
                        font.weight: Font.Light
                        onTriggered: {
                            stackView.push("qrc:/ui/IconsPage.qml")
                            title_page = qsTr("Ícones - Exemplos")
                        }
                    }
                    MenuItem {
                        text: qsTr("Sobre / Ajuda")
                        font.weight: Font.Light
                        onTriggered: {}
                    }
                }
            }
        }

        Row {
            id: row_header_pages
            width: parent.width
            height: parent.height - line_header.height
            spacing: 5

            visible: (stackView.depth > 1)? true : false

            ToolButton {
                id: button_return
                width: 50
                height: parent.height
                contentItem: Item {
                    width: parent.width
                    height: parent.height

                    anchors.centerIn: parent

                    SmartIcon {
                        iconName: "back"
                        iconColor: "#ffffff"
                        itemWidth: parent.width
                        itemHeight: parent.height
                    }
                }

                onClicked:
                    stackView.pop()
            }

            Text {
                id: header_title_page
                width: parent.width
                height: parent.height
                text: root.title_page
                color: "#ffffff"
                font.pixelSize: 20
                font.weight: Font.Light
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }

    Rectangle {
        id: line_header
        width: parent.width
        height: 1
        color: line_color
        anchors.bottom: line_header2.top
    }
    Rectangle {
        id: line_header2
        width: parent.width
        height: 1
        color: shadow_color
        anchors.bottom: parent.bottom
    }
}
