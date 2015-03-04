Final Exam 2
========================================================
##CLUSTERING STOCK RETURNS

When building portfolios of stocks, investors seek to obtain good returns while limiting the variability in those returns over time. This can be achieved by selecting stocks that show different patterns of returns. In this problem, we will use clustering to identify clusters of stocks that have similar returns over time; an investor might select a diverse portfolio by selecting stocks from different clusters.

For this problem, we'll use nasdaq_returns.csv, which contains monthly stock returns from the NASDAQ stock exchange from 2000-2009, limiting to tickers that were listed on the exchange that entire period and whose stock price never fell below $1. The NASDAQ is the second-largest stock exchange in the world, and it lists many technology companies. The stock price data used in this problem was obtained from infochimps, a website providing access to many datasets, and the industry information was obtained from Yahoo! Finance. This dataset contains the following variables:

stock_symbol: The symbol identifying the company for the stock
industry: The industry the stock is classified under
subindustry: The sub-industry the stock is classified under
ret2000.01-ret2009.12: The return for the stock during the variable's indicated month. The variable names have format "retYYYY.MM", where YYYY is the year and MM is the month. For instance, variable ret2005.02 refers to February 2005. The value stored is a proportional change in stock value during that month. For instance, a value of 0.05 means the stock increased in value 5% during the month, while a value of -0.02 means the stock decreased in value 2% during the month. There are 120 of these variables, for the 120 months in our dataset.

###PROBLEM 1 - LOADING THE DATA  (1 point possible)
Load nasdaq_returns.csv into a data frame called "stocks". How many companies are in the dataset?

```r
stocks <- read.csv("nasdaq_returns.csv")
unique(stocks$stock_symbol)
```

