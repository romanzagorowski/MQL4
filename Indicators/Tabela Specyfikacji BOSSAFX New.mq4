//+------------------------------------------------------------------+
//|                                  Tabela Specyfikacji BOSSAFX.mq4 |
//|                                                          BOSSAFX |
//|                                            http://www.bossafx.pl |
//+------------------------------------------------------------------+
#property copyright "BOSSAFX"
#property link      "http://www.bossafx.pl"

#property indicator_separate_window


// 04.07.2012    zmieniono JPYPLN.   i FBNAKNS

//          26.06.2012   dodano nowe instrumenty 84

//--------- 18.05.2011    -------------------
//                        dodane   nowe instrumenty (61 + 10 )

// ------  14.10.2010



#define wymiar  84
#define dim_opo 91

extern double  Nominal_w_lotach=1;
extern bool    Tabela_1=true;
extern bool    Tabela_2=false;
extern bool    Sortuj_Tabele=false;
extern bool    Zapisac_do_pliku=false;
extern color   Kolor=Green;

bool    do_5=true;

int dim_tab;

string instrumenty[wymiar]={"BOSSAPLN.",
                       "BOSSAUSD.",
                       "BOSSAEUR.",
                       "BOSSACZK.",
                       "USDPLN.",
                       "EURPLN.",
                       "GBPPLN.",
                       "CHFPLN.",
                       "JPYPLN..",
                       "EURUSD.",
                       "GBPUSD.",
                       "USDJPY.",
                       "USDCHF.",
                       "EURGBP.",
                       "EURJPY.",
                       "EURCHF.",                                            
                       "USDCAD.",                                              
                       "GBPJPY.",
                       "AUDUSD.",                       
                       "AUDJPY.",
                       "AUDNZD.",
                       "AUDCAD.",
                       "AUDCHF.",                       
                       "NZDUSD.",                                             
                       "EURCAD.",
                       "EURAUD.",
                       "EURNZD.",
                       "EURNOK.",
                       "EURSEK.",
                       "EURCZK.",
                       "USDCZK.",
                       "GBPCZK.",
                       "EURHUF.",                      
                       "USDHKD.",
                       "USDNOK.",
                       "USDSEK.",
                       
                       "USDHUF.",                       
                       "GBPCHF.",
                       "GBPNZD.",
                       "GBPAUD.",
                       "CADJPY.",
                       "CADCHF.",
                       "CHFJPY.",
                       
                       "NZDJPY.",
                       "GBPCAD.",
                       "USDZAR.",
                       "USDMXN.",
                       "USDTRY.",
                       "EURTRY.",
                       
                       "USDRON.",
                       "EURRON.",
                       "USDDKK.",
                       "EURDKK.",
                       "USDRUB.",
                       "EURRUB.",
                           
                                          
                       "FUS30.",
                       "FUS100.",
                       "FUS500.",                       
                       "FDE30.",
                       "FGB100.",
                       "FEU50.",
                       "FFR40.",
                       "FCH20.",
                       "FHK45.",
                       "FCN40.",                       
                       "FOIL.",                       
                       "FCOPPER.",
                       "FGOLD.",
                       "FCORN.",
                       "FWHEAT.",
                       "FSOYBEAN.",
                       
                       "FSCHATZ2.",
                       "FNL25.",
                       "FNATGAS.",
                       "FRICE.",
                                                                 
                       "SILVER.",
                       "PLATINUM.",
                       "PALLADIUM.",                    
                       "FTNOTE10.",
                       "FBUND10.",
                       
                       "FOAT10.",
                       "FBTP10.",
                       "FEUBANKS.",
                       "FJP225.",
                       "FPL20." 
                       
                       };
                           
                          
                          
                          
