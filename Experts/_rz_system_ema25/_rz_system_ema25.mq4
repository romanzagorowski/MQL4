//+------------------------------------------------------------------+
//|                                             _rz_system_ema25.mq4 |
//|                                     roman.zagorowski@hotmail.com |
//|                                                                  |
//+------------------------------------------------------------------+
#property strict
//--- includes
#include "IsNewBar.mqh"
#include "WithCheck.mqh"
#include <stdlib.mqh>
//--- constants
const int ___magicNumber = 20230618;
//--- input parameters
input int      EMAPeriod=25;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    IsNewBar(); // to initialize internal static variable
    
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//---

}
//+------------------------------------------------------------------+
bool SelectOrder(const int orderMagicNumber, const int orderType)
{
    for(int i = 0; i < OrdersTotal(); ++i)
    {
        if(OrderSelect(i, SELECT_BY_POS))
        {
            if(OrderMagicNumber() == orderMagicNumber && OrderType() == orderType)
            {
                return true;
            }
        }
    }

    return false;
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
//---
    if(IsNewBar())
    {
        //  TODO: if there is an open long position and an active sell stop order then cancel the sell stop order.
        if(SelectOrder(___magicNumber, OP_BUY))
        {
            Print("INFO: A long position found: ticket=", OrderTicket(), ". Canceling any SELLSTOP order...");
            
            int canceledOrdersCount = 0;
            
            while(SelectOrder(___magicNumber, OP_SELLSTOP))
            {
                const int ticket = OrderTicket();

                if(OrderDelete(ticket))
                {
                    Print("INFO: BUYSTOP order canceled. ticket=", ticket);
                }
                
                ++canceledOrdersCount;
            }
            
            Print("INFO: ", canceledOrdersCount, " SELLSTOP order(s) canceled.");
        }
        else
        {
            Print("INFO: No long positions found.");
        }
        
        //  TODO: if there is an open short position and an active buy stop order then cancel the buy stop order.
        if(SelectOrder(___magicNumber, OP_SELL))
        {
            Print("INFO: A short position found: ticket=", OrderTicket(), ". Canceling any BUYSTOP order...");
            
            int canceledOrdersCount = 0;
            
            while(SelectOrder(___magicNumber, OP_BUYSTOP))
            {
                const int ticket = OrderTicket();

                if(OrderDelete(ticket))
                {
                    Print("INFO: BUYSTOP order canceled. ticket=", ticket);
                }
                
                ++canceledOrdersCount;
            }
            
            Print("INFO: ", canceledOrdersCount, " BUYSTOP order(s) canceled.");
        }
        else
        {
            Print("INFO: No short positions found.");
        }
        
        double ema1 = iMA(NULL, 0, EMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 1);
        double ema2 = iMA(NULL, 0, EMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 2);
        
        if(Close[2] < ema2 && Close[1] > ema1)
        {
            // long setup
            
            // close short position if any
            // create buy stop order
        }
        
        if(Close[2] > ema2 && Close[1] < ema1)
        {
            // short setup
        }
    }
}
//+------------------------------------------------------------------+
