{$I start.inc}

unit kom2;

interface

uses
   komint,
   classes,
   math,
//   types,
   winm,

{$IFDEF WIN32}
//  windows,
 {$ELSE}
  {$ENDIF}

  kom3,
  wpr2,
  wpDate,
  sysutils,
  wpString;
type
  tObjectTuple=record
      s : ansiString;
  end;
  tJObject=record
     s:ansiString;
  end;

function kropki(const x:double;const y: integer):string;
function kropki0(x:double;y: integer):string;
function kropki2(x:double;y: integer):string;
function kropki3(x:double;y: integer;tt : boolean):string;
function kropkiStrona(x:double;y: integer;tt : boolean):string;
function kropki4Excel(x:double;y: integer;tt : boolean):ansistring;
function kropkiKolor(x:double;y: integer;tt : boolean):string;
function kropkiWNMA(x:double;y: integer):string;
function kropkiZ(x:double;y: integer):string;
function kropkiWSP(x:double;y: integer):string;
function kratka(ss:string;y:integer):string;
function kraC(ss:string;y:integer):string;
function kropkiColor(dd : double;ll : integer;astrona : boolean):string;


function okrInz(dd : double;decimals : integer):double;
function lC( ll :comp;dd : longint):string;{longint form}
function formSG(ll : integer;dd : integer):string;overload;
function formSG(ll : single;dd : integer):string;overload;
function formSG(ll : double):string;overload;
function formSG(ll : double;dd : integer):string;overload;
function formSGInz(ll : double;dd,Decimals : integer):string;overload;
function formSGZ(ll : single;dd : word):string;overload;
function formSGZ(ll : double;dd : word):string;overload;
function formSGA(ll : double):string;
function formSGD(ll : double;dd : word):string;
function formSGS(ll : single;dd : integer):shortstring;
//function formSGIlosc(ll : single;dd : word):string;overload;
function formSGCena(ll : single;dd : integer):string;overload;
function formSGCena(ll : double;dd : integer):string;overload;
function formKurs(ll : double;dd : integer):ansistring;
function form2D(ll : double;dd : word):string;
function formGodzin(ll : double; dd : integer):ansistring;
//function dbl2str(ll : double):string;
//function str2dbl(ss : string):double;

function linia(typ,pi,il,sz:word):string;
function zlotyI(akk:double;ch:char;szer : integer;const aslo : string):ansistring;
function zlotyII(kk:double;ch:char;szer : integer):string;
function zlotyIII(kk:double;ch:char;szer : integer):string;
//function dolar(kk:double;szer,ln : word;wal:string):string;
//function marka(kk:double;szer,ln : word;wal:string):string;
function zlotyV(kk:double;szer,ln : word;const wal:string):ansistring;
function slownieV(kk:double;szer,ln : word;const wal:string;ajezyk : word):ansistring;
//function maxword (a,b : word):word;
function memavail:longint;

procedure konQuote(var sss : string);
procedure kon852(var sss : string);
function  kon852Win(const sss : ansistring):ansistring;
procedure kon852LL(var sss : string);
procedure kon852GTKA(var sss : ansistring);
procedure kon852GTK(var sss : string);
procedure konLat8859(var sss : string);
procedure kon8859l2(var sss : string);overload;
procedure kon8859l2(var sss : ansistring);overload;
procedure konLat8859A(var sss : ansistring);
procedure konWinGtk(var sss : string);
procedure konWInUtfBB(var sss : string);
procedure konUtfWin(var sss : string);
function  komUtfWinA(const sss : utf8string):ansistring;
function  komUtf852A(const sss : utf8string):ansiString;
procedure konWinGtkA(var sss : ansistring);
procedure konWInUtfA(var sss : ansistring);
function  komWinUtf(const sss:ansiString):utf8string;
procedure konGtkWin(var sss : string);
procedure konGtkWinA(var sss : ansistring);
procedure konbrak(var sss : string);
function  komBrak(sss : ansiString):ansiString;
procedure konWin(var sss : string);{winl2A}
procedure konMazL2(var sss : string);
procedure kon852Maz(var sss : string);overload;
procedure kon852Maz(var sss : ansistring);overload;
procedure oldkon1250(var sss : string);
procedure konWinL2A(var sss : ansistring);
procedure kon852A(var sss : ansistring);
function  kom852UTF(sss : ansiString):utf8String;
function  komWinL2A(const sss : ansistring):ansiString;

//function konFromUCI(const ss : ansistring):ansiString;


procedure komCode( var s : string);overload;
procedure komCode( var s : ansistring);overload;
procedure komCodeWin( var s : string);overload;
procedure komCodeWin( var s : ansistring);overload;
function  konCodeUTF(  s : utf8string):ansiString;
procedure komCodeINV( var s : string);overload;
procedure komCodeINV( var s : ansistring);overload;

procedure pominPHPA(var sss : ansistring);
function tyt(i: integer;ss : string):string;

function binToDec( aStr:Ansistring):ansiString;
function binToHex(const aStr:Ansistring):ansiString;
function HexToBin(const aStr:Ansistring):ansiString;


function jx(const sa,sb : javastring):tObjectTuple;overload;
function jx(const sa : javastring;const sb: tJObject):tObjectTuple;overload;
function jx(const sa : javastring;sb: double):tObjectTuple;overload;
function jObject(values : array of tObjectTuple):tJObject;overload;
function jObject(const value : tObjectTuple):tJObject;overload;
function jObject(const sa : ansiString):tJObject;overload;
function jObject( a : double):tJObject;overload;

function jArray(values : array of tJObject):ansiString;overload;
function jArray(values : ansistring ;ch:char):tJObject;overload;
function px(const sa,sb : ansistring;removeempty:boolean=false):utf8String;overload;
function px(const sa : ansistring;sb : double;removeempty:boolean=false):utf8String;overload;
function px(const sa : ansistring;sb : tData;removeempty:boolean=false):utf8String;overload;
function px(const sa : ansistring;const sb : int64;removeempty:boolean=false):utf8String;overload;
function pxcd(const sa,sb : ansistring):ansiString;
function pxutf(const sa,sb : ansistring;removeempty:boolean=false):ansiString;
function pxu(const sa,sb : ansistring;removeempty:boolean=false):utf8String;
function py(const sa,sb : ansistring):ansiString;
function pz(const sa,sc,sb : ansistring):ansiString;
//function pxc(sa,sb : ansistring):ansiString;
function pyc(sa,sb : ansistring):ansiString;
function pzc(sa,sc,sb : ansistring):ansiString;
function nipXML(ss : string):ansistring;
function cleanxml(const ss : ansistring):ansiString;
function czyscTytulExcel( ss : string):ansistring;
function czyscTXT(ss : ansiString):ansiString;
function XMLwytnij(const sm1: utf8string ;var sm2,shh : utf8String;usun : boolean;jcc : integer=0):utf8string;
function XMLwytnijSH(const sm1: ansistring ;var sm2,shh : ansiString;usun : boolean;jcc : integer=0):ansiString;overload;
function XMLwytnijSH(const sm1: utf8string ;var sm2,shh : utf8String;usun : boolean;jcc : integer=0):utf8String;overload;
function XMLwytnijS(const sm1: ansistring ;var sm2 : ansiString;usun : boolean;jcc : integer=0):ansiString;overload;
function XMLwytnijS(const sm1: utf8string ;var sm2 : utf8String;usun : boolean;jcc : integer=0):utf8String;overload;
procedure XMLinsertS(sm1: string ;const smIn: ansiString;var smout : ansiString);
function XMLwytnijHeader(sm1 : string;var sm2 : utf8String;usun:boolean;jcc : integer=0):utf8String;
function xmlwytnijDbl(sm1: string ;var sm2 : utf8String;us : boolean):double;
function xmlwytnijData(sm1: string ;var sm2 : utf8String;us : boolean):tData;
function xmlwytnijInt(sm1: string ;var sm2 : ansiString;us : boolean):int64;overload;
function xmlwytnijInt(sm1: string ;var sm2 : utf8String;us : boolean):int64;overload;
function wytnijNickAllegro(sm1:string;out sm2 : string):boolean;
function wytnijNrDokumentu(const sm : string):int64;
function testEan(const kod : ansistring):Boolean;

function toJest(const sm1 : ansistring):integer;
function isEmail(const sm1 : ansistring):boolean;
function isPostCode(const s : ansiString):boolean;
function extractCity(var s : ansistring):ansistring;
function extractPostCode(var s : ansistring):ansistring;





function jednakoweNazwisko(sa,sb : string):boolean;
function jednakowyNip(const sa,sb : string):boolean;
function liniawklej(const aramka:string;sa : string):string;


function czytajString(const fname : filestring):rawString;overload;
function czytajString(const aStream : tStream):rawString;overload;
function zapiszString(const sn : ansiString;const fname : filestring):boolean;
procedure streamToFile(const sn : tStream;const fname : filestring);
procedure kopiujPlik(const sa,sb : filestring);

function bufToAnsi(const buf ;len : integer):ansiString;
function bufToUtf8(const buf ;len : integer):utf8String;
procedure AnsiToBuf(s : ansiString;var buf ;len : integer);
//function dajLinie(var sca : ansiString):ansiString;
function wytnijStringcss(var sca : ansiString;spocz,skon : ansiString):ansiString;


function napisBox(ww : integer;const ss : ansistring):ansistring;
function napisBoxUtf(ww : integer;const ss : ansistring):utf8string;
function sortedBox(const ss : ansiString):ansistring;
function pozycjaBox(const aw : string;const ss : ansistring):integer;
function lengthBox(const ss : ansistring):integer;
function napisPOP(ww : integer;const ss : ansistring):ansistring;
function napisPopWin(ww : integer;const ss : ansistring):ansistring;
function napisPopUTF(ww : integer;const ss : ansistring):utf8string;
function napisBoxWin(ww : integer;const ss : ansistring):ansistring;
function dataKolor(aD1,ad2 : integer):string;
function pickKolor(ap : integer):string;
function rowKolor(ak : word):string;

function skrocFisk(const sa : string):string;
function validateStyleString(const sa : AnsiString):AnsiString;
function validateScriptString(const sa : AnsiString):AnsiString;

function testUtfString:utf8String;
{
function kolorString(acolor : tColor):string;
}




var
  nZloty          : array[0..55] of string[20] =(
       'dziesi©Ü ','jedenaòcie ','dwanaòcie ','trzynaòcie ','czternaòcie ','pietnaòcie ',
       'szesnaòcie ','siedemnaòcie ','osiemnaòcie ','dziewi©tnaòcie ',
       '','jeden ','dwa ','trzy ','cztery ','pi©Ü ',
       'szeòÜ ','siedem ','osiem ','dziewi©Ü ',
       '','','dwadzieòcia ','trzydzieòci ','czterdzieòci ','pi©Üdziesi•t ',
       'szeòÜdziesi•t ','siedemdziesi•t ','osiemdziesi•t ','dziewi©Üdziesi•t ',
       '', 'sto ','dwieòcie ','trzysta ','czterysta ','pi©Üset ',
       'szeòÜset ','siedemset ','osiemset ','dziewi©Üset ',
       'zàotych ','zàote ','grosz','grosze','groszy',
       'tysi•c ','tysi•ce ','tysi©cy ','milion ','miliony ','milion¢w ',
       'miliard ','miliardy ','miliard¢w ',' sàownie: ','≥');
  nDolar          : array[0..36] of string[13] =(
       'ten ','eleven ','twelve ','thirteen   ','fourteen ','fifteen ',
       'sixteen ','seventeen ','eighteen ','nineteen ',
       '','one ','two ','three ','four ','five ',
       'six ','seven ','eight ','nine ',
       '','','twenty ','thirty ','forty ','fifty ',
       'sixty ','seventy ','eighty ','ninety ',
       '', 'hundred ',
       'thousand ','milion ',
       'bilion ',' say: ','|');
  nMarka          : array[0..36] of string[13] =(
       'zehn','elf','zwîlf','dreizehn','vierzehn','fÅnfzehn',
       'sechzehn','siebzehn','achtzehn','neunzehn',
       '','eins','zwei','drei','vier','fÅnf',
       'sechs','sieben','acht','neun',
       '','','zwanzig','drei·ig','vierzig','fÅnfzig',
       'sechzig','siebzig','achtzig','neunzig',
       '', 'hundert',
       'tausend',' Million ',
       ' Milliarde ',' In Worten: ','|');

const
  toJestNip = 1;
  toJestTelefon = 2;
  toJestFax = 3;
  toJestEmail = 4;


const
  pkpusty = 0;
  pkSzary = 1;
  pkBold  = 2;
  pkBraz  = 3;
  pkCzerwony =4;
  pkNiebieski=5;
  pkZielony  =6;
  pkFiolet   = 7;
  pkLampka = 10;
  pkSkreslony = 11;
  pkWykrzyknik = 12;
  pkItalic     = 13;
  pkDos        = 14;
  pkDosZamow   = 15;
  pkSprz       = 16;
  pkSprzZamow  = 17;
  pkPracow     = 18;
  pkOddzial    = 19;
  pkTermin     = 21;
  pkPoTerminie = 22;
  pkzalacznik  = 23;
  pkUsluga     = 24;
  pkDosButik   = 25;
  pkSprzButik  = 26;

  pkAutomatycznie = 27;
  pknieprawidlowy = 28;
  pkZamkniety     = 29;
  pkZaznaczony    = 30;
  pkWazne         = 31;
  pkRozlicz       = 32;
  pkCheck         = 33;
  pkWstecz        = 34;
  pkWidziany      = 35;
  pkDoPodpisu     = 36;
  pkProdZamow     = 37;
  pkProdSZamow    = 38;
  pkZadanie       = 39;
  pkKlodka        = 40;
  pkwyslany       = 41;
  pkewyslany      = 42;
  pkpotwierdzony  = 43;
  pkTeal          = 44;
  pkAnulowany     = 45;
  pkKorekta       = 46;
  pkMailIn        = 47;
  pkMailOut       = 48;
  pkTime          = 49;
  pkTimeTermin    = 50;
  pkSublist       = 51;
  pkRestBlack     = 52;
  pkRestRed       = 53;
  pkOK            = 54;
  pkNotOk         = 55;
  pkEye           = 56;

//  pkKlodkaOtw     = 46;


implementation

const commaChar =',';

function krp(x:double;ch : char):string;
var
  i : integer;
  kr  : string[50];

begin

//  if denominacja then begin
    {x:=okrg(x);}
 {$IFDEF FPC}
   {
    if x=0 then begin
      result:='          ';
      exit;
    end;
    }
 {$ELSE FPC}
    if  ((PInt64(@x)^ and $7FF0000000000000)  = $7FF0000000000000)     then begin
      result:='          ';
      exit;
    end;
 {$ENDIF FPC}

    if x>=0 then x:=x+0.00005
            else x:=x-0.00005;
    try
      str(x:20:2,kr);i:=length(kr);
    except
      kr:='         ';
      i:=1;
    end;
    kr[18]:=',';
    if (x>999.991) or (x<-999.991) then insert(ch,kr,i-5);
    if (x>999999.9)or(x<-999999.9) then insert(ch,kr,i-8);
    if (x>999999999.9)or(x<-999999999.9) then insert(ch,kr,i-11);
    kr:=trimLead(kr);
    {
  end else begin
    str(x:0:0,kr);i:=length(kr);
    if (x>999) or (x<-999) then insert(ch,kr,i-2);
    if (x>999999)or(x<-999999) then insert(ch,kr,i-5);
    if (x>999999999)or(x<-999999999) then insert(ch,kr,i-8);
  end;
  }
  krp:=kr;
end;



function krp4(x:double;ch : char):string;
var
  i : integer;
  kr  : string;

begin

    {x:=okrg(x);}
 {$IFDEF FPC}
   {
    if x=0 then begin
      result:='          ';
      exit;
    end;
    }
 {$ELSE FPC}
    if  ((PInt64(@x)^ and $7FF0000000000000)  = $7FF0000000000000)     then begin
      result:='          ';
      exit;
    end;
 {$ENDIF FPC}

    if x>=0 then x:=x+0.00005
            else x:=x-0.00005;
    try
      str(x:20:4,kr);i:=length(kr);
    except
      kr:='         ';
      i:=1;
    end;
    kr[16]:=',';
    if ch<>#0 then begin
    if (x>999.991) or (x<-999.991) then insert(ch,kr,i-7);
    if (x>999999.9)or(x<-999999.9) then insert(ch,kr,i-10);
    if (x>999999999.9)or(x<-999999999.9) then insert(ch,kr,i-13);
    end;
    result:=trimLead(kr);
end;


function kropki2;
var
  kr : string[50];
begin
  if abs(x)<0.002 then kr:='---'
           else kr:=krp(x,' ');

 kropki2:=leftPad(kr,y);
end;
{
function kropkiEX;
var
  kr : string[50];
begin
  str(x:20:2,kr);
  kr[18]:=',';
  result:=kr;
end;
}
function kropkiZ;
var
  i : integer;
  kr  : string[50];

