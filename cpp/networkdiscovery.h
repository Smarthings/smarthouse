#ifndef NETWORKDISCOVERY_H
#define NETWORKDISCOVERY_H

#include <QObject>
#include <QDebug>
#include <QUdpSocket>

class NetworkDiscovery : public QObject
{
    Q_OBJECT
    /*Q_PROPERTY(QString netDiscovery READ netDiscovery WRITE setNetDiscovery NOTIFY netDiscoveryChanged)*/
    Q_PROPERTY(QStringList serverDiscovery READ serverDiscovery WRITE setServerDiscovery NOTIFY serverDiscoveryChanged)
    Q_PROPERTY(bool update_status READ update_status NOTIFY update_statusChanged)
    Q_PROPERTY(int countServers READ countServers NOTIFY countServersChanged)

public:
    explicit NetworkDiscovery(QObject *parent = 0);
    ~NetworkDiscovery() {}

Q_SIGNALS:
    void netDiscoveryChanged();
    void serverDiscoveryChanged();
    void update_statusChanged();
    void countServersChanged();

public slots:
    void SearchSmarthingsServer();
    void getMessageDatagram();
    void setServerDiscovery(QStringList str) { server_address.clear(); Q_EMIT serverDiscoveryChanged(); }

private:
    QString netDiscovery() { return m_server_address; }
    void setNetDiscovery(QString str) { m_server_address = str; Q_EMIT netDiscoveryChanged(); }

    QStringList serverDiscovery() { return server_address; }
    bool update_status() { return busy; }
    int countServers() { return server_address.count(); }

    QString m_server_address;
    QStringList server_address;
    bool busy = false;
    QUdpSocket *udpSend, *udpGet;
};

#endif // NETWORKDISCOVERY_H
