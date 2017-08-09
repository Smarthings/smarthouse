#include "variantteste.h"

VariantTeste::VariantTeste(QObject *parent) : QObject(parent)
{
    QJsonObject objs;
    objs.insert("name", "001");
    objs.insert("range", "90");
    objs.insert("type", "01");

    QJsonObject objs2;
    objs2.insert("name", "002");
    objs2.insert("range", "50");

    map.insert("001", objs.toVariantMap());
    map.insert("002", objs2.toVariantMap());

    list.append(objs.toVariantMap());
    list.append(objs2.toVariantMap());

    QString str_time_start = QString::number(QDateTime::currentDateTime().toTime_t());
    QString str_time_end = QString::number(QDateTime::currentDateTime().toTime_t() + 500);

    qlist_variant.append(objs);
    qlist_variant.append(objs2);

    addNodes("001", "start", str_time_start);
    addNodes("001", "end", str_time_end);

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(addAttrNode()));
    timer->start(5000);
}

bool VariantTeste::addNodes(QString node, QString key, QString value)
{
    QJsonObject obj;
    for (int i = 0; i < qlist_variant.count(); i++) {
        if (qlist_variant[i].toJsonObject().value("name").toString() == node) {
            if (qlist_variant[i].toJsonObject().contains("range")) {
                obj.insert("range", qlist_variant[i].toJsonObject().value("range").toString());
            }
            if (qlist_variant[i].toJsonObject().contains("status")) {
                obj.insert("status", qlist_variant[i].toJsonObject().value("status").toString());
            }
            if (qlist_variant[i].toJsonObject().contains("range")) {
                obj.insert("range", qlist_variant[i].toJsonObject().value("range").toString());
            }
            if (qlist_variant[i].toJsonObject().contains("type")) {
                obj.insert("type", qlist_variant[i].toJsonObject().value("type").toString());
            }
            if (qlist_variant[i].toJsonObject().contains("start")) {
                obj.insert("start", qlist_variant[i].toJsonObject().value("start").toString());
            }
            if (qlist_variant[i].toJsonObject().contains("end")) {
                obj.insert("end", qlist_variant[i].toJsonObject().value("end").toString());
            }

            obj.insert("name", qlist_variant[i].toJsonObject().value("name").toString());
            obj.insert(key, value);
            qlist_variant.replace(i, obj);

            emit qlistvariantChanged();
            return true;
        }
    }
    return true;
}

void VariantTeste::addAttrNode()
{
    QString str_time_start = QString::number(QDateTime::currentDateTime().toTime_t());
    QString str_time_end = QString::number(QDateTime::currentDateTime().toTime_t() + 500);

    addNodes("002", "start", str_time_start);
    addNodes("002", "end", str_time_end);
}
