#ifndef FUNCTIONSCPP_H
#define FUNCTIONSCPP_H

#include <QObject>
#include <QDateTime>
#include <QDebug>

class FunctionsCPP : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int timeDifNow WRITE getTimeDifNow)
    Q_PROPERTY(int timeNow WRITE getTimeNow)
public:
    explicit FunctionsCPP(QObject *parent = nullptr);

public slots:
    int getTimeDifNow(int time);
    int getTimeNow(int var = NULL);

private:
    int _timedif;
};

#endif // FUNCTIONSCPP_H
