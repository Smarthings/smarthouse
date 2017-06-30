#include "nodes.h"
#include <QDebug>

Nodes::Nodes(QObject *parent) :
    QObject(parent), m_name(name()), m_status(status())
{

}

Nodes::Nodes(const QString &name, const QString &status, const QString &range, QObject *parent) :
    QObject(parent), m_name(name), m_status(status), m_range(range)
{

}

QString Nodes::name() const
{
    return m_name;
}

void Nodes::setName(const QString &name)
{
    if (name != m_name)
    {
        m_name = name;
        emit nameChanged();
    }
}

QString Nodes::status() const
{
    return m_status;
}

void Nodes::setStatus(const QString &status)
{
    if (status != m_status)
    {
        m_status = status;
        emit statusChanged();
    }
}

QString Nodes::range() const
{
    return m_range;
}

void Nodes::setRange(const QString &range)
{
    if (range != m_range)
    {
        m_range = range;
        emit rangeChanged();
    }
}
