#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QNetworkAddressEntry>
#include <QDebug>
#include <QList>
#include <QVariant>
#include <QDateTime>
#include <QTimer>

#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

#include "nodes.h"

class TcpClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString server_address READ server_address WRITE setServer_address NOTIFY server_addressChanged)
    Q_PROPERTY(int server_port READ server_port WRITE setServer_port NOTIFY server_portChanged)
    Q_PROPERTY(bool status_conn READ status_conn NOTIFY status_connChanged)
    Q_PROPERTY(QStringList error_conn READ error_conn NOTIFY error_connChanged)

    Q_PROPERTY(QList<QVariant> getNodes READ getNodes WRITE updateNodes NOTIFY getNodesChanged)
    Q_PROPERTY(QJsonObject sendCommandNode READ sendCommandNode WRITE setSendCommandNode NOTIFY sendCommandNodeChanged)

public:
    explicit TcpClient(QObject *parent = 0);

Q_SIGNALS:
    void server_addressChanged();
    void server_portChanged();
    void status_connChanged();
    void error_connChanged();
    void nodesUpdateChanged();
    void sendCommandNodeChanged();
    void getNodesChanged();

signals:
    void getNodesServer(QJsonObject nodes);

public slots:
    void startConnection();
    void disconnect();
    void writeTcpData(QJsonArray *json);

    void setServer_address(QString str){ serverIp = str; Q_EMIT server_addressChanged(); }
    void setServer_port(int str) { serverPort = str; Q_EMIT server_portChanged(); }
    void updateNodes(QList<QVariant> node);
    void setSendCommandNode(QJsonObject node);

private slots:
    void readTcpData();
    void connected();
    void disconnected();
    void error();
    //void stopwatch();

private:
    QString server_address() { return serverIp; }
    QString serverIp;

    int server_port() { return serverPort; }
    int serverPort;

    bool status_conn() { return status_connecting; }
    bool status_connecting = false;

    QStringList error_conn() { return errorMsg; }
    QStringList errorMsg;

    QTcpSocket *tcpSocket;

    QList<QVariant> getNodes() { return _Nodes->nodes(); }
    QList<QVariant> listNodes;

    bool nodesUpdate() { return nodes_update; }
    bool nodes_update = false;

    QJsonObject sendCommandNode() { return sendcommand; }
    QJsonObject sendcommand;

    QStringList fields = {"name", "range", "status", "type", "time"/*, "start", "end"*/, "to_range"};

    QTimer *timer = new QTimer(this);
    QList<QJsonObject> list_stopwatch;

    Nodes *_Nodes = new Nodes(this);
};

#endif // TCPCLIENT_H