```
##    [1] AAON  AAPL  ABAX  ABCB  ABFS  ABMD  ACAT  ACCL  ACET  ACGL  ACGY 
##   [12] ACIW  ACTL  ACXM  ADBE  ADCT  ADP   ADPI  ADPT  ADSK  ADTN  ADVS 
##   [23] AEIS  AEPI  AFAM  AFFX  AGYS  AHPI  AIPC  AIRM  AIRT  ALCO  ALKS 
##   [34] ALLB  ALNC  ALOG  ALOT  ALOY  ALSK  ALTR  ALXN  AMAC  AMAG  AMAT 
##   [45] AMCC  AMCS  AMED  AMGN  AMIC  AMKR  AMLN  AMNB  AMOT  AMPH  AMRB 
##   [56] AMRI  AMSC  AMSG  AMSWA AMTD  AMWD  AMZN  ANAD  ANAT  ANDE  ANEN 
##   [67] ANNB  ANSS  ANTP  APAGF APFC  APOG  APOL  APSG  ARBA  ARDNA ARKR 
##   [78] ARLP  ARMH  AROW  ARQL  ARRS  ARTC  ARTNA ARTW  ASBC  ASBI  ASCA 
##   [89] ASEI  ASFI  ASGN  ASGR  ASMI  ASML  ASRV  ASTE  ASYS  ATAC  ATAX 
##  [100] ATMI  ATNI  ATRI  ATRO  ATVI  ATX   AUBN  AVCT  AVID  AWRE  BAMM 
##  [111] BANF  BANR  BARI  BBBY  BBOX  BBSI  BCAR  BCPC  BCSB  BDGE  BEAV 
##  [122] BEBE  BELFB BEXP  BGCP  BIIB  BITS  BJRI  BKBK  BKSC  BKYF  BLUD 
##  [133] BMC   BMRC  BMRN  BMTC  BNCC  BNHN  BNHNA BOBE  BOCH  BOKF  BOLT 
##  [144] BOOT  BPFH  BPHX  BPOP  BRCD  BRCM  BRID  BRKL  BRKS  BRLI  BSMD 
##  [155] BSRR  BTFG  BTUI  BUSE  BWINB BYFC  CA    CAC   CACC  CACH  CADE 
##  [166] CAKE  CALM  CAMD  CARV  CASA  CASB  CASH  CASS  CASY  CATY  CBAN 
##  [177] CBIN  CBKN  CBRL  CBSH  CBST  CCBD  CCBG  CCBP  CCNE  CCRT  CDNS 
##  [188] CECE  CECO  CEDC  CELG  CENT  CENX  CEPH  CERN  CFBK  CFFC  CFFI 
##  [199] CFFN  CFK   CFNB  CFNL  CGNX  CHCO  CHDN  CHDX  CHFC  CHKE  CHKP 
##  [210] CHMP  CHNR  CHRW  CHSI  CHTT  CHUX  CIEN  CINF  CITZ  CIZN  CJBK 
##  [221] CLDA  CMCO  CMCSA CMCSK CMTL  CNAF  CNBC  CNBKA CNMD  COBZ  COCO 
##  [232] COHR  COHU  COKE  COLB  COLM  COMS  COST  CPBK  CPRT  CPTS  CPWR 
##  [243] CRA   CRAI  CRDN  CRED  CREE  CRESY CRMT  CRRB  CRRC  CRUS  CRVL 
##  [254] CRZO  CSBC  CSCO  CSGP  CSGS  CSPI  CSTR  CSWC  CTAS  CTBI  CTBK 
##  [265] CTEL  CTGX  CTSH  CTWS  CTXS  CUBA  CVBF  CVBK  CVLY  CVTI  CWBC 
##  [276] CWBS  CWCO  CWEI  CWTR  CY    CYBE  CYBX  CYMI  CZNC  DAKT  DASTY
##  [287] DAVE  DBLE  DBRN  DCOM  DECK  DELL  DEPO  DEST  DFZ   DGAS  DGICB
##  [298] DGII  DHFT  DINE  DIOD  DISH  DJCO  DLTR  DNBF  DNEX  DORM  DRAM 
##  [309] DRCO  DRIV  DSPG  DSWL  DTLK  DTPI  DUCK  DWSN  DYII  EBAY  ECBE 
##  [320] ECLP  ECOL  EDGW  EDUC  EEFT  EEI   EFII  EGBN  EGOV  ELMG  ELNK 
##  [331] ELON  ELRC  ELRN  ELSE  EMCI  EMITF ENER  ENZN  EPAY  EPIQ  ERIE 
##  [342] ERTS  ESBF  ESBK  ESGR  ESIO  ESLT  ESRX  EVBS  EWBC  EXAC  EXAR 
##  [353] EXBD  EXPD  EXPO  EXTR  EZCH  FARM  FARO  FAST  FBNC  FBSI  FBSS 
##  [364] FCAP  FCBC  FCEC  FCEL  FCFS  FCNCA FCZA  FDEF  FEIC  FEIM  FELE 
##  [375] FFBC  FFBH  FFCH  FFDF  FFEX  FFFD  FFHS  FFIC  FFIN  FFIV  FFKT 
##  [386] FFKY  FINL  FISI  FISV  FITB  FIZZ  FKFS  FLDR  FLEX  FLIC  FLIR 
##  [397] FLOW  FLXS  FMBI  FMER  FMFC  FNBN  FNDT  FNFG  FNLC  FORR  FORTY
##  [408] FOSL  FPFC  FPIC  FRBK  FRED  FRME  FSBI  FSBK  FSCI  FSRV  FSTR 
##  [419] FSYS  FTEK  FULT  FUNC  FUND  FWRD  FXEN  GABC  GAI   GAIA  GBCI 
##  [430] GCBC  GCOM  GENZ  GEOI  GERN  GFED  GIFI  GIII  GILD  GKSR  GLBL 
##  [441] GLBZ  GLDC  GMCR  GNCMA GNTX  GPOR  GRIF  GSBC  GSIC  GSLA  GTSI 
##  [452] GYMB  GYRO  HAIN  HANS  HARL  HAST  HBAN  HBHC  HCBK  HCKT  HCSG 
##  [463] HDNG  HELE  HEOP  HFBC  HFFC  HFWA  HGIC  HIBB  HIFS  HITK  HLIT 
##  [474] HMNF  HNBC  HOLX  HOTT  HRLY  HSIC  HSII  HTBK  HTCH  HTCO  HTLD 
##  [485] HTLF  HTRN  HUBG  HURC  HUVL  HWAY  HWBK  HWKN  IACI  IART  IBCA 
##  [496] IBKC  IBOC  ICCC  ICLR  ICTG  ICUI  IDCC  IDSA  IDSY  IDTI  IDXX 
##  [507] IFSB  IFSIA IGTE  IIJI  IIN   IIVI  IKNX  IMGN  IMKTA IMMR  INCB 
##  [518] INCY  INDB  INFA  INFY  ININ  INMD  INPH  INSU  INTC  INTG  INTU 
##  [529] INVE  IOSP  IPAR  IRET  ISCA  ISIS  ISLE  ISRL  ISSI  ISYS  ITIC 
##  [540] ITRI  IUSA  IVAC  IXYS  JACK  JAKK  JAVA  JAX   JAXB  JBHT  JBSS 
##  [551] JCDA  JCS   JCTCF JDAS  JDSU  JJSF  JKHY  JNPR  JOSB  JOUT  JST  
##  [562] JXSB  KAMN  KBALB KCLI  KELYA KENT  KEQU  KEYN  KFRC  KLAC  KLIC 
##  [573] KMGB  KNDL  KNSY  KOPN  KOSS  KRSL  KSWS  KTEC  KTII  KVHI  LABL 
##  [584] LACO  LAKE  LAMR  LANC  LARK  LAWS  LAYN  LBAI  LCRD  LCRY  LDSH 
##  [595] LECO  LFUS  LGND  LIFE  LIHR  LION  LKFN  LLTC  LMIA  LNBB  LNCE 
##  [606] LNCR  LNDC  LOGI  LOJN  LPNT  LRCX  LSBI  LSBX  LSCC  LSTR  LTRE 
##  [617] LUFK  LWAY  LYTS  MAGS  MANH  MARPS MAT   MATK  MATW  MAXY  MAYS 
##  [628] MBFI  MBTF  MBWM  MCBC  MCBI  MCHP  MCRI  MCRL  MCRS  MDCA  MDCI 
##  [639] MDRX  MEAS  MEDQ  MEDW  MENT  MEOH  METR  MFLR  MFRI  MFSF  MGAM 
##  [650] MGEE  MGRC  MIDD  MIND  MINI  MIPS  MITSY MKSI  MKTAY MLAB  MLHR 
##  [661] MMSI  MNRO  MNRTA MOCO  MOLX  MPB   MRCY  MRTI  MRTN  MSCC  MSEX 
##  [672] MSFG  MSFT  MSW   MTOX  MTRX  MTSC  MTXX  MU    MXIM  MXWL  MYGN 
##  [683] MYL   NABI  NADX  NAFC  NAII  NARA  NASB  NATH  NATI  NAVG  NBBC 
##  [694] NBIX  NBTB  NBTF  NDSN  NEOG  NEWP  NEXS  NHTB  NICE  NICK  NITE 
##  [705] NKSH  NKTR  NLCI  NMRX  NOBH  NOIZ  NOVB  NOVL  NPBC  NPSP  NRCI 
##  [716] NRIM  NSANY NSEC  NSFC  NSIT  NSYS  NTAP  NTCT  NTIC  NTRS  NTSC 
##  [727] NUHC  NUTR  NVDA  NVGN  NVLS  NWBI  NWFL  NWK   NWLI  NWPX  NWS  
##  [738] NWSA  NWSB  NYMX  OCFC  ODFL  OFIX  OICO  OKSB  ONFC  ONXX  OPOF 
##  [749] OPTC  ORBK  ORCL  ORLY  ORRF  OSBC  OSIP  OSIS  OSTE  OSUR  OTEX 
##  [760] OTTR  OUTD  OVBC  OYOG  OZRK  PAAS  PABK  PANL  PATR  PAYX  PBCI 
##  [771] PBCT  PBHC  PBNY  PCAR  PCBS  PCCC  PCLN  PCTI  PDCO  PDII  PDLI 
##  [782] PEBK  PEBO  PEGA  PENN  PENX  PERY  PETD  PETM  PFBI  PFBX  PFCB 
##  [793] PFED  PGC   PGNX  PHHM  PHII  PICO  PKOH  PLCE  PLCM  PLFE  PLUS 
##  [804] PLXS  PLXT  PMACA PMCS  PMD   PMFG  PMRY  PMTC  PNBC  PNBK  PNNW 
##  [815] PNRA  PNRG  POOL  POPE  POWI  POWL  PPDI  PRGO  PRGS  PRKR  PROV 
##  [826] PRSP  PRST  PRXL  PSEM  PSMT  PSSI  PTEC  PTEN  PTIX  PTNR  PTRY 
##  [837] PTSI  PULB  PVFC  PVSA  PVSW  PVTB  PWOD  PWX   PZZA  QADI  QCOM 
##  [848] QCRH  QDEL  QGEN  QLGC  QLTI  QQQQ  QSFT  QSII  QUIX  RADS  RAND 
##  [859] RAVN  RBCAA RBI   RBNF  RBPAA RCII  RCKY  RDEN  RDI   RDWR  REFR 
##  [870] REGN  REIS  RELL  RENT  REXI  REXMY RFIL  RGCO  RGEN  RGLD  RICK 
##  [881] RIMG  RIMM  RIVR  RLRN  RMBS  RMCF  RNST  RNWK  ROAC  ROCK  ROCM 
##  [892] ROME  ROST  ROVI  ROYL  RRD   RSCR  RSTI  RSYS  RTEC  RTLX  RUBO 
##  [903] RUSHB RVSB  RYAAY SAFM  SASR  SAVB  SBBX  SBCF  SBIB  SBSI  SBUX 
##  [914] SCBT  SCHL  SCHN  SCHS  SCHW  SCMM  SCMR  SCSC  SCVL  SEAC  SEIC 
##  [925] SENEA SENEB SERV  SFNC  SFST  SGC   SGMS  SHFL  SHLM  SHLO  SHOO 
##  [936] SHPGY SIAL  SIEB  SIGI  SIGM  SIMG  SIVB  SKIL  SKYW  SLGN  SMBC 
##  [947] SMHG  SMMF  SMMX  SMRT  SMSC  SMTB  SMTC  SMTL  SMTS  SNAK  SNBC 
##  [958] SNDK  SNHY  SNPS  SNSTA SNWL  SONC  SONE  SONO  SPAN  SPAR  SPEC 
##  [969] SPIR  SPLS  SPNC  SRCE  SRCL  SRDX  SRSL  SSRI  SSTI  SSYS  STBA 
##  [980] STBC  STEI  STEL  STFC  STLD  STLY  STMP  STNR  STRA  STRS  STRT 
##  [991] STRZ  SUBK  SUPG  SUPR  SUPX  SURW  SUSQ  SVNT  SWKS  SWWC  SYBT 
## [1002] SYKE  SYMC  SYMM  SYMS  SYNL  SYNO  SYNT  TACT  TATT  TATTF TAXI 
## [1013] TAYD  TBAC  TCBK  TCHC  TCLP  TDSC  TEAM  TECD  TECH  TECUA TELOZ
## [1024] TESO  TESS  TEVA  TFCO  THFF  THOR  THQI  THRD  TIBX  TIER  TINY 
## [1035] TISI  TIVO  TKLC  TLAB  TLGD  TO    TOBC  TQNT  TRCI  TRGL  TRID 
## [1046] TRMB  TRMK  TROW  TRST  TRUE  TSBK  TSCO  TSRI  TSTY  TTEC  TTEK 
## [1057] TTWO  TWIN  UBCP  UBFO  UBSH  UBSI  UEIC  UFCS  UFPI  UG    UHAL 
## [1068] ULBI  ULTI  UMBF  UMPQ  UNAM  UNFI  UNTY  URBN  USAK  USAP  USBI 
## [1079] USEG  USLM  USNA  USPH  USTR  UTEK  UTHR  UVSP  UWBK  VALU  VARI 
## [1090] VBFC  VCBI  VECO  VICL  VICR  VIDE  VIRC  VIST  VIVO  VLCCF VLGEA
## [1101] VOD   VOXX  VRSN  VRTX  VSAT  VSEA  VSEC  VTAL  VTNC  VVUS  WABC 
## [1112] WACLY WAIN  WASH  WAYN  WBCO  WCBO  WDFC  WEDC  WERN  WEYS  WFMI 
## [1123] WFSL  WGOV  WIBC  WINA  WIRE  WLFC  WMAR  WPPGY WRLD  WRLS  WSB  
## [1134] WSBC  WSFS  WSII  WSTG  WTFC  WTNY  WVFC  WVVI  WWVY  XATA  XLNX 
## [1145] XRAY  XRIT  YAVY  YDNT  YHOO  YORW  ZBRA  ZEUS  ZIGO  ZION  ZOLL 
## [1156] ZOLT  ZRAN  ZRBA 
## 1158 Levels: AAON AAPL ABAX ABCB ABFS ABMD ACAT ACCL ACET ACGL ACGY ... ZRBA
```


