#include "nodes.h"

Nodes::Nodes(QObject *parent) :
    QObject(parent)
{
    connect(stopwatch_timer, SIGNAL(timeout()), SLOT(Stopwatch()));
}

void Nodes::getNodesFromServer(QJsonObject nodes)
{
    QStringList nodes_list = nodes.keys();
    for (const QString &node: nodes_list) {
        nodes[node].toObject().insert("name", node);
        if (!findUpdateNode(node, nodes[node].toObject())) {
            v_nodes.append(addNode(node, nodes[node].toObject()).toVariantMap());
        }
        Q_EMIT nodesChanged();
    }
}

QJsonObject Nodes::addNode(QString node, QJsonObject node_list)
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

bool Nodes::findUpdateNode(QString node, QJsonObject node_list)
{
    QJsonObject obj;
    for (int i = 0; i < v_nodes.count(); i++) {
        if (v_nodes[i].toMap().take("name").toString() == node) {
            for (const QString &field: fields) {
                if (node_list.contains(field)) {
                    if (node_list.value(field).type() == 2) {
                        double _double = node_list.value(field).toDouble();
                        if (field == "range" && _double > 1)
                            _double++;
                        obj.insert(field, _double);
                        if (field == "time") {
                            stopwatch_list.append(node);
                            if (!stopwatch_timer->isActive()) {
                                stopwatch_timer->start(1000);
                            }
                        }
                    } else if (node_list.value(field).type() == 3 || node_list.value(field).type() == 128) {
                        QString _string = node_list.value(field).toString();
                        obj.insert(field, _string);
                    }
                } else if (v_nodes[i].toMap().contains(field)) {
                    if (v_nodes[i].toMap().take(field).type() == QVariant::Double) {
                        double _double = v_nodes[i].toMap().take(field).toDouble();
                        if (field == "range" && _double > 1)
                            _double++;
                        obj.insert(field, _double);
                    } else if (v_nodes[i].toMap().take(field).type() == QVariant::String) {
                        QString _string = v_nodes[i].toMap().take(field).toString();
                        obj.insert(field, _string);
                    }
                }
            }
            v_nodes.replace(i, obj.toVariantMap());
            return true;
        }
    }
    return false;
}

void Nodes::updateTime(QString node, QJsonObject node_list)
{
    QJsonObject obj;
    for (int i = 0; i < v_nodes.count(); i++) {
        if (v_nodes[i].toMap().take("name").toString() == node) {
            for (const QString &field: fields) {
                if (node_list.contains(field)) {
                    if (node_list.value(field).type() == 2) {
                        double _double = node_list.value(field).toDouble();
                        obj.insert(field, _double);
                    } else if (node_list.value(field).type() == 3 || node_list.value(field).type() == 128) {
                        QString _string = node_list.value(field).toString();
                        obj.insert(field, _string);
                    }
                } else if (v_nodes[i].toMap().contains(field)) {
                    if (v_nodes[i].toMap().take(field).type() == QVariant::Double) {
                        double _double = v_nodes[i].toMap().take(field).toDouble();
                        obj.insert(field, _double);
                    } else if (v_nodes[i].toMap().take(field).type() == QVariant::String) {
                        QString _string = v_nodes[i].toMap().take(field).toString();
                        obj.insert(field, _string);
                    }
                }
            }
            v_nodes.replace(i, obj.toVariantMap());
            return;
        }
    }
}

void Nodes::Stopwatch()
{
    quint32 it = 0;
    for (const auto &node: stopwatch_list) {
        for (const auto &v_node: v_nodes) {
            if (node == v_node.toMap().take("name").toString()) {
                QJsonObject value;
                double val = v_node.toMap().take("time").toDouble() -1;
                value.insert("time", val);
                updateTime(node, value);
                Q_EMIT nodesChanged();
                if (val == 0) {
                    stopwatch_list.removeAt(it);
                    if (stopwatch_list.length() == 0)
                        stopwatch_timer->stop();
                }
                break;
            }
        }
        it++;
    }
}