string instrumenty_2[25]={"BOSSAUSD.",
                           "BOSSAEUR.",
                           "BOSSAPLN.",
                           "USDHKD.",
                           "USDNOK.",
                           "USDSEK.",
                           "USDCZK.",
                           "USDHUF.",
                           "EURNOK.",
                           "EURSEK.",
                           "EURCZK.",
                           "EURHUF.",
                           "FCORN.",
                           "FWHEAT.",
                           "FSOYBEAN.",
                           "FTNOTE10.",
                           "FBUND10.",
                           "FUS100.",
                           "FGB100.",
                           "FFR40.",
                           "FHK45.",
                           "FCN40.",
                           "PLATINUM.",
                           "PALLADIUM.",
                           "FGOLD"};
                          
                          
                          
                          

string instrumenty_1[37]={"USDPLN.","EURPLN.","GBPPLN.","CHFPLN.","EURUSD.","GBPUSD.","USDJPY.","USDCHF.","EURJPY.","GBPJPY.",
                           "EURGBP.","USDCAD.","NZDUSD.","AUDUSD.","EURCHF.","AUDNZD.","AUDCAD.","AUDCHF.","AUDJPY.","CHFJPY.",
                           "EURAUD.","EURNZD.","EURCAD.","GBPCHF.","CADCHF.","GBPAUD.","CADJPY.","FGOLD.","SILVER.","GBPNZD.","FOIL.",
                           "FUS30.","FUS500.","FCOPPER.","FEU50.","FDE30.","FCH20."};





string t_ticker[10]={"EURUSD.","GBPUSD.","USDJPY.","USDCHF.","EURGBP.","EURJPY.","GBPJPY.","USDCAD.","EURCHF.","AUDUSD."};
string t_ticker2[1]={"SILVER."};

// bool znaleziono;
int  dim_ticker;







double   tablica[][6];
int      alarmy[];


int linie_pionowe_X[13]={75,130,208,300,395,460,500,570,620,695,788,890,970};            // linie
int shiftX[7]=          {5,85,145,220,310,400,900};                                      // tekst

int linie_pionowe_Y[3]={20,210,400};

int linie_poziome[24];
int linie_poziome_X[4]={0,265,525,700};

// int shiftX[7];
int shiftY[38];
int t_historia[];

bool cala_tablica=false;
bool wczytywanie_historii=false;
bool historia_zaladowana=false;
bool tabela_narysowana=false;

int iter_od;
int iter_do;

bool small_tab=true;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   
   dim_ticker=ArrayRange(t_ticker,0);
   dim_tab=ArrayRange(instrumenty,0);

//   Alert("dim_tab: ",dim_tab,"  dim_ticker: ",dim_ticker);

/*   
   if ( Pierwsza_Tabela==true )
   {
      dim_tab=ArrayRange(instrumenty_1,0);
      ArrayResize(instrumenty,dim_tab);
 //     ArrayResize(tabela_spready,dim_tab);
      
 //     Alert("ins: ",ArrayRange(instrumenty,0),"  ins_1: ",ArrayRange(instrumenty_1,0));

      
      for ( int i=0;i<dim_tab;i++)
      {
         instrumenty[i]=instrumenty_1[i];    
     
      }       
      
   }
   else
   {
      dim_tab=ArrayRange(instrumenty_2,0);
      ArrayResize(instrumenty,dim_tab);
  //     Alert("ins: ",ArrayRange(instrumenty,0),"  ins_2: ",ArrayRange(instrumenty_2,0));
      
      for ( i=0;i<dim_tab;i++)
      {
         instrumenty[i]=instrumenty_2[i];    
         
      }       
    
   }

*/
   if ( (Tabela_1 ==true && Tabela_2==true) || (Tabela_1 ==false && Tabela_2==false) )
   {
     iter_od=0;
     iter_do=42;   
     small_tab=true;
   }
   else
   {
      if ( Tabela_1==true && Tabela_2==false )
      {
        iter_od=0;
        iter_do=42;   
        small_tab=true;        
      }
      
      if ( Tabela_1==false && Tabela_2==true )
      {
        iter_od=43;
        iter_do=84;           
        small_tab=true;
      }   
   
   }
   
