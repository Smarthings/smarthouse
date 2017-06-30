#include "./networkdiscovery.h"

NetworkDiscovery::NetworkDiscovery(QObject *parent):
    QObject(parent), m_server_address("")
{
    udpSend = new QUdpSocket(this);
    udpGet = new QUdpSocket(this);
    udpGet->bind(QHostAddress::AnyIPv4, 9933);
    connect(udpGet, SIGNAL(readyRead()), this, SLOT(getMessageDatagram()));
}

void NetworkDiscovery::SearchSmarthingsServer()
{
    QByteArray datagram = "Get IP address Smarthings Server";
    udpSend->writeDatagram(datagram.data(), datagram.size(), QHostAddress::Broadcast, 9932);
    server_address.clear();
    emit serverDiscoveryChanged();
}

void NetworkDiscovery::getMessageDatagram()
{
    qDebug() << "Receive Datagram";
    busy = true;
    emit update_statusChanged();

    QByteArray buffer;
    QString get_server;
    buffer.resize(udpGet->pendingDatagramSize());

    QHostAddress server_addr;
    udpGet->readDatagram(buffer.data(), buffer.size(), &server_addr);
    get_server = server_addr.toString();

    if(get_server.size() > 0)
    {
        setNetDiscovery(server_addr.toString());
        server_address.append(server_addr.toString());
        emit serverDiscoveryChanged();
    }

    busy = false;
    emit update_statusChanged();
    qDebug() << server_address;
}
