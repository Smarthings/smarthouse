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
                    if (key == "Nodes" || key == "Stopwatch") {
                        getNodesFromServer(json_objects.toObject().value(key).toObject());
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
    }

    QJsonObject TcpClient::addNode(QString node, QJsonObject node_list)
    {
        QJsonObject obj;
        QStringList keys = node_list.keys();
        obj.insert("name", node);
        for (const QString &key: keys) {
            if (node_list.value(key).type() == 2) {
                double _double = node_list.value(key).toDouble();
                if (key == "range" && _double > 1)
                    _double++;
                obj.insert(key, _double);
            } else if (node_list.value(key).type() == 3 || node_list.value(key).type() == 128) {
                QString _string = node_list.value(key).toString();
                obj.insert(key, _string);
            }
        }
        return obj;
    }

    bool TcpClient::findNodes(QString node, QJsonObject node_list)
    {
        QJsonObject obj;
        for (int i = 0; i < listNodes.count(); i++) {
            if (listNodes[i].toMap().take("name").toString() == node) {
                for (const QString &field: fields) {
                    if (node_list.contains(field)) {
                        if (node_list.value(field).type() == 2) {
                            double _double = node_list.value(field).toDouble();
                            if (field == "range" && _double > 1)
                                _double++;
                            obj.insert(field, _double);
                        } else if (node_list.value(field).type() == 3 || node_list.value(field).type() == 128) {
                            QString _string = node_list.value(field).toString();
                            obj.insert(field, _string);
                        }
                    } else if (listNodes[i].toMap().contains(field)) {
                        if (listNodes[i].toMap().take(field).type() == QVariant::Double) {
                            double _double = listNodes[i].toMap().take(field).toDouble();
                            if (field == "range" && _double > 1)
                                _double++;
                            obj.insert(field, _double);
                        } else if (listNodes[i].toMap().take(field).type() == QVariant::String) {
                            QString _string = listNodes[i].toMap().take(field).toString();
                            obj.insert(field, _string);
                        }
                    }
                }
                listNodes.replace(i, obj.toVariantMap());
                return true;
            }
        }
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

    void TcpClient::updateNodes(QList<QVariant> node)
    {
        QString _node = listNodes[node.at(0).toMap().value("id").toInt()].toMap().take("name").toString();
        QJsonObject value;
        value.insert("time", node.at(0).toMap().value("time").toDouble());

        this->findNodes(_node, value);
    }
