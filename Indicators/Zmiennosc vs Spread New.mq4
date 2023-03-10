//+------------------------------------------------------------------+
//|                                         Zmiennosc vs Spread .mq4 |
//|                                                          BOSSAFX |
//|                                            http://www.bossafx.pl |
//+------------------------------------------------------------------+
#property copyright "BOSSAFX"
#property link      "http://www.bossafx.pl"

#property indicator_separate_window


#define wymiar  101
#define dim_opo 91

// 04.07.2012    zmieniono JPYPLN.   i FBNAKNS

// ---        26.06.2012    dodano nowe instrumenty 

// --------------- 18.05.2011 -------------------------------
//                            dodano nowe insturmenty (61 + 10 )


// --------------- 14.10.2010 -------------------------------

extern int     Zmiennosc=30;
extern bool    Tabela_1=True;
extern bool    Tabela_2=false;
extern bool    Sortuj_Tabele=false;
extern bool    Zapisac_do_pliku=false;
extern color   Kolor=Green;
extern bool    Uwzglednij_HL=true;
extern bool    Uwzglednij_StdDev=false;

bool    do_5=true;

int wymiar_tab;

string instrumenty[wymiar]=
  {
   "BOSSAPLN.",
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
   "FPL20.",
   //nowe INSTRIMENTY
   "FUSD.",
   "FCOCOA.",
   "FCOTTON.",
   "FSUGAR.",
   "FBRENT.",
   "FGASOIL",
   "FEMISS.",
   "FEU600.",
   "FMSCIEM.",
   "FEUVOL.",
   "FGILT10.",
   "FBOBL5.",
   "COFFEE.",
   "FORANGE.",
   "USDCNH.",
   "USDTHB.",
   "USDBRL."


  };

/*
 string instrumenty_1[37]={"USDPLN","EURPLN","GBPPLN","CHFPLN","EURUSD","GBPUSD","USDJPY","USDCHF","EURJPY","GBPJPY",
                           "EURGBP","USDCAD","NZDUSD","AUDUSD","EURCHF","AUDNZD","AUDCAD","AUDCHF","AUDJPY","CHFJPY",
                           "EURAUD","EURNZD","EURCAD","GBPCHF","CADCHF","GBPAUD","CADJPY","GOLD","SILVER","GBPNZD","FOIL",
                           "FUS30","FUS500","FCOPPER","FEU50","FDE30","FCH20"};


string instrumenty_2[25]={"BOSSAUSD",
                           "BOSSAEUR",
                           "BOSSAPLN",
                           "USDHKD",
                           "USDNOK",
                           "USDSEK",
                           "USDCZK",
                           "USDHUF",
                           "EURNOK",
                           "EURSEK",
                           "EURCZK",
                           "EURHUF",
                           "FCORN",
                           "FWHEAT",
                           "FSOYBEAN",
                           "FTNOTE10",
                           "FBUND10",
                           "FUS100",
                           "FGB100",
                           "FFR40",
                           "FHK45",
                           "FCN40",
                           "PLATINUM",
                           "PALLADIUM",
                           "FGOLD"};

*/

string instrumenty_rob[];


string t_ticker[10]={"EURUSD.","GBPUSD.","USDJPY.","USDCHF.","EURGBP.","EURJPY.","GBPJPY.","USDCAD.","EURCHF.","AUDUSD."};
string t_ticker2[1]={"SILVER."};
int  dim_ticker;

double   tablica[][5];
int      alarmy[];

int linie_pionowe_X[11]={110,172,241,325,399,466,570,630,700,785,855};
int linie_pionowe_Y[3]={35,220,400};

int linie_poziome[24];
int linie_poziome_X[3]={0,280,565};

int shiftX[6];
int shiftY[38];
int t_historia[];

bool cala_tablica=false;
bool wczytywanie_historii=false;
bool historia_zaladowana=false;
bool tabela_narysowana=false;

int iter_od;
int iter_do;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   int przesuniecie_X=70;
   int przesuniecie_Y=25;

   dim_ticker=ArrayRange(t_ticker,0);
   wymiar_tab=ArrayRange(instrumenty,0);