###PROBLEM 2 - SUMMARIZING THE DATA  (1 point possible)
For which industries are there 40 or more companies in our dataset?

```r
which(table(stocks$industry) >= 40)
```

```
##  Basic Materials   Consumer Goods        Financial       Healthcare 
##                1                4                5                6 
## Industrial Goods         Services       Technology 
##                7                8                9
```


###PROBLEM 3 - STOCK TRENDS IN THE DATA  (2 points possible)
In the aftermath of the dot-com bubble bursting in the early 2000s, the NASDAQ was quite tumultuous. In December 2000, how many stocks in our dataset saw their value increase by 10% or more?

```r
sum(stocks$ret2000.12 >= 0.1)
```

```
## [1] 309
```


In December 2000, how many stocks in our dataset saw their value decrease by 10% or more?

```r
sum(stocks$ret2000.12 <= -0.1)
```

```
## [1] 261
```


###PROBLEM 4 - STOCK TRENDS IN THE DATA  (2 points possible)
Entering the Great Recession most stocks lost significant value, but some sectors were hit harder than others. In October 2008, which of the following industries had the worst average return across the stocks in that industry?

```r
library(plyr)
averagePerIndustry2008.10 <- ddply(stocks, .(industry), summarise, average = mean(ret2008.10))
averagePerIndustry2008.10
```