//   Alert("iter_od:  ",iter_od,"  iter_do: ",iter_do);
   
   for(int i=0;i<ArrayRange(instrumenty,0);i++)
   {   
      ObjectDelete("dp"+instrumenty[i]);
      ObjectDelete("dpSPREAD "+instrumenty[i]);
      ObjectDelete("dpH-L "+instrumenty[i]);
      ObjectDelete("dpSTD "+instrumenty[i]);
      ObjectDelete("dpDepo "+instrumenty[i]);
      ObjectDelete("dpWSP "+instrumenty[i]);
   }
 
   

   
   ArrayResize(tablica,dim_tab);
   ArrayResize(alarmy,dim_tab);
   ArrayResize(t_historia,dim_tab);










//---- indicators
   int przesuniecie_X=70;
   int przesuniecie_Y=25;
   
/*   
   for (int i=2;i<7;i++)
   {
      shiftX[0]=20;
      shiftX[1]=120;
      shiftX[i]=shiftX[i-1]+przesuniecie_X;
   }
*/   
    
    for ( i=0;i<dim_tab;i++)
    {  
        tablica[i][0]=0;
        alarmy[i]=0;         
    }
   
    shiftY[0]=70;
  //   tablica[0][0]=0;
     
   for ( i=1;i<37;i++)
   {     
      shiftY[i]=shiftY[i-1]+przesuniecie_Y;          
   }
      shiftY[37]=shiftY[36]+przesuniecie_Y;
   
   for (i=3;i<ArrayRange(linie_poziome,0);i++)
   {
      linie_poziome[0]=15;
      linie_poziome[1]=55;
      linie_poziome[2]=80;
      linie_poziome[i]=linie_poziome[i-1]+przesuniecie_Y;
   }     
    
    
  


//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
//----
   int mnoznik=1;
   
   string pln=AccountCurrency();
   double lot=NormalizeDouble(Nominal_w_lotach,1);
   double dzwignia=AccountLeverage();
   string sdzwignia=DoubleToStr(dzwignia,0);
   
   if ( lot <= 0 )
   {
         lot=1.0;
   }
   
   int historia,handle;
   int zm,wsp;   
   int druga_kolumna_X=0;
   int druga_kolumna_Y=0;
   int pierwsza_linia=495;
   int okres=Period();
   string okres_alarm;
      
      
      
   
//   string short_name="BOSSAFX ++  Wartości dla nominału:  "+DoubleToStr(lot,1)+" ( w lotach)";
   string short_name="BOSSAFX ++";
   IndicatorShortName(short_name);
   int windex=WindowFind(short_name);
   
   ObjectCreate("dpLot", OBJ_LABEL, WindowFind(short_name), 0, 0);
   ObjectSet("dpLot", OBJPROP_CORNER, 0);       
   ObjectSet("dpLot", OBJPROP_XDISTANCE,80);
   ObjectSet("dpLot", OBJPROP_YDISTANCE, 3);
   
   ObjectSetText("dpLot","Wartości dla nominału:  "+DoubleToStr(lot,1)+"  ( w lotach)",7,"Verdana",Kolor);
   
   ObjectCreate("dpDzwignia", OBJ_LABEL, WindowFind(short_name), 0, 0);
   ObjectSet("dpDzwignia", OBJPROP_CORNER, 0);       
   ObjectSet("dpDzwignia", OBJPROP_XDISTANCE,300);
   ObjectSet("dpDzwignia", OBJPROP_YDISTANCE, 3);
   
   ObjectSetText("dpDzwignia","Dźwignia    1:"+sdzwignia,7,"Verdana",Kolor);
      
    
    
    string file_name;
    
    file_name="TabelaSpecyfikacjiBOSSAFX.csv";
       
//   datetime dzisiaj=TimeMonth(TimeCurrent());
//   string czas=TimeToStr(dzisiaj);
   
