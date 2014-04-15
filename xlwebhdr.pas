{****************************************************************************
*                                                                           *
*                          xweb framework                                   *
*                                                                           *
*                                                                           *
* Language:             FPC Pascal v2.2.0+ / Delphi 6+                      *
*                                                                           *
* Required switches:    none                                                *
*                                                                           *
* Author:               Dariusz Mazur                                       *
* Date:                 20.10.2008                                          *
* Version:              0.9                                                 *
* Licence:              MPL or GPL
*                                                                           *
*        Send bug reports and feedback to  darekm @@ emadar @@ com          *
*   You can always get the latest version/revision of this package from     *
*                                                                           *
*           http://www.emadar.com/fpc/xweb.htm                              *
*                                                                           *
*                                                                           *
* Description:  Framework to develop web-application                        *
*                                                                           *
*  This program is distributed in the hope that it will be useful,          *
*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
*                                                                           *
*                                                                           *
*****************************************************************************
*                      BEGIN LICENSE BLOCK                                  *

The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: xlmainsyn.pas, released 10.01.2009.
The Initial Developer of the Original Code is Dariusz Mazur


Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

*                     END LICENSE BLOCK                                     * }


{$I start.inc}

unit xlwebhdr;

interface
{.$DEFINE THREADSESSION}
uses
  classes,
  {$IFNDEF FPC}
  windows,
  {$ENDIF}
{$IFNDEF NOZLIB}
{$IFDEF FPC}
  zstream,
{$ELSE}
//  zstream,
  Zlib,
{$ENDIF}
{$ENDIF}
//  wpstring,
//  syncobjs,
  synautil,
  SysUtils;
const
   GSessionIDCookie = 'IDHTTPSESSIONID';    {Do not Localize}
type
  {$IFDEF THREADSESSION}
   tSession = class(tThread)
   {$ELSE}
   tSession = class(tObject)
   {$ENDIF}
     public
      lastTime      : tDateTime;
      application   : tObject;
      sessionThread : tThread;
      language      : integer;
      FSessionID    : shortstring;


      constructor create;
      destructor  destroy;override;
      function  forFree(aTime : tDateTime):boolean;
      procedure closeApplication;
      procedure lastTimeOK;

   end;

   tSessionClose = class(tThread)
      fSession  : tSession;

      constructor create(aSession : tSession);
      procedure execute;override;
      end;

   tApplicationClose = class(tThread)
      fApplication  : tObject;

      constructor create(aApplication : tObject);
      procedure execute;override;
      end;



   tHttpInfo = class

      request,
      FormParams,
      query   : ansiString;
      uri     : ansistring;
      ResponseNo  : integer;
      contentText : ansiString;
      dataSize  : integer;
      data      : tMemoryStream;
      tmpStream : tMemoryStream;
      ContentStream : tStream;
      Headers : tStringList;
      session : tSession;
      location : ansiString;
      fWebAppID: integer;
      fAgentID : integer;
      method,
      document,
      protocol      : shortString;
      fRemoteIP,
      fHost  ,
      fUserAgent,
      fEncodings,
      fAccLang,
      fCharset,
      fReferer,
      fContentType : shortstring;
      fContentDisposition : shortString;
      fLogString  : shortString;
      pragma,
      cacheControl : shortstring;
      CloseConnection : boolean;
      SSL             : boolean;
      LastModified,
      fDate,
      Expires     : tDateTime;
      fCookies    : tStringList;
      wasCookie   : boolean;
      wasAjax     : boolean;
      useZlib     : boolean;
      useCookie   : boolean;
      useOpenId   : boolean;
      fForm       : tObject;
      fCurrLang   : integer;
      constructor create;
      destructor destroy;override;
      procedure clear;
      function userAgent : string;
//      function cssHeader : ansistring;
      function params(const aParam:ansiString;ch:char=';'):ansiString;