```
##             industry average
## 1    Basic Materials -0.2547
## 2      Conglomerates -0.2657
## 3  Consumer Cyclical -0.1457
## 4     Consumer Goods -0.1552
## 5          Financial -0.1029
## 6         Healthcare -0.1694
## 7   Industrial Goods -0.2334
## 8           Services -0.1738
## 9         Technology -0.1963
## 10         Utilities -0.1201
```

```r
tapply(stocks$ret2008.10, stocks$industry, mean)
```

```
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##           -0.2547           -0.2657           -0.1457           -0.1552 
##         Financial        Healthcare  Industrial Goods          Services 
##           -0.1029           -0.1694           -0.2334           -0.1738 
##        Technology         Utilities 
##           -0.1963           -0.1201
```


February 2000 was the third strongest month in the dataset in terms of average returns. However, which of the following industries actually had a negative average return during that month?

```r
averagePerIndustry2000.02 <- ddply(stocks, .(industry), summarise, average = mean(ret2000.02))
averagePerIndustry2000.02
```

```
##             industry   average
## 1    Basic Materials  0.006955
## 2      Conglomerates -0.071627
## 3  Consumer Cyclical -0.124615
## 4     Consumer Goods  0.003679
## 5          Financial -0.024671
## 6         Healthcare  0.437414
## 7   Industrial Goods  0.110981
## 8           Services  0.036294
## 9         Technology  0.298034
## 10         Utilities  0.004375
```

