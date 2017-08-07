#include "stopwatch.h"

Stopwatch::Stopwatch(const QString &name, const QString &range, const int &start, const int &end, QObject *parent) :
    QObject(parent), m_name(name), m_range(range), m_start(start), m_end(end)
{

}

QString Stopwatch::name() const
{
    return m_name;
}

void Stopwatch::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged();
    }
}

QString Stopwatch::range() const
{
    return m_range;
}

void Stopwatch::setRange(const QString &range)
{
    if (range != m_range) {
        m_range = range;
        emit rangeChanged();
    }
}

int Stopwatch::start() const
{
    return m_start;
}

void Stopwatch::setStart(const int &start)
{
    if (start != m_start) {
        m_start = start;
        emit startChanged();
    }
}

int Stopwatch::end() const
{
    return m_end;
}

void Stopwatch::setEnd(const int &end)
{
    if (end != m_end) {
        m_end = end;
        emit endChanged();
    }
}

QJsonObject Stopwatch::stopwatch() const
{
    return m_stopwatch;
}

void Stopwatch::setStopwatch(const QJsonObject &stopwatch)
{
    if (stopwatch != m_stopwatch) {
        m_stopwatch = stopwatch;
        emit stopwatchChanged();
    }
}