//--------------------------------- rysowanie tabeli ------------------------------------------
   
   if (tabela_narysowana==false)
   {
      for (int j=0;j<4;j++)
      {
         for (int i=0;i<23;i++)                   // -------------- linie poziome  
         {  
         ObjectCreate("dpL"+i+j, OBJ_LABEL, windex,0, 0);
         ObjectSetText("dpL"+i+j,"-----------------------------------------------------",7, "Verdana", Kolor);
         ObjectSet("dpL"+i+j, OBJPROP_CORNER, 0);
         ObjectSet("dpL"+i+j,OBJPROP_ANGLE,0);
         ObjectSet("dpL"+i+j, OBJPROP_XDISTANCE, linie_poziome_X[j]);
         ObjectSet("dpL"+i+j, OBJPROP_YDISTANCE,linie_poziome[i]);    
         } 
      }
   
      for(j=0;j<3;j++)                               // ------------ linie pionowe
      {
       for (i=0;i<13;i++)
       {  
         ObjectCreate("dpS"+i+j, OBJ_LABEL, windex,0, 0);
         ObjectSetText("dpS"+i+j,"-----------------------------------------------",7, "Verdana", Kolor);
         ObjectSet("dpS"+i+j, OBJPROP_CORNER, 0);
         ObjectSet("dpS"+i+j,OBJPROP_ANGLE,-90);
         ObjectSet("dpS"+i+j, OBJPROP_XDISTANCE, linie_pionowe_X[i]);
         ObjectSet("dpS"+i+j, OBJPROP_YDISTANCE,linie_pionowe_Y[j]);    
       }
      }
           
      tabela_narysowana=true;
   }

