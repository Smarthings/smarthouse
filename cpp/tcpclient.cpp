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
                if (key == "Stopwatch") {
                    getStopwatchFromServer(json_objects.toObject().value("Stopwatch").toObject());
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
        nodes[node].toObject().insert("name", node);
        if (!findNodes(node, nodes[node].toObject())) {
            listNodes.append(addNode(node, nodes[node].toObject()).toVariantMap());
        }
        Q_EMIT getNodesChanged();
    }
    /*for (const QString &node: nodes_list) {
        if (!findNodes(node, nodes)) {
            dataList.append(
                        new Nodes(
                            node,
                            nodes[node].toObject().value("status").toString(),
                            nodes[node].toObject().value("range").toString(),
                            nodes[node].toObject().value("type").toString()
                            )
                        );
        }
        Q_EMIT nodesListChanged();
    }*/
}

QJsonObject TcpClient::addNode(QString node, QJsonObject node_list)
{
    QJsonObject obj;
    QStringList keys = node_list.keys();
    obj.insert("name", node);
    for (const QString &key: keys) {
        obj.insert(key, node_list.value(key).toString());
    }
    return obj;
}

bool TcpClient::findNodes(QString node, QJsonObject node_list)
{
    QJsonObject obj;
    for (int i = 0; i < listNodes.count(); i++) {
        if (listNodes[i].toJsonObject().value("name").toString() == node) {
            for (const QString &field: fields) {
                if (node_list.contains(field)) {
                    obj.insert(field, node_list.value(field).toString());
                } else if (listNodes[i].toJsonObject().contains(field)) {
                    obj.insert(field, listNodes[i].toJsonObject().value(field).toString());
                }
            }
            listNodes.replace(i, obj.toVariantMap());
            return true;
        }
    }
    /*for (int i = 0; i < dataList.count(); i++) {
        if (dataList[i]->property("name") == node) {
            dataList.replace(i,
                             new Nodes(
                                 node,
                                 nodes[node].toObject().value("status").toString(),
                                 nodes[node].toObject().value("range").toString(),
                                 nodes[node].toObject().value("type").toString())
                             );
            return true;
        }
    }*/
    return false;
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

void TcpClient::getStopwatchFromServer(QJsonObject nodes)
{
    QStringList nodes_list = nodes.keys();
    for (const QString &node: nodes_list) {
        QJsonObject stopwatch, object;
        object.insert("range", nodes[node].toObject().value("action").toObject().value("range").toString());
        object.insert("start", nodes[node].toObject().value("timestamp").toObject().value("start").toInt());
        object.insert("end", nodes[node].toObject().value("timestamp").toObject().value("end").toInt());
        stopwatch.insert("stopwatch", object);

        m_stopwatch.append(new Stopwatch(
                               node,
                               nodes[node].toObject().value("action").toObject().value("range").toString(),
                               nodes[node].toObject().value("timestamp").toObject().value("start").toInt(),
                               nodes[node].toObject().value("timestamp").toObject().value("end").toInt()
                            ));
        Q_EMIT stopwatchListChanged();
    }
}
