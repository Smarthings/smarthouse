#include "tcpclient.h"


TcpClient::TcpClient(QObject *parent) : QObject(parent)
{

}

void TcpClient::startConnection()
{
    if(status_connecting == true)
        return;
    tcpSocket = new QTcpSocket(this);
    connect(tcpSocket, SIGNAL(connected()), this, SLOT(connected()));
    connect(tcpSocket, SIGNAL(readyRead()), this, SLOT(readTcpData()));
    connect(tcpSocket, SIGNAL(disconnected()), this, SLOT(disconnected()));

    connect(tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));

    tcpSocket->connectToHost(this->serverIp, this->serverPort);
}

void TcpClient::disconnect()
{
    tcpSocket->close();
}

void TcpClient::connected()
{
    status_connecting = true;
    Q_EMIT status_connChanged();
}

void TcpClient::disconnected()
{
    tcpSocket->deleteLater();
    status_connecting = false;
    Q_EMIT status_connChanged();
}

void TcpClient::writeTcpData(QJsonArray *json)
{
    QJsonDocument json_doc(*json);
    if(tcpSocket->waitForConnected())
        tcpSocket->write(json_doc.toJson());
}

void TcpClient::readTcpData()
{
    tcpSocket->flush();
    QByteArray data = tcpSocket->readAll();
    QJsonParseError parseError;
    QJsonDocument doc_tcp = QJsonDocument::fromJson(data, &parseError);

    if (parseError.error == 0) {
        for (const QJsonValue &json_objects: doc_tcp.array()) {
            for (const QString &key: json_objects.toObject().keys()) {
                if (key == "Nodes") {
                    getNodesFromServer(json_objects.toObject().value("Nodes").toObject());
                }
            }
        }
    } else {
        qDebug() << "Error JSON parse" << parseError.error;
    }
}

void TcpClient::error()
{
    errorMsg.append(tcpSocket->errorString());
    qDebug() << tcpSocket->errorString();
    Q_EMIT error_connChanged();
}

void TcpClient::getNodesFromServer(QJsonObject nodes)
{
    QStringList nodes_list = nodes.keys();
    for (const QString &node: nodes_list) {
        if (!findNodes(node, nodes)) {
            dataList.append(new Nodes(node,
                                      nodes[node].toObject().value("status").toString(),
                                      nodes[node].toObject().value("range").toString()));
        }
        Q_EMIT nodesListChanged();
    }
}

bool TcpClient::findNodes(QString node, QJsonObject nodes)
{
    for (int i = 0; i < dataList.count(); i++) {
        if (dataList[i]->property("name") == node) {
            dataList.replace(i, new Nodes(node,
                                          nodes[node].toObject().value("status").toString(),
                                          nodes[node].toObject().value("range").toString()));
            return true;
        }
    }
    return false;
}

void TcpClient::setSendCommandNode(QString node)
{
    QJsonObject node_object,
                node_action;
    QJsonArray node_array;

    node_object.insert("action", node);
    node_action.insert("Node", node_object);
    node_array.push_back(node_action);

    writeTcpData(&node_array);
}
