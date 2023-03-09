//+------------------------------------------------------------------+
//|                                                    _rz_ea_01.mq4 |
//|                                     roman.zagorowski@hotmail.com |
//+------------------------------------------------------------------+
#property copyright "roman.zagorowski@hotmail.com"
#property version   "1.00"
#property strict

#include <stdlib.mqh>

//--- input parameters
input int      FastMAPeriod=25;
input int      SlowMAPeriod=50;
//--- global constants
#define MAGIC_NUMBER 20230309

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
}
//+------------------------------------------------------------------+
bool SelectOrderByMagicNumber(const int magicNumber)
{
    for(int i = 0; i < OrdersTotal(); ++i)
    {
        bool selected = OrderSelect(i, SELECT_BY_POS);
        
        if(!selected)
            Alert("ERROR: FindOrder(): OrderSelect failed (LastError=", GetLastError(), ")");

        if(OrderMagicNumber() == magicNumber)
        {
            return true;
        }
    }
    
    return false;
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    const double fastMA0 = iMA(NULL, PERIOD_CURRENT, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 0);
    const double slowMA0 = iMA(NULL, PERIOD_CURRENT, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 0);
    const double fastMA1 = iMA(NULL, PERIOD_CURRENT, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 1);
    const double slowMA1 = iMA(NULL, PERIOD_CURRENT, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 1);

    // Detect sell signal
    if(fastMA1 > slowMA1 && fastMA0 < slowMA0)
    {
        // Ok. The fast MA dived under the slow MA.
        // It's a signal to enter short position or
        // To close a long position and then open a short one - switch from long to short position.

        if(SelectOrderByMagicNumber(MAGIC_NUMBER))
        {
            const int orderType = OrderType();
            
            if(OP_SELL == orderType)
            {
                // We already have short position open. Stop processing.
                return;
            }
            
            if(OP_BUY == orderType)
            {
                // We have opend long position. Close it.
                bool closed = OrderClose(
                    OrderTicket()
                ,   OrderLots()
                ,   Bid
                ,   0
                );
                
                if(!closed)
                    Alert(
                        "ERROR: OnTick(): OrderClose() failed (LastError="
                    ,   GetLastError()
                    ,   ", ErrorDescription='"
                    ,   ErrorDescription(GetLastError())
                    ,   "')"
                    );
            }
        }
        
        // Ok. If we get here, we have no open positions.
        
        // Open short position.
        bool sent = OrderSend(
            NULL
        ,   OP_SELL
        ,   0.01
        ,   Bid
        ,   0
        ,   0
        ,   0
        ,   NULL
        ,   MAGIC_NUMBER
        );
        
        if(!sent)
            Alert(
                "ERROR: OnTick(): OrderSend() failed (LastError="
            ,   GetLastError()
            ,   ", ErrorDescription='"
            ,   ErrorDescription(GetLastError())
            ,   "')"
            );
    }
    
    // Detect buy signal
    if(fastMA1 < slowMA1 && fastMA0 > slowMA0)
    {
        if(SelectOrderByMagicNumber(MAGIC_NUMBER))
        {
            const int orderType = OrderType();
            
            if(orderType == OP_BUY)
            {
                // We have already open long position. Skip this buy signal.
                return;
            }
            
            if(orderType == OP_SELL)
            {
                // We have opened short positoin. Close it first.
                bool closed = OrderClose(
                    OrderTicket()
                ,   OrderLots()
                ,   Ask
                ,   0
                );
                
                if(!closed)
                    Alert(
                        "ERROR: OnTick(): OrderClose() failed (LastError="
                    ,   GetLastError()
                    ,   ", ErrorDescription='"
                    ,   ErrorDescription(GetLastError())
                    ,   "')"
                    );                
            }
        }
        
        // Ok. If we get here, we have no open positions.
        
        // Open short position.
        bool sent = OrderSend(
            NULL
        ,   OP_BUY
        ,   0.01
        ,   Ask
        ,   0
        ,   0
        ,   0
        ,   NULL
        ,   MAGIC_NUMBER
        );
        
        if(!sent)
            Alert(
                "ERROR: OnTick(): OrderSend() failed (LastError="
            ,   GetLastError()
            ,   ", ErrorDescription='"
            ,   ErrorDescription(GetLastError())
            ,   "')"
            );
    }
}
//+------------------------------------------------------------------+
