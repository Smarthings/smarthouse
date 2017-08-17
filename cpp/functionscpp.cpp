#include "functionscpp.h"

FunctionsCPP::FunctionsCPP(QObject *parent) : QObject(parent)
{

}

int FunctionsCPP::getTimeDifNow(int time)
{
    return (time - QDateTime::currentDateTimeUtc().toTime_t());
}

int FunctionsCPP::getTimeNow(int var)
{
    return QDateTime::currentDateTimeUtc().toTime_t();
}
