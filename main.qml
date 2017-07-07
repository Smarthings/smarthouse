import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import StatusBar 0.1
import NetworkDiscovery 1.0
import TcpClient 1.0

import "ui/"
import "fonts/"

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Smarthouse")

    property color dark_background:         "#111111"
    property color dark_text_primary:       "#ff821e"
    property color dark_background_items:   "#0f0f0f"
    property color dark_text_base:          "#cccccc"
    property color dark_title_base:         "#ffffff"
    property color dark_shadow_itens:       "#1e1e1e" //101010
    property color dark_line_itens:         "#000000"

    property color light_background:        "#f9f9f9"
    property color light_text_primary:      "#dd4814"
    property color light_background_items:  "#f9f9f9"
    property color light_text_base:         "#333333"
    property color light_title_base:        "#222222"
    property color light_shadow_itens:      "#dddddd"
    property color light_line_itens:        "#f0f0f0"

    property bool isConnect: tcpClient.status_conn
    property int numberMessage: tcpClient.error_conn.length

    Settings {
        id: settings
        property string theme: "Light"
        property string color_theme: Material.DeepOrange
        property string server_address: ""
        property int server_port: 9932
        onThemeChanged: {
            themeChoose = theme
        }
        onColor_themeChanged: {
            colorChoose = Material.color(color_theme)
            button_primary_color = colorChoose
            Material.accent = colorChoose
        }
    }

    property string themeChoose: settings.theme
    property string colorChoose: settings.color_theme

    property color background_color: (Material.theme == 0)? light_background : dark_background
    property color background_items: (Material.theme == 0)? light_background_items : dark_background_items
    property color text_color: (Material.theme == 0)? light_text_base : dark_text_base
    property color text_primary_color: colorChoose
    property color shadow_color: (Material.theme == 0)? light_shadow_itens : dark_shadow_itens
    property color line_color: (Material.theme == 0)? light_line_itens : dark_line_itens
    property color title_color: (Material.theme == 0)? light_title_base : dark_title_base
    property color button_foreground_color: "#ffffff"
    property color button_primary_color: colorChoose
    property color button_success_color: (Material.theme == 0)? "#4CAF50" : "#8BC34A"

    property color background_dark: "#333"
    property color background_light: "#EFEFEF"
    property color color_smarthouse: (themeChoose == "Light")? "#DD4814" : "#ff821e"

    property int size_nodes: checkSizeWidth()

    onThemeChooseChanged: {
        if (themeChoose == "Light")
            Material.theme = 0
        else
            Material.theme = 1
        Material.background = background_color
    }
    onColorChooseChanged: {
        Material.accent = colorChoose
    }

    StatusBar {
        id: statusBar
        color: colorChoose
    }

    header: HeaderPage {}

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: HomePage {}
    }

    NetworkDiscovery {
        id: networkDiscovery
    }

    TcpClient {
        id: tcpClient
    }

    FontLoader {
        id: smarthouse
        source: "./fonts/Smarthouse.ttf"
    }

    FontLoader {
        id: smarthouseFont
        source: "./fonts/Smarthouse.ttf"
    }

    Component.onCompleted: {
        tcpClient.server_address = settings.server_address;
        tcpClient.server_port = settings.server_port;
        tcpClient.startConnection();

        //checkConnection();
        //checkSizeWidth();
    }

    onClosing: {
        if (Qt.platform.os == "android")
        {
            close.accepted = false
            if(isConnect == false)
                return;
            if (stackView.depth > 1)
                stackView.pop()
        }
    }

    Connections {
        target: window
        onIsConnectChanged: {
            /*if(isConnect === true)
                tcpClient.writeTcpData("Hello Server")*/
            //checkConnection();
        }
    }

    function checkConnection()
    {
        if(isConnect == false) {
            stackView.push("qrc:/ui/NoConnectionPage.qml")
            header.visible = false
        } else {
            stackView.pop()
            header.visible = true
        }
        console.log(tcpClient.error_conn.length)
    }

    function checkSizeWidth()
    {
        var size = 0
        if (window.width <= 360) {
            size = window.width - 25
        } else {
            console.log(window.width, (window.width / 180), Math.floor(window.width / 180))
            size = (window.width / Math.floor(window.width / 180)) - 15
        }
        return size;
    }   
}