begin
  str(x:0:0,kr);i:=length(kr);
    if (x>999.991) or (x<-999.991) then insert('.',kr,i-2);
    if (x>999999.9)or(x<-999999.9) then insert('.',kr,i-5);
    if (x>999999999.9)or(x<-999999999.9) then insert('.',kr,i-8);
  result:=leftPad(kr,y);
end;

function kropki3;
begin
  if (x>=0 ) and tt then kropki3:=kropki2(x,y)
  else if (x<0) and not tt then kropki3:=kropki2(-x,y)
                   else kropki3:=leftpad('--- ',y);
end;
function kropkiStrona;
begin
  if  tt then result:=kropki2(x,y)
  else result:=leftpad('--- ',y);
end;
function kropkiKolor;
begin
  result:=kropki2(x,y);
  if not tt then result:=charBmp+#212+result;
end;
function kropki4Excel;
begin
  if  tt then result:=krp(x,#0)
  else result:='';
end;
function kropkiWNMA;
begin
   if x> 0 then result:='WN^'+kropki(x,y-3)
           else result:='MA^'+kropki(-x,y-3);
end;


function kropki(const x:double;const y: integer):string;
var
  kr : string;
begin
{  try
    writeln('kropia ',x+1);
  except
     on e : exception do begin
       writeln(e.className+e.message);
       result:=leftpad('&&&&',y);
       exit;
     end;
  end;}

     if isNan(x) then begin
//      writeln('kropki NAN');
      result:=leftpad('&&&&',y);
      exit;

    end;

  
 {$IFDEF FPC}

    if (x=0)  then begin
      result:=charstr(' ',y);
      exit;
    end;
 {$ELSE FPC}

    if  ((PInt64(@x)^ and $7FF0000000000000)  = $7FF0000000000000)     then begin
      result:=charstr(' ',y);
 //     exit;
    end;
 {$ENDIF FPC}

 if abs(x)<0.002 then kropki:=charstr(' ',y)
        else  begin
          kr:=krp(x,'.');
          kropki:=leftPad(kr,y);
        end;
end;
function kropki0(x:double;y: integer):string;
begin
 result:=leftPad(krp(x,'.'),y);
end;


function kropkiWSP(x:double;y: integer):string;
begin
 result:=leftPad(krp4(x,'.'),y);
end;


function kropkiColor(dd : double;ll : integer;astrona : boolean):string;
begin
    if aStrona then result:=charBMP+#208+kropki(dd,ll)
    else result:=charBMP+#206+kropki(dd,ll);
end;


function lc( ll :comp;dd : longint):string;
var
  sss : string;
begin
(*
{$IFDEF compabsent}
          tr(ll:0,sss);
{$ELSE}
          str(ll:0:0,sss);
{$ENDIF}
*)

  {$IFDEF cpu64}
  str(ll:0,sss);
  {$ELSE}

  {$IFDEF arm}
  str(ll:0,sss);
  {$ELSE}
  str(ll:0:0,sss);
  {$ENDIF}
  {$ENDIF}


  if dd=0 then result:=sss
  else begin
  if ll <> 0 then  lc:=leftpad(sss,dd)
             else  lc:=charstr(' ',dd);
  end;
end;


{
function dbl2str;
var
  ssl : string;
begin
  str(ll:20:3,ssl);
  if ssl[20]='0' then begin
       dec(ssl[0]);
  end;
  result:=trim(ssl);
end;
}

{
function str2dbl;
var
  io : integer;
  dd : double;
begin
  ss:=trim(ss);
  val(ss,dd,io);
  if io=0 then result:=dd
          else result:=0;
end;
}

function trimZero(const sn : string):string;
var
  s : string;
  i,p : integer;
begin
  s:=sn;
  i:=length(s);
  while (s[i]='0') do
    dec(i);
  if s[i] in [',','.'] then
     dec(i);
  setLength(result,i);
  p := 1;

  while (p <= i) and (S[p] <= ' ') do Inc(p);
  if p > i then Result := '' else
  begin
    Result := Copy(S, p, I - p + 1);
  end;



end;

function form2D;
var
  ssl : string;
begin
  str(ll:20:2,ssl);
  ssl[18]:=',';
  if ll> 1000    then insert('.',ssl,15);
  if ll> 1000000 then insert('.',ssl,12);
  result:=leftPad(trimLead(ssl),dd);
end;
function formsgz(ll : single;dd : word):string;
begin
  if ll=0 then result:=pad(' ',dd)
          else result:=formsgS(ll,dd);
end;

function formsgz(ll : double;dd : word):string;
begin
  if ll=0 then formsgz:=pad(' ',dd)
          else formsgz:=formsgd(ll,dd);
end;

function formSG(ll : integer;dd : integer):string;
begin
  result:=formsg(int(ll),dd);
end;

function formSG(ll : double;dd : integer):string;
begin
  result:=formsgd(ll,dd);
end;


function okrInz(dd : double;decimals : integer):double;
var
  dda : double;
  xm,
  xc  : double;
begin
  dda:= abs(dd);
  if      dda>100000000 then xm:=11
  else if dda>10000000000 then xm:=10
  else if dda>1000000000 then xm:=9
  else if dda>100000000 then xm:=8
  else if dda>10000000 then xm:=7
  else if dda>1000000 then xm:=6
  else if dda>100000 then xm:=5
  else if dda>10000 then xm:=4
  else if dda>1000 then xm:=3
  else if dda>100 then xm:=2
  else if dda>10 then xm:=1
  else if dda>1 then xm:=0
  else if dda>0.1 then xm:=-1
  else if dda>0.01 then xm:=-2
  else if dda>0.001 then xm:=-3
  else if dda>0.0001 then xm:=-4
  else if dda>0.00001 then xm:=-5
  else if dda>0.000001 then xm:=-6
  else if dda>0.0000001 then xm:=-7
  else if dda>0.00000001 then xm:=-8
  else xm:=0;
  xc:=power(10,decimals-xm-1);
  dd:=system.int(dd*xc+0.5)/xc;
  result:=dd;
end;

function formSGInz(ll : double;dd,decimals : integer):string;
begin
  result:=formSg(okrInz(ll,decimals),dd);
end;

function formSG(ll : single;dd : integer):string;
begin
  result:=formsgs(ll,dd);
end;
function formSGS(ll : single;dd : integer):shortstring;
var
  ssl : shortstring;
  lla : single;
begin
  lla:=abs(ll);
 if lla>15000 then begin
   str(ll:19:2,ssl);
   ssl:=ssl+'0';
 end else if (lla<{91}500) and (ll>0) then begin
    if (lla<0.2) and (lla>0.0001) then begin
      str(ll:20:6,ssl);
      ssl[14]:=',';
      if ssl[20]='0' then begin
          dec(ssl[0]);
          if ssl[19]='0' then begin
            dec(ssl[0]);
            if ssl[18]='0' then begin
               dec(ssl[0]);
               if ssl[17]='0' then begin
                 dec(ssl[0]);
                 if ssl[16]='0' then begin
                   dec(ssl[0]);
                   if ssl[15]='0' then begin
                     dec(ssl[0],2);
                   end;
                 end;
               end;

            end;
          end;
      end;
    end else begin
      str(ll:20:4,ssl);
      ssl[16]:=commaChar;
      if ssl[20]='0' then begin
          dec(ssl[0]);
          if ssl[19]='0' then begin
            dec(ssl[0]);
            if ssl[18]='0' then begin
               dec(ssl[0]);
               if ssl[17]='0' then begin
                 dec(ssl[0],2);
               end;

            end;
          end;
      end;
    end;
    result:=leftPad(trimLead(ssl),dd);
    exit;

 end else str(ll:20:3,ssl);
 ssl[17]:=',';
 if (ssl[20]='1' ) and((ll*100-system.int(ll*100))<0.07) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ll*1000-system.int(ll*1000))>0.2) then begin
   ll:=system.int(ll*1000+0.8)/1000;
   str(ll:20:3,ssl);
   ssl[17]:=',';

 end;
 if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
       if ssl[18]='0' then begin
       dec(ssl[0],2);
       end;
     end;
 end;
// if ll>= 1000    then insert('`',ssl,14);
// if ll>= 1000000 then insert('`',ssl,11);
// if ll>= 1000000 then insert('.',ssl,11);
 result:=leftPad(trimLead(ssl),dd);
end;
function formSGa;
var
  ssl : string;
  lla : double;