//      function FormParams(const aParam:ansiString):ansiString;overload;
//      property FormParams:ansiString read mFormParams write mFormParams;overload;
      function contentLength:integer;
      function contentStreamString:ansiString;
      function contentDataString:ansiString;
      procedure saveDataString(s : ansistring);
      function addCookie(const ass : ansistring):integer;
      function setCookie(fName,fValue,fPath,fExpires,fDomain,fSecures:string):integer;
      function getCookie(aValue:ansistring;var  fName,fValue,fPath,fExpires,fDomain,fSecures,fSession:string):integer;
      function idPolish : boolean;
      function idgerman : boolean;
      function isdeflate : boolean;
      function isie60:boolean;
      function isie10:boolean;
      function isie:boolean;
      function isIos:boolean;
      function isAndroid:boolean;
      function isFirefoxOs : boolean;
      function isWebApp : boolean;
      procedure setWebApp(aAgent : string);
      procedure setLanguage(aLang:integer);
      function metaLang:ansistring;
      procedure compress;
      procedure compressTEXT;
      procedure detectAgent;overload;
      function detectAgent( aAgent:string):integer;overload;
      function httpHost:ansiString;
      function shouldHaveSession:boolean;

   end;

   tParserUrl = class
     Scheme,
     User,
     Pass,
     Host,
     query : string;
     Anchor : string;

     constructor create(aUrl:string);
   end;


  THTTPRequestInfo = tHttpInfo;
  THTTPResponseInfo = tHttpInfo;

  THTTPGetEvent = procedure(   ARequestInfo: THTTPRequestInfo; AResponseInfo: THTTPResponseInfo) of object;




const
    agNone    = 0;
    agGSM     = 1;
    agPalm    = 2;
    agPalmOpera    = 3;
    agPalmAjax   = 4;
    agAndroid   = 5;
    agIOS   = 6;
    agFirefoxOS = 7;
    agAndroidOS   = 8;
    agPC      = 10;
var
  destroyedDemon : integer;

implementation




function AddCookieProperty(const AProperty, AValue, ACookie: String): ansiString;
begin
  result:=aCookie;
  if Length(AValue) > 0 then
  begin
    if Length(ACookie) > 0 then
    begin
      result := ACookie + '; ';    {Do not Localize}
    end;
    result := result + AProperty + '=' + AValue;    {Do not Localize}
  end;

//  result := ACookie;
end;



constructor tSession.create;
begin
  inherited create;
//  Priority:=tpNormal;
  application:=nil;
  lastTime:=sysutils.now;

end;
destructor tSession.destroy;
begin
//  DeleteCriticalSection(FLock);
  closeApplication;
  inherited destroy;
//  writeln('destroy fSession '+fSessionID);

end;


function tSession.forFree;
begin
  result:=LastTime<aTime;
end;

procedure tSession.lastTimeOK;
begin
  lastTime:=lastTime-1;
end;
procedure tSession.closeApplication;
begin
  try
  try

    if application<> nil then begin
    
      freeandNil(application);
   end;
  except
    on e : exception do
          writeln('destroy app.entry '+ e.message);

  end;
  finally
    lastTimeOK;
    application:=nil;
  end;


end;


constructor tSessionClose.create;
begin
  fSession:=aSession;
//  sleep(10);
  FreeOnTerminate:=true;
  interlockedIncrement(destroyedDemon);
  inherited create(false);
//  FreeOnTerminate:=true;
end;

procedure tSessionClose.execute;
begin
  sleep(5000);
  try
    fSession.free;
  except
                on e : exception do begin
                     writeln('tSessionClose.exception  '+e.Message+datetimeToStr(now));
               end;

  end;
  if not freeonTerminate then
    writeln('tsessionClose error freeonterminate');
  interlockedDecrement(destroyedDemon);
//  writeln('sessionClose destroy   '+datetimeToStr(now)+'  '+inttostr(destroyedDemon));

//  writeln('tsessionClose end');
end;


constructor tApplicationClose.create;
begin
  fApplication:=aApplication;
//  sleep(10);
  FreeOnTerminate:=true;
  interlockedIncrement(destroyedDemon);
  inherited create(false);
//  FreeOnTerminate:=true;
end;

procedure tApplicationClose.execute;
begin
  sleep(0);
  writeln('Close application destroy   '+datetimeToStr(now));
  try

    if fapplication<> nil then begin

//        currApplicationXML:=aap;


      sleep(10000);
      freeandNil(fapplication);
    end;
  except
                on e : exception do begin
                     writeln('tApplictionClose.exception  '+e.Message+datetimeToStr(now));
               end;

  end;
  if not freeonTerminate then
    writeln('tApplicationClose error freeonterminate');
  interlockedDecrement(destroyedDemon);

//  writeln('tsessionClose end');
end;


constructor tHttpInfo.create;
begin
  inherited create;
  data:=tMemoryStream.create;
  Headers:= TStringList.create;
  fCookies:=tStringList.create;
  ContentStream:=nil;
  tmpStream:=nil;
  clear;
end;

destructor tHttpInfo.destroy;
begin
  data.free;
  headers.free;
  fCookies.Free;
  inherited destroy;
  FreeAndNil(ContentStream);
  freeandnil(tmpStream);

end;

