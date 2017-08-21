#include "nodes.h"

Nodes::Nodes(QObject *parent) :
    QObject(parent)
{

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

void Nodes::updateNode(QList<QVariant> node)
{
    QString _node = v_nodes[node.at(0).toMap().value("id").toInt()].toMap().take("name").toString();
    QJsonObject value;
    value.insert("time", node.at(0).toMap().value("time").toDouble());
}