begin
 lla:=abs(ll);
 if lla>30000 then begin
   str(ll:19:3,ssl);
   ssl:=ssl+'0';
 end else str(ll:20:4,ssl);
 ssl[16]:=',';
 if (ssl[20]='1' ) and((ll*1000-system.int(ll*1000))<0.07) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ll*10000-system.int(ll*10000))>0.2) then begin
   ll:=system.int(ll*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=commaChar;

 end;
 if lla<9 then begin
   if lla<0.9 then begin
     str(ll:20:6,ssl);
     ssl[14]:=',';
   end else begin
     str(ll:20:5,ssl);
     ssl[15]:=',';
   end;
 end;
 result:=trimzero(ssl);
 {
 if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
       if ssl[18]='0' then begin
       dec(ssl[0]);
         if ssl[17]='0' then begin
           if ssl[16]=',' then     dec(ssl[0],2)
                          else dec(ssl[0],1);
         end;
       end;
     end;
 end;
 }

// formSGA:=ssl;
end;


function formKurs;
var
  ssl : string;
begin
 if ll>30000 then begin
   str(ll:19:3,ssl);
   ssl:=ssl+'0';
 end else str(ll:20:4,ssl);
 ssl[16]:=',';
 if (ssl[20]='1' ) and((ll*1000-system.int(ll*1000))<0.07) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ll*10000-system.int(ll*10000))>0.2) then begin
   ll:=system.int(ll*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=',';

 end;
 if abs(ll)<0.9 then begin
   str(ll:20:5,ssl);
   ssl[15]:=commaChar;
 end;
{ if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
       if ssl[18]='0' then begin
       dec(ssl[0]);
         if ssl[17]='0' then begin
           if ssl[16]=',' then     dec(ssl[0],2)
                          else dec(ssl[0],1);
         end;
       end;
     end;
 end;
}
// result:=ssl;
 result:=leftPad(trimLead(ssl),dd);
end;

function formSG(ll : double):string;
var
  ssl : string;
begin
{ if ll>30000 then begin
   str(ll:19:2,ssl);
   ssl:=ssl+'0';
 end else}
 if (abs(ll)<9) and (ll<>0) then begin
   if (abs(ll)<0.1)  then begin
     str(ll:20:7,ssl);
     ssl[13]:=commaChar;
   end else begin
     str(ll:20:6,ssl);
     ssl[14]:=',';
   end;
   result:=trimzero(ssl);
   exit;
 end;

 str(ll:20:4,ssl);
 ssl[16]:=',';
 if (ssl[20]='1' ) and((ll*10000-system.int(ll*10000-0.2))<0.8) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ll*10000-system.int(ll*10000-0.2))>0.2) then begin
   ll:=system.int(ll*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=',';

 end;
 if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
       if ssl[18]='0' then begin
          dec(ssl[0]);
          if ssl[17]='0' then begin
             dec(ssl[0],2);
          end;
       end;
     end;
 end;
 result:=trim(ssl);
end;


function formSGCena(ll : single;dd : integer):string;
var
  ssl : shortstring;
  ww  : double;
begin
 if ll>300000 then begin
   ll:=system.int(ll*10+0.51)/10;

 end;
 if abs(ll) > 8000 then ww:=okrg(ll)
 else
 ww:=ll;
 if abs(ww)>1000 then begin   {1176,82}
   str(ww:19:3,ssl);
   ssl:=ssl+'0';
 end else str(ww:20:4,ssl);
 ssl[16]:=',';
 if (ssl[20]='1' ) and((ww*1000-system.int(ww*1000))<0.07) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ww*10000-system.int(ww*10000))>0.2) then begin
   ww:=system.int(ww*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=',';

 end;
 if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
{       if ssl[18]='0' then begin
         dec(ssl[0]);
         if ssl[17]='0' then begin
            dec(ssl[0],2);
         end;
       end;
}     end;
 end;
 if ll> 1000    then insert('.',ssl,13);
 if ll> 1000000 then insert('.',ssl,10);
 if ll< -1000    then insert('.',ssl,13);
 if ll< -1000000 then insert('.',ssl,10);

 result:=leftPad(trimLead(ssl),dd);
end;

function formSGCena(ll : double;dd : integer):string;
var
  ssl : shortstring;
  ww  : double;
begin
 if abs(ll) > 8000 then ll:=okrg(ll)
 else if ll> 900 then begin
   ll:=system.int(ll*1000+0.51)/1000;

 end;

 ww:=ll;
 str(ll:20:4,ssl);
 ssl[16]:=',';
 if (ssl[20]='1' ) and((ww*10000-system.int(ww*10000-0.2))<0.7) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ww*10000-system.int(ww*10000-0.2))<0.7) then begin
   ww:=system.int(ww*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=',';

 end;
 if ssl[20]='0' then begin
     dec(ssl[0]);
     if ssl[19]='0' then begin
       dec(ssl[0]);
       {
       if ssl[18]='0' then begin
         dec(ssl[0]);
         if ssl[17]='0' then begin
            dec(ssl[0],2);
         end;
       end;
       }
     end;
 end;
 if ll> 1000    then insert('.',ssl,13);
 if ll> 1000000 then insert('.',ssl,10);
 if ll< -1000000 then insert('.',ssl,10);
 if ll< -1000    then insert('.',ssl,13);
 result:=leftPad(trimLead(ssl),dd);
end;

function formSGD(ll : double;dd : word):string;
var
  ssl : string;

  ww  : double;
begin
 ww:=ll;
 {
 if ll=0 then begin
   result:=pad(' ',dd);
   exit;
 end;
 }
 if (abs(ll)<9) and (abs(ll)>0.000001) then begin

   if (abs(ll)<0.1)  then begin
     str(ll:20:6,ssl);
     ssl[14]:=commaChar;
   end else begin
     str(ll:20:5,ssl);
     ssl[15]:=commaChar;
//   str(ll:20:7,ssl);
//   ssl[13]:=',';
     if (ssl[20]='1' ) and((ww*100000000-system.int(ww*100000000-0.2))<0.7) then ssl[20]:='0';
     if (ssl[20]='9' ) and((ww*100000000-system.int(ww*100000000-0.2))<0.7) then begin
       ww:=system.int(ww*100000000.0+0.8)/100000000;
       str(ll:20:5,ssl);
       ssl[15]:=',';
     end;
   end;
   {
   if  (ssl[20]='0') and (ssl[19]='0') then begin
       dec(ssl[0],2);
         if ssl[18]='0' then begin
           dec(ssl[0]);
           if ssl[17]='0' then begin
              dec(ssl[0]);
              if ssl[16]='0' then begin
                dec(ssl[0]);
                if ssl[15]='0' then begin
                   dec(ssl[0]);
                end;
              end;
           end;
         end;
   end;
   }
//   result:=leftPad(trimLead(ssl),dd);
   result:=leftPad(trimZero(ssl),dd);

   exit;
 end;
 str(ll:20:4,ssl);
 ssl[16]:=commaChar;

 if (ssl[20]='1' ) and((ww*10000-system.int(ww*10000-0.2))<0.7) then ssl[20]:='0';
 if (ssl[20]='9' ) and((ww*10000-system.int(ww*10000-0.2))<0.7) then begin
   ww:=system.int(ww*10000+0.8)/10000;
   str(ll:20:4,ssl);
   ssl[16]:=',';
 end;
 if  (ssl[20]='0') and (ssl[19]='0') then begin
     dec(ssl[0],2);
       if ssl[18]='0' then begin
         dec(ssl[0]);
         if ssl[17]='0' then begin
            dec(ssl[0],2);
         end;
       end;
 end;

 {
 if ll>= 1000    then insert('.',ssl,13);
 if ll>= 1000000 then insert('.',ssl,10);
 if ll< -1000000 then insert('.',ssl,10);
 if ll< -1000    then insert('.',ssl,13);
 }

 result:=leftPad(trimLead(ssl),dd);
 while length(result)>dd do begin
    if pos(',',result)>0 then begin
       if pos(',',result)=(length(result)-1) then begin
        delete(result,length(result)-1,2);
        result:=' '+result;
       end else
        delete(result,length(result),1);
    end else break;


 end;
end;


function formGodzin;
begin
 result:=lf(round(int(ll)),dd-3)+':'+lf(round(frac(ll)*60),2);
end;


function kratka;
begin
  kratka:=leftpad(ss,y-2)+' ≥';
end;

function kraC;
begin
  kraC:=center(ss,y-1)+'≥';
end;



function linia;
var
  s4 : string;
  ch,ch1,ch2 : char;
  i  : integer;
begin
  case typ of
    1,10 : ch :='¬';
    2,5 : ch :='≈';
    3 : ch :='¡';
    4 : ch :='≥';
    6 : ch:='¿';
  else ch:=' ';
  end;
  case typ of
    1 : ch1 :='ø';
    10,2 : ch1 :='¥';
    3 : ch1 :='Ÿ';
    4 : ch1 :='≥';
    5 : ch1 :='≈';
    6 : ch1 :=' ';
   else ch1:=' '; 
    
  end;


  if typ<>4 then ch2:='ƒ' else ch2:=' ';

  s4:=charStr(ch2,pi);

  for i := 1 to il do
    s4:=s4+ch+charStr(ch2,sz);
  if typ = 5 then delete(s4,1,1);
  linia:=s4+ch1;
end;






function  zloty1(kk: double):string;
var
  c1,c2 : int64;
//  cc2: comp;
  ss : string;
  lll: longint;
  cyfra : integer;
procedure liczba(cc: longint;var ss:string);
var
  cyfra,cyfra3,cyfra2 : integer;
begin
  cyfra:=cc mod 10;
  cyfra2 := (cc div 10) mod 10;
  cyfra3 := (cc div 100) mod 10;
  if cyfra2 = 1 then begin
  case cyfra of
     0	   : ss:='dziesiëç '+ss;
     1     : ss:='jedenaûcie '+ss;
     2     : ss:='dwanaûcie '+ss;
     3     : ss:='trzynaûcie '+ss;
     4     : ss:='czternaûcie '+ss;
     5     : ss:='piëtnaûcie '+ss;
     6     : ss:='szesnaûcie '+ss;
     7     : ss:='siedemnaûcie '+ss;
     8     : ss:='osiemnaûcie '+ss;
     9     : ss:='dziewietnaûcie '+ss;
  end;end
  else
  case cyfra of
     1     : ss:='jeden '+ss;
     2     : ss:='dwa '+ss;
     3     : ss:='trzy '+ss;
     4     : ss:='cztery '+ss;
     5     : ss:='piëç '+ss;
     6     : ss:='szeûç '+ss;
     7     : ss:='siedem '+ss;
     8     : ss:='osiem '+ss;
     9     : ss:='dziewiëç '+ss;
  end;
    case cyfra2 of
     2     : ss:='dwadzieûcia '+ss;
     3     : ss:='trzydziesci '+ss;
     4     : ss:='czterdzieûci '+ss;
     5     : ss:='piëçdziesiÜt '+ss;
     6     : ss:='szeûçdziesiÜt '+ss;
     7     : ss:='siedemdziesiÜt '+ss;
     8     : ss:='osiemdziesiÜt '+ss;
     9     : ss:='dziewiëçdziesiÜt '+ss;
  end;
    case cyfra3 of
     1     : ss:='sto '+ss;
     2     : ss:='dwieûcie '+ss;
     3     : ss:='trzysta '+ss;
     4     : ss:='czterysta '+ss;
     5     : ss:='piëçset '+ss;
     6     : ss:='szeûçset '+ss;
     7     : ss:='siedemset '+ss;
     8     : ss:='osiemset '+ss;
     9     : ss:='dziewiëçset '+ss;
  end;
end;


begin
  ss:='';
  c2:=trunc(kk/1000000);
//  cc2:=c2;
  c1:=trunc(kk-(c2*1000000.0));
  if (c1 mod 100) in [12..19] then ss:=' zíotych'
  else begin
   cyfra := c1 mod 10;
   case cyfra of
    0,1,5,6,7,8,9 : ss:=' zíotych';
    2,3,4         : ss:=' zíote';
    end;
  end;
  lll:=(c1 mod 1000);
    liczba(lll,ss);
  lll:=(c1 div 1000) mod 1000;
  if lll <> 0 then begin
{   if length(ss) > 30 then ss:='-'#13#10+'  -'+ss;}
   if (lll mod 1000 ) = 1 then ss:=' tysiÜc ' + ss
   else begin
     if (lll mod 100) in [12..19] then ss:=' tysiëcy '+ss
     else begin
       cyfra := lll mod 10;
       case cyfra of
         0,1,5,6,7,8,9 : ss:='tysiëcy '+ss;
         2,3,4         : ss:='tysiÜce '+ss;
       end;
     end;
   end;
   liczba(lll,ss);
  end;
  lll:=c2  mod 1000;
  if lll <> 0 then begin
{    if length(ss) > 30 then ss:='-'#13#10+'  -'+ss; }
    if (lll mod 1000) = 1 then ss:=' milion '+ss
    else begin
      if (lll mod 100) in [12..19] then ss:=' milion¢w '+ss
      else begin
      cyfra := lll mod 10;
      case cyfra of
        0,1,5,6,7,8,9 : ss:='milion¢w '+ss;
        2,3,4         : ss:='miliony '+ss;
      end;
      end;
    end;
    liczba(lll,ss);
  end;
  lll:=(c2 div 1000) mod 1000;
  if lll <> 0 then begin
    if (lll mod 1000) = 1 then ss:=' miliard ' + ss
    else begin
      if (lll mod 100) in [12..19] then ss:=' miliard¢w '+ss
      else begin
      cyfra := lll mod 10;
      case cyfra of
        0,1,5,6,7,8,9 : ss:=' miliard¢w '+ss;
        2,3,4         : ss:=' miliardy '+ss;
      end;
      end;
    end;
    liczba(lll,ss);
  end;
  zloty1:=ss;
end;

function zloty(kk : comp):string;
var
   sss : string[255];
   poz,i : word;
begin
  sss:=zloty1(kk);
  poz:=3;
  for i :=2 to length(sss) do begin
    inc(poz);
    if (sss[i]=' ') and (poz> 49) then begin
      insert('-'#13#10'    -',sss,i);
      poz:=3;
    end;
  end;
  zloty:=sss;
end;

function  zloty2(kk: double):string;
var
  c1,c2 : longint;
  cc2: double;
  ss : string;
  lll: longint;
  cyfra : integer;


procedure liczba(cc: longint;var ss:string);
var
  cyfra,cyfra3,cyfra2 : integer;
begin
  cyfra:=cc mod 10;
  cyfra2 := (cc div 10) mod 10;
  cyfra3 := (cc div 100) mod 10;
  if cyfra2 = 1 then ss:=nZloty[cyfra]+ss
                else  ss:=nZloty[cyfra+10]+ss;
  ss:=nZloty[cyfra2+20]+ss;
  ss:=nZLoty[cyfra3+30]+ss;
end;

procedure tys(lll,ww:longint;var ss:string);
begin
   if (lll mod 1000 ) = 1 then ss:=nZloty[ww]{' tysiÜc '} + ss
   else begin
     if (lll mod 100) in [12..19] then ss:=nZloty[ww+2]{' tysiëcy '}+ss
     else begin
       cyfra := lll mod 10;
       case cyfra of
         0,1,5,6,7,8,9 : ss:=nZloty[ww+2]+ss;
         2,3,4         : ss:=nZloty[ww+1]{'tysiÜce '}+ss;
       end;
     end;
   end;
end;

begin
  ss:='';
  c2:=round(frac(kk)*100);
  lll:=c2 mod 100;
  if lll <> 0 then begin
    tys(lll,42,ss);
    liczba(lll,ss);
  end;

  c2:=trunc(kk/1000000);
  cc2:=c2;
  c1:=trunc(kk-(cc2*1000000));
  if (c1 mod 100) in [12..19] then ss:=nZloty[40]+ss {' zíotych'}
  else begin
   cyfra := c1 mod 10;
   case cyfra of
    0,1,5,6,7,8,9 : ss:=nZloty[40]+ss;{' zíotych';}
    2,3,4         : ss:=nZloty[41]+ss;{' zíote';}
    end;
  end;
  lll:=(c1 mod 1000);
    liczba(lll,ss);
  lll:=(c1 div 1000) mod 1000;
  if lll <> 0 then begin
    tys(lll,45,ss);
    liczba(lll,ss);
  end;
  lll:=c2  mod 1000;
  if lll <> 0 then begin
    tys(lll,48,ss);
    liczba(lll,ss);
  end;
  lll:=(c2 div 1000) mod 1000;
  if lll <> 0 then begin
    tys(lll,51,ss);
    liczba(lll,ss);
  end;
  zloty2:=ss;
end;

function  dolar2(kk: double):string;
var
  c1,c2 : longint;
  cc2: double;
  ss : string;
  lll: longint;


procedure liczba(cc: longint;var ss:string);
var
  cyfra,cyfra3,cyfra2 : integer;
begin
  cyfra:=cc mod 10;
  cyfra2 := (cc div 10) mod 10;
  cyfra3 := (cc div 100) mod 10;
  if cyfra2 = 1 then ss:=nDolar[cyfra]+ss
                else  ss:=nDolar[cyfra+10]+ss;
  ss:=nDolar[cyfra2+20]+ss;
  if cyfra3>0 then
  ss:=nDolar[cyfra3+10]+nDolar[31]+ss;
end;


begin
  ss:='';
  c2:=trunc(kk/1000000);
  cc2:=c2;
  c1:=trunc(kk-(cc2*1000000));
  lll:=(c1 mod 1000);
    liczba(lll,ss);
  lll:=(c1 div 1000) mod 1000;
  if lll <> 0 then begin
    ss:=ndolar[32]+ss;
    liczba(lll,ss);
  end;
  lll:=c2  mod 1000;
  if lll <> 0 then begin
    ss:=ndolar[33]+ss;
    liczba(lll,ss);
  end;
  lll:=(c2 div 1000) mod 1000;
  if lll <> 0 then begin
    ss:=ndolar[34]+ss;
    liczba(lll,ss);
  end;
  dolar2:=ss;
end;





function zlotyI(akk:double;ch:char;szer : integer;const aslo : string):ansistring;
var
  sss : string[255];
  poz,i : integer;
  sz1   : integer;
  kk    : double;
begin
  kk:=okrg(abs(akk));
  if szer >50 then sz1:=12 else sz1:=9;
  if denominacja then sss:=ch+nZloty[54]+zloty2(kk)
                 else sss:=ch+' '+aslo+': '+zloty1(kk);
  poz:=9;
  i:=12;
  while i<length(sss) do begin
    inc(poz);
    inc(i);
    if (sss[i] = ' ') and ( (poz > (szer-sz1)) ) then begin
      if poz>szer-1 then poz:=szer-1;
      insert('-'+charStr(' ',szer-poz-1)+ch+#13#10+ch+'     -',sss,i);
      inc(i,szer-poz+13);
      poz:=8
    end;
  end;

  zlotyI:=sss+charStr(' ',szer-poz-1)+ch;
end;
function zlotyIII(kk:double;ch:char;szer : integer):string;
var
  ss,
  sss : string;
  i : word;
//  sz1   : word;
  s5    : string[4];
  lll,
  c2    : word;
  kkz   : double;
  
begin
  kk:=okrg(kk);
  kkz:=system.int(kk+0.0001);
//  if szer >50 then sz1:=18 else sz1:=9;
  sss:=zloty2(kkZ);
  s5:=nZloty[40];
  i:=pos(s5,sss);
  delete(sss,i,10);
  while pos(' ',sss) <>0 do delete(sss,pos(' ',sss),1);
  c2:=round(frac(kk)*100);
  lll:=c2 mod 100;
  if lll <> 0 then begin
    ss:=lf(lll,3)+'/100 gr';
    sss:=sss+ss;
  end;
  if kkz=0 then sss:=' zero';
  sss:=sss+'-';


  zlotyIII:=pad(sss,szer);
end;


function zlotyV;
var
  ss,
  sss : string;
  poz,i : integer;
  s5    : string[4];
  lll,ii,
  c2    : word;
  poz1,poz2 : word;
    lnn,
  sz1   : word;

  kkz   : double;
  nas   : boolean;
begin
  lnn:=0;
  poz1:=1;poz2:=0;
  kk:=abs(kk);

  kk:=okrg(kk);
  kkz:=system.int(kk+0.00001);
  if szer >50 then sz1:=18 else sz1:=13;
  sss:=nZloty[54]+zloty2(kkZ);
  s5:=nZloty[40];
  i:=pos(s5,sss);
  delete(sss,i,10);
  c2:=round(frac(kk)*100);
  lll:=c2 mod 100;
  if lll <> 0 then begin
    ss:=lf(lll,3)+'/100 ';
    sss:=sss+ss;
  end;
  sss:=sss+wal;
  poz:=12;
  i:=12;
  while i<length(sss) do begin
    inc(poz);
    inc(i);
    if (sss[i] = ' ') and ( (poz > szer-sz1) ) then begin
      nas:=false;
      if poz<szer-4 then
      for ii:= i+1 to i+szer-poz-1 do if sss[ii]=' ' then nas:=true;
      if szer> (length(sss)-poz1+1) then nas:=true;
      if nas then continue;
      inc(lnn);
      if lnn=ln then poz1:=i;
      if lnn=ln+1 then poz2:=i-poz1;
      poz:=1
    end;
  end;
  if (ln>0) and (poz1=1) then poz1:=255;
  if poz2=0 then poz2:=255;
  zlotyV:=trim(copy(sss,poz1,poz2));
end;





function zlotyII(kk:double;ch:char;szer : integer):string;
var
  sss : string[255];
    poz,i : integer;
  sz1   : word;
begin
  kk:=okrg(kk);
  if szer >50 then sz1:=18 else sz1:=9;
  sss:=ch+nZloty[54]+zloty2(kk);
  poz:=12;
  i:=12;
  while i<length(sss) do begin
    inc(poz);
    inc(i);
    if (sss[i] = ' ') and ( (poz > szer-sz1) ) then begin
      if poz>szer-1 then poz:=szer-1;
      insert('-'+charStr(' ',szer-poz-1)+ch+#13#10+ch+'     -',sss,i);
      inc(i,szer-poz+13);
      poz:=11
    end;
  end;

  zlotyII:=sss+charStr(' ',szer-poz-1)+ch;
end;
{
function maxword;
begin
  if a>b then result:=a
         else result:=b;
end;
}
function memavail;
begin
  result:=60000;
end;
{
function maxavail1;
begin
  result:=320000;
end;
}

function tyt;
begin
  if i=1 then result:=ss
         else result:='';
end;

procedure konquote;
var
  i : integer;
begin
  for i := 1 to length(sss) do
     case sss[i] of
        '"' : sss[i]:=' ';
        '\' : sss[i]:='/';
     end;                            //  "\\"
  
end;

procedure kon852;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='ú';
     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£';//L/
     'ó' : sss[i]:='å'; //S/
     'ƒ' : sss[i]:=#224; //_
     'ø' : sss[i]:=#222;
     '©' : sss[i]:='Í';
     '•' : sss[i]:='π';
     'ò' : sss[i]:='ú';
     'Ü' : sss[i]:='Ê';
     '¢' : sss[i]:='Û';
     '§' : sss[i]:='•';
     'Ω' : sss[i]:='Ø';
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';
     'æ' : sss[i]:='ø';
     '„' : sss[i]:='—';
     '®' : sss[i]:=' ';
     '‡' : sss[i]:='”';
     '´' : sss[i]:='ü';
     'ç' : sss[i]:='è';
     'è' : sss[i]:='∆';
     'Ñ' : sss[i]:='‰';
     'é' : sss[i]:='ƒ';
     'Å' : sss[i]:='¸';
     'ö' : sss[i]:='‹';
     'î' : sss[i]:='ˆ';
     'ô' : sss[i]:='÷';
     '·' : sss[i]:='ﬂ';

   end;
end;



procedure kon852A;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='ú';
     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£';
     'ó' : sss[i]:='å';
     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';
     '•' : sss[i]:='π';
     'ò' : sss[i]:='ú';
     'Ü' : sss[i]:='Ê';//`c
     '¢' : sss[i]:='Û';
     '§' : sss[i]:='•';
     'Ω' : sss[i]:='Ø';
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';
     'æ' : sss[i]:='ø';
     '„' : sss[i]:='—';
     '®' : sss[i]:=' ';
     '‡' : sss[i]:='”';
     '´' : sss[i]:='ü';
     'ç' : sss[i]:='è';
     'è' : sss[i]:='∆';
     'Ñ' : sss[i]:='‰';
     'é' : sss[i]:='ƒ';
     'Å' : sss[i]:='¸';
     'ö' : sss[i]:='‹';
     'î' : sss[i]:='ˆ';
     'ô' : sss[i]:='÷';
     '·' : sss[i]:='ﬂ';

   end;
end;


function kon852Win;
begin
  result:=sss;
  kon852A(result);
end;

procedure kon852LL;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
//     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='ú';
//     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£';
     'ó' : sss[i]:='å';
//     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';
//     '•' : sss[i]:='π';
     'ò' : sss[i]:='ú';
     'Ü' : sss[i]:='Ê';
//     '¢' : sss[i]:='Û';
     '§' : sss[i]:='•';
     'Ω' : sss[i]:='Ø';
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';
     'æ' : sss[i]:='ø';
     '„' : sss[i]:='—';
     '®' : sss[i]:=' ';
     '‡' : sss[i]:='”';
     '´' : sss[i]:='ü';
     'ç' : sss[i]:='è';
     'è' : sss[i]:='∆';
     'Ñ' : sss[i]:='‰';
     'é' : sss[i]:='ƒ';
     'Å' : sss[i]:='¸';
     'ö' : sss[i]:='‹';
     'î' : sss[i]:='ˆ';
     'ô' : sss[i]:='÷';
     '·' : sss[i]:='ﬂ';

   end;
end;

procedure konWinGtk;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
//     '´' : sss[i]:='º';   //x
 //    'è' : sss[i]:='¨';   //X
//     'ü' : sss[i]:='º';   //x
//     'è' : sss[i]:='¨';   //X
     'π' : sss[i]:='±';  //a
     '•'  : sss[i]:= '°' ;   //A
     'ü'  : sss[i]:='º';      //z`
     'è'  : sss[i]:='¨';      //Z`
      'ú'  : sss[i]:= '∂' ;   //s
      'å'   : sss[i]:= '¶';      //S
   end;

end;
procedure konGtkWin;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
//     '´' : sss[i]:='º';   //x
 //    'è' : sss[i]:='¨';   //X
//     'ü' : sss[i]:='º';   //x
//     'è' : sss[i]:='¨';   //X
     '±' : sss[i]:='π';  //a
     '°'  : sss[i]:= '•' ;   //A
     'º'  : sss[i]:='ü';      //z`
     '¨'  : sss[i]:='è';      //Z`
      '∂'  : sss[i]:= 'ú' ;   //s
      '¶'   : sss[i]:= 'å';      //S
   end;

end;


procedure konGtkWinA;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
//     '´' : sss[i]:='º';   //x
 //    'è' : sss[i]:='¨';   //X
//     'ü' : sss[i]:='º';   //x
//     'è' : sss[i]:='¨';   //X
     '±' : sss[i]:='π';  //a
     '°'  : sss[i]:= '•' ;   //A
     'º'  : sss[i]:='ü';      //z`
     '¨'  : sss[i]:='è';      //Z`
      '∂'  : sss[i]:= 'ú' ;   //s
      '¶'   : sss[i]:= 'å';      //S
   end;

end;


procedure konWinGtkA;
var
  i : integer;
//  sa : ansiString;
//    sb : shortstring;

begin
  for i := 1 to length(sss) do
   case sss[i] of
//     '´' : sss[i]:='º';   //x
 //    'è' : sss[i]:='¨';   //X
     'ü' : sss[i]:='º';   //x
     'è' : sss[i]:='¨';   //X
     'π' : sss[i]:='±';  //a
     '•'  : sss[i]:= '°' ;   //A
      'ú'  : sss[i]:= '∂' ;   //s

      'å'   : sss[i]:= '¶';      //S

   end;

end;

procedure konWinUtfBB(var sss : string);
var
  i : integer;
  sa,
  sb : shortstring;
begin
  sa:='';
  for i := 1 to length(sss) do begin
   case sss[i] of
    '≥' : sb:= '≈Ç' ;//
//   'å'  : sb:= 'ó' ;
//    #199 : sb:= 'ø' ;
    'Í'  : sb:= 'ƒô' ; //e
    '£'  : sb:= '≈Å' ;  //L
    'π'  : sb:= 'ƒÖ' ;   //a
    'ú'  : sb:= '≈õ' ;   //s
    'Ê'  : sb:= 'ƒá' ;   //c
    'Û'  : sb:= '√≥' ;   //o
    '•'  : sb:= 'ƒÑ' ;   //A
    'Ø'  : sb:= '≈ª' ;   //Z.
    'Ò'  : sb:= '≈Ñ' ;   //n
    'ø'  : sb:= '≈º' ;   //z.
    '—'  : sb:= '≈É' ;   //N   c583
    ' '  : sb:='ƒò';      //E
    '”'  : sb:='√ì';      //O '√'ì'    #195#147
    'ü'  : sb:='≈∫';      //z`
    'è'  : sb:='≈π';      //Z`
    '∆'  : sb:='ƒÜ';      //C
    'å'  : sb:='≈ö';     //S`  c59a


     '‰' : sb:=#$c3#$a4;      //a"  c3a4
     'ƒ' : sb:=#$c3#$84;      //A" c384
     '¸' : sb:=#$c3#$bc;      //u"  c3bc

//     '‰' : sb:='Ñ';      //a"  #195#164
//     'ƒ' : sb:='é';      //A" é
//     '¸' : sb:='Å';      //u"
     '‹' : sb:='ö';      //U"    #220
     'ˆ' : sb:='î';      //o"
     '÷' : sb:='ô';      //O"      #195#150
     'ﬂ' : sb:='·';      //SS     #223   #195#159
     else
     sb:=sss[i];

     end;
     sa:=sa+sb;
   end;
   sss:=sa;


end;
(*
procedure konWinUTF(var sss : string);
var
  i : integer;
  sa,
  sb : shortstring; 
begin
  sa:='';
  for i := 1 to byte(sss[0]) do begin
   case sss[i] of
    '≥' : sb:= '≈Ç' ;// 
//   'å'  : sb:= 'ó' ;
//    #199 : sb:= 'ø' ;
    'Í'  : sb:= 'ƒô' ; //e
    '£'  : sb:= '≈Å' ;  //L
    'π'  : sb:= 'ƒÖ' ;   //a
    'ú'  : sb:= '≈õ' ;   //s
    'Ê'  : sb:= 'ƒá' ;   //c
    'Û'  : sb:= '√≥' ;   //o
    '•'  : sb:= 'ƒÑ' ;   //A
    'Ø'  : sb:= '≈ª' ;   //Z.
    'Ò'  : sb:= '≈Ñ' ;   //n
    'ø'  : sb:= '≈º' ;   //z.
    '—'  : sb:= '≈É' ;   //N
    ' '  : sb:='ƒò';      //E
    '”'  : sb:='√ì';      //O
    'ü'  : sb:='≈∫';      //z`
    'è'  : sb:='≈π';      //Z`
    '∆'  : sb:='ƒÜ';      //C



     '‰' : sb:='Ñ';      //a"
     'ƒ' : sb:='é';      //A"
     '¸' : sb:='Å';      //u"
     '‹' : sb:='ö';      //U"
     'ˆ' : sb:='î';      //o"
     '÷' : sb:='ô';      //O"
     'ﬂ' : sb:='·';      //SS
     else
     sb:=sss[i];

     end;
     sa:=sa+sb;
   end;
   sss:=sa;


end;

*)

procedure konWinUTFA(var sss : ansistring);
var
  sa : ansiString;
begin
  sa:=komWinUtf(sss);
  sss:=sa;
end;

function komWinL2A(const sss : ansistring):ansistring;
begin
  result:=sss;
  konWinL2A(result);
end;




function komWinUTF(const sss : ansistring):utf8String;
var
  i : integer;
  sa : utf8String;
  sb : shortstring;

begin
  sa:='';
  for i := 1 to length(sss) do begin
   case sss[i] of
    '≥' : sb:= '≈Ç' ;//
//   'å'  : sb:= 'ó' ;
//    #199 : sb:= 'ø' ;
    'Í'  : sb:= 'ƒô' ; //e
    '£'  : sb:= '≈Å' ;  //L
    'π'  : sb:= 'ƒÖ' ;   //a
    'ú'  : sb:= '≈õ' ;   //s
    'Ê'  : sb:= 'ƒá' ;   //c
    'Û'  : sb:= '√≥' ;   //o
    '•'  : sb:= 'ƒÑ' ;   //A
    'Ø'  : sb:= '≈ª' ;   //Z.
    'Ò'  : sb:= '≈Ñ' ;   //n
    'ø'  : sb:= '≈º' ;   //z.
    '—'  : sb:= '≈É' ;   //N
    ' '  : sb:= 'ƒò';      //E
    '”'  : sb:= '√ì';      //O
    'ü'  : sb:= '≈∫';      //z`
    'è'  : sb:= '≈ª';      //Z`
    '∆'  : sb:= 'ƒÜ';      //C
    'å'  : sb:= '≈ö';     //S`  c59a



     '‰' : sb:=#$c3#$a4;      //a"  c3a4
     'ƒ' : sb:=#$c3#$84;      //A" c384
     '¸' : sb:=#$c3#$bc;      //u"  c3bc
     '‹' : sb:=#$c3#$9c;      //U" c39c
     'ˆ' : sb:=#$c3#$b6;      //o" c3b6
     '÷' : sb:=#$c3#$96;      //O" c396
     'ﬂ' : sb:=#$c3#$9f;      //ss
     '?' : sb:=#$E1#$BA#$9E;              //SS
     'ß' : sb:=#$c2#$a7;        //c2 a7 ¬ßU+00A7
     '∞' : sb:='¬∞';        //¬ß
     '©' : sb:=#$c2#$a9;        //c2 a7 ¬ßU+00A9

     #$97 : sb:='-';
     #$96 : sb:='-';

     'A'..'Z',
     'a'..'z' : sb:=sss[i];
     else
     sb:=sss[i];

     end;
     sa:=sa+sb;
   end;
   result:=sa;


end;


function komUTFWinA(const sss : Utf8string):ansiString;
var
  i : integer;
  sa : ansiString;
  sb : ansistring;
begin
//http://www.utf8-zeichentabelle.de/

  sa:='';
  i:=1;

  while i < length(sss) do begin
   if sss[i]='≈' then begin
   case sss[i+1] of
    'õ' : sb:='ú';   //s
    'Ç' : sb:='≥';//l
    'Å' : sb:='£';  //L
    'ª' : sb:='Ø';   //Z.
    'Ñ' : sb:='Ò';   //n
    'º' : sb:='ø';   //z.
    'É' : sb:='—';   //N
    '∫' : sb:='ü';      //z`
    'π' : sb:='è';      //Z`
    'ö' : sb:='å';     //S`  c59a
    end;
   end else  if sss[i]='ƒ' then begin
   case sss[i+1] of
    'ô' : sb:='Í' ; //e
    'Ö' : sb:='π';   //a
    'á' : sb:='Ê' ;   //c
    'Ñ' : sb:='•';   //A
    'ò' : sb:=' ';      //E
    'Ü' : sb:='∆';      //C
    end;
   end else if sss[i]='¬' then begin
    case sss[i+1] of
      '∞' : sb:='∞' ; //e
      'ß' : sb:='ß'; //ß
      '©' : sb:='©';//©
    end;
   end else  if sss[i]='√' then begin       // ¬∞
   case sss[i+1] of
    '≥': sb:='Û' ;   //o
    'ì': sb:='”';      //O
   end;
   end else begin
      sb:=sss[i];
      dec(i);
   end;
   inc(i,2);



    sa:=sa+sb;
   end;
   if i=length(sss) then sa:=sa+sss[i];
   result:=sa;


end;


procedure konUTFWin(var sss : string);
var
  i : integer;
  sa,
  sb : shortstring;
begin

  sa:='';
  i:=1;

  while i < length(sss) do begin
   if sss[i]='≈' then begin
   case sss[i+1] of
    'õ' : sb:='ú';   //s
    'Ç' : sb:='≥';//l
    'Å' : sb:='£';  //L
    'ª' : sb:='Ø';   //Z.
    'Ñ' : sb:='Ò';   //n
    'º' : sb:='ø';   //z.
    'É' : sb:='—';   //N
    '∫' : sb:='ü';      //z`
    'π' : sb:='è';      //Z`
    'ö' : sb:='å';     //S`  c59a
    end;
   end else  if sss[i]='ƒ' then begin
   case sss[i+1] of
    'ô' : sb:='Í' ; //e
    'Ö' : sb:='π';   //a
    'á' : sb:='Ê' ;   //c
    'Ñ' : sb:='•';   //A
    'ò' : sb:=' ';      //E
    'Ü' : sb:='∆';      //C
    end;
   end else  if sss[i]='√' then begin
   case sss[i+1] of
    '≥': sb:='Û' ;   //o
    'ì': sb:='”';      //O
   end;
   end else if sss[i]='¬' then begin
    case sss[i+1] of
      '∞' : sb:='∞' ; //e
      'ß' : sb:='ß'; //ß
      '©' : sb:='©';//©
    end;

   end else begin
      sb:=sss[i];
      dec(i);
   end;
   inc(i,2);



    sa:=sa+sb;
   end;
   if i=length(sss) then sa:=sa+sss[i];
   sss:=sa;


end;


function komUTF852A(const sss : utf8string):ansiString;
var
  i : integer;
  sa,
  sb :ansistring;
begin

  sa:='';
  i:=1;

  while i < length(sss) do begin
   if sss[i]='≈' then begin
   case sss[i+1] of
    'õ' : sb:='ò';   //s
    'Ç' : sb:='à';//l
    'Å' : sb:='ù';  //L
    'ª' : sb:='Ω';   //Z.
    'Ñ' : sb:='‰';   //n
    'º' : sb:='æ';   //z.
    'É' : sb:='„';   //N
    '∫' : sb:='´';      //z`
    'π' : sb:='ç';      //Z`
    'ö' : sb:='ó';     //S`  c59a

    end;
   end else  if sss[i]='ƒ' then begin
   case sss[i+1] of
    'ô' : sb:='©' ; //e
    'Ö' : sb:='•';   //a
    'á' : sb:='Ü' ;   //c
    'Ñ' : sb:='§';   //A
    'ò' : sb:='®';      //E
    'Ü' : sb:='è';      //C
    end;
   end else  if sss[i]='√' then begin
   case sss[i+1] of
    '≥': sb:='¢' ;   //o
    'ì': sb:='‡';      //O
   end;
   end else if sss[i]='¬' then begin
    case sss[i+1] of
      '∞' : sb:='∞' ; //e
      'ß' : sb:='ß'; //ß
      '©' : sb:='©';//©
    end;
   end else begin
      sb:=sss[i];
      dec(i);
   end;
   inc(i,2);



    sa:=sa+sb;
   end;
   if i=length(sss) then sa:=sa+sss[i];
   result:=sa;


end;


procedure kon852GTK;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
//     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='∂'; //s
//     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£'; //L
     'ó' : sss[i]:='¶'; //S
//     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';  //e
     '•' : sss[i]:='±';  //a
     'π' : sss[i]:='±';  //a
     'ò' : sss[i]:='∂';  //s
     'Ü' : sss[i]:='Ê';  //c
     '¢' : sss[i]:='Û';  //o
     '§' : sss[i]:='°';  //A
     'Ω' : sss[i]:='Ø';  //Z
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';   //n
     'æ' : sss[i]:='ø';   //z
     '„' : sss[i]:='—';   //N
     '®' : sss[i]:=' ';   //E
     '‡' : sss[i]:='”';   //O
     '´' : sss[i]:='º';   //x
     'ç' : sss[i]:='¨';   //X
     'è' : sss[i]:='∆';    //C
     'Ñ' : sss[i]:='‰';    //a"
     'é' : sss[i]:='ƒ';    //A"
     'Å' : sss[i]:='¸';    //u"
     'ö' : sss[i]:='‹';    //U"
     'î' : sss[i]:='ˆ';    //o"
     'ô' : sss[i]:='÷';    //O"
     '·' : sss[i]:='ﬂ';    //S"

   end;
end;

procedure kon852GTKA;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
//     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='∂'; //s
//     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£'; //L
     'ó' : sss[i]:='¶'; //S
//     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';  //e
     '•' : sss[i]:='±';  //a
     'π' : sss[i]:='±';  //a
     'ò' : sss[i]:='∂';  //s
     'Ü' : sss[i]:='Ê';  //c
     '¢' : sss[i]:='Û';  //o
     '§' : sss[i]:='°';  //A
     'Ω' : sss[i]:='Ø';  //Z
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';   //n
     'æ' : sss[i]:='ø';   //z
     '„' : sss[i]:='—';   //N
     '®' : sss[i]:=' ';   //E
     '‡' : sss[i]:='”';   //O
     '´' : sss[i]:='º';   //x
     'ç' : sss[i]:='¨';   //X
     'è' : sss[i]:='∆';    //C
     'Ñ' : sss[i]:='‰';    //a"
     'é' : sss[i]:='ƒ';    //A"
     'Å' : sss[i]:='¸';    //u"
     'ö' : sss[i]:='‹';    //U"
     'î' : sss[i]:='ˆ';    //o"
     'ô' : sss[i]:='÷';    //O"
     '·' : sss[i]:='ﬂ';    //S"

   end;
end;


procedure konLat8859;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';  //l`
     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='ú';
     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£';
     'ó' : sss[i]:=#166; //S'
     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';
     '•' : sss[i]:={'π'}#177;
     'ò' : sss[i]:={'ú'}#182;
     'Ü' : sss[i]:='Ê';
     '¢' : sss[i]:='Û';
     '§' : sss[i]:='°';
     'Ω' : sss[i]:='Ø';
//     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';
     'æ' : sss[i]:='ø';
     '„' : sss[i]:='—';
     '®' : sss[i]:=' ';
     '‡' : sss[i]:='”';
     '´' : sss[i]:={'ü'}#188;
     'ç' : sss[i]:=#172;//'è';
     'è' : sss[i]:=#198;//'∆';
     'Ñ' : sss[i]:='‰';    //a"
     'é' : sss[i]:='ƒ';    //A"
     'Å' : sss[i]:='¸';    //u"
     'ö' : sss[i]:='‹';    //U"
     'î' : sss[i]:='ˆ';    //o"
     'ô' : sss[i]:='÷';    //O"
     '·' : sss[i]:='ﬂ';    //S"

   end;
end;

procedure pominPHPA;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     '/','\',
     '"' : sss[i]:=' ';
     '''' : sss[i]:=' ';
//     #136: sss[i]:='≥';
   end;

end;


procedure konBrak;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='l';
     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='s';
     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='L';
     'ó' : sss[i]:='S';
     'ø' : sss[i]:=#220;
     '©' : sss[i]:='e';
     '•' : sss[i]:='a';
     'ò' : sss[i]:='s';
     'Ü' : sss[i]:='c';
     '¢' : sss[i]:='o';
     '§' : sss[i]:='A';
     'Ω' : sss[i]:='Z';
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='n';
     'æ' : sss[i]:='z';
     '„' : sss[i]:='N';
     '®' : sss[i]:='E';
     '‡' : sss[i]:='O';
     '´' : sss[i]:='z';
     'ç' : sss[i]:='Z';
     'è' : sss[i]:='C';
     '&','^','/','\','<','>',
     '"' : sss[i]:='_';

   end;
end;

function komBrak;
var
  i : integer;
begin
  result:=sss;
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : result[i]:='l';
     '—' : result[i]:=#221;
//     #136: result[i]:='≥';
     'û' : result[i]:='s';
     '≥' : result[i]:=#178;
     'ù' : result[i]:='L';
     'ó' : result[i]:='S';
     'ø' : result[i]:=#220;
     '©' : result[i]:='e';
     '•' : result[i]:='a';
     'ò' : result[i]:='s';
     'Ü' : result[i]:='c';
     '¢' : result[i]:='o';
     '§' : result[i]:='A';
     'Ω' : result[i]:='Z';
     '°' : result[i]:= '§' ;
     '‰' : result[i]:='n';
     'æ' : result[i]:='z';
     '„' : result[i]:='N';
     '®' : result[i]:='E';
     '‡' : result[i]:='O';
     '´' : result[i]:='z';
     'ç' : result[i]:='Z';
     'è' : result[i]:='C';
     '&','^','/','\','<','>',
     '"' : result[i]:='_';

   end;
end;




procedure konWin;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
    '≥': sss[i]:= 'à';
{    'ú': sss[i]:='û';}
{    'Ê': sss[i]:='ç';}
    #178 : sss[i]:= '≥' ;
   'å'  : sss[i]:= 'ó' ;
    #199 : sss[i]:= 'ø' ;
    'Í'  : sss[i]:= '©' ;
    '£'  : sss[i]:= 'ù' ;
    'π'  : sss[i]:= '•' ;
    'ú'  : sss[i]:= 'ò' ;
    'Ê'  : sss[i]:= 'Ü' ;
    'Û'  : sss[i]:= '¢' ;
    '•'  : sss[i]:= '§' ;
    'Ø'  : sss[i]:= 'Ω' ;
    'Ò'  : sss[i]:= '‰' ;
    'ø'  : sss[i]:= 'æ' ;
    '—'  : sss[i]:= '„' ;
    ' '  : sss[i]:='®';
    '”'  : sss[i]:='‡';
    'ü'  : sss[i]:='´';
    'è'  : sss[i]:='ç';
    '∆'  : sss[i]:='è';



     '‰' : sss[i]:='Ñ';
     'ƒ' : sss[i]:='é';
     '¸' : sss[i]:='Å';
     '‹' : sss[i]:='ö';
     'ˆ' : sss[i]:='î';
     '÷' : sss[i]:='ô';
     'ﬂ' : sss[i]:='·';


    '±'  : sss[i]:='•' ;
    '∂'  : sss[i]:= 'ò' ;
    '¶'  : sss[i]:= 'ó' ;


   end;
end;




procedure konLat8859A;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
     'à' : sss[i]:='≥';
     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
     'û' : sss[i]:='ú';
     '≥' : sss[i]:=#178;
     'ù' : sss[i]:='£';
     'ó' : sss[i]:=#166; //S'
     'ø' : sss[i]:=#220;
     '©' : sss[i]:='Í';
     '•' : sss[i]:={'π'}#177;
     'ò' : sss[i]:={'ú'}#182;
     'Ü' : sss[i]:='Ê';
     '¢' : sss[i]:='Û';
     '§' : sss[i]:='°';
     'Ω' : sss[i]:='Ø';
     '°' : sss[i]:= '§' ;
     '‰' : sss[i]:='Ò';
     'æ' : sss[i]:='ø';
     '„' : sss[i]:='—';
     '®' : sss[i]:=' ';
     '‡' : sss[i]:='”';
     '´' : sss[i]:={'ü'}#188;
     'ç' : sss[i]:=#172;//'è';
     'è' : sss[i]:=#198;//'∆';
     'Ñ' : sss[i]:='‰';    //a"
     'é' : sss[i]:='ƒ';    //A"
     'Å' : sss[i]:='¸';    //u"
     'ö' : sss[i]:='‹';    //U"
     'î' : sss[i]:='ˆ';    //o"
     'ô' : sss[i]:='÷';    //O"
     '·' : sss[i]:='ﬂ';    //S"

   end;
end;


procedure kon8859l2(var sss : string);
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
    '≥': sss[i]:= 'à';
{    'ú': sss[i]:='û';}
{    'Ê': sss[i]:='ç';}
    #178 : sss[i]:= '≥' ;
   #166{'å'}  : sss[i]:= 'ó' ;
    #199 : sss[i]:= 'ø' ;
    'Í'  : sss[i]:= '©' ;
    '£'  : sss[i]:= 'ù' ;
    {'π'}#177  : sss[i]:= '•' ;
//     '•' : sss[i]:={'π'}#177;
//     'ò' : sss[i]:={'ú'}#182;

    {'ú'}#182  : sss[i]:= 'ò' ;
    'Ê'  : sss[i]:= 'Ü' ;
    'Û'  : sss[i]:= '¢' ;
//    '•'  : sss[i]:= '§' ;

    '°'  : sss[i]:= '§' ;   //A
//     '§' : sss[i]:='°';
    'Ø'  : sss[i]:= 'Ω' ;
    'Ò'  : sss[i]:= '‰' ;
    'ø'  : sss[i]:= 'æ' ;
    '—'  : sss[i]:= '„' ;
    ' '  : sss[i]:='®';
    '”'  : sss[i]:='‡';
    #188{'ü'}  : sss[i]:='´';
    #172{'è'}  : sss[i]:='ç';
    'è'  : sss[i]:='ç';
//     '´' : sss[i]:={'ü'}#188;
//     'ç' : sss[i]:=#172;//'è';
//    'ç' : sss[i]:=#172;//'è';
//    'è' : sss[i]:=#198;//'∆';

    '∆'  : sss[i]:='è';



     '‰' : sss[i]:='Ñ';
     'ƒ' : sss[i]:='é';
     '¸' : sss[i]:='Å';
     '‹' : sss[i]:='ö';
     'ˆ' : sss[i]:='î';
     '÷' : sss[i]:='ô';
     'ﬂ' : sss[i]:='·';


//    '±'  : sss[i]:='•' ;
//    '∂'  : sss[i]:= 'ò' ;
//    '¶'  : sss[i]:= 'ó' ;


   end;
end;

procedure kon8859l2(var sss : ansistring);
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
    '≥': sss[i]:= 'à';
{    'ú': sss[i]:='û';}
{    'Ê': sss[i]:='ç';}
    #178 : sss[i]:= '≥' ;
   #166{'å'}  : sss[i]:= 'ó' ;
    #199 : sss[i]:= 'ø' ;
    'Í'  : sss[i]:= '©' ;
    '£'  : sss[i]:= 'ù' ;
    {'π'}#177  : sss[i]:= '•' ;
//     '•' : sss[i]:={'π'}#177;
//     'ò' : sss[i]:={'ú'}#182;

    {'ú'}#182  : sss[i]:= 'ò' ;
    'Ê'  : sss[i]:= 'Ü' ;
    'Û'  : sss[i]:= '¢' ;
//    '•'  : sss[i]:= '§' ;

    '°'  : sss[i]:= '§' ;   //A
//     '§' : sss[i]:='°';
    'Ø'  : sss[i]:= 'Ω' ;
    'Ò'  : sss[i]:= '‰' ;
    'ø'  : sss[i]:= 'æ' ;
    '—'  : sss[i]:= '„' ;
    ' '  : sss[i]:='®';
    '”'  : sss[i]:='‡';
    #188{'ü'}  : sss[i]:='´';
    #172{'è'}  : sss[i]:='ç';
    'è'  : sss[i]:='ç';
//     '´' : sss[i]:={'ü'}#188;
//     'ç' : sss[i]:=#172;//'è';
//    'ç' : sss[i]:=#172;//'è';
//    'è' : sss[i]:=#198;//'∆';

    '∆'  : sss[i]:='è';



     '‰' : sss[i]:='Ñ';
     'ƒ' : sss[i]:='é';
     '¸' : sss[i]:='Å';
     '‹' : sss[i]:='ö';
     'ˆ' : sss[i]:='î';
     '÷' : sss[i]:='ô';
     'ﬂ' : sss[i]:='·';


//    '±'  : sss[i]:='•' ;
//    '∂'  : sss[i]:= 'ò' ;
//    '¶'  : sss[i]:= 'ó' ;


   end;
end;


procedure konMazL2;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
            'Ü' :sss[i]:='ç';
            '´' :sss[i]:='¶';
            'ò' :sss[i]:='û';
            'æ' :sss[i]:='ß';
            '¢' :sss[i]:='¢';
            '‰' :sss[i]:='§';
            '©' :sss[i]:='ë';
            'à' :sss[i]:='í';
            '•' :sss[i]:='Ü';
            'è' :sss[i]:='ï';
            'ç' :sss[i]:='†';
            'ó' :sss[i]:='ò';
            'Ω' :sss[i]:='°';
            '‡' :sss[i]:='£';
            '„' :sss[i]:='•';
            '®' :sss[i]:='ê';
            'ù' :sss[i]:='ú';
            '§' :sss[i]:='è';

   end;
end;
procedure kon852Maz(var sss : string);
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
            'ç':sss[i]:='Ü';
            '¶':sss[i]:='´';
            'û':sss[i]:='ò';
            'ß':sss[i]:='æ';
//            '¢' :sss[i]:='¢';
            '§':sss[i]:='‰';
            'ë':sss[i]:='©';
            'í':sss[i]:='à';
            'Ü':sss[i]:='•';
            'ï':sss[i]:='è';
            '†':sss[i]:='ç';
            'ò':sss[i]:='ó';
            '°':sss[i]:='Ω';
            '£':sss[i]:='‡';
            '•':sss[i]:='„';
            'ê':sss[i]:='®';
            'ú':sss[i]:='ù';
            'è':sss[i]:='§';

   end;
end;

procedure kon852Maz(var sss : ansistring);
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
            'ç':sss[i]:='Ü';
            '¶':sss[i]:='´';
            'û':sss[i]:='ò';
            'ß':sss[i]:='æ';
//            '¢' :sss[i]:='¢';
            '§':sss[i]:='‰';
            'ë':sss[i]:='©';
            'í':sss[i]:='à';
            'Ü':sss[i]:='•';
            'ï':sss[i]:='è';
            '†':sss[i]:='ç';
            'ò':sss[i]:='ó';
            '°':sss[i]:='Ω';
            '£':sss[i]:='‡';
            '•':sss[i]:='„';
            'ê':sss[i]:='®';
            'ú':sss[i]:='ù';
            'è':sss[i]:='§';

   end;
end;


procedure oldkon1250;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
    '≥': sss[i]:= 'à';
{    'ú': sss[i]:='û';}
{    'Ê': sss[i]:='ç';}
//    #178 : sss[i]:= '≥' ;
   '„' : sss[i]:='π';

   'å'  : sss[i]:= 'ó' ;
    #199 : sss[i]:= 'ø' ;
    'Í'  : sss[i]:= '©' ;
    '£'  : sss[i]:= 'ù' ;
    '•'  : sss[i]:= '§' ;{A}
//    'π'  : sss[i]:= '•' ;{a}
//    'ú'  : sss[i]:= 'ò' ;
    'Ê'  : sss[i]:= 'Ü' ;
    'Û'  : sss[i]:= '¢' ;
    'Ø'  : sss[i]:= 'Ω' ;
    'Ò'  : sss[i]:= '‰' ;
    'ø'  : sss[i]:= 'æ' ;
//    '—'  : sss[i]:= '•' ;
    ' '  : sss[i]:='®';
    '”'  : sss[i]:='‡';
    'ü'  : sss[i]:='´';
    'è'  : sss[i]:='ç';
    '∆'  : sss[i]:='è';
   end;
end;

function kom852UTF;
var
  i : integer;
  sb,
  sa : ansiString;
begin
   sa:='';
   for i := 1 to length(sss) do begin
     case sss[i] of
//     'à' : sss[i]:='≥';
     'à' : sb:='≈Ç';
//     '—' : sss[i]:=#221;
//     #136: sss[i]:='≥';
//     'û' : sss[i]:='ú';
     'û' : sb:='≈õ';


//     '≥' : sss[i]:=#178;
//     'ù' : sss[i]:='£';
     'ù' : sb:='≈Å';
//     'ó' : sss[i]:='å';
     'ó' : sb:='≈ö';
//     'ø' : sss[i]:=#220;
//     '©' : sss[i]:='Í';
     '©' : sb:='ƒô';
//     '•' : sss[i]:='π';
     '•' : sb:='ƒÖ';
//     'ò' : sss[i]:='ú';
     'ò' : sb:='≈õ';
//     'Ü' : sss[i]:='Ê';
     'Ü' : sb:='ƒá';
//     '¢' : sss[i]:='Û';
     '¢' : sb:='√≥';
//     '§' : sss[i]:='•';
     '§' : sb:='ƒÑ';
//     'Ω' : sss[i]:='Ø';
     'Ω' : sb:='≈ª';
//     '°' : sss[i]:= '§' ;
//     '‰' : sss[i]:='Ò';
     '‰' : sb:='≈Ñ';
//     'æ' : sss[i]:='ø';
     'æ' : sb:='≈º';
//     '„' : sss[i]:='—';
     '„' : sb:='≈É';
//     '®' : sss[i]:=' ';
     '®' : sb:='ƒò';
//     '‡' : sss[i]:='”';
     '‡' : sb:='√ì';
//     '´' : sss[i]:='ü';
     '´' : sb:='≈∫';
//     'ç' : sss[i]:='è';
     'ç' : sb:='≈ª';
//   'è' : sss[i]:='∆';
     'è' : sb:='ƒÜ';


      '&' : sb:='_';

     else
     sb:=sss[i];

     end;
     sa:=sa+sb;
   end;
   result:=sa;
end;


procedure konWinL2A;
var
  i : integer;
begin
  for i := 1 to length(sss) do
   case sss[i] of
    '≥': sss[i]:= 'à';
{    'ú': sss[i]:='û';}
{    'Ê': sss[i]:='ç';}
    #178 : sss[i]:= '≥' ;
   'å'  : sss[i]:= 'ó' ;
    #199 : sss[i]:= 'ø' ;
    'Í'  : sss[i]:= '©' ;
    '£'  : sss[i]:= 'ù' ;
    'π'  : sss[i]:= '•' ;
    'ú'  : sss[i]:= 'ò' ;
    'Ê'  : sss[i]:= 'Ü' ;
    'Û'  : sss[i]:= '¢' ;
    '•'  : sss[i]:= '§' ;
    'Ø'  : sss[i]:= 'Ω' ;
    'Ò'  : sss[i]:= '‰' ;
    'ø'  : sss[i]:= 'æ' ;
    '—'  : sss[i]:= '„' ;
    ' '  : sss[i]:='®';
    '”'  : sss[i]:='‡';
    'ü'  : sss[i]:='´';
    'è'  : sss[i]:='ç';
    '∆'  : sss[i]:='è';
    '±'  : sss[i]:='•' ;
    '∂'  : sss[i]:= 'ò' ;
    '¶'  : sss[i]:= 'ó' ;


     '‰' : sss[i]:='Ñ';
     'ƒ' : sss[i]:='é';
     '¸' : sss[i]:='Å';
     '‹' : sss[i]:='ö';
     'ˆ' : sss[i]:='î';
     '÷' : sss[i]:='ô';
     'ﬂ' : sss[i]:='·';


   end;
end;










function dolar(kk:double;szer,ln : word;wal:string):ansistring;
var
  ss,
  sss : string[255];

  lll,
  c2    : word;

//  dol   : string;
begin
//  lnn:=0;
//  dol:='';
  kk:=okrg(kk);
  sss:=nDolar[35]+dolar2(kk);

  c2:=round(frac(kk)*100);
  lll:=c2 mod 100;
  if lll <> 0 then begin
    ss:='AND '+lf(lll,3)+'/100 ';
    sss:=sss+ss;
  end;
  sss:=sss+wal;
  {
  poz:=12;
  i:=12;
  while i<length(sss) do begin
    inc(poz);
    inc(i);
    if (sss[i] = ' ') and ( (poz > szer-sz1) ) then begin
      inc(lnn);
      if lnn=ln then poz1:=i;
      if lnn=ln+1 then poz2:=i-poz1;
      poz:=1
    end;
  end;
  if (ln>0) and (poz1=1) then poz1:=255;
  if poz2=0 then poz2:=255;
  dolar:=trim(copy(sss,poz1,poz2));
  }
  result:=sss;
end;


function  marka(kk:double;szer,ln : word;wal:string):ansistring;
var
  c1,c2 : longint;
  cc2: double;
  ss : ansistring;
  lll: longint;
  cyfra : integer;


procedure liczba(cc: longint;var ss:ansistring);
var
  cyfra,cyfra3,cyfra2 : integer;
begin
  cyfra:=cc mod 10;
  cyfra2 := (cc div 10) mod 10;
  ss:=nmarka[cyfra2+20]+ss;
  cyfra3 := (cc div 100) mod 10;
  if cyfra2 = 1 then ss:=nmarka[cyfra]+ss
                else  if cyfra <> 0 then begin
                   if cyfra2=0 then ss:=nmarka[cyfra+10]+ss
                   else if cyfra=1 then ss:='einund'+ss
                   else  ss:=nmarka[cyfra+10]+'und'+ss;
                end;
{  ss:=nmarka[cyfra3+30]+ss;}
  if cyfra3>0 then begin
    if cyfra3=1 then ss:='ein'+nMarka[31]+ss
    else ss:=nMarka[cyfra3+10]+nMarka[31]+ss;
  end;
end;

procedure tys(lll,ww:longint;var ss:string);
begin
   if (lll mod 1000 ) = 1 then ss:=nmarka[ww]{' tysiÜc '} + ss
   else begin
     if (lll mod 100) in [12..19] then ss:=nmarka[ww+2]{' tysiëcy '}+ss
     else begin
       cyfra := lll mod 10;
       case cyfra of
         0,1,5,6,7,8,9 : ss:=nmarka[ww+2]+ss;
         2,3,4         : ss:=nmarka[ww+1]{'tysiÜce '}+ss;
       end;
     end;
   end;
end;

begin
  ss:=' '+wal;
{  sss:=' DM';}
  c2:=round(frac(kk)*100);
  lll:=c2 mod 100;
  if lll <> 0 then begin
    ss:=' '+lf(lll,3)+'/100'+ss;
{    sss:=sss+ss;}
  end;


  c2:=trunc(kk/1000000);
  cc2:=c2;
  c1:=trunc(kk-(cc2*1000000));
  (*
  if (c1 mod 100) in [12..19] then ss:=nmarka[36]+ss {' zíotych'}
  else begin
   cyfra := c1 mod 10;
   case cyfra of
    0,1,5,6,7,8,9 : ss:=nmarka[36]+ss;{' zíotych';}
    2,3,4         : ss:=nmarka[36]+ss;{' zíote';}
    end;
  end;
  *)
  lll:=(c1 mod 1000);
    liczba(lll,ss);
  lll:=(c1 div 1000) mod 1000;
  if lll <> 0 then begin
    ss:=nmarka[32]+ss;
    liczba(lll,ss);
  end;
  lll:=c2  mod 1000;
  if lll <> 0 then begin
     ss:=nmarka[33]+ss;
    liczba(lll,ss);
  end;
  lll:=(c2 div 1000) mod 1000;
  if lll <> 0 then begin
     ss:=nmarka[34]+ss;
    liczba(lll,ss);
  end;
  marka:=nmarka[35]+ss;
end;




function slownieV;
var
  ss,
  sss : ansistring;
  poz,i : integer;
  s5    : string[4];
  lll,ii,
  c2    : integer;
  poz1,poz2 : integer;
    lnn,
  sz1   : word;

  kkz   : double;
  nas   : boolean;
begin
  lnn:=0;
  poz1:=1;poz2:=0;
  kk:=abs(kk);

  kk:=okrg(kk);
  kkz:=system.int(kk+0.00001);
  if szer >50 then sz1:=18 else sz1:=13;
  if ajezyk=0 then begin
    sss:=nZloty[54]+zloty2(kkZ);
    s5:=nZloty[40];
    i:=pos(s5,sss);
    delete(sss,i,10);
    c2:=round(frac(kk)*100);
    lll:=c2 mod 100;
    if lll <> 0 then begin
      ss:=lf(lll,3)+'/100 ';
      sss:=sss+ss;
    end;
    sss:=sss+wal;
  end else if ajezyk=1 then begin
    sss:=dolar(kk,szer,0 ,wal)
  end else  if ajezyk=2 then begin
    sss:=marka(kk,szer,0 ,wal)
  end else sss:='';



  poz:=12;
  i:=12;
  while i<length(sss) do begin
    inc(poz);
    inc(i);
    if (sss[i] = ' ') and ( (poz > szer-sz1) ) then begin
      nas:=false;
      if poz<szer-4 then
      for ii:= i+1 to i+szer-poz-1 do if sss[ii]=' ' then nas:=true;
      if szer> (length(sss)-poz1+1) then nas:=true;
      if nas then continue;
      inc(lnn);
      if lnn=ln then poz1:=i;
      if lnn=ln+1 then poz2:=i-poz1;
      poz:=1
    end;
  end;
  if (ln>0) and (poz1=1) then poz1:=255;
  if poz2=0 then poz2:=255;
  result:=trim(copy(sss,poz1,poz2));
end;



function jx(const sa,sb : ansistring):tObjectTuple;
begin
  result.s:=sa+':"'+sb+'"';
end;

function jx(const sa : ansistring;const sb : tJObject):tObjectTuple;
begin
  result.s:=sa+':'+sb.s;
end;
function jx(const sa : ansistring;sb : double):tObjectTuple;
begin
  result.s:=sa+':'+dbl4str(sb);
end;

function jobject(const sa:ansiString):tJObject;
begin
  result.s:='"'+sa+'"';
end;

function jObject(a : double):tJObject;
begin
  result.s:=dbl4str(a);
end;

function jObject(const value: tObjectTuple):tJObject;
begin
       result.s:='{'+value.s+'}';
end;

function jObject(values : array of tObjectTuple):tJObject;

var
  i : integer;
begin
    result.s:='';
    for i:=Low(Values) to High(Values) do begin
//       if result.s<>'' then
//         result.s:=result.s+',';
       result.s:=result.s+','+values[i].s;
    end;
    result.s:=result.s+'}';
    result.s[1]:='{';

end;

function jArray(values : array of tJObject):ansiString;

var
  i : integer;
begin
    result:='';
    for i:=Low(Values) to High(Values) do begin
       result:=result+','+values[i].s;
    end;
    if result<>'' then begin
      result:=result+']';
      result[1]:='[';
    end else begin
      result:='[]';
    end;

end;

function jArray(values : ansistring ;ch:char):tJObject;overload;
var
  i,strt,cnt : integer;
  sepLen: Integer;


    procedure AddString(aEnd: Integer = -1);
    var
      endPos: Integer;
    begin
      if (aEnd = -1) then
        endPos := i
      else
        endPos := aEnd + 1;

      if (strt < endPos) then
        result.s := result.s+',"'+Copy(values, strt, endPos - strt)+'"'
      else
//        result[cnt] := '';

      Inc(cnt);
    end;


begin
    result.s:='';
    i:=1;
    strt  := i;
    cnt   := 0;
    sepLen:=1;
    while (i <= (Length(values)- sepLen + 1)) do
    begin
      if (values[i] = ch) then begin
 //       if (Copy(aString, i, sepLen) = aSeparator) then
           AddString;
          Inc(i, sepLen - 1);
          strt := i + 1;
      end;
      Inc(i);
    end;
    AddString(Length(values));
  if result.s<>'' then begin
    result.s:=result.s+']';
    result.s[1]:='[';
  end else
    result.s:='[]';

end;





  function pX(const sa,sb : ansistring;removeempty:boolean=false):utf8String;overload;
  begin
    if removeempty and (sb='') then result:=''
    else
    result:='<'+sa+'>'+sb+'</'+sa+'>';
  end;
  function px(const sa : ansistring;sb : double;removeempty:boolean=false):utf8String;overload;
  begin
    if removeEmpty and (sb=0) then
      result:=''
    else
      result:=px(sa,dbl4str(sb))
  end;

  function px(const sa : ansistring;sb : tData;removeempty:boolean=false):utf8String;overload;
  begin
    if removeEmpty and (sb=0) then
      result:=''
    else
      result:=px(sa,datetoDateString('yyyy-mm-dd',sb))
  end;


  function px(const sa : ansistring;const sb : int64;removeempty:boolean=false):utf8String;overload;
  begin
    if removeEmpty and (sb=0) then
      result:=''
    else
      result:=px(sa,inttostr(sb))
  end;




  {
  function pXC;
  begin
    czyscxml(sb);
    result:='<'+sa+'>'+czyscXML(sb)+'</'+sa+'>'#13#10;
  end;
  }
  function pxcd(const sa,sb : ansistring):ansiString;
  begin
    result:='<'+sa+'><![CDATA['+sb+']]></'+sa+'>'#13#10;
  end;
  {
  function pxutf;
  var
    cn : ANSIstring;
  begin
      cn:=sb;
      kon852a(cn);
      konwinutfa(cn);
      result:='<'+sa+'><![CDATA['+cn+']]></'+sa+'>'#13#10;

  end;
  }
  function pxutf(const sa,sb : ansistring;removeempty:boolean=false):ansiString;
  begin
    if removeempty and (sb='') then result:=''
    else begin
      result:='<'+sa+'>'+cleanXML(sb)+'</'+sa+'>'#13#10;
    end;

  end;

  function pxu(const sa,sb : ansistring;removeempty:boolean=false):utf8String;
  var
    cn : ANSIstring;
  begin
    if removeempty and (sb='') then result:=''
    else begin
      cn:=sb;
      kon852a(cn);
      konwinutfa(cn);
//      czyscxml(sb);
      result:='<'+sa+'>'+cleanXML(cn)+'</'+sa+'>'#13#10;
    end;

  end;
  function py;
  begin
//    czyscxml(sb);
    result:='<'+sa+' '+sb+'/>'#13#10;
  end;
  function pyc;
  begin
    result:='<'+sa+' '+cleanXML(sb)+'/>'#13#10;
  end;
  function pz;
  begin
    result:='<'+sa+' '+sc+'>'+sb+'</'+sa+'>'#13#10;
  end;
  function pzc;
  begin
    cleanxml(sb);
    result:='<'+sa+' '+sc+'>'+sb+'</'+sa+'>'#13#10;
  end;

    function znajdzKoniec(apc : pchar;const smOut : ansiString;const stoken : ansistring):integer;
    var
      pcs,
      pc1,
      pce : pchar;
      znalaz : boolean;
      sz : string;
      scc : ansiString;

      k1 : nativeint;
      xt  : integer;
      xLevel : integer;
    begin
      znalaz:=false;
      pce:=apc;
      xLevel:=1;
      result:=-1;
      repeat
        pcs:=pce;
        pce:=ansistrPos(pcs,pchar(stoken));
        if pce=nil then exit;
        k1:=pce-@(smout[1]);
        sz:=copy(smout,k1,length(stoken)+3);
        xt:=length(stoken);
        inc(pce,xt);
        if sz[xt+2]=#10 then inc(xt);
        if not (sz[xt+2] in [' ','/','>']) then continue;
        if (sz[1]='<')  then begin
          scc:='>';
          inc(xLevel);
          pc1:=ansistrPos(pce,pchar(scc));
          if (pc1<>nil) then begin
            pce:=pc1;
            dec(pce,1);
            if pce^='/' then
               dec(xLevel);

          end;

          continue;
        end;
        if (sz[1]='/') then begin
          dec(xLevel);
          if xLevel=0 then begin
            result:=k1-1;
            exit;
          end;
        end;


      until znalaz;
    end;


    function znajdzKoniecU(apc : pchar;const smOut : utf8String;const stoken : utf8string):integer;
    var
      pcs,
      pc1,
      pce : pchar;
      znalaz : boolean;
      sz : string;
      scc : utf8String;

      k1 : nativeint;
      xt  : integer;
      xLevel : integer;
    begin
      znalaz:=false;
      pce:=apc;
      xLevel:=1;
      result:=-1;
      repeat
        pcs:=pce;
        pce:=ansistrPos(pcs,pchar(stoken));
        if pce=nil then exit;
        k1:=pce-@(smout[1]);
        sz:=copy(smout,k1,length(stoken)+3);
        xt:=length(stoken);
        inc(pce,xt);
        if sz[xt+2]=#10 then inc(xt);
        if not (sz[xt+2] in [' ','/','>']) then continue;
        if (sz[1]='<')  then begin
          scc:='>';
          inc(xLevel);
          pc1:=ansistrPos(pce,pchar(scc));
          if (pc1<>nil) then begin
            pce:=pc1;
            dec(pce,1);
            if pce^='/' then
               dec(xLevel);

          end;

          continue;
        end;
        if (sz[1]='/') then begin
          dec(xLevel);
          if xLevel=0 then begin
            result:=k1-1;
            exit;
          end;
        end;


      until znalaz;
    end;


  function xmlwytnijS(const sm1: ansistring ;var sm2 : ansiString;usun : boolean;jcc : integer=0):ansiString;
  var
    shh : ansiString;
  begin
    result:=xmlWytnijSH(sm1,sm2,shh,usun,jcc);
  end;

  function xmlwytnijS(const sm1: utf8string ;var sm2 : utf8String;usun : boolean;jcc : integer=0):utf8String;
  var
    shh : utf8String;
  begin
    result:=xmlWytnijSH(sm1,sm2,shh,usun,jcc);
  end;


  procedure zeroString(var sm : ansiString;aPocz,aKon:integer);overload;

  var
    i : integer;
  begin
    if aPocz>length(sm) then exit;
    if aKon>length(sm) then aKon:=length(sm);
    for i := aPocz to aKon do
      sm[i]:=' ';
  end;
  procedure zeroString(var sm : utf8String;aPocz,aKon:integer);overload;

  var
    i : integer;
  begin
    if aPocz>length(sm) then exit;
    if aKon>length(sm) then aKon:=length(sm);
    for i := aPocz to aKon do
      sm[i]:=' ';
  end;


  procedure zeroStringUtf(var sm : utf8String;aPocz,aKon:integer);

  var
    i : integer;
  begin
    if aPocz>length(sm) then exit;
    if aKon>length(sm) then aKon:=length(sm);
    for i := aPocz to aKon do
      sm[i]:=' ';
  end;



  function xmlwytnij(const sm1: utf8string ;var sm2,shh : utf8String;usun : boolean;jcc : integer=0):utf8String;
  var
    i1,i2,
    iStart,
    iStop : integer;
    sa : utf8string;
    scc,
    sn : utf8String;
    pcc,
    pc1 : pchar;


  begin

    sa:='<'+sm1+'>';
    i1:=ansipos(sa,sm2);
    istart:=i1;
    shh:='';
    i1:=iStart+length(sa);
    if iStart=0 then begin
      if sm2='' then begin
         shh:='';
         result:='';
         exit;
      end;
      sa:='<'+sm1+' ';
      i1:=ansipos(sa,sm2);
      istart:=i1;
      if i1>0 then begin
         pcc:=@(sm2[i1]);
         scc:='>';

        pc1:=ansistrPos(pcc,pchar(scc));
        i2:=pc1-pcc+1;
        if i2>0 then begin
           shh:=copy(sm2,i1,i2);
           i1:=i1+i2;
           if shh[i2-1]='/' then begin
             if usun then begin
                delete(sm2,istart,i2);
             end;
             result:='';
             exit;
           end;
        end else i1:=0;
      end;
    end;
    pcc:=@(sm2[i1]);


    if i1=0 then begin
      sa:='<'+sm1+'/>';
      i1:=ansipos(sa,sm2);
      if i1>0 then begin
        if usun then begin
          i2:=length(sm1)+3;
          delete(sm2,i1,i2);
        end;
        result:='';
        exit;
      end;
    end;
{    sb:='</'+sm1+'>';
    i2:=ansiPos(sb,sm2);
    istop:=i2;}
    i2:=znajdzKoniecU(pcc,sm2,sm1);
    if (i1>0) and (i2>i1) then begin
//      i1:=i1+length(sa);

      sn:=copy(sm2,i1,i2-i1);
      if usun then begin
        iStop:=i2+length(sm1)+3;
        if length(sm2)>100000 then begin
          zerostringUtf(sm2,iStart,iStop-1);
        end else
          delete(sm2,iStart,iStop-iStart);
      end;
    end else sn:='';
    if (sn<>'') and (sn[1]='<') and (sn[2]='!') and (sn[3]='[') then begin
      delete(sn,1,9);
      delete(sn, length(sn)-2,2);
    end;
    if jcc=jCodeUtf then begin
      sn:=komUtf852A(strHtmlDecode(sn));
    end;
    result:=sn;
  end;

  function xmlwytnijSH(const sm1: utf8string ;var sm2,shh : utf8String;usun : boolean;jcc : integer=0):utf8String;
  var
    i1,i2,
    xl,
    iStart,
    iStop : nativeint;
    sa : utf8string;
    scc,
    sn : ansiString;
    pcc,
    pc1 : pchar;


  begin

    sa:='<'+sm1+'>';
    xl:=length(sm1);
    iStart:=ansipos(sa,sm2);
    shh:='';
    i1:=iStart+length(sa);
    if iStart=0 then begin
      if sm2='' then begin
         shh:='';
         result:='';
         exit;
      end;
      sa:='<'+sm1+' ';
      i1:=ansipos(sa,sm2);
      if i1=0 then begin
        sa:='<'+sm1+#10;
        i1:=ansipos(sa,sm2);
      end;
      istart:=i1;
      if i1>0 then begin
         i1:=i1+xl+1;
         pcc:=@(sm2[i1]);
         scc:='>';

        pc1:=ansistrPos(pcc,pchar(scc));

        i2:=pc1-pcc+1;
        if i2>0 then begin
           shh:=copy(sm2,i1,i2-1);
           if jcc=jCodeUtf then begin
                 shh:=komUtf852A(strHtmlDecode(shh));
           end;

           i1:=i1+i2;
           if shh[i2-1]='/' then begin
             if usun then begin
                delete(sm2,istart,i2);
             end;
             result:='';
             exit;
           end;
        end else i1:=0;
      end;
    end;
    pcc:=@(sm2[i1]);


    if i1=0 then begin
      sa:='<'+sm1+'/>';
      i1:=ansipos(sa,sm2);
      if i1>0 then begin
        if usun then begin
          i2:=length(sm1)+3;
          delete(sm2,i1,i2);
        end;
        result:='';
        exit;
      end;
    end;
{    sb:='</'+sm1+'>';
    i2:=ansiPos(sb,sm2);
    istop:=i2;}
    i2:=znajdzKoniecU(pcc,sm2,sm1);
    if (i1>0) and (i2>i1) then begin
//      i1:=i1+length(sa);

      sn:=copy(sm2,i1,i2-i1);
      if usun then begin
        iStop:=i2+length(sm1)+3;
        if length(sm2)>100000 then begin
          zerostring(sm2,iStart,iStop-1);
        end else
          delete(sm2,iStart,iStop-iStart);
      end;
    end else sn:='';
    if (sn<>'') and (sn[1]='<') and (sn[2]='!') and (sn[3]='[') then begin
      delete(sn,1,9);
      delete(sn, length(sn)-2,2);
    end;
//    if jcc=jCodeUtf then konUtfWinA(sn);
    if jcc=jCodeUtf then begin
      sn:=komUtf852A(strHtmlDecode(sn));
    end;
//    if jcc=jcode1250 then konWinL2A(sn);
    result:=sn;

  end;


  function xmlwytnijSH(const sm1: ansistring ;var sm2,shh : ansiString;usun : boolean;jcc : integer=0):ansiString;
  var
    i1,i2,
    xl,
    iStart,
    iStop : nativeint;
    sa : ansistring;
    scc,
    sn : ansiString;
    pcc,
    pc1 : pchar;


  begin

    sa:='<'+sm1+'>';
    xl:=length(sm1);
    i1:=ansipos(sa,sm2);
    istart:=i1;
    shh:='';
    i1:=iStart+length(sa);
    if iStart=0 then begin
      if sm2='' then begin
         shh:='';
         result:='';
         exit;
      end;
      sa:='<'+sm1+' ';
      i1:=ansipos(sa,sm2);
      if i1=0 then begin
        sa:='<'+sm1+#10;
        i1:=ansipos(sa,sm2);
      end;
      istart:=i1;
      if i1>0 then begin
         i1:=i1+xl+1;
         pcc:=@(sm2[i1]);
         scc:='>';

        pc1:=ansistrPos(pcc,pchar(scc));

        i2:=pc1-pcc+1;
        if i2>0 then begin
           shh:=copy(sm2,i1,i2-1);
           if jcc=jCodeUtf then begin
                 shh:=komUtf852A(strHtmlDecode(utf8string(shh)));
           end;

           i1:=i1+i2;
           if shh[i2-1]='/' then begin
             if usun then begin
                delete(sm2,istart,i2);
             end;
             result:='';
             exit;
           end;
        end else i1:=0;
      end;
    end;
    pcc:=@(sm2[i1]);


    if i1=0 then begin
      sa:='<'+sm1+'/>';
      i1:=ansipos(sa,sm2);
      if i1>0 then begin
        if usun then begin
          i2:=length(sm1)+3;
          delete(sm2,i1,i2);
        end;
        result:='';
        exit;
      end;
    end;
{    sb:='</'+sm1+'>';
    i2:=ansiPos(sb,sm2);
    istop:=i2;}
    i2:=znajdzKoniec(pcc,sm2,sm1);
    if (i1>0) and (i2>i1) then begin
//      i1:=i1+length(sa);

      sn:=copy(sm2,i1,i2-i1);
      if usun then begin
        iStop:=i2+length(sm1)+3;
        if length(sm2)>100000 then begin
          zerostring(sm2,iStart,iStop-1);
        end else
          delete(sm2,iStart,iStop-iStart);
      end;
    end else sn:='';
    if (sn<>'') and (sn[1]='<') and (sn[2]='!') and (sn[3]='[') then begin
      delete(sn,1,9);
      delete(sn, length(sn)-2,2);
    end;
//    if jcc=jCodeUtf then konUtfWinA(sn);
    if jcc=jCodeUtf then begin
      sn:=komUtf852A(strHtmlDecode(utf8string(sn)));
    end;
    if jcc=jcode1250 then konWinL2A(sn);
    result:=sn;
  end;

  function xmlWytnijHeader(sm1 : string;var sm2 : utf8String;usun:boolean;jcc : integer=0):utf8String;
  var
    i2 ,
    i1 : nativeint;
    sa : string;
    scc : ansiString;
    pcc,
    pc1 : pchar;
  begin
      sa:=' '+sm1+'="';
      i1:=ansipos(sa,sm2);
      result:='';
      if i1>0 then begin
         pcc:=@(sm2[i1+length(sa)]);
         scc:='"';

        pc1:=ansistrPos(pcc,pchar(scc));
        i2:=pc1-pcc;
        if i2>0 then begin
           result:=copy(sm2,i1+length(sa),i2);
        end else i2:=0;
        if usun then begin
          delete(sm2,i1,i2+length(sa)+1);
        end;
      end;

  end;


  function xmlwytnijDbl(sm1: string ;var sm2 : utf8String;us : boolean):double;
  var
    Sdbl : String;
    dbl  : double;
    io   : integer;
  begin
     sdbl:=xmlwytnijS(sm1,sm2,us);
     io:= ansiPos(',',sdbl);
     if io>0 then sdbl[io]:='.';
     val(sdbl,dbl,io);
     if io =0 then result:=dbl
              else result:=0;
  end;
  function xmlwytnijData(sm1: string ;var sm2 : utf8String;us : boolean):tData;
  var
    Sdbl : String;
  begin
     sdbl:=xmlwytnijS(sm1,sm2,us);
     result:=datestringToDate('yyyy-mm-dd',sdbl);
  end;
  function xmlwytnijInt(sm1: string ;var sm2 : ansiString;us : boolean):int64;
  var
    Sdbl : ansiString;
    dbl  : int64;
    io   : integer;
  begin
     sdbl:=xmlwytnijS(sm1,sm2,us);
     val(sdbl,dbl,io);
     if io =0 then result:=dbl
              else result:=0;
  end;
  function xmlwytnijInt(sm1: string ;var sm2 : utf8String;us : boolean):int64;
  var
    Sdbl : utf8String;
    dbl  : int64;
    io   : integer;
  begin
     sdbl:=xmlwytnijS(sm1,sm2,us);
     val(sdbl,dbl,io);
     if io =0 then result:=dbl
              else result:=0;
  end;



  procedure xmlInsertS(sm1: string ;const smIn: ansiString;var smout : ansiString);
  var

    sa : ansiString;
    i1,i2 : integer;
    iStart,iStop : integer;
    pcc : pchar;



  begin
    if smOut<>'' then begin
      sa:='<'+sm1+'>';
      i1:=ansipos(sa,smout);
      iStart:=i1;
      i1:=iStart+length(sa);
      if iStart=0 then begin
        sa:='<'+sm1+' ';
        i1:=ansipos(sa,smout);

        istart:=i1;
      end;
      pcc:=@(smout[i1]);
      i2:=znajdzKoniec(pcc,smout,sm1);
    end else begin
      i1:=0;
      i2:=0;
      iStart:=0;
    end;
    if (i1>0) and (i2>i1) then begin
      if smin='' then begin
        iStop:=i2+length(sm1)+3;
        delete(smout,iStart,iStop-iStart);
      end else begin
        sa:=copy(smout,i1,i2-i1);
        if sa<>smin then begin
          delete(smOut,i1,i2-i1);
          insert(smin,smout,i1);
        end;
      end;
    end else begin
     smOut:=smOut+px(sm1,smIn,true);
    end;






  end;


  function cleanxml(const ss : ansistring):ansiString;
  var
    i : integer;
  begin
//  https://www.owasp.org/index.php/XSS_%28Cross_Site_Scripting%29_Prevention_Cheat_Sheet
    setLength(result,length(ss));
    result:='';
    for i:= 1 to length(ss) do begin
     case ss[i] of
       #$A0: result:=result+' ';
       '"' : result:=result+'&quot;';
       '&' : result:=result+'&amp;';
       '>' : result:=result+'&gt;';
       '<' : result:=result+'&lt;';
       '/' : result:=result+'&#x2F;';
       #10: result:=result+'&#xA;';
       #13: result:=result+'&#xD;';
     else
       result:=result+ss[i]
     end;
    end;
//    result:=ss;

  end;
  function czyscTXT(ss : ansiString):ansiString;
  var
    i : integer;
  begin
    for i:= 1 to length(ss) do begin
     if ss[i] in [#9,'''','^','|',#178] then ss[i]:=' ';
//     else if ss[i]
//     if ss[i] in ['<','>','&'] then ss[i]:='_';
    end;
    result:=ss
  end;

  function czyscTytulExcel(ss : string):ansistring;
  var
    io : integer;
  begin
      result:=trim(stupcaseWin(ss));
      io:=length(result);
      while io>0 do begin
         if result[io] in [' ','-','.','_']  then delete(result,io,1);
         dec(io);
      end;

  end;

  function nipXML;
  var
    i : integer;
  begin
    result:='';
    for i:= 1 to length(ss) do begin

     if ss[i] in ['0'..'9'] then result:=result+ss[i]
    end;
  end;

  {
  function dajLinie;
    var
    ii : integer;
  begin
    ii:=pos(#13,sca);
    result:=copy(sca,1,ii-1);
    delete(sca,1,ii+1);
    if (sca<>'') and (sca[1]=#10) then delete(sca,1,1);

  end;
  }



function wytnijStringcss(var sca : ansiString;spocz,skon : ansiString):ansiString;
var
  ip,ik : integer;
begin
  result:='';
  if skon='' then exit;
  ip:=pos(sPocz,sca);
  if ip>0 then begin
     ik:=ip+length(spocz);
     ip:=ik;
     while ik<length(sca) do begin
        if sca[ik]=skon[1] then begin
           if copy(sca,ik,length(skon))=skon then begin
              result:=copy(sca, ip,ik-ip);
              exit;
           end;
        end;
        inc(ik);
     end;
  end;
end;


(*
{$R spin}
procedure additembmp(mi : tMenu;x1 : word;resa,resb:string);
var
  tba,
  tbb : tBitmap;
  bb  : boolean;
begin
  with mi do begin
      tba:=tBitmap.create;
      tbb:=tbitmap.create;
      tba.LoadFromResourceName(hinstance,resa);
      tbb.LoadFromResourceName(hinstance,resb);
   {   mi.insertcomponent(tba);    timage
      mi.insertComponent(tbb);
      }
      bb:=setmenuitembitmaps(mi.handle,x1,mf_byposition, tba.handle,tbb.handle);
   end;
end;
*)


function wytnijNickAllegro;
var
  ia ,ib : integer;
  s1     : string;
  function jestLiczba(snn : string):boolean;
  var
     i : integer;
  begin
    result:=true;

    for i := 1 to length(snn) do
      if not (snn[i] in numberOnlyset) then begin
        result:=false;
        exit;
      end;

  end;

begin
  result:=false;
  sm1:=trim(sm1);
  sm2:='';
  ib:=pos(')',sm1);
  if ib=length(sm1) then begin
    ia:=pos('(',sm1);
    if (ia<ib) and (ia>0) then begin
       s1:=copy(sm1,ia+1,ib-ia-1);
       if jestLiczba(s1) then begin
         result:=true;
         sm2:='AL:'+copy(sm1,1,ia-1);
       end;
    end;
  end;
end;


   function czytajString(const aStream : tStream):rawString;
   var
     xx : longint;
   begin
     if not assigned(astream) then begin
       result:='';
       exit;
     end;
       try
         xx:=aStream.size;
         setstring(result,nil,xx);
         aStream.seek(0,0);
         astream.Read(Pointer(result)^, xx);
       except
          on e: exception do begin
            exit;
          end;
        end;

   end;

    function czytajString(const fname : filestring):rawString;
  var
    stm : tFileStream;
    xx  : longint;
  begin
     result:='';
     try
     stm:=nil;
       try
         stm:=tFilestream.create(fname,fmOpenRead+fmShareDenyNone);
         xx:=stm.size;
         setstring(result,nil,xx);
         Stm.Read(Pointer(result)^, xx);
       except
          on e: exception do begin
//            piszLog(4,'wydruk '+e.message,fName,61603,false);
            freeandnil(stm);
            setLastError(0);
            exit;
          end;
        end;
     finally
       freeandnil(stm);
       setLastError(0);
     end;
  end;
  function zapiszString(const sn : ansiString;const fname : filestring):boolean;
  begin
     with tFilestream.create(fname,fmCreate) do try
       write(Pointer(Sn)^, length(sn));
       result:=true;
     finally
       free;
       setLastError(0);
     end;
  end;


  procedure streamToFile(const sn : tStream;const fname : filestring);
  var
    ln  : int64;
  begin
     with tFilestream.create(fname,fmCreate) do try
        ln:=sn.Seek(0,soEnd);
        sn.seek(0,soBeginning);
        copyFrom(sn, ln);
     finally
       free;
       setLastError(0);
     end;
  end;

  procedure kopiujPlik;
  begin
  {.$IFDEF WIN32}
//    copyfile(pchar(sa),pChar(sb),false);
  {.$ELSE}

  try
    Wcopyfile(sa,sb);
  except
  end;
  {.$ENDIF}


  end;



function wytnijNrDokumentu;
var
  ip,ik,i  : integer;

begin
  ip:=0;
  ik:=length(sm);
  result:=-1;
  for i :=1 to length(sm) do begin
    if  ip=0 then begin
      if sm[i] in ['0'..'9'] then ip:=i;
    end else begin
      if not (sm[i] in ['0'..'9']) then begin
        ik:=i-1;
        break;
      end;
    end;
  end;
  if (ip<>0) and (ik<>0) then begin
    result:=str2Int(copy(sm,ip,ik-ip+1));

  end;

end;


procedure komcode( var s : string);overload;

begin
       {$IFNDEF WIN32}
//       writeln(jcharcode,s);
    if jcharcode=jcodeutf then    konWinUtfBB(s);
    if jcharcode=jcode88592 then    konWingtk(s);

//    writeln(s);

     {$ENDIF}
  if jcharCode=jCodeHTML then konLat8859(s);

end;

procedure komcode( var s : ansistring);overload;

begin
       {$IFNDEF WIN32}
    if jcharcode=jcodeutf then    konWinUtfA(s);
    if jcharcode=jcode88592 then    konWingtkA(s);

     {$ENDIF}

  if jcharCode=jCodeHTML then konLat8859A(s);

end;



procedure komcodeWin( var s : string);overload;

begin
       {$IFNDEF WIN32}
//       writeln(jcharcode,s);
    if jcharcode=jcodeutf then    konWinUtfBB(s);
    if jcharcode=jcode88592 then    konWingtk(s);

//    writeln(s);

     {$ENDIF}
  if jcharCode=jCodeHTML then konWingtk(s);

end;
procedure komcodeWin( var s : ansistring);overload;

begin
       {$IFNDEF WIN32}
    if jcharcode=jcodeutf then    konWinUtfA(s);
    if jcharcode=jcode88592 then    konWingtkA(s);

     {$ENDIF}

  if jcharCode=jCodeHTML then konWingtkA(s);

end;

function konCodeUtf(s : utf8String):ansiString;
begin
       {$IFNDEF WIN32}
    if jcharcode=jcodeutf then    result:=komWinUtf(s);
//    if jcharcode=jcode88592 then    konWingtkA(s);

     {$ENDIF}

//  if jcharCode=jCodeHTML then result:=konUtfgtkA(s);

end;


procedure komcodeINV( var s : string);overload;

begin
       {$IFNDEF WIN32}
    if jcharcode=jcodeutf then    konUtfWIn(s);
    if jcharcode=jcode88592 then    kongtkWin(s);

     {$ENDIF}

  if jcharCode=jCodeHTML then konWIn(s);

end;


procedure komcodeINV( var s : ansistring);overload;

begin
       {$IFNDEF WIN32}
    if jcharcode=jcodeutf then    komUtfWInA(s);
    if jcharcode=jcode88592 then    kongtkWinA(s);

     {$ENDIF}
  if jcharCode=jCodeHTML then konWInL2A(s);


end;


function wytnijCyfry(sm1:string):string;
var
  i : integer;
begin
  result:='';
  for i := 1 to length(sm1) do begin
    if sm1[i] in numberOnlyset then result:=result+sm1[i];
  end;
end;

function isEmail(const sm1 : ansistring):boolean;
var
  ia : integer;
  s  : string;
begin
  result:=false;
  ia:=pos('@',sm1);
  if ia=0 then exit;
  s:=copy(sm1,ia,length(sm1));
  ia:=pos('.',s);
  if ia<2 then exit;
  s:=copy(s,ia,length(s));
  if length(s)<3 then exit;
  result:=true;



end;

function toJest(const sm1 : ansistring):integer;
var
  ss : ansistring;

begin
 result:=0;
 if (length(sm1)=13) and (length(wytnijCyfry(sm1))=10) then begin
   result:=toJestNip;
   exit;
 end;


 if length(sm1)=9 then begin
   if (sm1[1] in numberOnlyset) and (sm1[2] in numberOnlyset) and (sm1[5] in numberOnlyset) and (sm1[8] in numberOnlyset) then begin
      result:=toJestTelefon;
      exit;
   end;
 end;

 if length(sm1)=11 then begin
   if (sm1[4] =' ') and (sm1[8] =' ') and (length(wytnijCyfry(sm1))=9) then begin
      result:=toJestTelefon;
      exit;
   end;
 end;
 if firstChar(sm1)='0' then begin
   ss:=copy(sm1,2,100);
   result:=toJest(ss);
   if result=toJestTelefon then exit
   else result:=0;

 end;
 if length(sm1)>6 then begin
 if (sm1[1]='(') and ((sm1[6]=')') or (sm1[4]=')')or (sm1[5]=')')) then begin
    result:=toJestTelefon;
    exit;
 end;
 end;
 if system.pos('TEL',sm1)>0 then begin
    result:=toJestTelefon;
    exit;
 end;
 if system.pos('FAX',sm1)>0 then begin
    result:=toJestFax;
    exit;
 end;


end;

function isPostCode;
begin
  result:=false;
  if length(s)<6 then exit;
  if (s[1] in numberOnlyset) and (s[2] in numberOnlyset)
     and (s[3]='-')
     and (s[4]in numberOnlyset)
     and (s[5]in numberOnlyset)
     and (s[6]in numberOnlyset) then begin
       result:= (length(s)=6) or (s[7]=' ')
  end;



end;

function extractCity;
var
  a,
  i : integer;
  il   : integer;
  it : array[0..9] of integer;
  sc : ansistring;
begin
  result:='';
  if length(s)<8 then exit;
  if isPostCode(s) then begin
     a:=8;
     if s[a]=' ' then inc(a);
     for i := a to length(s) do
       if s[i] =' ' then begin
          result:=copy(s,1,i-1);
          s:=copy(s,i+1, length(s));
          exit;
       end;
  end;
  il:=0;
  it[3]:=1;
  it[2]:=1;
  for i:= length(s) downto 4 do begin
    if s[i]=' ' then begin
       inc(il);
       it[il]:=i+1;
       if il>5 then break;
    end;
  end;
    sc:=copy(s,it[2],it[1]-it[2]);
    if isPostCode(sc) then begin
       result:=copy(s,it[2],length(s));
       s:=trim(copy(s,1,it[2]-1));
    end;



end;

function extractPostCode;
begin
  result:='';
  if isPostCode(s) then begin
        result:=trim(copy(s,1,7));
        s:=copy(s,8,length(s));
  end;

end;


function jednakoweNazwisko;
var
  xsa : ansistring;
  i    : integer;

begin
  result:=false;
  xsa:='';
  for i := 1 to length(sa) do
    case sa[i] of
      '.','"','`','''' : continue

      else xsa:=xsa+stUpCase(sa[i]);
    end;


end;


function jednakowyNip;
var
//  ia,ib : integer;
  xsa,
  xsb : string;
  i    : integer;

begin
  xsa:='';
  xsb:='';
  for i := 1 to length(sa) do
    case sa[i] of
      '.','"',' ','''','-' : continue

      else xsa:=xsa+stUpCase(sa[i]);
    end;
  for i := 1 to length(sb) do
    case sb[i] of
      '.','"',' ','''','-' : continue

      else xsb:=xsb+stUpCase(sb[i]);
    end;
  result:=xsa=xsb;


end;



procedure ansiToBuf;
var
  i,
  io : integer;
  tab : array[1..1000]of ansichar absolute buf;
begin
  io:=len;
  if length(s)<io then io:=length(s);
  for i:= 1 to io do begin
    tab[i]:=s[i]
  end;
  tab[io+1]:=#0;
end;
function bufToAnsi;
var
  pc : pChar;
  io : integer;
begin
  pc:=@buf;
  io:=strLen(pc);
  if io>0 then begin
  setlength(result,io);
  move(pc^,result[1],io);
//  result:=(pc,1,io);
  if result[io]=#26 then setLength(result,io-1)
  end else result:=''

end;
function bufToUtf8;
begin
  result:=bufToAnsi( buf ,len);
end;

  function liniawklej(const aramka:string;sa : string):string;
  var
    sbb : string;
    i,
    ip  : integer;
  begin
    if sa='' then begin
      result:='';
      exit;
    end;
//    result:=1;

    sbb:=aramka;
    ip:=0;
    for i:= 1 to length(aramka) do begin
      if aramka[i]='^' then begin
         inc(ip);
         if ip > length(sa) then
           sbb[i]:=' '
         else
           sbb[i]:=sa[ip];
      end
    end;
    result:=sbb;
  end;

function sortedBox;
var
  tl : tStringList;
    ib,i : integer;
    sb : ansistring;

begin
  tl:=tStringList.create;
     sb :=ss;
     i:=1;ib:=1;
     while i< length(sb) do begin
       if sb[i]='|' then begin
//         inc(ia);
         if i<>ib then
           tl.add(copy(sb,ib,i-ib));
         ib:=i+1;

       end;
       inc(i);
     end;
     if (sb[i]<>' ') or ((ib+1)<>i) then
       tl.add(copy(sb,ib,i-ib+1));
     tl.sort;
     result:=tl[0];
     for i:= 1 to tl.count-1 do
     result:=result+'|'+tl[i];

  tl.free;
end;


function napisBox;
  var
    ia,ib,i : integer;
    sb : ansistring;
  begin
     sb :=ss;
     i:=1;ib:=1;ia:=0;
     if ww<0 then begin
       result:='';exit;
     end;
     while i<= length(sb) do begin
       if sb[i]='|' then begin
         inc(ia);
         if ia=ww then begin
           ib:=i+1;
         end;
         if ia=ww+1 then begin
           result:=copy(sb,ib,i-ib);
           exit;
         end;
       end;
       inc(i);
     end;
     if (ww>1) and (ib=1) then result:=''
     else    result:=copy(sb,ib,i-ib+1);
  end;


function pozycjaBox;
var
  i,ia,ib : integer;
begin
     i:=1;ib:=1;ia:=0;
     while i<= length(ss) do begin
       if ss[i]='|' then begin
         if aw= copy(ss,ib,i-ib) then begin
           result:=ia;
           exit;
         end;
         inc(ia);
         ib:=i+1;

       end;
       inc(i);
     end;
     if aw= copy(ss,ib,length(ss)-ib+1) then begin
           result:=ia;
           exit;
     end else
     result:=-1;

end;

function lengthBox;
var
  last,
  i,ia : integer;
begin
     i:=1;ia:=0;last:=1;
     while i< length(ss) do begin
       if ss[i]='|' then begin
         inc(ia);
         last:=i+1;

       end;
       inc(i);
     end;
     if length(ss)>last then
       inc(ia);
     result:=ia;

end;

function napisPop;
var
  startA,
  ip,ik,ic,ir, i : integer;
  sb : ansistring;
  sww ,
  sa,
  sn : string;
begin
  {
     if (ww=0)  then begin
       result:='';
       exit;
     end;
     }
     sb :=ss;

     sww:=long2str(ww);

     i:=1; ik:=0;ic:=0;
     while i< length(sb) do begin
       if sb[i]='^' then ic:=i;
       if sb[i]='|' then begin

//         inc(ia);
         ip:=ik;
         ik:=i;
         startA:=1;
         if ic<length(sb) then
         while sb[ic+startA] in [' ','>'] do inc(startA);
         sn:=copy(sb,ic+startA,ik-ic-startA);
         if sn=sww then begin
           sa:=copy(sb,ip+1,ic-ip-1);
           ir:=pos('##',sa);
           if ir>0 then delete(sa,1,ir+1);
           ir:=pos('%%',sa);
           if ir>0 then delete(sa,1,ir+1);
{           if sa[length(sa)]='^' then
           delete(sa,length(sa),1);
 }
           result:=sa;
           exit;
         end;
       end;
       inc(i);
     end;
//     if (ww>1) and (ip=1) then result:=''
//     else    result:=copy(sb,ip,i-ic-1);
     result:='';


end;

function napisPopWin;
var
  sa : string;
begin
  sa:=napisPop(ww,ss);
  konWin(sa);
  result:=sa;


end;
function napisPopUtf;
begin
  result:=komWInUtf(napisPop(ww,ss));

end;

function napisBoxUtf;
begin
  result:=komWInUtf(napisBox(ww,ss));

end;


function napisBoxWin;

var
  sa : string;
begin
  sa:=napisBox(ww,ss);
  konWin(sa);
  result:=sa;


end;



function DataKolor;
begin
  if ad1>ad2 then result:=''
  else if ad1=ad2 then result:=pickKolor(pkTermin)
  else result:=pickKolor(pkpoTerminie);
  result:=result+date4st(ad1);


end;

function skrocFisk;
var
   tnij : boolean;
   i,
   ln : integer;
begin
  if length(sa)<20 then begin
    result:=sa;
    exit;
  end;
  result:='';
  tnij:=false;
  ln:=0;
  for i := 1 to length(sa) do begin
    case sa[i] of
    'A'..'z','0'..'9','≥','à','ù','‡','”','ó','®' : begin
                if tnij then continue
               else begin
                  inc(ln);
                  if ln=3 then tnij:=true;
                  result:=result+sa[i];
               end;
            end;
     ' ','-','.' : begin
       tnij:=false;
       if ln>0 then
         result:=result+sa[i];
       ln:=0;

     end;
    else
      result:=result+sa[i];
    end;

  end;
end;

function rowKolor;
begin
    if (ak>0) and (ak<20) then
        result:=charBMP+char(200+ak)
    else
      result:='';
end;

function PickKolor;
begin
  case ap of
    pkPusty : result:=#1;
    pkCzerwony : result:=#202;
    pkNiebieski : result:=#204;
    pkSzary : result:=#205;
    pkBold  : result:='|';
    pkBraz  : result:=charColor+#6;
    pkFiolet : result:=#207;
    pkZielony : result:=#203;
    pkLampka : result:=#252;
    pkSkreslony : result:='_';
    pkAnulowany : result:='_'#254#216;
    pkItalic : result:='/'#254#205;
    pkKorekta  : result:=#234;
    pkWykrzyknik : result:=#248;
    pkDos : result:=#246;
    pkDosZamow : result:=#237;
    pkDosButik : result:=#246;
    pkSprz : result:=#247;
    pkSprzZamow : result:=#236;
    pkSprzButik : result:=#247;
    pkPracow : result:=#245;
    pkOddzial: result:=#244;
    pkTermin : result:=#204;
    pkPoTerminie : result:=#202;
    pkZalacznik  : result:=#250;
    pkUsluga     : result:=#243;
    pkAutomatycznie : result:=#242;
    pkNieprawidlowy : result:=#241;
    pkCheck         : result:=#240;
    pkZamkniety     : result:=#205;
    pkWazne         : result:=#239;
    pkRozlicz       : result:=#238;
    pkProdZamow     : result:=#235;
    pkProdSZamow    : result:=#234;
    pkZadanie       : result:=#233;
    pkklodka        : result:=#227;
//    pkklodkaOtw     : result:=#205#254#227;
    pkWyslany       : result:=#230;
    pkewyslany      : result:=#229;
    pkpotwierdzony  : result:=#228;
    pkTeal          : result:=#201;


    pkZaznaczony    : result:=#192;
    pkWidziany      : result:=#191;
    pkDoPodpisu     : result:=#253;
    pkMailIn        : result:=#224;
    pkMailOut       : result:=#223;
    pkTime          : result:=#222;
    pkTimeTermin    : result:=#221;
    pkSubList       : result:=#220;
    pkRestBlack     : result:=#150;
    pkRestRed       : result:=#149;
    pkOK            : result:=#148;
    pkNotOk         : result:=#147;
    pkEye           : result:=#219;
//    pkKsiegowany    : result:=#218;


  end;
  if result<>'' then result:=charBMP+result;

end;
{

{
function kolorString;
begin
  case acolor of
    clBraz : result:='brown';
    clRed  : result:='red';
    clgreen : result:='green';
    clMaroon : result:='maroon';
    clBlue   : result:='blue';
    clPurple : result:='purple';
  else
    result:='';
  end;
end;
function stringKolor;
begin
  if asc[1]='(' then delete(asc,1,1);
             if asc='brown' then result:=clBraz;
             if asc='red' then result:=clRed;
             if asc='green' then result:=clGreen;
             if asc='maroon' then result:=clMaroon;
             if asc='blue' then result:=clBlue;
             if asc='purple' then result:=clPurple;

end;

}

function testEan(const kod : ansistring):Boolean;

var
  w1,w2  : word;
begin
  result:=false;
    if length(kod)=8 then begin
      w2:=word(kod[1])-48+word(kod[3])-48+word(kod[5])-48+word(kod[7])-48;
      w1:=word(kod[2])-48+word(kod[4])-48+word(kod[6])-48;
      w2:=(w1+w2*3) mod 10;
      w1:=(10-w2) mod 10+48;
      result:=w1= byte(kod[8]);
    end;

    if length(kod)=13 then begin
      w2:=word(kod[1])-48+word(kod[3])-48+word(kod[5])-48+word(kod[7])-48+word(kod[9])-48+word(kod[11])-48;
      w1:=word(kod[2])-48+word(kod[4])-48+word(kod[6])-48+word(kod[8])-48+word(kod[10])-48+word(kod[12])-48;
      w2:=(w2+w1*3) mod 10;
      w1:=(10-w2) mod 10+48;
      result:= w1= byte(kod[13]);
    end;
end;


function binToDec( aStr:Ansistring):Ansistring;
var
  xMod : integer;
   function divstr(ast : Ansistring;aBase : integer;var aMod : integer):AnsiString;
   var
     i,
     x,d : integer;
   begin

     result:='';
     for i :=  1 to length(ast)  do begin
       x:=(aMod shl 8) +byte(ast[i]);
       d:=x div abase;
       if (i>1) or (d<>0) then
          result:=result+chr(d);
       aMod:=x mod abase;
     end;

   end;


begin
   result:='';
   xMod:=0;
   repeat
     xMod:=0;
     astr:=divStr(astr,10, xMod);
     result:=inttostr(xMod)+result
   until astr='';


end;



function binToHex(const aStr:Ansistring):AnsiString;
var
  i : integer;
begin
  result:='';
  for i := 1 to length(astr) do begin
    result:=result+intToHex(byte(astr[i]),2)+' ';

  end;
  result:=trim(result);
end;


function HexToBin(const aStr: ansistring): ansiString;
const
  Digits = '0123456789ABCDEF';
var
  I, J, K, P: Integer;
  B: Byte;
  U: string;
begin
  SetLength(Result,Length(aStr) shr 1);
  J := 1;
  B := 0;
  K := 0;
  U := UpperCase(aStr);
  for I := 1 to Length(U) do begin
    P := Pos(U[I],Digits);
    if P > 0 then begin
      B := (B shl 4) + P - 1;
      Inc(K);
    end;
    if K = 2 then begin
      Result[J] := Char(B);
      Inc(J);
      B := 0;
      K := 0;
    end;
  end;
  SetLength(Result,J-1);
end;



function tagHtml(s : Ansistring;aPos : integer):AnsiString;
begin
  result:=copy(s,apos,100);
end;

function validateStyleString;
var
  i : integer;
begin
  result:=sa;
  for i := 1 to length(result) do begin
    case result[i] of
      '<' : if tagHtml(result,i) ='style' then result[i+1]:='_';
    end;
  end;
end;
{ iframe}

function validateScriptString;
var
  i : integer;
begin
  result:=sa;
  for i := 1 to length(result) do begin
    case result[i] of
      '<' : if tagHtml(result,i) ='style' then result[i+1]:='_';
    end;
  end;
end;


function testUtfString:utf8String;
var
  s : ansiString;
begin
  s:='za≈ÇƒÖcznik';
  result:=s;

end;
end.