procedure tHttpInfo.clear;
begin
  data.clear;
  contentText:='';
  headers.clear;
  fCookies.clear;
  fHost:='';
  fuserAgent:='';
  fAgentID:=0;
  fEncodings:='';
  fAccLang:='';
  fCharset:='';
  cacheControl:='';
  pragma:='';
  fDate:=0;
  Expires:=0;
  lastModified:=0;
  uri:='';
  responseNo:=0;
  wasAjax:=false;

  FreeAndNil(ContentStream);
  freeandnil(tmpStream);

end;


procedure tHttpInfo.compress;
var
//  cs        : tStream;
  io        : integer;
  tmpStream2 : tMemoryStream;
begin
 if contentText<>'' then begin
   compressText;
   exit;
 end;
 if assigned(contentStream)   then begin
{   if  ContentStream.Size<2000 then begin
    usezlib:=false;
    exit;
   end;
   }
        TmpStream := TMemoryStream.Create;
         with TCompressionStream.Create(clMax, TmpStream) do      begin
            CopyFrom(contentStream, 0);
            Free;
         end;
//         tmpStream.position:=0;
         contentStream.free;

         io:=tmpStream.size;
         tmpStream.position:=2;

         TmpStream2 := TMemoryStream.Create;
         tmpStream2.CopyFrom(tmpStream,io-2);
         tmpStream2.position:=0;
         contentStream:=tmpstream2;
         tmpStream.free;

{        contentStream:=tmpstream;}

         tmpStream:=nil;
    end;

end;
procedure tHttpInfo.compressText;
var
  y,yr  : integer;
begin
  if length(contentText)<2000 then begin
    usezlib:=false;
    exit;
  end;
        TmpStream := TMemoryStream.Create;
         with TCompressionStream.Create(clMax, TmpStream) do      begin

            Write(pchar(contentText)^,length(contentTExt));
            Free;
         end;
         y:=tmpStream.size;
         Setlength(contentText, y);
         tmpStream.position:=2;
         yr := tmpStream.read(pchar(contentText)^, y-2);
         if y<>yr then       setLEngth(contentText,yr);



end;

function tHttpInfo.userAgent:string;
begin
  result:=fUserAgent;
end;



function tHttpInfo.params;
var
  i1,inn,
  io : integer;
//  s5  : ansiString;
  lc,ls : pchar;
begin
  inn:=length(aParam)+1;
  if inn<4 then begin
    io:=pos(';'+aParam+'=',query);
    inc(inn);
  end else
    io:=pos(aParam+'=',query);

  if io>0 then begin
    i1:=io+inn;
    lc:=@(query[i1]);
    ls:=StrScan(lc,ch);
    {
    s5:=copy(query,io+length(aParam)+1,1250);
    result:=s5;
    }
    if ls<>nil then
      result:=copy(query,i1,ls-lc{-length(s4)})
    else
      result:=copy(query,i1,length(query));

  end else
    result:='';
end;




procedure tHttpInfo.setLanguage;
begin
  if assigned(session) then begin
    session.language:=aLang;
  end;
end;
function tHttpInfo.isDeflate;
begin
  result:=(pos('deflate',fEncodings)>0) {and not isie60};
end;

function tHttpInfo.isIE60;
begin
  result:=(pos('MSIE 6.0',fUserAgent)>0);
end;

//Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)

function tHttpInfo.isIE10;
begin
  result:=(pos('MSIE 1',fUserAgent)>0);
end;


//Mozilla/5.0 (Linux; U; Android 2.3.5; en-us; LG-VM670 Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1
//Firefox OS Phone 	Mozilla/5.0 (Mobile; rv:15.0) Gecko/15.0 Firefox/15.0

function tHttpInfo.isAndroid;
begin
  result:=(pos('Android',fUserAgent)>0) or (fAgentId=agAndroid);
end;
function tHttpInfo.isFirefoxOs;
begin
  result:=(pos('Mozilla',fUserAgent)>0) and (pos('Mobile',fUserAgent)>0)or (fAgentId=agFirefoxOS);
end;

function tHttpInfo.isWebApp;
begin
  result:=fWebAppId>0;
end;

procedure tHttpInfo.setWebApp;
begin
 if aAgent='ANDROID' then
   fWebAppId:=1;
end;


function tHttpInfo.isIos;
begin
  result:=(pos('iPhone',fUserAgent)>0)
       or  (pos('iPod',fUserAgent)>0)
       or (pos('iPad',fUserAgent)>0)
{
var IsiPhone = navigator.userAgent.indexOf("iPhone") != -1 ;
 var IsiPod = navigator.userAgent.indexOf("iPod") != -1 ;
 var IsiPad = navigator.userAgent.indexOf("iPad") != -1 ;

 var IsiPhoneOS = IsiPhone || IsiPad || IsiPod ;
 }
