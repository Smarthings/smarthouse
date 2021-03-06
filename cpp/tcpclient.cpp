#include "tcpclient.h"

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    connect(_Nodes, SIGNAL(nodesChanged()), this, SIGNAL(getNodesChanged()));
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
                if (key == "Nodes" || key == "Stopwatch") {
                    _Nodes->getNodesFromServer(json_objects.toObject().value(key).toObject());
                    continue;
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

void TcpClient::setSendCommandNode(QJsonObject node)
{
    QString name = node["name"].toString();
    node.remove("name");

    QJsonObject node_object, node_send;
    node_object.insert(name, node);
    node_send.insert("Node", node_object);

    QJsonArray node_array;
    node_array.push_back(node_send);

    writeTcpData(&node_array);
}

void TcpClient::updateNodes(QList<QVariant> node)
{
    QString _node = listNodes[node.at(0).toMap().value("id").toInt()].toMap().take("name").toString();
    QJsonObject value;
    value.insert("time", node.at(0).toMap().value("time").toDouble());

    _Nodes->findUpdateNode(_node, value);
}
