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
    Q_PROPERTY(QList<QVariant> nodes READ nodes NOTIFY nodesChanged)

public:
    Nodes(QObject *parent = 0);

public slots:
    void getNodesFromServer(QJsonObject nodes);
    bool findUpdateNode(QString node, QJsonObject node_list);
    void updateTime(QString node, QJsonObject node_list);
    QList<QVariant> nodes() { return v_nodes; }

protected slots:
    void Stopwatch();

Q_SIGNALS:
    void nodesChanged();
    void stopwatch_listChanged();

protected:
    QJsonObject addNode(QString node, QJsonObject node_list);

private:
    QList<QVariant> v_nodes;
    QStringList fields = {"name", "range", "status", "type", "time"/*, "start", "end"*/, "to_range"};

    QList<QString> stopwatch_list;
    QTimer *stopwatch_timer = new QTimer();
};

#endif // NODES_H
