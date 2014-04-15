{****************************************************************************
*                                                                           *
*                          openid framework                                 *
*                                                                           *
*                                                                           *
* Language:             FPC Pascal v2.4.0+ / Delphi 6+                      *
*                                                                           *
* Required switches:    none                                                *
*                                                                           *
* Author:               Dariusz Mazur                                       *
* Date:                 30.06.2011                                          *
* Version:              0.1                                                 *
* Licence:              MPL or GPL                                          *
*                                                                           *
*        Send bug reports and feedback to  darekm @@ emadar @@ com          *
*   You can always get the latest version/revision of this package from     *
*                                                                           *
*           http://www.emadar.com/fpc/opinid.htm                            *
*                                                                           *
*                                                                           *
* Description:  OpenID identity verification library                        *
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

The Original Code is: xlopinid.pas, released 30.06.2011.
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

unit xlopenid;

interface
{$H+}

uses
  classes,
  base64,
//  association,
//  diffiehellman,
//  oid_message,
//  consumer,

//  flopenidutil,
  httpsend,
  ssl_openssl,
  flstringarray,

  lightopenid,
  jsondecode,
//  xlcmd,
//  xllpt,
  xlapp,
  syncobjs,
  xlwebhdr,
  xlwebsrv,
  wpstring,
  SysUtils;




type
   tOpenID= class
   private
    class function getToken(const aCode,aRedirectUri,aClientID,aClientSecret:string):string;
   public
    class function readUrl(aUrl : string):String;
    class procedure try_auth(aPop : boolean;aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
    class procedure fb_auth(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
    class function fbfinish_auth(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo):tApplicationXML;
    class function googlefinish_auth(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo):tApplicationXML;
    class procedure fb_logout(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
    class procedure fb_source(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
    class function fbgetToken(const aGrant:string):string;
    class procedure logout(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
//    class function fb_feed(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo):tApplicationXML;

   end;




var
  fbClientId,
  fbClientSecret,
  fbRedirectUri : string;
implementation


// Client side authentication
//http://developers.facebook.com/docs/authentication/client-side/
//http://connect.facebook.net/en_US/all.js


 procedure sendReload(aResponseInfo : THTTPRequestInfo;ares : String);
 begin
        AResponseInfo.ResponseNo := 302;
        AresponseInfo.fContentType:='text/html';
        aResponseInfo.cacheControl:=' no-store, no-cache, must-revalidate';
        aResponseInfo.Pragma:='no-cache';
        aResponseInfo.Location:=ares;

 end;

 procedure sendPop(aResponseInfo : THTTPRequestInfo;ares : String);
 begin
        AResponseInfo.ResponseNo := 200;
        AresponseInfo.fContentType:='text/html';
        aResponseInfo.cacheControl:=' no-store, no-cache, must-revalidate';
        aResponseInfo.Pragma:='no-cache';
        AResponseInfo.ContentText :='script<|>'+ares;
 end;


 procedure sendHtml(aResponseInfo:tHTTPRequestInfo;ares : String);
 begin
            AResponseInfo.ResponseNo := 200;
            AresponseInfo.fContentType:='text/html; charset=utf-8';
            aResponseInfo.cacheControl:=' no-store, no-cache, must-revalidate';
            AresponseInfo.fContentType:='text/html; charset=utf-8';
            AResponseInfo.ContentText :=ares;

            aResponseInfo.Pragma:='no-cache';
 end;






(*

function rand(astop: integer)
var
  rBytes : string;
  xduplicate_cache : string;
    begin
        static $duplicate_cache = array();

        // Used as the key for the duplicate cache
        rbytes = longToBinary(astop);

        if (array_key_exists(rbytes, aduplicate_cache))  then begin
            list(xduplicate, $nbytes) = xduplicate_cache[rbytes];
        end else  begin
            if ($rbytes[0] == "\x00") {
                $nbytes = Auth_OpenID::bytes($rbytes) - 1;
            } else {
                $nbytes = Auth_OpenID::bytes($rbytes);
            }

            $mxrand = $this->pow(256, $nbytes);

            // If we get a number less than this, then it is in the
            // duplicated range.
            $duplicate = $this->mod($mxrand, $stop);

            if (count($duplicate_cache) > 10) {
                $duplicate_cache = array();
            }

            $duplicate_cache[$rbytes] = array($duplicate, $nbytes);
        }

        do {
            $bytes = "\x00" . Auth_OpenID_CryptUtil::getBytes($nbytes);
            $n = $this->binaryToLong($bytes);
            // Keep looping if this value is in the low duplicated range
        } while ($this->cmp($n, $duplicate) < 0);

        return $this->mod($n, $stop);
    end;

*)
(*
function getReturnTo():string;
begin
    result:='http://127.0.0.1:8001/finish_auth.php';
//    sprintf("%s://%s:%s%s/finish_auth.php",
//                   getScheme(), $_SERVER['SERVER_NAME'],
//                   $_SERVER['SERVER_PORT'],
//                   dirname($_SERVER['PHP_SELF']));
end;

function getTrustRoot():string;
begin
  result:='http://127.0.0.1:8001/';
 {
    return sprintf("%s://%s:%s%s/",
                   getScheme(), $_SERVER['SERVER_NAME'],
                   $_SERVER['SERVER_PORT'],
                   dirname($_SERVER['PHP_SELF']));
}

end;
*)



class function tOpenId.readUrl;
  procedure czytajStream(var sn : String;stm : tStream);
  begin
     stm.seek(0,0);
     setstring(sn,nil,stm.size);
     Stm.Read(Pointer(sn)^, stm.Size);

  end;

var
  bb : boolean;
  http : tHttpSend;
  xDataSt : string;
begin
  HTTP := THTTPSend.Create;
  try
    bb := HTTP.HTTPMethod('GET', aURL);


    if bb then begin
       czytajStream(result,http.document);
       {
       result:=result+'(('+long2str(length(result))+'))';

      for i := http.headers.count-1 downto 0 do
         result:=result+ http.headers[i]+#13#10;
         }
//         writeln('#',http.resultCode);
    end else begin
         czytajStream(result,http.document);
         result:='#'+inttostr(http.resultCode)+#10+result;
         dateTimeToString(xDataSt,'dd/mm/yyyy hh:mm:ss.zzz    ',now);
         writeln('%',http.resultCode,               xDataSt);
    end;
  finally
    HTTP.Free;
  end;
end;

//Authorized Access to your Google Account
//https://accounts.google.com/IssuedAuthSubTokens

//img src="http://developer.myspace.com/Community/favicon.ico"
//img src="http://www.yahoo.com/favicon.ico"
//<img src="http://www.google.com/favicon.ico"
class procedure tOpenId.try_auth;
var
  tlo : tLightOpenID;
//  OK  : boolean;
  xScript,
  sUrl  : string;



 (*
 $.ajax({ url: "/popuplib.js",
success: function(response) {
$("#popuplib_source").html('<pre style="text-align:left;">'+response+'</pre>');
}
});
var extensions = { 'openid.ns.ax' : 'http://openid.net/srv/ax/1.0', 'openid.ax.mode' : 'fetch_request', 'openid.ax.type.email' : 'http://axschema.org/contact/email', 'openid.ax.type.first' : 'http://axschema.org/namePerson/first', 'openid.ax.type.last' : 'http://axschema.org/namePerson/last', 'openid.ax.type.country' : 'http://axschema.org/contact/country/home', 'openid.ax.type.lang' : 'http://axschema.org/pref/language', 'openid.ax.type.web' : 'http://axschema.org/contact/web/default', 'openid.ax.required' : 'email,first,last,country,lang,web', 'openid.ns.oauth' : 'http://specs.openid.net/extensions/oauth/1.0', 'openid.oauth.consumer' : 'www.puffypoodles.com', 'openid.oauth.scope' : 'http://www.google.com/m8/feeds/' , 'openid.ui.icon' : 'true' } ;
var googleOpener = popupManager.createPopupOpener(
{ 'realm' : 'http://*.puffypoodles.com',
  'opEndpoint' : 'https://www.google.com/accounts/o8/ud',
  'returnToUrl' : 'http://www.puffypoodles.com/checkauth?login_type=popup',
'onCloseHandler' : greetUser,
'shouldEncodeUrls' : true,
'extensions' : extensions });
document.getElementById("submit_button").onclick = function() {
googleOpener.popup(450,500);
return true;
};
*)
 function ptrStr(ptr:pointer):string;
begin
  {$ifdef cpu64}
    result:='a'+IntToHex(int64(ptr),16);
  {$else}
    result:='a'+IntToHex(longword(ptr),8);
  {$endif}

end;


begin
  {
  tao:=tAuthOpenId.create;
  tao.identifier:=   ARequestInfo.params('identifier');

  ok := tao.redirectURL(getTrustRoot(),  getReturnTo());
  }
  setupssl;
  
//  'biuro.emadar.eu:7777'
  tlo:=tLightOpenID.create(aRequestInfo.httpHost,googlefinish_authName);
  tlo.discover('https://www.google.com/accounts/o8/id');
  tlo.required:='email';
  tlo.required:='language';
  tlo.required:='nickname';
  tlo.required:='firstname';
  tlo.required:='lastname';
  tlo.fAssoc_Handle:=ptrStr(aRequestInfo)+IntToHex(Random($FFFF),4);
  tlo.fPopup:= aPop;

  sUrl:=tlo.authUrl();
  if apop then begin
//  result:='var x=window.open("'+fName+'",null,"top=300,width=200,height=200,resizable,scrollbars"); x.focus(); ';
    xScript:='  googleOpener = popupManager.createPopupOpener("");';
    xScript:=xScript+'   googleOpener.popup(600,510,"'+sUrl+'");';

     sendPop(aResponseInfo,xScript);
  end else begin
    sendReload(aResponseInfo,sUrl);
  end;


  tlo.free;


end;



class function tOpenId.googlefinish_auth;
var
  tlo : tLightOpenID;
//  wykazXML : tApplicationXML;
//  OK  : boolean;
//  sUrl,
//  sn  : string;
  xForm    : tForm1;

begin
  setupssl;
{   tObject(xForm):=aREquestInfo.fForm;
   result:=xForm.chooseCurrent(ARequestInfo,'b000.htm');
   result:=aRequestInfo.session.application;
   }
   result:=nil;
   if ARequestInfo.session <>nil then
     result:=ARequestInfo.session.application as tApplicationXML;
  if result=nil then
    result:=pointer(11);


        aRequestInfo.ResponseNo:=-1;
  tlo:=tLightOpenID.create(aRequestInfo.httpHost,googlefinish_authName);
  tlo.discover('https://www.google.com/accounts/o8/id');
  tlo.parse_data(      UrlDecode(aRequestInfo.query));
  if tlo.mode=openIdRes then begin
     if tlo.Validate then begin
        aRequestInfo.query:=ssProcedura+'=LO'
          +';name=@OPENID@'
          +';email='+tlo.get('email')
          +';login='+tlo.get('name')
          +';lang='+tlo.get('lang')
//          +';role='+tlo.get('lang')
          +';token=token'
          +';popup=popup'

          +';provider=google';
//        aRequestInfo.useOpenId:=true;
        aRequestInfo.ResponseNo:=openIdLogin;
     end;


  end else begin
    aRequestInfo.ResponseNo:=hsNoPassword;

  end;


  tlo.free;


end;


class procedure tOpenId.fb_auth;
var
//  OK  : boolean;
  xHost,
  sUrl  : string;
  xhost_End : integer;

//?fb_source=search&ref=ts
begin
  setupssl;
  xHost:=aRequestInfo.httpHost;
  xhost_end := strposL(xHost, '/', 9);
  if xhost_end >0 then begin
            xHost := copy(xHost, 0, xhost_end);
  end else xHost:=xHost+'/';
  xHost:=fbRedirectUri;

  sUrl:='https://www.facebook.com/dialog/oauth'
//   +'?client_id=invoicer'
//   +'?client_id=233626170086540'
   +'?client_id='+fbClientId
   +'&redirect_uri='+Urlencode(xHost+fbfinish_authName)
// +'&redirect_uri='+Urlencode(aRequestInfo.httpHost+'/'+finish_authName)
//   +'&response_type=code_and_token'
   +'&scope=email,user_checkins'
   +'&display=popup'
   +'&state='+aRequestInfo.session.fSessionId;

    sUrl:='  googleOpener = popupManager.createPopupOpener("");'
         +'   googleOpener.popup(500,510,"'+sUrl+'");';

     sendPop(aResponseInfo,sUrl);

//  sendReload(aResponseInfo,sUrl);

end;


class function tOpenId.getToken(const aCode,aRedirectUri,aClientID,aClientSecret:string):string;
    var
      xServer: string;
      xResponse : string;
//      xCode  : string;
      xQuery: string;
    begin

//    echo("<script> top.location.href='" . $auth_url . "'</script>")

        xServer:= 'https://graph.facebook.com/oauth/access_token';
        xQuery:='?client_id='+aClientID
               +'&redirect_uri='+Urlencode(aRedirectUri+fbfinish_authName)
               +'&client_secret='+aClientSecret
               +'&code='+aCode;

        xResponse:= readUrl(xServer+xQuery);
        if firstChar(xResponse)='#' then begin
          result:=xResponse;
          exit;
        end;
        result:=slowo('access_token',xResponse,'&');
        if result='' then begin
          result:='#'+xResponse;
        end;

   end;


class function tOpenId.fbgetToken(const aGrant:string):string;
    var
      xServer: string;
      xResponse : string;
//      xCode  : string;
      xQuery: string;
    begin

//    echo("<script> top.location.href='" . $auth_url . "'</script>")

        xServer:= 'https://graph.facebook.com/oauth/access_token';
        xQuery:='?client_id='+fbClientID
               +'&client_secret='+fbClientSecret
               +'&grant_type='+aGrant;

        xResponse:= readUrl(xServer+xQuery);
        if firstChar(xResponse)='#' then begin
          result:=xResponse;
          exit;
        end;
        result:=slowo('access_token',xResponse,'&');
        if result='' then begin
          result:='#'+xResponse;
        end;

   end;


class function tOpenId.fbfinish_auth;
var
  wykazXML : tApplicationXML;
//  OK  : boolean;
//  sUrl,
//  sn  : string;
  xState,
  xError,
  xToken,
  xCode    : string;
//  xForm    : tForm1;
//  s64,
  xMe      : string;
  xForm    : tForm1;
  xSes     : tSession;

  function getjson(aJs: string;aPath:string):string;
  begin
    result:=JSONEscapeDecode(JSONTreeGet(aJS,aPath));
    if firstChar(result)='"' then
       result:=copy(result,2,length(result)-2);
  end;


begin
   result:=nil;
  tObject(xForm):=aREquestInfo.fForm;

  xCode:=aRequestInfo.params('code','&');
//  s64:=base64Urltostr(xcode);

//  writeln('code  =',base64Urltostr(xCode));
  xState:=aRequestInfo.params('state','&');
  xSes:=xForm.getSession(xState);
  if xSes=nil then begin

     writeln('FB session error '+xState);
  end else begin
     aRequestInfo.session:= xSes;
  end;


   if ARequestInfo.session <>nil then
     result:=ARequestInfo.session.application as tApplicationXML;
  if result=nil then
    result:=pointer(11);



        aRequestInfo.ResponseNo:=-1;
//  xQuery:=UrlDecode(aRequestInfo.query);
//  xCode:=aRequestInfo.params('code','&');
  xError:=aRequestInfo.params('error','&');
  if xError<>'' then begin
     aRequestInfo.formParams:=aRequestInfo.params('error_description','&');
     aRequestInfo.ResponseNo:=hsNoPassword;
  end;
  xToken:=getToken(xCode,fbRedirectUri,fbClientId,fbClientSecret);

  if firstChar(xToken)<>'#' then begin
       xMe:=readUrl('https://graph.facebook.com/me?access_token='+xToken);
       if firstChar(xToken)<>'#' then begin
       aRequestInfo.query:=ssProcedura+'=LO'
          +';name=@OPENID@'
          +';email='+getjSOn(xme,'"email"')
          +';login='+getjson(xme,'"name"')
          +';lang='+getjson(xme,'"locale"')
          +';token='+xToken
          +';popup=popup'
          +';provider=facebook';

//        aRequestInfo.useOpenId:=true;
        aRequestInfo.ResponseNo:=openIdLogin;
       end else
         aRequestInfo.formParams:=xME;
       writeln(' xme ',xme);  


  end else begin
    writeln(' ERROR ',xToken);
    aRequestInfo.formParams:=xToken;
    aRequestInfo.ResponseNo:=hsNoPassword;

  end;




end;


class procedure tOpenId.fb_logout(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
var
  sUrl : string;
begin
sUrl:='https://www.facebook.com/logout.php?'
    +'next='+Urlencode(aRequestInfo.httpHost)
   +'&access_token='+aRequestInfo.query;
   writeln(readUrl(sUrl));

end;


class procedure tOpenId.fb_source(aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo);
var
  x : String;


 function auth:String;
//var
//  OK  : boolean;
//  sUrl,
//  sn  : string;

//?fb_source=search&ref=ts
begin
  result:='https://www.facebook.com/dialog/oauth'
   +'?client_id=401609313213511'
   +'&redirect_uri='+Urlencode('https://biuro.emadar.eu:7777/'+fbfinish_authName)
// +'&redirect_uri='+Urlencode(aRequestInfo.httpHost+'/'+finish_authName)
//   +'&response_type=code_and_token'
   +'&scope=email,user_checkins'
//   +'&display=popup'
   +'&state='+aRequestInfo.session.fSessionId;
  writeln('AUTH = ',result);


end;

(*

('', 'signed_request=2tLGCVODSx-OKI8bHPOLFrKuAwXV81s9tXNHvk4cxdc.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzNDI2OTkyMDAsImlzc3VlZF9hdCI6MTM0MjY5Mzk3NSwib2F1dGhfdG9rZW4iOiJBQUFGdFF2UnozRWNCQU1qeE1QbDE4M0xFTjVUeVQxUDBBVFpCakFSOVU0Q2t1NGZLbkZ0ZjlCSjUwakhLWkFaQWpveEdtTFdaQlpCd0ltandKa1lpRVdqdzFkdTVaQmFaQVRTUHRYbWZIcjZsN3BaQ0xwa1haQTFWcyIsInVzZXIiOnsiY291bnRyeSI6InBsIiwibG9jYWxlIjoicGxfUEwiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAxMDIxMTc5NzI4In0',
'fb_source=bookmark_apps&ref=bookmarks&count=0&fb_bmpos=1_0',
'/auth/?fb_source=bookmark_apps&ref=bookmarks&count=0&fb_bmpos=1_0', 0, '', 454, $25E8D60, nil, nil, $25FCF10, $24C0F00, '', 0, 'POST', 'auth/', 'HTTP/1.1', '79.187.5.190', 'biuro.emadar.eu:7777', 'Mozilla/5.0 (Windows NT 5.1; rv:8.0.1) Gecko/20100101 Firefox/8.0.1', 'gzip, deflate', 'pl,en-us;q=0.7,en;q=0.3', 'ISO-8859-2,utf-8;q=0.7,*;q=0.7',
 'https://apps.facebook.com/401609313213511/?fb_source=bookmark_apps&ref=bookmarks&count=0&fb_bmpos=1_0',
 'application/x-www-form-urlencoded', '', '', '',
 'https://apps.facebook.com/401609313213511/?fb_source=bookmark_apps&ref=bookmarks&count=0&fb_bmpos=1_0',
 'application/x-www-form-urlencoded', '', '', '', '', False, True, 0, 0, 0, $25FCFC0, True, False, False, True, False, nil, 0)


'{"algorithm":"HMAC-SHA256","expires":1342706400,
"issued_at":1342700958,
"oauth_token":"AAAFtQvRz3EcBAGq1fHbaE9yDsUZBw2TbznzRzWF7Jz1sihIUcKWvSZBZBc4AkyMeBUGYYEfZCnyirObuidJiRlXuWeEVHRl83ZAaYgxZBpMInb1tdgH3wd",
"user":{"country":"pl","locale":"pl_PL","age":{"min":21}},"user_id":"100001021179728"}'
*)

  function getjson(aJs: string;aPath:string):string;
  begin
    result:=JSONEscapeDecode(JSONTreeGet(aJS,aPath));
    if firstChar(result)='"' then
       result:=copy(result,2,length(result)-2);
  end;

var
  xjs : stringArray;
  xToken,
  xMe,
  s64 : string;
begin
  setupssl;
  writeln('signed request '+aRequestInfo.formParams+aRequestInfo.query);
  x:=slowo('signed_request',aRequestInfo.formParams,'&');
  xjs:=explode('.',x);
  s64:=base64Urltostr(xjs[1]);
  writeln(s64);
  xToken:=getjSON(s64,'"oauth_token"');
  writeln('token ' ,xToken);
  if (xToken)<>'' then begin

     xMe:=readUrl('https://graph.facebook.com/me?access_token='+xToken);
      aRequestInfo.query:=ssProcedura+'=LO'
          +';name=@OPENID@'
          +';email='+getjSOn(xme,'"email"')
          +';login='+getjson(xme,'"name"')
          +';lang='+getjson(xme,'"locale"')
          +';token='+xToken
          +';provider=facebook';

//        aRequestInfo.useOpenId:=true;
        aRequestInfo.ResponseNo:=openIdLogin;
     writeln('xme ',aRequestInfo.query);

//     result:=nil;
  end else begin
    x:=StrTobase64( x );
    writeln(x);
    sendHTML(AResponseInfo,'<html><body ><h1>'+applicationClass.splashText(10)+'</h1>'
            +'<h2>FB Login </h2>'

            +'<div><a  target="_top"  href="'+auth
             +'/" >  Authenticate Me! </a></div>'
//            +'<div id="popuserqt" style="display:none;"><p>invalid user error:<b>'+inttostr(io)+'</b></p></div>'
            +'</body>'
//            <script type="text/javascript">'
            +'</html>');
  end;


end;

class procedure tOpenId.logout;
begin
  if aRequestInfo.FormParams='facebook' then
    fb_logout(aRequestInfo,aResponseInfo);
end;




function parseAutenticationUtil(const aFile: shortstring;aRequestInfo:THTTPRequestInfo;aResponseInfo : THTTPRequestInfo):tApplicationXML;
begin
  result:=nil;
  if aFile=try_authName then tOpenId.try_auth(false,aRequestInfo,aResponseInfo);
  if aFile=google_authName then tOpenId.try_auth(true,aRequestInfo,aResponseInfo);
  if aFile=fb_authName then tOpenId.fb_auth(aRequestInfo,aResponseInfo);
  if aFile=fb_source then tOpenId.fb_source(aRequestInfo,aResponseInfo);
  if aFile=fbfinish_authName then result:=tOpenId.fbfinish_auth(aRequestInfo,aResponseInfo);
  if aFile=googlefinish_authname then result:=tOpenId.googlefinish_auth(aRequestInfo,aResponseInfo);
  if aFile='logout' then tOpenId.logout(aRequestInfo,aResponseInfo);

end;



procedure loginOpenId;
begin
end;

begin
  parseAuth:=parseAutenticationUtil;

end.