//--------------------------------- pierwsza linia -----------------------------------------------
   
  
      
    ObjectCreate("dpInstrument", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpInstrument","Instrument",7, "Verdana", Kolor);
    ObjectSet("dpInstrument", OBJPROP_CORNER, 0);
    ObjectSet("dpInstrument", OBJPROP_XDISTANCE, shiftX[0]-5);
    ObjectSet("dpInstrument", OBJPROP_YDISTANCE,shiftY[0]-35);
   
    ObjectCreate("dpSpread", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpSpread","SPREAD",7, "Verdana", Kolor);
    ObjectSet("dpSpread", OBJPROP_CORNER, 0);
    ObjectSet("dpSpread", OBJPROP_XDISTANCE, shiftX[1]-15);
    ObjectSet("dpSpread", OBJPROP_YDISTANCE,shiftY[0]-35);
    
    ObjectCreate("dpWartosc", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWartosc","WARTOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpWartosc", OBJPROP_CORNER, 0);
    ObjectSet("dpWartosc", OBJPROP_XDISTANCE, shiftX[2]-10);
    ObjectSet("dpWartosc", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpPips", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpPips","PIPSA ("+pln+" )",7, "Verdana", Kolor);
    ObjectSet("dpPips", OBJPROP_CORNER, 0);
    ObjectSet("dpPips", OBJPROP_XDISTANCE, shiftX[2]-18);
    ObjectSet("dpPips", OBJPROP_YDISTANCE,shiftY[0]-25);
      
    ObjectCreate("dpWarSpread", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarSpread","WARTOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpWarSpread", OBJPROP_CORNER, 0);
    ObjectSet("dpWarSpread", OBJPROP_XDISTANCE, shiftX[3]-5);
    ObjectSet("dpWarSpread", OBJPROP_YDISTANCE,shiftY[0]-45);
   
    ObjectCreate("dpWarSpread2", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarSpread2","SPREADU ("+pln+")",7, "Verdana", Kolor);
    ObjectSet("dpWarSpread2", OBJPROP_CORNER, 0);
    ObjectSet("dpWarSpread2", OBJPROP_XDISTANCE, shiftX[3]-15);
    ObjectSet("dpWarSpread2", OBJPROP_YDISTANCE,shiftY[0]-25);
   
   
    ObjectCreate("dpWDepo", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWDepo","WIELKOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpWDepo", OBJPROP_CORNER, 0);
    ObjectSet("dpWDepo", OBJPROP_XDISTANCE, shiftX[4]);
    ObjectSet("dpWDepo", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpDepo", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpDepo","DEPOZYTU ("+pln+")",7, "Verdana", Kolor);
    ObjectSet("dpDepo", OBJPROP_CORNER, 0);
    ObjectSet("dpDepo", OBJPROP_XDISTANCE, shiftX[4]-15);
    ObjectSet("dpDepo", OBJPROP_YDISTANCE,shiftY[0]-25);
      
    ObjectCreate("dpWSP", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWSP","SPREAD /",7, "Verdana", Kolor);
    ObjectSet("dpWSP", OBJPROP_CORNER, 0);
    ObjectSet("dpWSP", OBJPROP_XDISTANCE, shiftX[5]-5);
    ObjectSet("dpWSP", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpWSP2", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWSP2","DEPOZYT",7, "Verdana", Kolor);
    ObjectSet("dpWSP2", OBJPROP_CORNER, 0);
    ObjectSet("dpWSP2", OBJPROP_XDISTANCE, shiftX[5]-5);
    ObjectSet("dpWSP2", OBJPROP_YDISTANCE,shiftY[0]-25);
    
    
    
    
    ObjectCreate("dpInstrument_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpInstrument_","Instrument",7, "Verdana", Kolor);
    ObjectSet("dpInstrument_", OBJPROP_CORNER, 0);
    ObjectSet("dpInstrument_", OBJPROP_XDISTANCE, shiftX[0]+pierwsza_linia);
    ObjectSet("dpInstrument_", OBJPROP_YDISTANCE,shiftY[0]-30);
   
    ObjectCreate("dpSpread_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpSpread_","SPREAD",7, "Verdana", Kolor);
    ObjectSet("dpSpread_", OBJPROP_CORNER, 0);
    ObjectSet("dpSpread_", OBJPROP_XDISTANCE, shiftX[1]+pierwsza_linia-15);
    ObjectSet("dpSpread_", OBJPROP_YDISTANCE,shiftY[0]-30);
    
    ObjectCreate("dpWarpipsa_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarpipsa_","WARTOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpWarpipsa_", OBJPROP_CORNER, 0);
    ObjectSet("dpWarpipsa_", OBJPROP_XDISTANCE, shiftX[2]-15+pierwsza_linia);
    ObjectSet("dpWarpipsa_", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpWarpipsa2_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarpipsa2_","PIPSA ("+pln+")",7, "Verdana", Kolor);
    ObjectSet("dpWarpipsa2_", OBJPROP_CORNER, 0);
    ObjectSet("dpWarpipsa2_", OBJPROP_XDISTANCE, shiftX[2]-20+pierwsza_linia);
    ObjectSet("dpWarpipsa2_", OBJPROP_YDISTANCE,shiftY[0]-25);
    
    ObjectCreate("dpWarSpread_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarSpread_","WARTOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpWarSpread_", OBJPROP_CORNER, 0);
    ObjectSet("dpWarSpread_", OBJPROP_XDISTANCE, shiftX[3]-10+pierwsza_linia);
    ObjectSet("dpWarSpread_", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpWarSpread2_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWarSpread2_","SPREADU ("+pln+")",7, "Verdana", Kolor);
    ObjectSet("dpWarSpread2_", OBJPROP_CORNER, 0);
    ObjectSet("dpWarSpread2_", OBJPROP_XDISTANCE, shiftX[3]-20+pierwsza_linia);
    ObjectSet("dpWarSpread2_", OBJPROP_YDISTANCE,shiftY[0]-25);
    
   
    ObjectCreate("dpDEPO_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpDEPO_","WIELKOŚĆ",7, "Verdana", Kolor);
    ObjectSet("dpDEPO_", OBJPROP_CORNER, 0);
    ObjectSet("dpDEPO_", OBJPROP_XDISTANCE, shiftX[4]+pierwsza_linia-5);
    ObjectSet("dpDEPO_", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpDEPO2_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpDEPO2_","DEPOZYTU ("+pln+")",7, "Verdana", Kolor);
    ObjectSet("dpDEPO2_", OBJPROP_CORNER, 0);
    ObjectSet("dpDEPO2_", OBJPROP_XDISTANCE, shiftX[4]+pierwsza_linia-20);
    ObjectSet("dpDEPO2_", OBJPROP_YDISTANCE,shiftY[0]-25);
    
    ObjectCreate("dpWSP_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWSP_","SPREAD /",7, "Verdana", Kolor);
    ObjectSet("dpWSP_", OBJPROP_CORNER, 0);
    ObjectSet("dpWSP_", OBJPROP_XDISTANCE, shiftX[6]-5);
    ObjectSet("dpWSP_", OBJPROP_YDISTANCE,shiftY[0]-45);
    
    ObjectCreate("dpWSP2_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("dpWSP2_","DEPOZYT",7, "Verdana", Kolor);
    ObjectSet("dpWSP2_", OBJPROP_CORNER, 0);
    ObjectSet("dpWSP2_", OBJPROP_XDISTANCE, shiftX[6]-5);
    ObjectSet("dpWSP2_", OBJPROP_YDISTANCE,shiftY[0]-25);
    
   
  
   
   for (i=0;i<dim_tab;i++)
   {
      tablica[i][4]=lot*MarketInfo(instrumenty[i],MODE_MARGINREQUIRED);
      tablica[i][1]=MarketInfo(instrumenty[i],MODE_SPREAD);
      tablica[i][2]=lot*MarketInfo(instrumenty[i],MODE_TICKVALUE);      
      tablica[i][3]=(tablica[i][1]*tablica[i][2]);
      
         if (tablica[i][4]==0 )
         {
          tablica[i][0]=0; 
         }
         else
         {
         tablica[i][0]=NormalizeDouble(((tablica[i][3]/tablica[i][4])*100),3);
         }
     
      tablica[i][5]=i;   
 //     tablica[37][5]=37;
      
   }


   
   if (Sortuj_Tabele==True)
   {   
   ArraySort(tablica,WHOLE_ARRAY,0,MODE_ASCEND);
   }
    
 
   if ( small_tab ==true )                   // ----------------- rysuje mala tablice
   { 
            for (i=iter_od;i<iter_do;i++)
            {
                     if ( iter_od ==0 ) 
                     {
                        if (i>=21) { druga_kolumna_X=495; druga_kolumna_Y=21; wsp=1; }
                     }
                     else
                     {
                        if (i >= 63 )  { druga_kolumna_X=495; druga_kolumna_Y=63; wsp=1; }                 
                        
                        else         { druga_kolumna_X=0; druga_kolumna_Y=43; wsp=0; } 
                   
                     }
      
               mnoznik=1;
      
      
      
      
               for( j=0;j<dim_tab;j++)
               {
                 if (tablica[i][5]==j)
                 {       
                     ObjectCreate("dp"+instrumenty[j], OBJ_LABEL, windex,0, 0);
                     ObjectSetText("dp"+instrumenty[j],instrumenty[j],7, "Verdana", Kolor);
                     ObjectSet("dp"+instrumenty[j], OBJPROP_CORNER, 0);
                     ObjectSet("dp"+instrumenty[j], OBJPROP_XDISTANCE, shiftX[0]+druga_kolumna_X);
                     ObjectSet("dp"+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
            
      
         
                              for (int k=0;k<dim_ticker;k++)
                               { 
                                     if (instrumenty[j]==t_ticker[k] )
                                     {
                                         if ( do_5==true) { mnoznik=10; }
                                         break;          
      
                                     }
                                     else if (instrumenty[j]==t_ticker2[k] )
                                     {
                                         if ( do_5==true) { mnoznik=100; }
                                         break;          
      
                                     }
                                     else
                                     {
                                        mnoznik=1;
                                     }  
                               }   
      
                       break;   
         
                 }       
               }
      
               ObjectCreate("dpSPREAD "+instrumenty[j], OBJ_LABEL, windex,0, 0);
               ObjectSetText("dpSPREAD "+instrumenty[j],DoubleToStr(tablica[i][1]/mnoznik,1),7, "Verdana", Kolor);
               ObjectSet("dpSPREAD "+instrumenty[j], OBJPROP_CORNER, 0);
               ObjectSet("dpSPREAD "+instrumenty[j], OBJPROP_XDISTANCE, shiftX[1]+(druga_kolumna_X));
               ObjectSet("dpSPREAD "+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
      
               ObjectCreate("dpH-L "+instrumenty[j], OBJ_LABEL, windex,0, 0);
               ObjectSetText("dpH-L "+instrumenty[j],DoubleToStr(tablica[i][2]*mnoznik,2),7, "Verdana", Kolor);
               ObjectSet("dpH-L "+instrumenty[j], OBJPROP_CORNER, 0);
               ObjectSet("dpH-L "+instrumenty[j], OBJPROP_XDISTANCE, shiftX[2]+druga_kolumna_X);
               ObjectSet("dpH-L "+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
      
               ObjectCreate("dpSTD "+instrumenty[j], OBJ_LABEL, windex,0, 0);
               ObjectSetText("dpSTD "+instrumenty[j],DoubleToStr(tablica[i][3],2),7, "Verdana", Kolor);
               ObjectSet("dpSTD "+instrumenty[j], OBJPROP_CORNER, 0);
               ObjectSet("dpSTD "+instrumenty[j], OBJPROP_XDISTANCE, shiftX[3]+druga_kolumna_X);
               ObjectSet("dpSTD "+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
      
               ObjectCreate("dpDepo "+instrumenty[j], OBJ_LABEL, windex,0, 0);
               ObjectSetText("dpDepo "+instrumenty[j],DoubleToStr(tablica[i][4],2),7, "Verdana", Kolor);
               ObjectSet("dpDepo "+instrumenty[j], OBJPROP_CORNER, 0);
               ObjectSet("dpDepo "+instrumenty[j], OBJPROP_XDISTANCE, shiftX[4]+druga_kolumna_X);
               ObjectSet("dpDepo "+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
      
      
               ObjectCreate("dpWSP "+instrumenty[j], OBJ_LABEL, windex,0, 0);
               ObjectSetText("dpWSP "+instrumenty[j],DoubleToStr(tablica[i][0],2)+" %",7, "Verdana", Kolor);
               ObjectSet("dpWSP "+instrumenty[j], OBJPROP_CORNER, 0);
               ObjectSet("dpWSP "+instrumenty[j], OBJPROP_XDISTANCE, shiftX[5+wsp]);
               ObjectSet("dpWSP "+instrumenty[j], OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
     

             }
     } 
     else       ////////////// ------------------------ duza tablica  -- nie ma bo jest za duza ;) 
     {
     
     
     
     
     }
       

//-------------- nowe cala tablica itp -------------------------------------------------------

     if (Zapisac_do_pliku==true)
     {     
     

     handle=FileOpen(file_name,FILE_CSV|FILE_WRITE,";");
     
      if (handle== -1)
      {
       Alert("Wystąpił błąd podczas zapisu pliku. Spróbuj ponownie!");
       return;
      }

         FileWrite(handle,"LP","Instrument","Spread","Wartość pipsa","Wielkość spreadu","Wielkość depozytu","Spread/Depozyt (%)");
         for (i=0;i<dim_tab;i++)
         {
            for (j=0;j<dim_tab;j++)
            {
               if ( tablica[i][5]==j)  
               {                                                 
                   mnoznik=1;
      
                     for (k=0;k<dim_ticker;k++)
                     { 
                                 if (instrumenty[j]==t_ticker[k] )
                                 {
                                     if ( do_5==true) { mnoznik=10; }
                                     break;          
      
                                 }
                                 else if (instrumenty[j]==t_ticker2[k] )
                                 {
                                     if ( do_5==true) { mnoznik=100; }
                                     break;          
      
                                 }
                                 else
                                 {
                                    mnoznik=1;
                                 }  
                     }   
                  
                        FileWrite(handle,i+1,instrumenty[j],NormalizeDouble(tablica[i][1]/mnoznik,1),NormalizeDouble(tablica[i][2]*mnoznik,2),NormalizeDouble(tablica[i][3],2),NormalizeDouble(tablica[i][4],2),NormalizeDouble(tablica[i][0],2));
                        FileFlush(handle);     
               }
            }
         }
   

       FileClose(handle); 
       Alert("Plik  \"",file_name,"\"  został zapisany w folderze ",TerminalPath(),"\experts\files");          
      Zapisac_do_pliku=false;     
     
   }




//----
   return(0);
  }
//+------------------------------------------------------------------+


