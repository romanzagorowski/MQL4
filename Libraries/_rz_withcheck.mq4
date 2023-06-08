//+------------------------------------------------------------------+
//|                                                _rz_withcheck.mq4 |
//|                                     roman.zagorowski@hotmail.com |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "roman.zagorowski@hotmail.com"
#property link      ""
#property version   "1.00"
#property strict

#include <stdlib.mqh>

//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+
bool ObjectSetDoubleWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_DOUBLE propId, int propModifier, double propValue)
export
{
    bool set = ObjectSetDouble(0, objectName, propId, propModifier, propValue);
    
    if(!set)
    {
        int error = GetLastError();
        
        Print("ERROR: ObjectSetDouble() has failed. chartId=", chartId, 
            ", objectName='", objectName, 
            ", propId=", EnumToString(propId), 
            ", propModifier=", propModifier,
            "propValue=", DoubleToString(propValue),
            "', error=", error, 
            ", description='", ErrorDescription(error), "'"
            );
    }
    
    return set;
}
//+------------------------------------------------------------------+
bool ObjectSetIntegerWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_INTEGER propId, int propModifier, long propValue)
export
{
    bool set = ObjectSetInteger(0, objectName, propId, propModifier, propValue);
    
    if(!set)
    {
        int error = GetLastError();
        
        Print(
            "ERROR: ObjectSetInteger() has failed. chartId=", chartId, 
            ", objectName='", objectName, 
            ", propId=", EnumToString(propId), 
            ", propModifier=", propModifier,
            ", propValue=", propValue,
            "', error=", error, 
            ", description='", ErrorDescription(error), "'"
            );
    }
    
    return set;
}
//+------------------------------------------------------------------+
bool ObjectSetIntegerWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_INTEGER propId, long propValue)
export
{
    bool set = ObjectSetInteger(0, objectName, propId, propValue);
    
    if(!set)
    {
        int error = GetLastError();
        
        Print("ERROR: ObjectSetInteger() has failed. propId=", EnumToString(propId), ", objectName='", objectName, "', error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return set;
}
//+------------------------------------------------------------------+
bool ObjectSetStringWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_STRING propId, const string propValue)
export
{
    bool set = ObjectSetString(chartId, objectName, propId, propValue);

    if(!set)
    {
        int error = GetLastError();
        
        Print("ERROR: ObjectSetString() has failed. propId=", EnumToString(propId), ", objectName='", objectName, "', error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return set;
}
//+------------------------------------------------------------------+
bool ObjectDeleteWithCheck(string objectName)
export
{
    bool deleted = ObjectDelete(objectName);
    
    if(!deleted) 
    {
        int error = GetLastError();
        
        Print("ERROR: ObjectDelete() has failed. objectName='", objectName, "', error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return deleted;
}
//+------------------------------------------------------------------+
int ObjectTypeWithCheck(string objectName)
export
{
    int objectType = ObjectType(objectName);
    
    int error = GetLastError();
    
    if(ERR_NO_ERROR != error)
    {
        Print("ERROR: ObjectType() has failed. error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return objectType;
}
//+------------------------------------------------------------------+
int ObjectsTotalWithCheck()
export
{
    const int objectsTotal = ObjectsTotal();
    
    int error = GetLastError();
    
    if(ERR_NO_ERROR != error)
    {
        Print("ERROR: ObjectsTotal() has failed. error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return objectsTotal;
}
//+------------------------------------------------------------------+
string ObjectNameWithCheck(int index)
export
{
    const string objectName = ObjectName(index);

    int error = GetLastError();
    
    if(ERR_NO_ERROR != error)
    {
        Print("ERROR: ObjectName() has failed. error=", error, ", description='", ErrorDescription(error), "'");
    }
    
    return objectName;
}
//+------------------------------------------------------------------+
bool ObjectCreateWithCheck(string objectName, ENUM_OBJECT objectType, int subWindow, datetime time1, double price1, datetime time2, double price2)
export
{
    bool created = ObjectCreate(objectName, objectType, 0, time1, price1, time2, price2);
    
    if(!created)
    {
        int error = GetLastError();
        
        Print("ERROR: ObjectCreate() has failed. objectName='", objectName, 
            ", objectType=", EnumToString(objectType),
            ", subWindow=", subWindow,
            ", time1='", time1,
            "', price1=", DoubleToString(price1),
            ", time2='", time2,
            "', price2=", DoubleToString(price2),
            "', error=", error, ", description='", ErrorDescription(error), "'");
    }

    return created;
}
//+------------------------------------------------------------------+
