#ifndef VARIANTTESTE_H
#define VARIANTTESTE_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QVariant>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include <QDateTime>
#include <QTimer>

class VariantTeste : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap variant READ variant NOTIFY variantChanged)
    Q_PROPERTY(QVariantList lists READ lists NOTIFY listsChanged)
    Q_PROPERTY(QList<QVariant> qlistvariant READ qlistvariant NOTIFY qlistvariantChanged)

public:
    explicit VariantTeste(QObject *parent = nullptr);
    bool addNodes(QString node, QString key, QString value);

signals:

Q_SIGNALS:
    void variantChanged();
    void listsChanged();
    void qlistvariantChanged();

public slots:
    void addAttrNode();

private:
    QVariantMap variant() { return map; }
    QVariantList lists() { return list; }
    QList<QVariant> qlistvariant() {return qlist_variant; }

    QVariantList list;
    QVariantMap map;

    QList<QVariant> qlist_variant;
};

#endif // VARIANTTESTE_H
