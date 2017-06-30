#ifndef NODES_H
#define NODES_H

#include <QObject>

class Nodes : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString range READ range WRITE setRange NOTIFY rangeChanged)

public:
    Nodes(QObject *parent = 0);
    Nodes(const QString &name, const QString &status, const QString &range, QObject *parent = 0);

    QString name() const;
    void setName(const QString &name);

    QString status() const;
    void setStatus(const QString &status);

    QString range() const;
    void setRange(const QString &range);

signals:
    void nameChanged();
    void statusChanged();
    void rangeChanged();

private:
    QString m_name;
    QString m_status;
    QString m_range;
};

#endif // NODES_H
