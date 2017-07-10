import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../../fonts/"

Item {
    id: item
    property int iconSize: 32
    property string iconName: ""
    property string iconColor: Material.foreground
    property string unicode: ""
    property int itemWidth: 0
    property int itemHeight: 0

    width: (itemWidth > 0)? itemWidth : iconSize
    height: (itemHeight > 0)? itemHeight : iconSize

    property variant listFont: {
        "home" : "\uf000",
        "lamp" : "\uf001",
        "smartphone" : "\uf002",
        "menu" : "\uf003",
        "go" : "\uf004",
        "back" : "\uf005",
        "up" : "\uf006",
        "down" : "\uf007",
        "search" : "\uf008",
        "close" : "\uf009",
        "ok" : "\uf010",
        "question" : "\uf011",
        "exclamation" : "\uf012",
        "clock" : "\uf013",
        "alarm" : "\uf014",
        "key" : "\uf015",
        "trash" : "\uf016",
        "close_circle" : "\uf017",
        "crop" : "\uf018",
        "fan" : "\uf019",
        "ceiling_fan" : "\uf020",
        "alert" : "\uf021",
    }

    FontLoader {
        id: smartfont
        source: "../../fonts/Smarthouse.ttf"
    }

    Text {
        id: icon
        text: (iconName != "")? listFont[iconName] : unicode
        font.family: smartfont.name
        font.pixelSize: iconSize
        color: iconColor

        anchors.centerIn: parent
    }
}