```r
tapply(stocks$ret2000.02, stocks$industry, mean)
```

```
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##          0.006955         -0.071627         -0.124615          0.003679 
##         Financial        Healthcare  Industrial Goods          Services 
##         -0.024671          0.437414          0.110981          0.036294 
##        Technology         Utilities 
##          0.298034          0.004375
```


###PROBLEM 5 - PREPARING THE DATASET  (2 points possible)
Copy the stocks data frame into a new data frame called "limited", and remove the first three variables of limited: stock_symbol, industry, and subindustry.

```r
limited <- stocks[, 4:ncol(stocks)]
```


Now, identify the month with the largest average return across all stocks in the dataset. What is the variable name associated with this month (for instance, if your answer were February 2004, you would answer ret2004.02)?

```r
which.max(colSums(limited)/nrow(limited))
```

```
## ret2009.04 
##        112
```


Identify the month with the lowest average return across all the stocks in the dataset. What is the variable name associated with this month?

```r
which.min(colSums(limited)/nrow(limited))
```

```
## ret2008.10 
##        106
```


###PROBLEM 6 - PREPARING FOR CLUSTERING  (1 point possible)
We are about to cluster our data. Why did we remove the stock_symbol, industry, and subindustry variables prior to clustering our data?

ANS If we had included these variables in our clustering analysis, they would have caused an error.