end;

function tHttpInfo.isIE;
begin
  result:=(pos('MSIE',fUserAgent)>0) and not isIE10;
end;

function tHttpInfo.idPolish;
begin
 if assigned(session) then begin
   if (session.language=6) then begin
     result:=true;
     exit;
   end;
   if (session.language>0) then begin
     result:=false;
     exit;
   end;
 end else begin
   if fCurrLang >0 then begin
     result:=false;
     exit;
   end;
 end;
 result:= pos('pl',fAccLang)>0;
end;


function tHttpInfo.idGerman;
begin
 if assigned(session) then begin
   if (session.language=2) then begin
     result:=true;
     exit;
   end;
 end else begin
   if fCurrLang <>2 then begin
     result:=false;
     exit;
   end;
 end;
 result:= pos('de',fAccLang)>0;
end;

function tHttpInfo.metaLang;
begin
 if idPolish then begin
  result:='<meta id="mdlang" name="adlang" content="pl">';
 end else if idGerman then begin
  result:='<meta id="mdlang" name="adlang" content="de">';
 end else begin
  result:='<meta id="mdlang" name="adlang" content="en">';
 end;
end;
function tHttpInfo.contentLength;
begin
    if ContentText <> '' then begin
      result:= Length(ContentText);
    end else if Assigned(ContentStream) then begin
      result:= ContentStream.Size;
    end else result:=data.size;


end;

function tHttpInfo.contentStreamString;
begin
    if assigned(contentStream) then begin
     Setlength(result, ContentStream.Size);
     contentStream.read(Pointer(result)^, ContentStream.Size);
    end else result:='';
end;
function tHttpInfo.contentDataString;
begin
    if assigned(data) then begin
     Setlength(result, data.Size);
     data.seek(0,0);
     data.read(Pointer(result)^, data.Size);
    end else result:='';
end;

procedure tHttpInfo.saveDataString;
begin
     data.write(Pointer(s)^, length(s));

end;


function tHttpInfo.addCookie;
begin
  wasCookie:=true;
  result:=fCookies.Add(ass);
end;


function tHttpInfo.shouldHaveSession;
begin
  result:=useCookie;
  if not wasCookie then begin
        if pos('.ico',document)>0 then
                 result:=false;
        if pos('.css',document)>0 then
                 result:=false;
        if pos('.js',document)>0 then
                 result:=false;
  end;


end;


function THttpInfo.setCookie;
var
   sCookie:AnsiString;
begin
  sCookie:= AddCookieProperty(FName, FValue, '');    {Do not Localize}
  if fPath<>'' then
  sCookie := AddCookieProperty('path', FPath, sCookie);    {Do not Localize}
//  if FInternalVersion = cvNetscape then
//  begin
if fExpires<>'' then
    sCookie := AddCookieProperty('expires', FExpires, sCookie);    {Do not Localize}
//  end;

if fDomain<>'' then
  sCookie:= AddCookieProperty('domain', FDomain, sCookie);    {Do not Localize}
  if FSecures<>'' then
    sCookie:=sCookie+';HttpOnly ';

  result:=addCookie(sCookie);

//  if FSecure then
//  begin
//    result := AddCookieFlag('secure', result);    {Do not Localize}
//  end;
end;


function THttpInfo.getCookie;
Var
  io,
  i: Integer;
  ss : shortstring;
  CookieProp: TStringList;

procedure LoadProperties(APropertyList: TStringList);
begin
  FPath := APropertyList.values['PATH'];    {Do not Localize}
  // Tomcat can return SetCookie2 with path wrapped in "
  if (Length(FPath) > 0) then
  begin
    if FPath[1] = '"' then    {Do not Localize}
      Delete(FPath, 1, 1);
    if FPath[Length(FPath)] = '"' then    {Do not Localize}
      SetLength(FPath, Length(FPath) - 1);
  end
  else begin
    FPath := '/'; {Do not Localize}
  end;
  fExpires := APropertyList.values['EXPIRES'];    {Do not Localize}
  FDomain := APropertyList.values['DOMAIN'];    {Do not Localize}
  fSecures:='';
  FSession := APropertyList.values[GSessionIDCookie];    {Do not Localize}
//  FSecure := APropertyList.IndexOf('SECURE') <> -1;    {Do not Localize}
end;

