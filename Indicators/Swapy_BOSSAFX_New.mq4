//+------------------------------------------------------------------+
//|                                                Swapy_BOSSAFX.mq4 |
//|                                                          BOSSAFX |
//|                                            http://www.bossafx.pl |
//+------------------------------------------------------------------+
#property copyright "BOSSAFX"
#property link      "http://www.bossafx.pl"

#property indicator_separate_window

// 04.07.2012    zmieniono JPYPLN.   i FBNAKNS

// ----------- 26.06.2012 ------- nowe instrumenty zrobione

// ----------- 16.05.2011 ----------------------------------------------------
//                        dodano nowe instrumenty



#define wymiar  58
#define dim_opo 91

extern color   Kolor=Green;
extern bool    Tabela_1=true;
extern bool    Tabela_2=false;
extern bool    Wszystkie_instrumenty=false;
extern bool    Zapisac_do_pliku=false;

bool    do_5=true;

int dim_tab;

string instrumenty[wymiar]=
  {
   "BOSSAUSD.",
   "BOSSAEUR.",
   "BOSSAPLN.",
   "BOSSACZK.",
   "EURUSD.",
   "GBPUSD.",
   "USDJPY.",
   "USDCHF.",
   "EURGBP.",
   "EURJPY.",
   "EURCHF.",
   "USDCAD.",
   "GBPJPY.",
   "AUDJPY.",
   "USDPLN.",
   "EURPLN.",
   "GBPPLN.",
   "CHFPLN.",
   "JPYPLN..",
   "USDCZK.",
   "EURCZK.",
   "GBPCZK.",
   "USDHUF.",
   "EURHUF.",
   "USDSEK.",
   "EURSEK.",
   "USDNOK.",
   "EURNOK.",
   "AUDUSD.",

   "AUDCAD.",
   "AUDCHF.",
   "AUDNZD.",
   "NZDUSD.",
   "EURCAD.",
   "EURAUD.",
   "EURNZD.",
   "USDHKD.",
   "GBPCHF.",
   "GBPNZD.",
   "GBPAUD.",
   "CADJPY.",
   "CADCHF.",
   "CHFJPY.",
   "USDZAR.",
   "USDMXN.",
   "USDTRY.",
   "EURTRY.",
   "GBPCAD.",
   "NZDJPY.",
   "SILVER.",
   "PLATINUM.",
   "PALLADIUM.",

   "USDRON.",
   "EURRON.",
   "USDDKK.",
   "EURDKK.",
   "USDRUB.",
   "EURRUB."


  };



// tu dodano 
string instrumenty_1[29]=
  {
   "BOSSAUSD.",
   "BOSSAEUR.",
   "BOSSAPLN.",
   "BOSSACZK.",
   "EURUSD.",
   "GBPUSD.",
   "USDJPY.",
   "USDCHF.",
   "EURGBP.",
   "EURJPY.",
   "EURCHF.",
   "USDCAD.",
   "GBPJPY.",
   "USDPLN.",
   "EURPLN.",
   "GBPPLN.",
   "CHFPLN.",
   "JPYPLN.",
   "USDCZK.",
   "EURCZK.",
   "GBPCZK.",
   "USDHUF.",
   "EURHUF.",
   "USDSEK.",
   "USDNOK.",
   "USDTRY.",
   "USDZAR.",
   "USDMXN.",
   "EURNOK."

  };

string instrumenty_2[32]=
  {
   "AUDUSD.",
   "AUDJPY.",
   "AUDCAD.",
   "AUDCHF.",
   "AUDNZD.",
   "NZDUSD.",
   "EURCAD.",
   "EURAUD.",
   "EURNZD.",
   "USDHKD.",
   "GBPCHF.",
   "GBPNZD.",
   "GBPAUD.",
   "CADJPY.",
   "CADCHF.",
   "CHFJPY.",
   "EURTRY.",
   "USDTRY.",
   "USDZAR.",
   "GBPCAD.",
   "NZDJPY.",
   "USDRON.",
   "EURRON.",
   "USDDKK.",
   "EURDKK.",
   "USDRUB.",
   "EURRUB.",
   "SILVER.",
   "PLATINUM.",
   "PALLADIUM."
  };


string t_ticker[10]={"EURUSD.","GBPUSD.","USDJPY.","USDCHF.","EURGBP.","EURJPY.","GBPJPY.","USDCAD.","EURCHF.","AUDUSD."}; //instrumenty z mnożnikiem 10 (0.00000)
string t_ticker2[1]={"SILVER."};  //instrumenty z mnożnikiem 100 
bool znaleziono;
int  dim_ticker;


