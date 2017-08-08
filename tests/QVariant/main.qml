import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import VariantTeste 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    VariantTeste {
        id: variant
    }

    Component.onCompleted: {
        //func_variant();
    }

    function func_variant()
    {
        console.log("List")
        for (var list in variant.lists) {
            console.log(list, variant.lists[list].name, variant.lists[list].range, variant.lists[list].start);
        }

        console.log("Map")
        for (var node in variant.variant) {
            console.log(variant.variant[node].name, variant.variant[node].range);
        }
    }

    ListModel {
        id: list_model

        ListElement { name: "Teste 1" }
    }

    Item {
        anchors.fill: parent

        GridView {
            id: gridview_example

            cellHeight: 100
            cellWidth: 100
            anchors.fill: parent
            focus: true

            model: variant.lists

            delegate: Item {
                id: item_content
                width: gridview_example.cellWidth -10
                height: gridview_example.cellHeight -10

                Rectangle {
                    id: rectangle_box
                    anchors.fill: parent
                    color: "#999"

                    Text {
                        text: model.modelData.name
                    }
                }
            }
        }
    }
}
