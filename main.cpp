#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

#include "./cpp/networkdiscovery.h"
#include "./cpp/tcpclient.h"
#include "./cpp/nodes.h"
#include "./cpp/statusbar.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<NetworkDiscovery>("NetworkDiscovery", 1, 0, "NetworkDiscovery");
    qmlRegisterType<TcpClient>("TcpClient", 1, 0, "TcpClient");
    qmlRegisterType<StatusBar>("StatusBar", 0, 1, "StatusBar");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