int tabela_spready[];

int tabela_spready_1[37]={40,40,70,40,2,4,3,3,4,8,4,5,5,5,4,13,11,10,8,5,10,15,9,10,10,10,7,80,6,30,8,6,80,40,3,30,6,3};

int tabela_spready_2[24];

double   tablica[][5];
int      alarmy[];


int linie_pionowe_X[11]={110,172,241,325,388,480,560,630,695,785,840};
int linie_pionowe_Y[3]={35,245,380};
int linie_pionowe_Y_2[5]={35,210,380,535,635};

int linie_poziome[31];
int linie_poziome_X[4]={0,200,435,470};

int shiftX[6];
int shiftY[37];
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
//---- indicators

   tabela_spready_2[0]=10;                               //       "USDINDEX",
   tabela_spready_2[1]=10;                               //       "EURINDEX",
   tabela_spready_2[2]=30;                               //       "PLNINDEX",
   tabela_spready_2[3]=8;                               //       "USDHKD",
   tabela_spready_2[4]=50;                               //       "USDNOK",
   tabela_spready_2[5]=50;                               //       "USDSEK",
   tabela_spready_2[6]=35;                               //       "USDCZK",
   tabela_spready_2[7]=35;                               //       "USDHUF",
   tabela_spready_2[8]=50;                               //       "EURNOK",
   tabela_spready_2[9]=50;                               //       "EURSEK",
   tabela_spready_2[10]=35;                               //       "EURCZK",
   tabela_spready_2[11]=35;                               //       "EURHUF",
   tabela_spready_2[12]=35;                               //       "FCORN",
   tabela_spready_2[13]=100;                               //       "FWHEAT",
   tabela_spready_2[14]=100;                               //       "FSOYBEAN",
   tabela_spready_2[15]=4;                               //       "FTNOTE10",
   tabela_spready_2[16]=2;                               //       "FBUND10",
   tabela_spready_2[17]=100;                               //       "FUS100",
   tabela_spready_2[18]=25;                               //       "FGB100",
   tabela_spready_2[19]=35;                               //       "FFR40",
   tabela_spready_2[20]=25;                               //       "FHK45",
   tabela_spready_2[21]=25;                               //       "FCN40",
   tabela_spready_2[22]=500;                               //       "PLATINUM",
   tabela_spready_2[23]=200;                               //       "PALLADIUM"};


   dim_ticker=ArrayRange(t_ticker,0);
   dim_tab=ArrayRange(instrumenty,0);

   if(Wszystkie_instrumenty==true)
     {
      iter_od=0;
      iter_do=wymiar;
      small_tab=false;
     }
   else
     {
      if(Tabela_1==true && Tabela_2==true)
        {
         iter_od=0;
         iter_do=wymiar;
         small_tab=false;
        }

      if(Tabela_1==true && Tabela_2==false)
        {
         iter_od=0;
         iter_do=28;
         small_tab=true;
        }

      if(Tabela_1==false && Tabela_2==true)
        {
         iter_od=28;
         iter_do=wymiar;
         small_tab=true;
        }

      if(Tabela_1==false && Tabela_2==false)
        {
         iter_od=0;
         iter_do=28;
         small_tab=true;
        }
     }



/*   
   if ( Pierwsza_Tabela==true )
   {
      dim_tab=ArrayRange(instrumenty,0);
      ArrayResize(instrumenty,dim_tab);
      ArrayResize(tabela_spready,dim_tab);
      
      for ( int i=0;i<dim_tab;i++)
      {
         instrumenty[i]=instrumenty_1[i];    
         tabela_spready[i]=tabela_spready_1[i];
      }       
   
   
   }
   else
   {
      dim_tab=ArrayRange(instrumenty_2,0);
      ArrayResize(instrumenty,dim_tab);
      ArrayResize(tabela_spready,dim_tab);
      
      for ( i=0;i<dim_tab;i++)
      {
         instrumenty[i]=instrumenty_2[i];    
         tabela_spready[i]=tabela_spready_2[i];
      }       
    
   }
   
  */

