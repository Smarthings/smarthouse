#ifndef NODES_H
#define NODES_H

#include <QObject>

class Nodes : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString range READ range WRITE setRange NOTIFY rangeChanged)
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)

public:
    Nodes(QObject *parent = 0);
    Nodes(const QString &name, const QString &status, const QString &range, const QString &type, QObject *parent = 0);

    QString name() const;
    void setName(const QString &name);

    QString status() const;
    void setStatus(const QString &status);

    QString range() const;
    void setRange(const QString &range);

    QString type() const;
    void setType(const QString &type);

signals:
    void nameChanged();
    void statusChanged();
    void rangeChanged();
    void typeChanged();

private:
    QString m_name;
    QString m_status;
    QString m_range;
    QString m_type;
};

#endif // NODES_H