begin

    CookieProp := TStringList.Create;

    try
      io:=pos(';',AValue);
      while io > 0 do    {Do not Localize}
      begin
        ss:=copy(AValue,1,io-1);
        delete(AValue,1,io);
        CookieProp.Add(Trim(ss));    {Do not Localize}
        io:=pos(';',AValue);

 //       if (Pos(';', AValue) = 0) and (Length(AValue) > 0) then CookieProp.Add(Trim(AValue));    {Do not Localize}
      end;
      if (io=0) and (length(AValue)>0) then CookieProp.Add(trim(aValue));
      if CookieProp.Count = 0 then CookieProp.Text := AValue;

      FName := CookieProp.Names[0];
//      Fvalue := CookieProp.valuefromindex[0];
//      cookieprop.quotechar:='"';
      FValue := CookieProp.Values[fname];
      CookieProp.Delete(0);

      for i := 0 to CookieProp.Count - 1 do
        if Pos('=', CookieProp[i]) = 0 then    {Do not Localize}
        begin
          CookieProp[i] := UpperCase(CookieProp[i]);  // This is for cookie flags (secure)
        end
        else begin
          CookieProp[i] := UpperCase(CookieProp.Names[i]) + '=' + CookieProp.values[CookieProp.Names[i]];    {Do not Localize}
        end;

       LoadProperties(CookieProp);
    finally
      FreeAndNil(CookieProp);
    end;
    result:=1;
end;

{
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/528.12 (KHTML, like Gecko) Version/4.0 Safari/528.12
User-Agent: Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_2_1 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5H11 Safari/525.20
User-Agent: Opera/9.63 (Windows NT 6.0; U; en) Presto/2.1.1
User-Agent: Opera/9.63 (Macintosh; Intel Mac OS X; U; en) Presto/2.1.1


Mozilla/5.0 (iPod; U; CPU iPhone OS 3_1_2 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7D11 Safari/528.16

}
function tHttpInfo.httpHost;
begin
 if ssl then
  result:='https://'+fHost
 else
  result:='http://'+fHost
end;

procedure tHttpInfo.detectAgent;
begin
  fAgentID:=detectAgent(fUserAgent);

end;

function tHttpInfo.detectAgent( aAgent:string):integer;
var
  agentID : integer;
begin
  aAgent:=UpperCase(aAgent);
  agentID:=agGSM;

  if pos('NOKIA',aAgent)>0 then agentID:=agGSM;
  if pos('OPERA',aAgent)>0 then begin
    agentID:=agPC;
    if pos('MOBI',aAgent)>0 then begin


      result:=agPalmOpera;
      exit;
    end;
  end;
  if{ (pos('MOZILLA',aAgent)>0)and }(pos('WINDOWS;',aAgent)>0) then agentID:=agPC
  else  if (pos('ANDROID',aAgent)>0) then agentID:=agAndroid
  else  if (pos('IPHONE',aAgent)>0) or (pos('IPOD',aAgent)>0) or (pos('IPAD',aAgent)>0) then agentID:=agIOS

  else  if (pos('WEBKIT',aAgent)>0) then agentID:=agPC
  else  if (pos('WINDOWS NT',aAgent)>0) then agentID:=agPC
  else  if (pos('MACINTOSH;',aAgent)>0) then agentID:=agPC
  else  if (pos('Mobile;',aAgent)>0)  then begin
    agentID:=agFirefoxOs;
  end else  if (pos('X11;',aAgent)>0)  then agentID:=agPC;
  if pos('WINDOWS CE',aAgent)>0 then begin
    agentID:=agPalmAjax;
    if pos('OPERA',aAgent)>0 then agentId:=agPalmOpera;
//    if pos('3.',aAgent)>0 then agentID:=agPalm;
//    if pos('IEMOBILE',aAgent)>0 then agentID:=agPalmA
  end;

  result:=agentID;

end;


constructor tParserUrl.create;

    procedure ReplaceChar(c1, c2: Char; var St: String);
    var
      p: Integer;
    begin
      while True do
       begin
        p := Pos(c1, St);
        if p = 0 then Break
        else St[p] := c2;
       end;
    end;

  var
    i: Integer;
begin

    i:= Pos(':', aURL);
    if i<> 0 then begin
      Scheme:=copy(aUrl,1,i-1);
      System.Delete(aURL, 1, i+2);
    end;

    i := Pos('/', aURL);
    if i>0 then begin
    Host := Copy(aURL, 1, i);
    Query := Copy(aURL, i+1, Length(aURL) - i + 1);
    end else begin
      host:=aUrl;
      query:='';
    end;

    if (Length(Host) > 0) and (Host[Length(Host)] = '/') then
      SetLength(Host, Length(Host) - 1);

end;

end.