// usuwam wszystkie instrumenty jesli byly juz na wykresie   

   for(int i=0;i<ArrayRange(instrumenty,0);i++)
     {
      ObjectDelete("s"+instrumenty[i]);
      ObjectDelete("sSPREAD "+instrumenty[i]);
      ObjectDelete("sSWAP LONG "+instrumenty[i]);
      ObjectDelete("sSWAP SHORT "+instrumenty[i]);
      ObjectDelete("sLIMIT "+instrumenty[i]);

     }

// usuwam tabele 
   for(int  j=0;j<3;j++)
     {
      for(i=0;i<31;i++)
        {
         ObjectDelete("L"+i+j);

        }
     }

   for(j=0;j<5;j++)
     {
      for(i=0;i<9;i++)
        {
         ObjectDelete("P"+i+j);

        }
     }



   ArrayResize(tablica,dim_tab);
   ArrayResize(alarmy,dim_tab);
   ArrayResize(t_historia,dim_tab);

   int przesuniecie_X=70;
   int przesuniecie_Y=25;


   for(i=2;i<6;i++)
     {
      shiftX[0]=20;
      shiftX[1]=120;
      shiftX[i]=shiftX[i-1]+przesuniecie_X;
     }

   for(i=1;i<37;i++)
     {
      shiftY[0]=70;
      shiftY[i]=shiftY[i-1]+przesuniecie_Y;
      tablica[0][0]=0;
      tablica[i][0]=0;
      alarmy[i]=0;
     }

   linie_poziome[0]=30;
   linie_poziome[1]=80;

   for(i=2;i<31;i++)
     {
      linie_poziome[i]=linie_poziome[i-1]+przesuniecie_Y;
      Print("linie_poziome[i]:",i,"  ",linie_poziome[i]);
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
   int pierwsza_linia=380;
   int okres=Period();
   string okres_alarm;

   if(okres==1)      { okres_alarm = "M1"; }
   if(okres==5)      { okres_alarm = "M5"; }
   if(okres==15)     { okres_alarm = "M15"; }
   if(okres==30)     { okres_alarm = "M30"; }
   if(okres==60)     { okres_alarm = "H1"; }
   if(okres==240)    { okres_alarm = "H4"; }
   if(okres==1440)   { okres_alarm = "D1"; }
   if(okres==10080)  {okres_alarm = "W1"; }
   if(okres==43200)  { okres_alarm = "MN"; }

   string short_name="++ BOSSAFX ++  ( SWAPY - LIMITY )";

   IndicatorShortName(short_name);
   int windex=WindowFind(short_name);

   string file_name="SWAPY_BOSSAFX.csv";

//  int handle;

//--------------------------------- rysowanie tabeli ---------------------------------------------------------------------------

   if(tabela_narysowana==false)
     {
      if(small_tab==true)
        {
         for(int j=0;j<3;j++)
           {
            for(int i=0;i<17;i++)
              {
               ObjectCreate("L"+i+j,OBJ_LABEL,windex,0,0);
               ObjectSetText("L"+i+j,"---------------------------------------------------",7,"Verdana",Kolor);
               ObjectSet("L"+i+j,OBJPROP_CORNER,0);
               ObjectSet("L"+i+j,OBJPROP_ANGLE,0);
               ObjectSet("L"+i+j,OBJPROP_XDISTANCE,linie_poziome_X[j]);
               ObjectSet("L"+i+j,OBJPROP_YDISTANCE,linie_poziome[i]);
              }
           }

         for(j=0;j<2;j++)
           {
            for(i=0;i<9;i++)
              {
               ObjectCreate("P"+i+j,OBJ_LABEL,windex,0,0);
               ObjectSetText("P"+i+j,"------------------------------------------------------",7,"Verdana",Kolor);
               ObjectSet("P"+i+j,OBJPROP_CORNER,0);
               ObjectSet("P"+i+j,OBJPROP_ANGLE,-90);
               ObjectSet("P"+i+j,OBJPROP_XDISTANCE,linie_pionowe_X[i]);
               ObjectSet("P"+i+j,OBJPROP_YDISTANCE,linie_pionowe_Y[j]);
              }
           }
        }
      else
        {
         for(j=0;j<3;j++)
           {
            for(i=0;i<31;i++)
              {
               ObjectCreate("L"+i+j,OBJ_LABEL,windex,0,0);
               ObjectSetText("L"+i+j,"---------------------------------------------------",7,"Verdana",Kolor);
               ObjectSet("L"+i+j,OBJPROP_CORNER,0);
               ObjectSet("L"+i+j,OBJPROP_ANGLE,0);
               ObjectSet("L"+i+j,OBJPROP_XDISTANCE,linie_poziome_X[j]);
               ObjectSet("L"+i+j,OBJPROP_YDISTANCE,linie_poziome[i]);
              }
           }

         for(j=0;j<5;j++)
           {
            for(i=0;i<9;i++)
              {
               ObjectCreate("P"+i+j,OBJ_LABEL,windex,0,0);
               ObjectSetText("P"+i+j,"--------------------------------------------",7,"Verdana",Kolor);
               ObjectSet("P"+i+j,OBJPROP_CORNER,0);
               ObjectSet("P"+i+j,OBJPROP_ANGLE,-90);
               ObjectSet("P"+i+j,OBJPROP_XDISTANCE,linie_pionowe_X[i]);
               ObjectSet("P"+i+j,OBJPROP_YDISTANCE,linie_pionowe_Y_2[j]);
              }
           }

        }
      tabela_narysowana=true;
     }

//--------------------------------- pierwsza linia ---------------------------------------------------------------------------


   ObjectCreate("sInstrument",OBJ_LABEL,windex,0,0);
   ObjectSetText("sInstrument","Instrument",7,"Verdana",Kolor);
   ObjectSet("sInstrument",OBJPROP_CORNER,0);
   ObjectSet("sInstrument",OBJPROP_XDISTANCE,shiftX[0]);
   ObjectSet("sInstrument",OBJPROP_YDISTANCE,shiftY[0]-20);

   ObjectCreate("sSpread",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSpread","SPREAD",7,"Verdana",Kolor);
   ObjectSet("sSpread",OBJPROP_CORNER,0);
   ObjectSet("sSpread",OBJPROP_XDISTANCE,shiftX[1]-10);
   ObjectSet("sSpread",OBJPROP_YDISTANCE,shiftY[0]-20);

   ObjectCreate("sLONG",OBJ_LABEL,windex,0,0);
   ObjectSetText("sLONG","SWAP",7,"Verdana",Kolor);
   ObjectSet("sLONG",OBJPROP_CORNER,0);
   ObjectSet("sLONG",OBJPROP_XDISTANCE,shiftX[2]);
   ObjectSet("sLONG",OBJPROP_YDISTANCE,shiftY[0]-25);

   ObjectCreate("sLONG2",OBJ_LABEL,windex,0,0);
   ObjectSetText("sLONG2","LONG ",7,"Verdana",Kolor);
   ObjectSet("sLONG2",OBJPROP_CORNER,0);
   ObjectSet("sLONG2",OBJPROP_XDISTANCE,shiftX[2]);
   ObjectSet("sLONG2",OBJPROP_YDISTANCE,shiftY[0]-5);

   ObjectCreate("sSHORT",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSHORT","SWAP ",7,"Verdana",Kolor);
   ObjectSet("sSHORT",OBJPROP_CORNER,0);
   ObjectSet("sSHORT",OBJPROP_XDISTANCE,shiftX[3]);
   ObjectSet("sSHORT",OBJPROP_YDISTANCE,shiftY[0]-25);

   ObjectCreate("sSHORT2",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSHORT2","SHORT ",7,"Verdana",Kolor);
   ObjectSet("sSHORT2",OBJPROP_CORNER,0);
   ObjectSet("sSHORT2",OBJPROP_XDISTANCE,shiftX[3]);
   ObjectSet("sSHORT2",OBJPROP_YDISTANCE,shiftY[0]-5);
/*  
    ObjectCreate("sLIMITY", OBJ_LABEL, windex,0, 0);
    ObjectSetText("sLIMITY","LIMIT",7, "Verdana", Kolor);
    ObjectSet("sLIMITY", OBJPROP_CORNER, 0);
    ObjectSet("sLIMITY", OBJPROP_XDISTANCE, shiftX[4]);
    ObjectSet("sLIMITY", OBJPROP_YDISTANCE,shiftY[0]-20);
 */
   ObjectCreate("sInstrument_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sInstrument_","Instrument",7,"Verdana",Kolor);
   ObjectSet("sInstrument_",OBJPROP_CORNER,0);
   ObjectSet("sInstrument_",OBJPROP_XDISTANCE,shiftX[0]+pierwsza_linia);
   ObjectSet("sInstrument_",OBJPROP_YDISTANCE,shiftY[0]-20);

   ObjectCreate("sSpread_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSpread_","SPREAD",7,"Verdana",Kolor);
   ObjectSet("sSpread_",OBJPROP_CORNER,0);
   ObjectSet("sSpread_",OBJPROP_XDISTANCE,shiftX[1]-10+pierwsza_linia);
   ObjectSet("sSpread_",OBJPROP_YDISTANCE,shiftY[0]-20);

   ObjectCreate("sLONG_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sLONG_","SWAP ",7,"Verdana",Kolor);
   ObjectSet("sLONG_",OBJPROP_CORNER,0);
   ObjectSet("sLONG_",OBJPROP_XDISTANCE,shiftX[2]+pierwsza_linia);
   ObjectSet("sLONG_",OBJPROP_YDISTANCE,shiftY[0]-25);

   ObjectCreate("sLONG2_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sLONG2_","LONG ",7,"Verdana",Kolor);
   ObjectSet("sLONG2_",OBJPROP_CORNER,0);
   ObjectSet("sLONG2_",OBJPROP_XDISTANCE,shiftX[2]+pierwsza_linia);
   ObjectSet("sLONG2_",OBJPROP_YDISTANCE,shiftY[0]-5);

   ObjectCreate("sSHORT_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSHORT_","SWAP ",7,"Verdana",Kolor);
   ObjectSet("sSHORT_",OBJPROP_CORNER,0);
   ObjectSet("sSHORT_",OBJPROP_XDISTANCE,shiftX[3]+pierwsza_linia);
   ObjectSet("sSHORT_",OBJPROP_YDISTANCE,shiftY[0]-25);

   ObjectCreate("sSHORT2_",OBJ_LABEL,windex,0,0);
   ObjectSetText("sSHORT2_","SHORT ",7,"Verdana",Kolor);
   ObjectSet("sSHORT2_",OBJPROP_CORNER,0);
   ObjectSet("sSHORT2_",OBJPROP_XDISTANCE,shiftX[3]+pierwsza_linia);
   ObjectSet("sSHORT2_",OBJPROP_YDISTANCE,shiftY[0]-5);

/*  
    ObjectCreate("sLIMITY_", OBJ_LABEL, windex,0, 0);
    ObjectSetText("sLIMITY_","LIMIT",7, "Verdana", Kolor);
    ObjectSet("sLIMITY_", OBJPROP_CORNER, 0);
    ObjectSet("sLIMITY_", OBJPROP_XDISTANCE, shiftX[4]+pierwsza_linia);
    ObjectSet("sLIMITY_", OBJPROP_YDISTANCE,shiftY[0]-20);
 */

   for(i=0;i<dim_tab;i++)
     {
      tablica[i][0]=MarketInfo(instrumenty[i],MODE_SPREAD);
      tablica[i][4]=i;
      tablica[i][1]=MarketInfo(instrumenty[i],MODE_SWAPLONG);
      tablica[i][2]=MarketInfo(instrumenty[i],MODE_SWAPSHORT);
      tablica[i][3]=MarketInfo(instrumenty[i],MODE_STOPLEVEL);

     }

// ------------- zmieniajac rozmiar trzeba pamietac i zmiennej druga_kolumna_Y !!!

   for(i=iter_od;i<iter_do;i++)
     {
      //    if (i>18) { druga_kolumna_X=460; druga_kolumna_Y=19; }

      if(iter_od==0)
        {
         if(iter_do==28)
           {
            if(i>=14) { druga_kolumna_X=380; druga_kolumna_Y=14; }
           }
         else
           {
            if(i>=14 && i<=26)
              {
               druga_kolumna_X=380; druga_kolumna_Y=14;
              }

            if(i>=27 && i<=41)
              {
               druga_kolumna_X=0; druga_kolumna_Y=13;
              }

            if(i>=42)
              {
               druga_kolumna_X=380; druga_kolumna_Y=29;
              }
           }

        }
      else
        {
         if(i>42) { druga_kolumna_X=380; druga_kolumna_Y=43; }

         else         { druga_kolumna_X=0; druga_kolumna_Y=28;}

        }


      mnoznik=1;

      for(j=0;j<dim_ticker;j++)
        {
         if(instrumenty[i]==t_ticker[j])
           {
            if(do_5==true) { mnoznik=10; }
            break;

           }
         else if(instrumenty[i]==t_ticker2[j])
           {
            if(do_5==true) { mnoznik=100; }
            break;

           }
         else
           {
            mnoznik=1;
           }
        }

      ObjectCreate("s"+instrumenty[i],OBJ_LABEL,windex,0,0);
      ObjectSetText("s"+instrumenty[i],instrumenty[i],7,"Verdana",Kolor);
      ObjectSet("s"+instrumenty[i],OBJPROP_CORNER,0);
      ObjectSet("s"+instrumenty[i],OBJPROP_XDISTANCE,shiftX[0]+druga_kolumna_X);
      ObjectSet("s"+instrumenty[i],OBJPROP_YDISTANCE,shiftY[i+1-druga_kolumna_Y]);

      ObjectCreate("sSPREAD "+instrumenty[i],OBJ_LABEL,windex,0,0);
      ObjectSetText("sSPREAD "+instrumenty[i],DoubleToStr(tablica[i][0]/mnoznik,1),7,"Verdana",Kolor);
      ObjectSet("sSPREAD "+instrumenty[i],OBJPROP_CORNER,0);
      ObjectSet("sSPREAD "+instrumenty[i],OBJPROP_XDISTANCE,shiftX[1]+druga_kolumna_X);
      ObjectSet("sSPREAD "+instrumenty[i],OBJPROP_YDISTANCE,shiftY[i+1-druga_kolumna_Y]);

      ObjectCreate("sSWAP LONG "+instrumenty[i],OBJ_LABEL,windex,0,0);
      ObjectSetText("sSWAP LONG "+instrumenty[i],DoubleToStr(tablica[i][1]/mnoznik,3),7,"Verdana",Kolor);
      ObjectSet("sSWAP LONG "+instrumenty[i],OBJPROP_CORNER,0);
      ObjectSet("sSWAP LONG "+instrumenty[i],OBJPROP_XDISTANCE,shiftX[2]+druga_kolumna_X);
      ObjectSet("sSWAP LONG "+instrumenty[i],OBJPROP_YDISTANCE,shiftY[i+1-druga_kolumna_Y]);

      ObjectCreate("sSWAP SHORT "+instrumenty[i],OBJ_LABEL,windex,0,0);
      ObjectSetText("sSWAP SHORT "+instrumenty[i],DoubleToStr(tablica[i][2]/mnoznik,3),7,"Verdana",Kolor);
      ObjectSet("sSWAP SHORT "+instrumenty[i],OBJPROP_CORNER,0);
      ObjectSet("sSWAP SHORT "+instrumenty[i],OBJPROP_XDISTANCE,shiftX[3]+druga_kolumna_X);
      ObjectSet("sSWAP SHORT "+instrumenty[i],OBJPROP_YDISTANCE,shiftY[i+1-druga_kolumna_Y]);

/*  
           ObjectCreate("sLIMIT "+instrumenty[i], OBJ_LABEL, windex,0, 0);
           ObjectSetText("sLIMIT "+instrumenty[i],DoubleToStr(tablica[i][3]/mnoznik,1),7, "Verdana", Kolor);
           ObjectSet("sLIMIT "+instrumenty[i], OBJPROP_CORNER, 0);
           ObjectSet("sLIMIT "+instrumenty[i], OBJPROP_XDISTANCE, shiftX[4]+druga_kolumna_X);
           ObjectSet("sLIMIT "+instrumenty[i], OBJPROP_YDISTANCE,shiftY[i+1-druga_kolumna_Y]);
    */

     }

   if(Zapisac_do_pliku==true)
     {

      handle=FileOpen(file_name,FILE_CSV|FILE_WRITE,";");

      if(handle==-1)
        {
         Alert("Wystąpił błąd podczas zapisu pliku. Spróbuj ponownie!");
         return;
        }

      FileWrite(handle,"LP","Instrument","Spread","SWAP LONG","SWAP SHORT");

      for(i=0;i<dim_tab;i++)
        {

         mnoznik=1;

         for(j=0;j<dim_ticker;j++)
           {
            if(instrumenty[i]==t_ticker[j])
              {
               if(do_5==true) { mnoznik=10; }
               break;

              }
            else if(instrumenty[i]==t_ticker2[j])
              {
               if(do_5==true) { mnoznik=100; }
               break;

              }
            else
              {
               mnoznik=1;
              }
           }

         FileWrite(handle,i+1,instrumenty[i],tablica[i][0]/mnoznik,tablica[i][1]/mnoznik,tablica[i][2]/mnoznik);
         FileFlush(handle);

        }

      FileClose(handle);
      Alert("Plik  \"",file_name,"\"  został zapisany w folderze ",TerminalPath(),"\experts\files");
      Zapisac_do_pliku=false;

     }



//----
   return(0);
  }
//+------------------------------------------------------------------+
