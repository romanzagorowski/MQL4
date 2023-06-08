//+------------------------------------------------------------------+
//|                                                _rz_withcheck.mqh |
//|                                     roman.zagorowski@hotmail.com |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "roman.zagorowski@hotmail.com"
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
#import "_rz_withcheck.ex4"

bool ObjectSetDoubleWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_DOUBLE propId, int propModifier, double propValue);
bool ObjectSetIntegerWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_INTEGER propId, long propValue);
bool ObjectSetIntegerWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_INTEGER propId, int propModifier, long propValue);
bool ObjectSetStringWithCheck(long chartId, string objectName, ENUM_OBJECT_PROPERTY_STRING propId, const string propValue);
bool ObjectDeleteWithCheck(string objectName);
int ObjectTypeWithCheck(string objectName);
int ObjectsTotalWithCheck();
string ObjectNameWithCheck(int index);
bool ObjectCreateWithCheck(string objectName, ENUM_OBJECT objectType, int subWindow, datetime time1, double price1, datetime time2, double price2);

#import