Because these are text variables, they would have caused an error when clustering

###PROBLEM 7 - NORMALIZING  (1 point possible)
In this analysis, we will not normalize our data prior to clustering. Why is this a valid approach?

ANS All the variables have the same scale, so no normalization is necessary 

###PROBLEM 8 - HIERARCHICAL CLUSTERING  (1 point possible)
Using Euclidean distances (the default) and the Ward method, perform hierarchical clustering on the "limited" data frame, and plot the resulting dendrogram.

```r
distance = dist(limited, method = "euclidean")
HClust = hclust(distance, method = "ward")
```

```
## The "ward" method has been renamed to "ward.D"; note new "ward.D2"
```

```r
plot(HClust)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


Which of the following number of clusters is least appropriate, based on the dendrogram?

answered 4
   
###PROBLEM 9 - THE HIERARCHICAL CLUSTERS  (1 point possible)
Extract cluster assignments from your hierarchical clustering object, using 5 clusters in total. Which cluster has the largest number of stocks?

```r
HGroups = cutree(HClust, k = 5)
table(HGroups)
```

```
## HGroups
##   1   2   3   4   5 
## 257 243 577  67  14
```


###PROBLEM 10 - UNDERSTANDING THE CLUSTERS  (2 points possible)
Which cluster best fits the description "healthcare and technology stocks"?

```r
HCluster1 = subset(stocks, HGroups == 1)
HCluster2 = subset(stocks, HGroups == 2)
HCluster3 = subset(stocks, HGroups == 3)
HCluster4 = subset(stocks, HGroups == 4)
HCluster5 = subset(stocks, HGroups == 5)
table(HCluster1$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                27                 0                 0                31 
##         Financial        Healthcare  Industrial Goods          Services 
##                19                40                30                55 
##        Technology         Utilities 
##                55                 0
```

```r
table(HCluster2$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                 4                 0                 0                 2 
##         Financial        Healthcare  Industrial Goods          Services 
##                13                17                 9                31 
##        Technology         Utilities 
##               166                 1
```

```r
table(HCluster3$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                17                 2                 2                47 
##         Financial        Healthcare  Industrial Goods          Services 
##               306                25                22               110 
##        Technology         Utilities 
##                35                11
```

```r
table(HCluster4$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                 0                 0                 0                 0 
##         Financial        Healthcare  Industrial Goods          Services 
##                 0                28                 1                 4 
##        Technology         Utilities 
##                34                 0
```

```r
table(HCluster5$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                 2                 0                 0                 0 
##         Financial        Healthcare  Industrial Goods          Services 
##                 0                 1                 3                 2 
##        Technology         Utilities 
##                 6                 0
```

```r
table(stocks$industry)
```

```
## 
##   Basic Materials     Conglomerates Consumer Cyclical    Consumer Goods 
##                50                 2                 2                80 
##         Financial        Healthcare  Industrial Goods          Services 
##               338               111                65               202 
##        Technology         Utilities 
##               296                12
```

ANS Cluster4

Which of the following industries have more than half of their stocks assigned to a single cluster?
ANS Basic Materials, Consumer Goods ,Financial , Services ,Technology 

###PROBLEM 11 - SUB-INDUSTRIES  (2 points possible)
We can get a finer-grained understanding of the composition of the clusters by looking at subindustry information. Which cluster contains nearly all companies categorized in the subindustry "Apparel Stores" (part of the services industry)?

```r
sum(stocks$subindustry == "Apparel Stores")
```

```
## [1] 14
```

```r
sum(HCluster5$subindustry == "Apparel Stores")
```

```
## [1] 0
```

```r
sum(HCluster4$subindustry == "Apparel Stores")
```

```
## [1] 0
```

```r
sum(HCluster3$subindustry == "Apparel Stores")
```

```
## [1] 12
```

```r
sum(HCluster2$subindustry == "Apparel Stores")
```

```
## [1] 1
```

```r
sum(HCluster1$subindustry == "Apparel Stores")
```

```
## [1] 1
```


ANS Cluster3
Which cluster contains all stocks categorized in sub-industry "Electronics Wholesale" (another part of the services industry)?

```r
sum(stocks$subindustry == "Electronics Wholesale")
```

```
## [1] 5
```

```r
sum(HCluster5$subindustry == "Electronics Wholesale")
```

```
## [1] 0
```

```r
sum(HCluster4$subindustry == "Electronics Wholesale")
```

```
## [1] 0
```

```r
sum(HCluster3$subindustry == "Electronics Wholesale")
```

```
## [1] 0
```

```r
sum(HCluster2$subindustry == "Electronics Wholesale")
```

```
## [1] 5
```

```r
sum(HCluster1$subindustry == "Electronics Wholesale")
```

```
## [1] 0
```


###PROBLEM 12 - STOCK TRENDS IN THE CLUSTERS  (2 points possible)
For some months, we expect there to be significant differences between the returns of stocks in different clusters. In February 2000, the average return of stocks in Cluster 3 was negative, while the average return of stocks in one of the other clusters was more than 100%. What cluster had the average return exceeding 100%?

```r
mean(HCluster1$ret2000.02)
```

```
## [1] 0.06117
```

```r
mean(HCluster2$ret2000.02)
```

```
## [1] 0.2425
```

```r
mean(HCluster3$ret2000.02)
```

```
## [1] -0.02244
```

```r
mean(HCluster4$ret2000.02)
```

```
## [1] 1.18
```

```r
mean(HCluster5$ret2000.02)
```

```
## [1] 0.1826
```


ANS Cluster 4 
For which of the following months did one cluster have an average return exceeding 30% and another cluster have a negative average return?
March 2000 May 2005 October 2009 December 2009


```r
c(mean(HCluster1$ret2000.03), mean(HCluster2$ret2000.03), mean(HCluster3$ret2000.03), 
    mean(HCluster4$ret2000.03), mean(HCluster5$ret2000.03))
```

```
## [1] -0.009457 -0.069108  0.016467 -0.303064  0.445977
```

```r
c(mean(HCluster1$ret2005.05), mean(HCluster2$ret2005.05), mean(HCluster3$ret2005.05), 
    mean(HCluster4$ret2005.05), mean(HCluster5$ret2005.05))
```

```
## [1] 0.04840 0.07537 0.03412 0.09700 0.57596
```

```r
c(mean(HCluster1$ret2009.10), mean(HCluster2$ret2009.10), mean(HCluster3$ret2009.10), 
    mean(HCluster4$ret2009.10), mean(HCluster5$ret2009.10))
```

```
## [1] -0.04910 -0.06546 -0.05096 -0.05784 -0.05550
```

```r
c(mean(HCluster1$ret2009.12), mean(HCluster2$ret2009.12), mean(HCluster3$ret2009.12), 
    mean(HCluster4$ret2009.12), mean(HCluster5$ret2009.12))
```

```
## [1] 0.06330 0.08125 0.04078 0.09281 0.54678
```


ANS March 2000

###PROBLEM 13 - USING A VISUALIZATION  (1 point possible)
Which of the following visualizations could be used to observe the distribution of stock returns in February 2000, broken down by cluster? Select all that apply.

ANS: A box plot of the variable ret2000.02, subdivided by cluster and ggplot with ret2000.02 on the x-axis and the cluster number on the y-axis, plotting with geom_point()


```r
par(mfcol = c(1, 5))
boxplot(HCluster1$ret2000.02)
boxplot(HCluster2$ret2000.02)
boxplot(HCluster3$ret2000.02)
boxplot(HCluster4$ret2000.02)
boxplot(HCluster5$ret2000.02)
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 



```r
library(ggplot2)
```


###PROBLEM 14 - K-MEANS CLUSTERING  (1 point possible)
Now set the seed to 144 and immediately afterward run k-means clustering on the "limited" data frame, using 5 clusters. How many stocks are in the smallest cluster?

```r
k = 5
set.seed(144)
KMC = kmeans(limited, centers = k)
table(KMC$cluster)
```

```
## 
##   1   2   3   4   5 
## 323 532 107 143  53
```


###PROBLEM 15 - COMPARING CLUSTERING ALGORITHMS  (1 point possible)
k-means cluster number 4 contains more than half of its members from which hierarchical cluster?

```r
KMCluster1 <- subset(stocks, KMC$cluster == 1)
KMCluster2 <- subset(stocks, KMC$cluster == 2)
KMCluster3 <- subset(stocks, KMC$cluster == 3)
KMCluster4 <- subset(stocks, KMC$cluster == 4)
KMCluster5 <- subset(stocks, KMC$cluster == 5)
sum(KMCluster4$stock_symbol %in% HCluster1$stock_symbol)/nrow(KMCluster4)
```

```
## [1] 0.06294
```

```r
sum(KMCluster4$stock_symbol %in% HCluster2$stock_symbol)/nrow(KMCluster4)
```

```
## [1] 0.7832
```

```r
sum(KMCluster4$stock_symbol %in% HCluster3$stock_symbol)/nrow(KMCluster4)
```

```
## [1] 0
```

```r
sum(KMCluster4$stock_symbol %in% HCluster4$stock_symbol)/nrow(KMCluster4)
```

```
## [1] 0.1189
```

```r
sum(KMCluster4$stock_symbol %in% HCluster5$stock_symbol)/nrow(KMCluster4)
```

```
## [1] 0.03497
```


ANS Hierarchical Cluster 

###PROBLEM 16 - RANDOM BEHAVIOR  (2 points possible)
If we re-ran hierarchical clustering a second time without making any additional calls to set.seed(), would we expect:

ANS Identical results to the first hierarchical clustering

If we re-ran k-means clustering a second time without making any additional calls to set.seed(), would we expect:

Different results from the first k-means clustering

###PROBLEM 17 - CREATING A DIVERSE PORTFOLIO  (1 point possible)
In the introduction to the problem, we discussed the value of a diverse portfolio and how we might achieve this objective by selecting stocks from different clusters. Consider an investor with a large holding of stock from the company with stock_symbol AAPL. Which of the following stock symbols is neither in the same hierarchical cluster nor in the same k-means cluster as AAPL?

```r
sum(HCluster2$stock_symbol == "AAPL")
```

```
## [1] 1
```

```r
sum(KMCluster3$stock_symbol == "AAPL")
```

```
## [1] 1
```

```r
# in HCluster 2 KMCluster 3
```



```r
sum(HCluster2$stock_symbol == "AMZN")
```

```
## [1] 1
```

```r
sum(KMCluster4$stock_symbol == "AMZN")
```

```
## [1] 1
```

```r
# in HCluster 2 KMCluster 4
```



```r
sum(HCluster3$stock_symbol == "MSFT")
```

```
## [1] 1
```

```r
sum(KMCluster3$stock_symbol == "MSFT")
```

```
## [1] 1
```

```r
# in HCluster 3 KMCluster 3
```



```r
sum(HCluster3$stock_symbol == "TROW")
```

```
## [1] 1
```

```r
sum(KMCluster1$stock_symbol == "TROW")
```

```
## [1] 1
```

```r
# in HCluster 3 KMCluster 1
```

