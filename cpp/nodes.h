#ifndef NODES_H
#define NODES_H

#include <QObject>
#include <QList>
#include <QVariant>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QTimer>
#include <QDebug>

class Nodes : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QVariant> nodes READ nodes WRITE updateNode NOTIFY nodesChanged)

public:
    Nodes(QObject *parent = 0);

public slots:
    void getNodesFromServer(QJsonObject nodes);
    void updateNode(QList<QVariant> node);
    bool findUpdateNode(QString node, QJsonObject node_list);
    QList<QVariant> nodes() { return v_nodes; }

Q_SIGNALS:
    void nodesChanged();

protected:
    QJsonObject addNode(QString node, QJsonObject node_list);

private:
    QList<QVariant> v_nodes;
    QStringList fields = {"name", "range", "status", "type", "time"/*, "start", "end"*/, "to_range"};
};

#endif // NODES_H
