#ifndef STOPWATCH_H
#define STOPWATCH_H

#include <QObject>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>

class Stopwatch : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString range READ range WRITE setRange NOTIFY rangeChanged)
    Q_PROPERTY(int start READ start WRITE setStart NOTIFY startChanged)
    Q_PROPERTY(int end READ end WRITE setEnd NOTIFY endChanged)
    Q_PROPERTY(QJsonObject stopwatch READ stopwatch WRITE setStopwatch NOTIFY stopwatchChanged)

public:
    Stopwatch(QObject *parent = nullptr);
    Stopwatch(const QString &name, const QString &range, const int &start, const int &end, QObject *parent = 0);

    QString name() const;
    void setName(const QString &name);

    QString range() const;
    void setRange(const QString &range);

    int start() const;
    void setStart(const int &start);

    int end() const;
    void setEnd(const int &end);

    QJsonObject stopwatch() const;
    void setStopwatch(const QJsonObject &stopwatch);

signals:
    void nameChanged();
    void rangeChanged();
    void startChanged();
    void endChanged();
    void stopwatchChanged();

public slots:

private:
    QString m_name;
    QString m_range;
    int m_start;
    int m_end;
    QJsonObject m_stopwatch;
};

#endif // STOPWATCH_H