/*   
   
   if ( Pierwsza_Tabela==true )
   {
      wymiar_tab=ArrayRange(instrumenty_1,0);
      
      for ( int i=0;i<wymiar_tab;i++)
      {
         instrumenty[i]=instrumenty_1[i];    
      }       
   }
   else
   {
     wymiar_tab=ArrayRange(instrumenty_2,0);
      
      for ( i=0;i<wymiar_tab;i++)
      {
         instrumenty[i]=instrumenty_2[i];    
      }       
   
   }
*/

   ArrayResize(tablica,wymiar_tab);
   ArrayResize(alarmy,wymiar_tab);
   ArrayResize(t_historia,wymiar_tab);

   for(int i=0;i<ArrayRange(instrumenty,0);i++)
     {

      ObjectDelete("zm"+instrumenty[i]);
      ObjectDelete("zmSPREAD "+instrumenty[i]);
      ObjectDelete("zmH-L "+instrumenty[i]);
      ObjectDelete("zmSTD "+instrumenty[i]);
      ObjectDelete("zmWSP "+instrumenty[i]);
     }

//  Alert("zatrzymuje sie " ); 

//   Sleep(1000);

//    Alert("jade sie " ); 

   if((Tabela_1==true && Tabela_2==true) || (Tabela_1==false && Tabela_2==false))
     {
      iter_od=0;
      iter_do=42;
      //     small_tab=true;
     }
   else
     {
      if(Tabela_1==true && Tabela_2==false)
        {
         iter_od=0;
         iter_do=42;
         //       small_tab=true;        
        }

      if(Tabela_1==false && Tabela_2==true)
        {
         iter_od=43;
         iter_do=84;
         //      small_tab=true;
        }

     }



   for(i=2;i<6;i++)
     {
      shiftX[0]=20;
      shiftX[1]=120;
      shiftX[i]=shiftX[i-1]+przesuniecie_X;
     }

   for(i=1;i<38;i++)
     {
      shiftY[0]=70;
      shiftY[i]=shiftY[i-1]+przesuniecie_Y;
      //      tablica[0][0]=0;
      //      tablica[i][0]=0;
      //      alarmy[i]=0;          
     }

   for(i=3;i<ArrayRange(linie_poziome,0);i++)
     {
      linie_poziome[0]=30;
      linie_poziome[1]=52;
      linie_poziome[2]=80;
      linie_poziome[i]=linie_poziome[i-1]+przesuniecie_Y;
     }

   for(i=0;i<38;i++)
     {
      tablica[i][1]=0.0;
      tablica[i][2]=0.0;
      tablica[i][3]=0.0;
      t_historia[i]=0;
      tablica[i][0]=0.0;
      alarmy[i]=0;
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

   int historia,handle;
   int zm;
   int druga_kolumna_X=0;
   int druga_kolumna_Y=0;
   int pierwsza_linia=460;
   int okres=Period();
   string okres_alarm;
   int wymiar_rob=0;

   if(okres==1)      { okres_alarm = "M1"; }
   if(okres==5)      { okres_alarm = "M5"; }
   if(okres==15)     { okres_alarm = "M15"; }
   if(okres==30)     { okres_alarm = "M30"; }
   if(okres==60)     { okres_alarm = "H1"; }
   if(okres==240)    { okres_alarm = "H4"; }
   if(okres==1440)   { okres_alarm = "D1"; }
   if(okres==10080)  {okres_alarm = "W1"; }
   if(okres==43200)  { okres_alarm = "MN"; }

   string short_name="++ BOSSAFX ++  ( ZMIENNOSC - "+Zmiennosc+", INTERWAŁ -"+okres_alarm+" )";
   IndicatorShortName(short_name);
   int windex=WindowFind(short_name);

   string file_name=okres_alarm+"_ZMSPREAD.csv";

   RefreshRates();

//   datetime dzisiaj=TimeMonth(TimeCurrent());
//   string czas=TimeToStr(dzisiaj);

//--------------------------------- rysowanie tabeli ------------------------------------------

   if(tabela_narysowana==false)
     {
      for(int j=0;j<3;j++)
        {
         for(int i=0;i<23;i++)
           {
            ObjectCreate("zmL"+i+j,OBJ_LABEL,windex,0,0);
            ObjectSetText("zmL"+i+j,"---------------------------------------------------------",7,"Verdana",Kolor);
            ObjectSet("zmL"+i+j,OBJPROP_CORNER,0);
            ObjectSet("zmL"+i+j,OBJPROP_ANGLE,0);
            ObjectSet("zmL"+i+j,OBJPROP_XDISTANCE,linie_poziome_X[j]);
            ObjectSet("zmL"+i+j,OBJPROP_YDISTANCE,linie_poziome[i]);
           }
        }

      for(j=0;j<3;j++)
        {
         for(i=0;i<13;i++)
           {
            ObjectCreate("zmS"+i+j,OBJ_LABEL,windex,0,0);
            ObjectSetText("zmS"+i+j,"-----------------------------------------------",7,"Verdana",Kolor);
            ObjectSet("zmS"+i+j,OBJPROP_CORNER,0);
            ObjectSet("zmS"+i+j,OBJPROP_ANGLE,-90);
            ObjectSet("zmS"+i+j,OBJPROP_XDISTANCE,linie_pionowe_X[i]);
            ObjectSet("zmS"+i+j,OBJPROP_YDISTANCE,linie_pionowe_Y[j]);
           }
        }

      tabela_narysowana=true;
     }

//--------------------------------- pierwsza linia -----------------------------------------------


   ObjectCreate("zmInstrument",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmInstrument","Instrument",7,"Verdana",Kolor);
   ObjectSet("zmInstrument",OBJPROP_CORNER,0);
   ObjectSet("zmInstrument",OBJPROP_XDISTANCE,shiftX[0]);
   ObjectSet("zmInstrument",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmSpread",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmSpread","SPREAD",7,"Verdana",Kolor);
   ObjectSet("zmSpread",OBJPROP_CORNER,0);
   ObjectSet("zmSpread",OBJPROP_XDISTANCE,shiftX[1]-10);
   ObjectSet("zmSpread",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmHL",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmHL","H-L ("+DoubleToStr(Zmiennosc,0)+")",7,"Verdana",Kolor);
   ObjectSet("zmHL",OBJPROP_CORNER,0);
   ObjectSet("zmHL",OBJPROP_XDISTANCE,shiftX[2]-10);
   ObjectSet("zmHL",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmStd",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmStd","StdDev ("+DoubleToStr(Zmiennosc,0)+")",7,"Verdana",Kolor);
   ObjectSet("zmStd",OBJPROP_CORNER,0);
   ObjectSet("zmStd",OBJPROP_XDISTANCE,shiftX[3]-20);
   ObjectSet("zmStd",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmWsp",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmWsp","WSP",7,"Verdana",Kolor);
   ObjectSet("zmWsp",OBJPROP_CORNER,0);
   ObjectSet("zmWsp",OBJPROP_XDISTANCE,shiftX[4]);
   ObjectSet("zmWsp",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmInstrument_",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmInstrument_","Instrument",7,"Verdana",Kolor);
   ObjectSet("zmInstrument_",OBJPROP_CORNER,0);
   ObjectSet("zmInstrument_",OBJPROP_XDISTANCE,shiftX[0]+pierwsza_linia);
   ObjectSet("zmInstrument_",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmSpread_",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmSpread_","SPREAD",7,"Verdana",Kolor);
   ObjectSet("zmSpread_",OBJPROP_CORNER,0);
   ObjectSet("zmSpread_",OBJPROP_XDISTANCE,shiftX[1]-10+pierwsza_linia);
   ObjectSet("zmSpread_",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmHL_",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmHL_","H-L ("+DoubleToStr(Zmiennosc,0)+")",7,"Verdana",Kolor);
   ObjectSet("zmHL_",OBJPROP_CORNER,0);
   ObjectSet("zmHL_",OBJPROP_XDISTANCE,shiftX[2]-10+pierwsza_linia);
   ObjectSet("zmHL_",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmStd_",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmStd_","StdDev ("+DoubleToStr(Zmiennosc,0)+")",7,"Verdana",Kolor);
   ObjectSet("zmStd_",OBJPROP_CORNER,0);
   ObjectSet("zmStd_",OBJPROP_XDISTANCE,shiftX[3]-20+pierwsza_linia);
   ObjectSet("zmStd_",OBJPROP_YDISTANCE,shiftY[0]-30);

   ObjectCreate("zmWsp_",OBJ_LABEL,windex,0,0);
   ObjectSetText("zmWsp_","WSP",7,"Verdana",Kolor);
   ObjectSet("zmWsp_",OBJPROP_CORNER,0);
   ObjectSet("zmWsp_",OBJPROP_XDISTANCE,shiftX[4]+pierwsza_linia);
   ObjectSet("zmWsp_",OBJPROP_YDISTANCE,shiftY[0]-30);

   if(wczytywanie_historii==false)
     {
      Alert("Wczytywanie historii... ");

      for(i=0;i<wymiar_tab;i++)
        {
         t_historia[i]=iBars(instrumenty[i],okres);
        }

      for(int z=1;z<3;z++)
        {
         for(i=0;i<wymiar_tab;i++)
           {
            if(t_historia[i]<Zmiennosc)
              {
               Sleep(500);
               t_historia[i]=iBars(instrumenty[i],okres);
              }
           }
        }

      wczytywanie_historii=true;
     }


   for(i=0;i<wymiar_tab;i++)
     {
      if(MarketInfo(instrumenty[i],MODE_SPREAD)!=0)
        {
         mnoznik=1;

         for(int k=0;k<dim_ticker;k++)
           {
            if(instrumenty[i]==t_ticker[k])
              {
               if(do_5==true) { mnoznik=10; }
               break;

              }
             else if(instrumenty[i]==t_ticker2[k])
              {
               if(do_5==true) { mnoznik=100; }
               break;

              }
            else
              {
               mnoznik=1;
              }

           }

         tablica[i][1]=NormalizeDouble(MarketInfo(instrumenty[i],MODE_SPREAD)/mnoznik,1);

        }
      else
        {
         tablica[i][1]=0.0;
        }

      tablica[i][4]=i;
      //   tablica[37][4]=37;
     }

//-------------------------------- W20 ---------------------------------------------------------------------------
/*  
   tablica[37][1]=3;
   
   if(okres==1)      
   {
      if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=2;
         tablica[37][3]=3;
       }  
      
      if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=1;
         tablica[37][3]=4;
       }  
       
       if(Zmiennosc>=50)
       {
         t_historia[37]=100;
         tablica[37][2]=2;
         tablica[37][3]=4;
       }  
   
   
   }
      
   if(okres==5)  
   { 
      if(Zmiennosc<=20)
       {
         t_historia[37]=20;
         tablica[37][2]=3;
         tablica[37][3]=4;
       }  
      
      if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=3;
         tablica[37][3]=4;
       }  
       
       if(Zmiennosc>=50)
       {
         t_historia[37]=100;
         tablica[37][2]=4;
         tablica[37][3]=18;
       }   
   }
   
      
   if(okres==15)     
   { 
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=6;
         tablica[37][3]=6;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=7;
         tablica[37][3]=21;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=7;
         tablica[37][3]=41;
       }
      
   }   
   
   if(okres==30)     
   { 
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=10;
         tablica[37][3]=18;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=10;
         tablica[37][3]=42;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=11;
         tablica[37][3]=44;
       } 
   }
      
   if(okres==60)     
   {
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=15;
         tablica[37][3]=35;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=15;
         tablica[37][3]=44;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=16;
         tablica[37][3]=49;
       } 
   }
      
   if(okres==240)    
   {
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=31;
         tablica[37][3]=46;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=33;
         tablica[37][3]=63;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=38;
         tablica[37][3]=76;
       } 
   }
      
   if(okres==1440)   
   { 
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=46;
         tablica[37][3]=71;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=53;
         tablica[37][3]=77;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=55;
         tablica[37][3]=174;
       } 
   }
  
   if(okres==10080)  
   {
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=141;
         tablica[37][3]=173;
       }  
      
       if( (Zmiennosc>20) && (Zmiennosc<50) )
       {
         t_historia[37]=50;
         tablica[37][2]=143;
         tablica[37][3]=268;
       }  
       
       if( Zmiennosc>=50 )
       {
         t_historia[37]=100;
         tablica[37][2]=161;
         tablica[37][3]=572;
       } 
   }
   
   if(okres==43200)  
   { 
       if( Zmiennosc<=20 )
       {
         t_historia[37]=20;
         tablica[37][2]=351;
         tablica[37][3]=485;
       }  
      
       if( (Zmiennosc>20) )
       {
         t_historia[37]=50;
         tablica[37][2]=355;
         tablica[37][3]=671;
       }  
       
     
   } 
 */

//---------------------------- obliczanie zmiennosc --------------------------------------------------------------     
   for(i=0;i<wymiar_tab;i++)
     {
      mnoznik=1;

      for(k=0;k<dim_ticker;k++)
        {
         if(instrumenty[i]==t_ticker[k])
           {
            if(do_5==true) { mnoznik=10; }
            break;

           }
         else if(instrumenty[i]==t_ticker2[k])
           {
            if(do_5==true) { mnoznik=100; }
            break;

           }
         else
           {
            mnoznik=1;
           }

        }

      if(historia_zaladowana==true) {   historia=t_historia[i]; }
      else                             {   t_historia[i]=iBars(instrumenty[i],okres);  historia=t_historia[i];  }

      if(historia<Zmiennosc)
        {
         zm=historia;
         if(alarmy[i]==0)
           {
            if(t_historia[ArrayMinimum(t_historia)]!=0)
              {
               Alert("Liczba swieczek na  ",instrumenty[i]," interwał ",okres_alarm," wynosi ",historia,". ","Załaduj historie!");
               alarmy[i]=1;
              }
           }
        }
      else { zm=Zmiennosc; }

      if(zm==0) { tablica[i][3]=0; }
      else
        {
         tablica[i][3]=NormalizeDouble((iStdDev(instrumenty[i],okres,zm,MODE_SMA,0,PRICE_CLOSE,0)*MathPow(10,MarketInfo(instrumenty[i],MODE_DIGITS)))/mnoznik,MarketInfo(instrumenty[i],MODE_DIGITS));
        }
     }

   for(i=0;i<wymiar_tab;i++)
     {

      mnoznik=1;

      for(k=0;k<dim_ticker;k++)
        {
         if(instrumenty[i]==t_ticker[k])
           {
            if(do_5==true) { mnoznik=10; }
            break;

           }
         else
           {
            mnoznik=1;
           }

        }



      if(historia_zaladowana==true) {   historia=t_historia[i]; }
      else                             {   t_historia[i]=iBars(instrumenty[i],okres);  historia=t_historia[i];   }

      if(historia<Zmiennosc) { zm=historia; }
      else  { zm=Zmiennosc; }

      if(zm==0) { tablica[i][2]=0; }
      else
        {
         tablica[i][2]=NormalizeDouble((funkcja_hl(instrumenty[i],zm,okres))*MathPow(10,MarketInfo(instrumenty[i],MODE_DIGITS))/mnoznik,MarketInfo(instrumenty[i],MODE_DIGITS));
        }
     }


//----------------------------------------------------------------------------------------------------------------
   if(Uwzglednij_HL==true && Uwzglednij_StdDev==true)
     {
      for(i=0;i<wymiar_tab;i++)
        {
         if((tablica[i][2]+tablica[i][3])==0)
           {
            tablica[i][0]=0.00;
           }
         else
           {
            tablica[i][0]=(tablica[i][1]/((tablica[i][2]+tablica[i][3])/2))*100;
           }
        }
     }
   else if(Uwzglednij_HL==true && Uwzglednij_StdDev==false)
     {
      for(i=0;i<wymiar_tab;i++)
        {
         if(tablica[i][2]==0)
           {
            tablica[i][0]=0.00;
           }
         else
           {
            tablica[i][0]=(tablica[i][1]/tablica[i][2])*100;
           }
        }
     }
   else if(Uwzglednij_HL==false && Uwzglednij_StdDev==true)
     {
      for(i=0;i<wymiar_tab;i++)
        {
         if(tablica[i][3]==0)
           {
            tablica[i][0]=0.00;
           }
         else
           {
            tablica[i][0]=(tablica[i][1]/tablica[i][3])*100;
           }
        }
     }

   if(Sortuj_Tabele==True)
     {
      ArraySort(tablica,WHOLE_ARRAY,0,MODE_ASCEND);
     }

   ArrayResize(instrumenty_rob,0);
   wymiar_rob=0;

   for(i=iter_od;i<iter_do;i++)
     {
      //   if (i>18) { druga_kolumna_X=460; druga_kolumna_Y=19; }

      if(iter_od==0)
        {
         if(i>=21) { druga_kolumna_X=460; druga_kolumna_Y=21; }


        }
      else
        {
         if(i>=63) { druga_kolumna_X=460; druga_kolumna_Y=63; }

         else         { druga_kolumna_X=0; druga_kolumna_Y=43;}

        }



      for(j=0;j<wymiar_tab;j++)
        {
         if(tablica[i][4]==j)
           {

            wymiar_rob=ArrayRange(instrumenty_rob,0)+1;
            ArrayResize(instrumenty_rob,wymiar_rob);

            instrumenty_rob[wymiar_rob-1]=instrumenty[j];

            if(t_historia[j]<Zmiennosc)
              {
               ObjectCreate("zm"+instrumenty[j],OBJ_LABEL,windex,0,0);
               ObjectSetText("zm"+instrumenty[j],instrumenty[j]+" ("+DoubleToStr(t_historia[j],0)+")",7,"Verdana",Kolor);
               ObjectSet("zm"+instrumenty[j],OBJPROP_CORNER,0);
               ObjectSet("zm"+instrumenty[j],OBJPROP_XDISTANCE,shiftX[0]+druga_kolumna_X);
               ObjectSet("zm"+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
              }
            else
              {
               ObjectCreate("zm"+instrumenty[j],OBJ_LABEL,windex,0,0);
               ObjectSetText("zm"+instrumenty[j],instrumenty[j],7,"Verdana",Kolor);
               ObjectSet("zm"+instrumenty[j],OBJPROP_CORNER,0);
               ObjectSet("zm"+instrumenty[j],OBJPROP_XDISTANCE,shiftX[0]+druga_kolumna_X);
               ObjectSet("zm"+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);
              }

            break;
           }
        }

      ObjectCreate("zmSPREAD "+instrumenty[j],OBJ_LABEL,windex,0,0);
      ObjectSetText("zmSPREAD "+instrumenty[j],DoubleToStr(tablica[i][1],1),7,"Verdana",Kolor);
      ObjectSet("zmSPREAD "+instrumenty[j],OBJPROP_CORNER,0);
      ObjectSet("zmSPREAD "+instrumenty[j],OBJPROP_XDISTANCE,shiftX[1]+druga_kolumna_X);
      ObjectSet("zmSPREAD "+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);

      ObjectCreate("zmH-L "+instrumenty[j],OBJ_LABEL,windex,0,0);
      ObjectSetText("zmH-L "+instrumenty[j],DoubleToStr(tablica[i][2],1),7,"Verdana",Kolor);
      ObjectSet("zmH-L "+instrumenty[j],OBJPROP_CORNER,0);
      ObjectSet("zmH-L "+instrumenty[j],OBJPROP_XDISTANCE,shiftX[2]+druga_kolumna_X);
      ObjectSet("zmH-L "+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);

      ObjectCreate("zmSTD "+instrumenty[j],OBJ_LABEL,windex,0,0);
      ObjectSetText("zmSTD "+instrumenty[j],DoubleToStr(tablica[i][3],1),7,"Verdana",Kolor);
      ObjectSet("zmSTD "+instrumenty[j],OBJPROP_CORNER,0);
      ObjectSet("zmSTD "+instrumenty[j],OBJPROP_XDISTANCE,shiftX[3]+druga_kolumna_X);
      ObjectSet("zmSTD "+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);


      ObjectCreate("zmWSP "+instrumenty[j],OBJ_LABEL,windex,0,0);
      ObjectSetText("zmWSP "+instrumenty[j],DoubleToStr(tablica[i][0],2)+" %",7,"Verdana",Kolor);
      ObjectSet("zmWSP "+instrumenty[j],OBJPROP_CORNER,0);
      ObjectSet("zmWSP "+instrumenty[j],OBJPROP_XDISTANCE,shiftX[4]+druga_kolumna_X);
      ObjectSet("zmWSP "+instrumenty[j],OBJPROP_YDISTANCE,shiftY[i-druga_kolumna_Y]);



     }

   bool  usun;

   for(i=0;i<wymiar_tab;i++)
     {
      usun=true;

      for(j=0;j<wymiar_rob;j++)
        {
         if(instrumenty[i]==instrumenty_rob[j])
           {
            usun=false;
            break;

           }
        }

      if(usun==true)
        {
         if(ObjectFind("zm"+instrumenty[i])!=-1)
           {
            ObjectDelete("zm"+instrumenty[i]);
            ObjectDelete("zmSPREAD "+instrumenty[i]);
            ObjectDelete("zmH-L "+instrumenty[i]);
            ObjectDelete("zmSTD "+instrumenty[i]);
            ObjectDelete("zmWSP "+instrumenty[i]);
           }

         //       Alert("usuwam: ",instrumenty[i]);
        }

     }





//----------------- historia zaladowana -----------------------------------------------------

   if(historia_zaladowana==false)
     {
      if(t_historia[ArrayMinimum(t_historia)]>=Zmiennosc)
        {
         Alert("Historia została załadowana.");
         historia_zaladowana=true;

        }
     }



//-------------- nowe cala tablica itp -------------------------------------------------------


   if(cala_tablica==false)
     {
      cala_tablica=true;

      for(i=0;i<4;i++)
        {
         for(j=0;j<wymiar_tab;j++)
           {
            if(i!=1)
              {
               if(tablica[j][i]==0) { cala_tablica=false; }
              }
           }
        }

      for(i=0;i<wymiar_tab;i++)
        {
         if(tablica[i][1]==0) { cala_tablica=true;  }
        }

     }

   if(cala_tablica==true)
     {
      if(Zapisac_do_pliku==true)
        {

         handle=FileOpen(file_name,FILE_CSV|FILE_WRITE,";");

         if(handle==-1)
           {
            Alert("Wystąpił błąd podczas zapisu pliku. Spróbuj ponownie!");
            return (0);
           }

         FileWrite(handle,"LP","Instrument","Spread","H-L ("+DoubleToStr(Zmiennosc,0)+")","StdDev ("+DoubleToStr(Zmiennosc,0)+")","WSP");

         for(i=0;i<wymiar_tab;i++)
           {
            for(j=0;j<wymiar_tab;j++)
              {
               if(tablica[i][4]==j)
                 {

                  if(t_historia[j]<Zmiennosc)
                    {
                     FileWrite(handle,i+1,instrumenty[j]+" ("+t_historia[j]+")",tablica[i][1],tablica[i][2],NormalizeDouble(tablica[i][3],1),NormalizeDouble(tablica[i][0],2));
                     FileFlush(handle);
                    }
                  else
                    {
                     FileWrite(handle,i+1,instrumenty[j],tablica[i][1],tablica[i][2],NormalizeDouble(tablica[i][3],1),NormalizeDouble(tablica[i][0],2));
                     FileFlush(handle);
                    }

                 }
              }
           }

         FileClose(handle);
         Alert("Plik  \"",file_name,"\"  został zapisany w folderze ",TerminalPath(),"\experts\files");
         Zapisac_do_pliku=false;
        }
     }

   WindowRedraw();

//----
   return(0);
  }
//+------------------------------------------------------------------+

double funkcja_hl(string symbol,int ilosc_swieczek,int interwal)
  {
   double zm=0;
   double licznik=0;
   double wynik;

   for(int i=0;i<ilosc_swieczek;i++)
     {
      zm=zm+((iHigh(symbol,interwal,i)-iLow(symbol,interwal,i))+MarketInfo(symbol,MODE_POINT));
      licznik=licznik+1;
     }

   wynik=NormalizeDouble((zm/licznik),MarketInfo(symbol,MODE_DIGITS));

   return(wynik);


  }
//+------------------------------------------------------------------+
