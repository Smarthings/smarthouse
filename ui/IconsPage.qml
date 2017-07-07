import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ScrollablePage {
    id: iconsPage

    property int width_icon: slider.value

    Column {
        width: parent.width

        Item {
            width: parent.width
            height: 50
            Slider {
                id: slider
                from: 10
                value: 50
                to: 200
                stepSize: 1
            }
        }

        Item {
            width: parent.width
            height: 50

            GridView {
                id: gridview
                cellWidth: width_icon
                cellHeight: width_icon
                anchors.fill: parent
                focus: true

                model: listIcons

                delegate: Item {
                    id: item_content
                    width: gridview.cellWidth
                    height: gridview.cellHeight
                    anchors.margins: 5

                    Text {
                        text: name
                        font.family: smarthouseFont.name
                        font.pixelSize: width_icon
                        color: Material.foreground
                    }
                }

                ListModel {
                    id: listIcons
                    ListElement { name: "\uf000" }
                    ListElement { name: "\uf001" }
                    ListElement { name: "\uf002" }
                    ListElement { name: "\uf003" }
                    ListElement { name: "\uf004" }
                    ListElement { name: "\uf005" }
                    ListElement { name: "\uf006" }
                    ListElement { name: "\uf007" }
                    ListElement { name: "\uf008" }
                    ListElement { name: "\uf009" }
                    ListElement { name: "\uf010" }
                    ListElement { name: "\uf012" }
                    ListElement { name: "\uf012" }
                    ListElement { name: "\uf013" }
                    ListElement { name: "\uf014" }
                    ListElement { name: "\uf015" }
                    ListElement { name: "\uf016" }
                    ListElement { name: "\uf017" }
                    ListElement { name: "\uf018" }

                }
            }
        }

    }
}

