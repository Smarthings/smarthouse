#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QNetworkAddressEntry>
#include <QProcess>
#include <QDebug>
#include <QList>

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
    Q_PROPERTY(QStringList error_conn READ error_conn WRITE setError_conn NOTIFY error_connChanged)

    Q_PROPERTY(QStringList tcpStringList READ tcpStringList WRITE setTcpStringList NOTIFY tcpStringListChanged)
    Q_PROPERTY(QList<QObject*> nodesList READ nodesList WRITE setNodesList NOTIFY nodesListChanged)
    Q_PROPERTY(QJsonObject sendCommandNode READ sendCommandNode WRITE setSendCommandNode NOTIFY sendCommandNodeChanged)
    //Q_PROPERTY(QByteArray sendCommandNode READ sendCommandNode WRITE setSendCommandNode NOTIFY sendCommandNodeChanged)

public:
    explicit TcpClient(QObject *parent = 0);

Q_SIGNALS:
    void server_addressChanged();
    void server_portChanged();
    void status_connChanged();
    void error_connChanged();
    void tcpStringListChanged();
    void nodesListChanged();
    void nodesUpdateChanged();
    void sendCommandNodeChanged();

public slots:
    void startConnection();
    void disconnect();
    void writeTcpData(QJsonArray *json);

    void setServer_address(QString str){ serverIp = str; Q_EMIT server_addressChanged(); }
    void setServer_port(int str) { serverPort = str; Q_EMIT server_portChanged(); }
    void setError_conn(QStringList str) { errorMsg.clear(); Q_EMIT error_connChanged(); }
    void setTcpStringList(QStringList str) { nodesAddress.clear(); Q_EMIT tcpStringListChanged(); }

    void setNodesList(QList<QObject*> str) { dataList.clear(); Q_EMIT nodesListChanged(); }
    void getNodesFromServer(QJsonObject nodes);
    bool findNodes(QString node, QJsonObject nodes);
    void setSendCommandNode(QJsonObject node);
    void getStopwatchFromServer(QJsonObject nodes);
    //void setSendCommandNode(QString node, QString action);

private slots:
    void readTcpData();
    void connected();
    void disconnected();
    void error();

private:
    QString server_address() { return serverIp; }
    QString serverIp;

    int server_port() { return serverPort; }
    int serverPort;

    bool status_conn() { return status_connecting; }
    bool status_connecting = false;

    QStringList error_conn() { return errorMsg; }
    QStringList errorMsg;

    QStringList tcpStringList() { return nodesAddress; }
    QStringList nodesAddress;

    QTcpSocket *tcpSocket;

    QList<QObject*> nodesList() { return dataList; };
    QList<QObject*> dataList;

    bool nodesUpdate() { return nodes_update; }
    bool nodes_update = false;

    QJsonObject sendCommandNode() { return sendcommand; }
    QJsonObject sendcommand;

    //QByteArray sendCommandNode() { return ""; }
};

#endif // TCPCLIENT_H
