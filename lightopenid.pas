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
unit lightopenid;
interface
{$H+}
uses
  classes,
  sysutils,
  strutils,
  base64,
  kom2,
  flstringarray,
  httpsend,
//  ssl_openssl,
  wpstring,
  xlwebhdr,
  jsondecode;
//  wpdate;

type
 OpenIdMode =(openIdUnknown,openIdRes,openIdCancel);
 openidException = class(exception)
    private
     fResponse : integer;
    public
     constructor Create(const Msg: string;aResponse : integer);
    property response: Integer read FResponse ;

 end;
  tUrl = class(TInterfacedObject)

   public
   url,
   query,
   port,
   path,
   fragment,
   username,
   password,
   scheme,
   host,
   method : string;
  end;

 tLightData = class
   method : string;
   openid_sig: string;
   openid_mode : string;
   openid_ns   : string;
   openid_ns_ax : string;
   openid_claimed_id : string;
   openid_identity   : string;
   openid_return_to  : string;
   openid_signed  : string;
   openid_assoc_handle : string;
   openid_user_setup_url : string;
   function parseFile(aN : string;aBool  : boolean):string;
   function get(aName : string):string;
   function key(i : integer):string;
   function val(i : integer):string;
   function count:integer;

 end;

 tLightOpenID = class

    public

     returnUrl : string;

     optional : stringarray;
     verify_peer : boolean;
         capath : string;
         cainfo : string;
//         Ldata   : tLightData;
      fAssoc_Handle : string;
      fPopup     : boolean;

    private
     frequired : stringarray;
     fData    : tStringList;
     fHeaders : tStringList;
     identity,
     claimed_id : string;
     yadis      : boolean;
    protected
    server,
    trustRoot:string;
    aliases  : stringArray;
    version  : integer;
    identifier_select : boolean;
            ax :boolean;
            sreg : boolean;
             setup_url :string;
             headers :stringarray;
      function parse_header_array(aheader: string; aupdate_claimed_id:boolean):string;
      procedure setRequired(ass : string);
    public

    constructor create(ahost,auri:string);
    destructor destroy;override;
    procedure setvalue(aname, avalue:string);
    function get(aname:string):string;
    function hostExists(aurl:string):boolean;
    function request(aurl:string; amethod:string; aparams:stringarray; aupdate_claimed_id:boolean=false):string;

    function request_streams(aurl:string; amethod:string; aparams:stringArray; aupdate_claimed_id:boolean):string;
    function htmlTag(acontent:string; atag, aattrName, aattrValue, avalueName:string):string;
    function get_Headers(aurl,Aopt:string):string;
    function get_Contents(aMethod,aurl,aOpt:string):string;
    function build_url(aurl, aparts:tUrl):string;overload;
    function build_url(aurl:tUrl;aQuery:string):string;overload;
    function build_url(aurl:string;aQuery:string):string;overload;
    function discover(aurl:string):string;
    function sregParams():stringarray;
    function axParams():stringArray;
    function authUrl(aimmediate:boolean = false):string;
    function authUrl_v2(immediate:boolean):string;
    function authUrl_v1(aimmediate:boolean):string;
    function validate:boolean;
    function validateFB:boolean;
    function ax_to_sreg:stringArray;
    function sreg_to_ax:stringArray;
    function getAttributes():stringArray;
    function getAxAttributes():stringArray;
    function getSregAttributes():stringarray;
    procedure testServer(aServer:string);
    property required:string write setrequired;
    function mode : openIdMode;
      function parse_data(aHeader:string):string;


    end;


implementation

function http_build_query(aparams:stringArray; aa : string;aDelim : string):ansiString;
begin
 translate(aparams,'=>','=');
 result:=implode(aDelim,aParams);
end;

type
 tState = (method,host,userName, password,query,fragment);

function parse_url(aUrl : string):tUrl;
var
  xState : tState;
  i      : integer;
begin
 result:=tUrl.create;
 xState:=method;
 for i := 1 to length(aUrl) do begin
   case aUrl[i] of
    '/' :
   end;
   case xState of
     method : result.method:=result.method+aUrl[i];
   end;
 end;

end;
function parse_host(aUrl : string):string;
begin
 result:='';
end;

constructor openidException.create(const Msg: string;aResponse : integer);
begin
   fResponse:=aResponse;
   inherited create(msg);
end;


    constructor tLightOpenID.create(ahost,auri:string);
    var
      xHost_end : integer;
    begin
//      setupssl;
//        ldata:=tLightData.create;
        fHeaders:=tStringList.create;
        fData:=tStringList.create;
        trustRoot := ifthen(pos('://',ahost) >0, ahost , 'http://' + ahost);
        {
        if ((!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off')
            || (isset($_SERVER['HTTP_X_FORWARDED_PROTO'])
            && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
        )  then begin
            $this->trustRoot = (strpos($host, '://') ? $host : 'https://' . $host);
        end;
        }
        xhost_end := strposL(trustRoot, '/', 9);
        if xhost_end >0 then begin
            trustRoot := copy(trustRoot, copyStart, xhost_end);
        end else trustRoot:=trustRoot+'/';


        returnUrl := trustRoot + aUri;

//        data.Method := aRequestInfo.method;


        //        ($_SERVER['REQUEST_METHOD'] = 'POST') ? $_POST : $_GET;

//        if(!function_exists('curl_init') && !in_array('https', stream_get_wrappers())) {
//             ErrorException('You must have either https wrappers or curl enabled.');
    end;

    destructor tLightOpenId.destroy;
    begin
      inherited;
//      ldata.free;
      fData.free;
      fHeaders.Free;
    end;

    procedure tLightOpenID.setvalue(aname, avalue:string);
    begin
        if aName= 'identity' then begin
//            if (strlen(avalue = trim((String) $value))) then begin
//                if (preg_match('#^xri:/*#i', $value, $m)) {
                if copyEqual(aValue,'xri:') then
                    avalue := copy(avalue,5,length(aValue))
//                else if (!preg_match('/^(?:[=@+\$!\(]|https?:)/i', $value)) {
                else if not copyequal(aValue,'https') then
                    avalue := 'http://'+avalue;

//                if (preg_match('#^https?://[^/]+$#i', $value, $m)) {
                if copyEqual(aValue,'https') then
                    avalue :=aValue+ '/';

//            end;
            claimed_id := avalue;
//            name := avalue;
        end else if aName= 'trustRoot' then
        else if aName= 'realm' then begin
            trustRoot := trim(avalue);
        end;
    end;

    function tLightOpenID.get(aname:string):string;
    begin
        result:='';
        if aName= 'identity' then begin
            // We return claimed_id instead of identity,
            // because the developer should see the claimed identifier,
            // i.e. what he set as identity, not the op-local identifier (which is what we verify)
            result:= claimed_id;
        end else if aName= 'trustRoot' then
        else if aName= 'realm' then
            result:= trustRoot
        else if aName= 'mode' then
            result:= ifthen (fdata.values['openid.mode']='' ,'' , fdata.values['openid.mode'])
        else if aName='email' then
           result:=fData.values['openid.ext1.value.email']
        else if aName='fullname' then
           result:=fData.values['openid.ext1.value.fullname']
        else if aName='lang' then
           result:=fData.values['openid.ext1.value.language']
        else if aName='name' then begin
           result:=fData.values['openid.ext1.value.name'];
           if result='' then
             result:= fData.values['openid.ext1.value.firstname']+' '
             +fData.values['openid.ext1.value.lastname'];
           if result='' then
             result:=fData.values['openid.ext1.value.fullname'];
        end;

    end;

    (**
     * Checks if the server specified in the url exists.
     *
     * @param $url url to check
     * @return true, if the server exists; false otherwise
     *)
    function tLightOpenID.hostExists(aurl:string):boolean;
//    var
//      xParser : tParserUrl;
    begin
       {
        if (pos('/',aurl) <=0) then begin
            server := aurl;
        end else begin
            with tParserUrl.create(aUrl) do try
              server := host
            finally
              free;
            end;
        end;
        }
        if (aUrl='') then begin
            result:=false;
            exit;
        end else
          result:=true;

//        result:= gethostbynamel(server);
    end;

    function tLightOpenID.get_Headers(aurl,aOpt:string):string;
    begin
      result:=get_Contents('HEAD',aurl,aOpt);
    end;
function tLightOpenID.get_Contents(aMethod,aurl,aopt:string):string;
  procedure czytajStream(var sn : ansiString;stm : tStream);
  begin
     stm.seek(0,0);
     setstring(sn,nil,stm.size);
     Stm.Read(Pointer(sn)^, stm.Size);

  end;

var
  bb : boolean;
  i    : integer;
  http : tHttpSend;
  xDataSt : ansistring;
begin
  HTTP := THTTPSend.Create;
  try
    if aOpt<>'' then
      http.Headers.insert(0,aOpt);
    bb := HTTP.HTTPMethod(aMethod, aURL);

    if bb then begin
       czytajStream(result,http.document);
//       result:=result+'(('+long2str(length(result))+'))';

      result:=result+#10;
      for i := http.headers.count-1 downto 0 do
         result:=result+ http.headers[i]+#10;
    end else begin
         result:='%';
         dateTimeToString(xDataSt,'dd/mm/yyyy hh:mm:ss.zzz    ',now);
         writeln('%',http.resultCode,               xDataSt);
    end;
  finally
    HTTP.Free;
  end;
end;




(*    function request_curl($url, $method='GET', $params=array(), $update_claimed_id)
    {
        $params = http_build_query($params, '', '&');
        $curl = curl_init($url . ($method == 'GET' && $params ? '?' . $params : ''));
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Accept: application/xrds+xml, */*'));

        if($this->verify_peer !== null) {
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, $this->verify_peer);
            if($this->capath) {
                curl_setopt($curl, CURLOPT_CAPATH, $this->capath);
            }

            if($this->cainfo) {
                curl_setopt($curl, CURLOPT_CAINFO, $this->cainfo);
            }
        }

        if ($method == 'POST') {
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $params);
        } elseif ($method == 'HEAD') {
            curl_setopt($curl, CURLOPT_HEADER, true);
            curl_setopt($curl, CURLOPT_NOBODY, true);
        } else {
            curl_setopt($curl, CURLOPT_HEADER, true);
            curl_setopt($curl, CURLOPT_HTTPGET, true);
        }
        $response = curl_exec($curl);

        if($method == 'HEAD' && curl_getinfo($curl, CURLINFO_HTTP_CODE) == 405) {
            curl_setopt($curl, CURLOPT_HTTPGET, true);
            $response = curl_exec($curl);
            $response = substr($response, 0, strpos($response, "\r\n\r\n"));
        }

        if($method == 'HEAD' || $method == 'GET') {
            $header_response = $response;

            # If it's a GET request, we want to only parse the header part.
            if($method == 'GET') {
                $header_response = substr($response, 0, strpos($response, "\r\n\r\n"));
            }

            $headers = array();
            foreach(explode("\n", $header_response) as $header) {
                $pos = strpos($header,':');
                if ($pos !== false) {
                    $name = strtolower(trim(substr($header, 0, $pos)));
                    $headers[$name] = trim(substr($header, $pos+1));
                }
            }

            if($update_claimed_id) {
                # Updating claimed_id in case of redirections.
                $effective_url = curl_getinfo($curl, CURLINFO_EFFECTIVE_URL);
                if($effective_url != $url) {
                    $this->identity = $this->claimed_id = $effective_url;
                }
            }

            if($method == 'HEAD') {
                return $headers;
            } else {
                $this->headers = $headers;
            }
        }

        if (curl_errno($curl)) {
            throw new ErrorException(curl_error($curl), curl_errno($curl));
        }

        return $response;
    }
*)

   procedure tLightOpenId.setRequired(ass : string);
   begin
      add_Array(ass,fRequired);
   end;


    function tLightOpenId.parse_data(aHeader:string):string;
    var
      nHeaders : stringArray;
      xPos : integer;
      xName,
      xHeader : string;
      i        : integer;
    begin
        nHeaders:=explode('&',aHeader);
        for i :=low(nHeaders) to high(nHeaders) do begin
            xHeader:=nHeaders[i];
            xpos := pos('=',xheader);
            if (xpos >0) then begin
                xname := lowercase(trim(copy(xheader, 1, xpos-1)));
                fData.Values[xname] := trim(copy(xheader, xpos+1,length(xHeader)));
            end;
        end;

    end;

    function tLightOpenID.parse_header_array(aHeader: string; aupdate_claimed_id:boolean):string;
    var
      xPos : integer;
      xName,
      xHeader : string;
      nHeaders : stringArray;
      i       : integer;
    begin
        nHeaders:=explode(#10,aHeader);
        fheaders.clear;
        for i :=0 to high(nHeaders) do begin
             xHeader:=nHeaders[i];


            xpos := pos(':',xheader);
            if (xpos >0) then begin
                xname := lowercase(trim(copy(xheader, 1, xpos-1)));
                fheaders.Values[xname] := trim(copy(xheader, xpos+1,length(xHeader)));

                // Following possible redirections. The point is just to have
                // claimed_id change with them, because the redirections
                // are followed automatically.
                // We ignore redirections with relative paths.
                // If any known provider uses them, file a bug report.
                if((xname = 'location') and aupdate_claimed_id) then begin
                    if(pos('http',fheaders.values[xname]) = 1)  then begin
                        claimed_id := fheaders.values[xname];
                        identity := claimed_id;
                    end else if(fheaders.values[xname][1] = '/') then begin
                        with tParserUrl.create(claimed_id) do try
//                        $parsed_url = parse_url($this->claimed_id);
                        claimed_id := scheme + '://'
                                          + host
                                          + fheaders.values[xname];
                        identity :=claimed_id;
                        finally
                         free;
                        end;
                    end;
                end;
            end;
        end;
//        return $headers;
    end;

    function tLightOpenID.request_streams(aurl:string; amethod:string; aparams:stringArray; aupdate_claimed_id:boolean):string;
    var
      xHeaders : string;
      xopt,
      xParams  : string;
      xOpts    : stringArray;
      xResult  : integer;
    begin
        if(not hostExists(aurl)) then begin
            raise OpenIdException.create('Could not connect to $url.', 404);
        end;
        xOpt:='';

        xparams := http_build_query(aparams, '', '&');
        if amethod ='GET' then begin
           xOpts:=make_Array('http_method=>GET',
                             'http_header=>Accept: application/xrds+xml, */*',
                             'http_ignore_errors=>true',
                             'ssl_CN_match=>'+ parse_host(aurl));
           {
            xopts = array(
                'http' => array(
                    'method' => 'GET',
                    'header' => 'Accept: application/xrds+xml, */*',
                    'ignore_errors' => true,
                ), 'ssl' => array(
                    'CN_match' => parse_url($url, PHP_URL_HOST),
                ),
            );
            }
            if xParams<>'' then
            aurl := aurl + '?'+xparams;
        end else if amethod= 'POST' then begin
            xopts := make_array(
                    'http_method=>POST',
                    'http_header=>Content-type: application/x-www-form-urlencoded',
                    'http_content=>'+xparams,
                    'http_ignore_errors=>true',
                    'ssl_CN_match=>'+ parse_host(aurl)
            );
        end else if amethod= 'HEAD' then begin
            // We want to send a HEAD request,
            // but since get_headers doesn't accept $context parameter,
            // we have to change the defaults.
            xOpt:='Accept: application/xrds+xml, */*';
(*            xdefault := stream_context_get_options(stream_context_get_default());

            stream_context_get_default(
                make_array(
                    'http_method=>HEAD',
                        'http_header=>Accept: application/xrds+xml, */*',
                        'http_ignore_errors=>true',
                        'ssl_CN_match=>'+parse_host(aurl)
                )
            );
*)
//            if not  is_null(aParams) then
//              aurl := aurl +'?'+ implode('&',aparams);
            if xParams<>'' then
              aurl := aurl + '?'+xparams;


            xheaders := get_headers (aurl,xOpt);
            if(xheaders='') then begin
               result:=xHeaders;
               exit;
            end;

            xresult:=strtointdef(copy(xheaders, pos('HTTP/1.',xHeaders)+9,3),0);
            if (xResult = 301) or (xResult=302) then
              xheaders:=xHeaders+'HTTPMOVE:true'#10+xHeaders;
            if xResult = 405 then begin
                // The server doesn't support HEAD, so let's emulate it with
                // a GET.
//                xargs = func_get_args();
//                $args[1] = 'GET';
//                call_user_func_array(array($this, 'request_streams'), $args);
                result:=request_Streams(aurl,'GET',aparams,aupdate_claimed_id);
                exit;

//                return $this->headers;
            end;

            result:=xHeaders;
            parse_header_array(xheaders, aupdate_claimed_id);
            exit;

            // And restore them.
(*            stream_context_get_default(xdefault);*)
        end;

        if (verify_peer) then begin
(*            xopts['ssl'] += add_array(
                'verify_peer=>true',
                'capath=>'+ capath,
                'cafile=>'+ cainfo
            );
*)
        end;

(*        xcontext = stream_context_create ($opts);*)

//        data.parsefile = file_get_contents($url, false, $context);
//        data.parsefile (aurl, false{, xcontext});
        // This is a hack for providers who don't support HEAD requests.
        // It just creates the headers array for the last request in $this->headers.
(*        if(not is_null(http_response_header)) then begin
             headers.assign(http_response_header);
            headers:=parse_header_array(headers, aupdate_claimed_id);
        end;
*)

        result:= get_contents(aMethod,aurl,xOpt);

    end;

    function tLightOpenID.request(aurl:string; amethod:string; aparams:stringarray; aupdate_claimed_id:boolean=false):string;
    begin
        result:=request_streams(aurl, amethod, aparams, aupdate_claimed_id);
//        fdata.parsefile (result, false{, xcontext});
    end;

    function tLightOpenID.build_url(aurl, aparts:tUrl):string;
    begin
        if (aurl.query<>'') and (aparts.query<>'') then
            aparts.query:= aurl.query + '&' + aparts.query;

//        result := aparts + aurl;
        result := aurl.scheme + '://'             +
               ifempty(aurl.username,'',
                 ifempty(aurl.password, aurl.username+'@',aurl.username+':'+aurl.password+'@'))
             + aurl.host
             + ifempty(aurl.port,'',':'+aurl.port)
             + ifempty(aurl.path,'',aurl.path)
             + ifempty(aurl.query,'','?'+aurl.query)
             + ifempty(aurl.fragment,'','#'+aurl.fragment);
    end;

    function tLightOpenID.build_url(aurl:tUrl;aQuery : string):string;
    begin
        if AQuery<>'' then begin
          if (aurl.query<>'') then
            aUrl.query:= aurl.query + '&' + aquery
          else
            aUrl.query:=  aquery;
        end;

//        result := aparts + aurl;
        result := aurl.scheme + '://'             +
               ifempty(aurl.username,'',
                 ifempty(aurl.password, aurl.username+'@',aurl.username+':'+aurl.password+'@'))
             + aurl.host
             + ifempty(aurl.port,'',':'+aurl.port)
             + ifempty(aurl.path,'',aurl.path)
             + ifempty(aurl.query,'','?'+aurl.query)
             + ifempty(aurl.fragment,'','#'+aurl.fragment);
    end;

    function tLightOpenID.build_url(aurl:string;aQuery : string):string;
    begin
        if AQuery<>'' then begin
          result:=aUrl+ '?' + aquery;
        end else begin
           result:=aUrl;
        end;
    end;



    (**
     * Helper function used to scan for <meta>/<link> tags and extract information
     * from them
     *)
    function tLightOpenID.htmlTag(acontent:string; atag, aattrName, aattrValue, avalueName:string):string;
    begin
    (*
      result:=preg_match_all("#<{$tag}[^>]*$attrName=['\"].*?$attrValue.*?['\"][^>]*$valueName=['\"](.+?)['\"][^>]*/?>#i", $content, $matches1);
      if result='' then
        result:=preg_match_all("#<{$tag}[^>]*$valueName=['\"](.+?)['\"][^>]*$attrName=['\"].*?$attrValue.*?['\"][^>]*/?>#i", $content, $matches2);
     *)


//        $result = array_merge($matches1[1], $matches2[1]);

//        return empty($result)?false:$result[0];
    end;

    (**
     * Performs Yadis and HTML discovery. Normally not used.
     * @param $url Identity URL.
     * @return String OP Endpoint (i.e. OpenID provider address).
     * @throws ErrorException
     *)
    function tLightOpenID.discover(aurl:string):string;
    var
      xNext : boolean;
      xNS,
      xc,
      xurl   : string;
      xHeaders : string;
      xContent : string;
      xLocation,
      xxtype,
      xType,
      xDelegate: string;
      xServer  : string;
      xCon,
      xOriginalUrl : string;
      it,
      i        : integer;
    begin

        if (aurl='') then  raise OpenIdException.create('No identity supplied.',200);
        xUrl:=aUrl;
        // Use xri.net proxy to resolve i-name identities
//        if copy( not (copy(aurl,1,5)<>'https' '#^https?:#', aurl)) then begin
{        if  copy(aurl,1,5)<>'https'  then begin
            xurl := 'http://xri.net/'+aurl;
        end;
}

        // We save the original url in case of Yadis discovery failure.
        // It can happen when we'll be lead to an XRDS document
        // which does not have any OpenID2 services.
        xoriginalUrl := xurl;
        server:=xUrl;

        // A flag to disable yadis discovery in case of failure in headers.
        yadis := true;

        // We'll jump a maximum of 5 times, to avoid endless redirections.
        for i :=0 to 4 do begin
            if (yadis) then begin
                xheaders := request(xurl, 'HEAD', make_array(), true);

                xnext := false;
                if fHeaders.values['HTTPMOVE']='true' then begin
                  xurl:=fHeaders.values['location'];
                  continue;
                end;
                if fHeaders.values['x-xrds-location']<>'' then begin
                    xurl := build_url(parse_url(xurl), parse_url(trim(fHeaders.values['x-xrds-location'])));
                    xnext := true;
                end;
                xCon:=fheaders.Values['content-type'];
                if (xCOn<>'')
                    and (pos('application/xrds+xml',xCon)  >0)
                       or (pos('text/html',xCon)  >0)
                        or (pos('text/xml',xCon)  >0)
                then begin
                    // Apparently, some providers return XRDS documents as text/html.
                    // While it is against the spec, allowing this here shouldn't break
                    //# compatibility with anything.
                    //# ---
                    //# Found an XRDS document, now let's find the server, and optionally delegate.
                    xcontent := request(xurl, 'GET',make_array);

//                    preg_match_all('#<Service.*?>(.*?)</Service>#s', content, m);
                    repeat
                       xc:=XMLWytnijS('Service',xContent,true);
                       if xc='' then continue;
//                    foreach($m[1] as content) then begin
//                        xcontent := ' ' + xcontent; // The space is added, so that strpos doesn't return 0.

                        // OpenID 2
//                       xns := preg_quote('http://specs.openid.net/auth/2.0/', '#');
//                       if(preg_match('#<Type>\s*'+xns+'(server|signon)\s*</Type>#s', xc, xtype)) then begin
                       xns:='http://specs.openid.net/auth/2.0/';
                       repeat

                       xxType:=xmlWYtnijS('Type',xc,true);

                       it:=pos(xns,xxType);
                       if it>0 then begin
                         xType:=copy(xxType,it+length(xns),10);
                       end else
                         xType:='';
                       if xType<>'' then begin
                            if (xtype = 'server') then identifier_select := true;

                            //preg_match('#<URI.*?>(.*)</URI>#', xcontent, xserver);
                            xServer:=XMLWytnijS('URI',xc,true);

//                            preg_match('#<(Local|Canonical)ID>(.*)</\1ID>#', xcontent, xdelegate);
                            xDelegate:=XMLWytnijS('ID',xc,true);
                            if (xserver='') then begin
                                result:= '';
                                exit;

                            end;
                            // Does the server advertise support for either AX or SREG?
                            ax   := pos( '<Type>http://openid.net/srv/ax/1.0</Type>',xc)>0;
                            sreg := (pos( '<Type>http://openid.net/sreg/1.0</Type>',xC)>0)
                                       or (pos('<Type>http://openid.net/extensions/sreg/1.1</Type>',xC)>0);

//                            $server = $server[1];
//                            if (isset(delegate[2])) then identity := trim($delegate[2]);
                            identity:=xDelegate;
                            version := 2;

                            server := xserver;
                            result:= xserver;
                            exit;
                       end;
                    until xxType='';
                    until xc='';

                        // OpenID 1.1
//                    xns := preg_quote('http://openid.net/signon/1.1', '#');
//                    if (preg_match('#<Type>\s*'+xns+'\s*</Type>#s', xc)) then begin
                         xType:=xmlWytnijS('Type',xc,false);
                         if xType<>'' then begin

//                            preg_match('#<URI.*?>(.*)</URI>#', xcontent, xserver);
                            xServer:=XMLWytnijS('URI',xc,true);
//                            preg_match('#<.*?Delegate>(.*)</.*?Delegate>#', xcontent, xdelegate);
                            xDelegate:=XMLWytnijS('Delegate',xc,true);
                            if (xserver='') then begin
                                result:='' ;exit;
                            end;

                            // AX can be used only with OpenID 2.0, so checking only SREG
                            sreg := (pos( '<Type>http://openid.net/sreg/1.0</Type>',xc)>0)
                                       or (pos( '<Type>http://openid.net/extensions/sreg/1.1</Type>',xc)>0);

//                            if (isset(delegate[1]))then identity := $delegate[1];
                            identity:=xDelegate;
                            version := 1;

                            server := xserver;
                            result:=xserver;
                            exit;
                    end;
//                end;

                    xnext := true;
                    yadis:= false;
                    xurl := xoriginalUrl;
                    xcontent := '';
                    break;
                end;
                if (xnext) then continue;

                // There are no relevant information in headers, so we search the body.
                xcontent := request(xurl, 'GET', make_array(), true);

                if fheaders.values['x-xrds-location']<>'' then begin
                    xurl := build_url(xurl, trim(fheaders.values['x-xrds-location']));
                    continue;
                end;

                xlocation := htmlTag(xcontent, 'meta', 'http-equiv', 'X-XRDS-Location', 'content');
                if xlocation<>'' then begin
                    xurl := build_url(xurl, xlocation);
                    continue;
                end;
            end;

            if is_null(xcontent) then xcontent := request(xurl, 'GET',make_array);

            // At this point, the YADIS Discovery has failed, so we'll switch
            // to openid2 HTML discovery, then fallback to openid 1.1 discovery.
            xserver   := htmlTag(xcontent, 'link', 'rel', 'openid2.provider', 'href');
            xdelegate := htmlTag(xcontent, 'link', 'rel', 'openid2.local_id', 'href');
            version := 2;

            if (xserver='') then begin
                // The same with openid 1.1
                xserver   := htmlTag(xcontent, 'link', 'rel', 'openid.server', 'href');
                xdelegate := htmlTag(xcontent, 'link', 'rel', 'openid.delegate', 'href');
                version := 1;
            end;

            if (xserver<>'') then begin
                // We found an OpenID2 OP Endpoint
                if (xdelegate<>'') then begin
                    // We have also found an OP-Local ID.
                    identity := xdelegate;
                end;
                server := xserver;
                result:= xserver;
                exit;
            end;

            raise OpenIdException.create('No OpenID Server found at '+aurl, 404);
        end;
        raise OpenIdException.create('Endless redirection!', 500);
    end;

    function tLightOpenID.sregParams():stringarray;
    var
      xop,
      xReq : string;
      i    : integer;

    begin
        result := make_array;
        xReq:='';
        // We always use SREG 1.1, even if the server is advertising only support for 1.0.
        // That's because it's fully backwards compatibile with 1.0, and some providers
        // advertise 1.0 even if they accept only 1.1. One such provider is myopenid.com
        set_array(result,'openid.ns.sreg', 'http://openid.net/extensions/sreg/1.1');
        if not is_null(frequired) then begin
            (* $params['openid.sreg.required'] = array();
            foreach ($this->required as $required) {
                if (!isset(self::$ax_to_sreg[$required])) continue;
                $params['openid.sreg.required'][] = self::$ax_to_sreg[$required];
            }
            *)
            for i := low(frequired) to high(frequired) do begin
               xop:=get_array(ax_to_sreg,frequired[i]);
               if xop='' then continue;
               xReq:=xReq+','+xop;
            end;
//            $params['openid.sreg.required'] = implode(',', $params['openid.sreg.required']);

            set_array(result,'openid.sreg.required',xReq);
        end;

        if not is_null(optional) then begin
//            $params['openid.sreg.optional'] = array();
            xReq:='';
//            foreach ($this->optional as $optional) then
            for i := 1 to high(optional) do begin
                xop:=get_array(ax_to_sreg,optional[i]);
                if xop='' then continue;
//                if (!isset(self::$ax_to_sreg[$optional])) continue;
//                $params['openid.sreg.optional'][] = self::$ax_to_sreg[$optional];
                xReq:=xReq+','+ get_array(ax_to_sreg,xop);

            end;
            set_array(result,'openid.sreg.optional',xReq);
//            implode(',', get_array(xparams,'openid.sreg.optional'));
        end;
    end;

    function tLightOpenID.axParams():stringArray;
    var
//     xparams : stringarray;
     xCounts  : stringArray;
     x,
     i    : integer;

     xAlias : string;
     xField : stringarray;
     s,sv : string;
    begin
        result := make_array;
        xField:=sreg_to_ax;
        if not is_null(frequired) or not is_null(optional) then begin
            set_array(result,'openid.ns.ax', 'http://openid.net/srv/ax/1.0');
            set_array(result,'openid.ax.mode', 'fetch_request');
            for i:=low(frequired) to high(frequired) do begin
              s:=frequired[i];
              xAlias:=get_array(xField,s);
              set_array(aliases,s,'http://axschema.org/' + xAlias);
              {
              s:=find_array(xCounts,xAlias);
              x:=strtointdef(s,0);
              inc(x);
              set_array(xCounts,xAlias,inttostr(x));
              }
            end;
            for i:=low(optional) to high(optional) do begin
              s:=optional[i];
              xAlias:=get_array(xField,s);
              set_array(aliases,s,'http://axschema.org/' + xAlias);
              s:=get_array(xCounts,xAlias);
              x:=strtointdef(s,0);
              inc(x);
              set_array(xCounts,xAlias,inttostr(x));
            end;


            (*
            foreach (array('required','optional') as $type)  then

                foreach ($this->$type as $alias => $field) {
                    if (is_int($alias)) $alias = strtr($field, '/', '_');
                    $this->aliases[$alias] = 'http://axschema.org/' . $field;
                    if (empty($counts[$alias])) $counts[$alias] = 0;
                    $counts[$alias] += 1;
                    ${$type}[] = $alias;
                }
            end;
            *)
            for i := 0 to high(Aliases) do begin

//            foreach ($this->aliases as $alias => $ns) {
                s:=get_String(Aliases[i],sv);
                set_array(result,'openid.ax.type.' + s, sv);
            end;
            for i:= 0 to high(xCounts) do begin
//            foreach ($counts as $alias => $count)
                s:=get_String(xCounts[i],sv);
                if strtoIntdef(sv,0)<=1  then continue;
                 set_array(result, 'openid.ax.count.' + s, sv);
            end;
            // Don't send empty ax.requied and ax.if_available.
            //.. Google and possibly other providers refuse to support ax when one of these is empty.
            if not is_null(frequired) then begin
                set_array(result,'openid.ax.required', implode(',', frequired));
            end;
            if not is_null(optional) then begin
                set_array(result,'openid.ax.if_available', implode(',', optional));
            end;
        end;
    end;

    function tLightOpenID.authUrl_v1(aimmediate:boolean):string;
    var
      xReturnUrl: string;
      xParams   : stringarray;
    begin
        xreturnUrl := returnUrl;
        // If we have an openid.delegate that is different from our claimed id,
        // we need to somehow preserve the claimed id between requests.
        // The simplest way is to just send it along with the return_to url.
        if(identity <> claimed_id) then begin
            xreturnUrl :=xreturnUrl+ ifthen(pos('?',xreturnUrl)>0 , '&' , '?') + 'openid.claimed_id=' + claimed_id;
        end;

        xparams := make_array(
            'openid.return_to=>'+xreturnUrl,
            'openid.mode=>'+ ifthen(aimmediate , 'checkid_immediate' , 'checkid_setup'),
            'openid.identity=>'+identity,
            'openid.trust_root=>'+trustRoot
            ) ;
            add_array( sregParams(),xParams);

        result:= build_url(server           ,  http_build_query(xparams, '', '&'));
    end;

    function tLightOpenID.authUrl_v2(immediate:boolean):string;
    var
      xParams :stringarray;
    begin
        xparams := make_array(
            'openid.ns=>http://specs.openid.net/auth/2.0',
            'openid.mode=>'+ ifthen(immediate , 'checkid_immediate' , 'checkid_setup'),
            'openid.return_to=>'+returnUrl,
            'openid.realm=>'+trustRoot
        );
        if fAssoc_handle<>'' then
         set_array(xParams,'openid.assoc_handle',fAssoc_handle);

        if (ax) then begin
            add_array(axParams(),xParams);
        end;
        if (sreg) then begin
            add_array( sregParams(),xParams);
        end;
        if fPopup then begin
         set_array(xParams,'openid.ui.ns','http://specs.openid.net/extensions/ui/1.0');
         set_array(xParams,'openid.ui.mode','popup');
         set_array(xParams,'openid.ui.icon','true');
        end;
        if not(ax) and  not(sreg) then begin
            // If OP doesn't advertise either SREG, nor AX, let's send them both
            // in worst case we don't get anything in return.
            add_array( sregParams(),xParams);
            add_array( axParams(),xParams);
        end;

        if (identifier_select) then begin
            set_array( xparams,'openid.claimed_id', 'http://specs.openid.net/auth/2.0/identifier_select');
            set_array(xparams,'openid.identity','http://specs.openid.net/auth/2.0/identifier_select');
        end else begin
            set_array(xparams,'openid.identity', identity);
            set_array(xparams,'openid.claimed_id',claimed_id);
        end;

        result:= build_url(server                               , http_build_query(xparams, '', '&'));
    end;

    (**
     * Returns authentication url. Usually, you want to redirect your user to it.
     * @return String The authentication url.
     * @param String $select_identifier Whether to request OP to select identity for an user in OpenID 2. Does not affect OpenID 1.
     * @throws ErrorException
     *)

(*

from: https://developers.google.com/accounts/docs/OpenID?hl=pl


     https://www.google.com/accounts/o8/id
?openid.ns=http://specs.openid.net/auth/2.0
&openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select
&openid.identity=http://specs.openid.net/auth/2.0/identifier_select
&openid.return_to=http://www.example.com/checkauth
&openid.realm=http://www.example.com/
&openid.assoc_handle=ABSmpf6DNMw
&openid.mode=checkid_setup


*)
    function tLightOpenID.authUrl(aimmediate:boolean = false):string;
    begin
        if ((setup_url<>'') and not aimmediate) then begin
          result:= setup_url;
          exit;
        end;
        if (server='') then  discover(identity);

        if (version = 2) then begin
            result:= authUrl_v2(aimmediate);
            exit;
        end;
        result:=authUrl_v1(aimmediate);
    end;

    (**
     * Performs OpenID verification with the OP.
     * @return Bool Whether the verification was successful.
     * @throws ErrorException
     *)

    function tLightOpenId.mode:openIdMode;
    var
      s : string;
    begin
     s:=get('mode');
     if s = 'id_res' then result:=openIdRes
     else if s='cancel' then result:=openIdCancel
     else result:=openIdUnknown;
    end;

    function tLightOpenID.validate():boolean;
    var
      xServer: string;
      xItems,
      xParams : stringArray;
      i   : integer;
      xValue : string;
      xResponse : string;
    begin
        // If the request was using immediate mode, a failure may be reported
        // by presenting user_setup_url (for 1.1) or reporting
        // mode 'setup_needed' (for 2.0). Also catching all modes other than
        // id_res, in order to avoid throwing errors.
        if(fdata.values['openid_user_setup_url']<>'') then begin
            setup_url := fdata.values['openid_user_setup_url'];
            result:= false;
            exit;
        end;

        if (get('mode') <> 'id_res') then begin
            result:= false;
            exit;
        end;

//        parsedata;

        claimed_id := ifthen((fdata.values['openid.claimed_id']<>''),fdata.values['openid.claimed_id'],fdata.values['openid.identity']);
        xparams := make_array(
//            'openid.assoc_handle=>'+fdata.values['openid.assoc_handle'],
            'openid.signed=>'+ fdata.values['openid.signed'],
            'openid.sig=>'+fdata.values['openid.sig']
            );

        if (fdata.values['openid.ns']<>'') then begin
            // We're dealing with an OpenID 2.0 server, so let's set an ns
            // Even though we should know location of the endpoint,
            // we still need to verify it by discovery, so $server is not set here
            set_Array( xparams,'openid.ns', 'http://specs.openid.net/auth/2.0');
        end else if (fdata.values['openid.claimed_id']<>'')
            and (fdata.values['openid.claimed_id']  <> fdata.values['openid.identity']  ) then begin
            // If it's an OpenID 1 provider, and we've got claimed_id,
            // we have to append it to the returnUrl, like authUrl_v1 does.
            returnUrl :=returnUrl +ifthen (pos(returnUrl, '?')>0, '&' , '?')
                             +  'openid.claimed_id=' + claimed_id;
        end;

        if (fdata.values['openid.return_to'] <> returnUrl) then begin
            // The return_to url must match the url of current request.
            // I'm assuing that noone will set the returnUrl to something that doesn't make sense.
            result:= false;
            exit;
        end;

        xserver := discover(claimed_id);
        xItems:=explode(',', fdata.values['openid.signed']);
        for i := low(xItems) to high(xitems) do begin
//            xvalue := fdata.values['openid.' + stringreplace(xitems[i],'.','_',[rfReplaceAll])];
            xvalue := fdata.values['openid.' + xitems[i]];
            set_array(xParams,'openid.'+xItems[i],xvalue);
        end;

//        foreach (explode(',', data.openid_signed) as $item) then begin
            // Checking whether magic_quotes_gpc is turned on, because
            // the function may fail if it is. For example, when fetching
            // AX namePerson, it might containg an apostrophe, which will be escaped.
            // In such case, validation would fail, since we'd send different data than OP
            // wants to verify. stripslashes() should solve that problem, but we can't
            // use it when magic_quotes is off.
//            xvalue := data['openid_' + str_replace('.','_',xitem)];
//            xparams['openid.' + xitem] := function_exists('get_magic_quotes_gpc') and  ifthen (get_magic_quotes_gpc() , stripslashes($value) , $value);

//        end;

        set_array(xparams,'openid.mode', 'check_authentication');

        xresponse := request(xserver, 'GET', xparams);
        i:=pos('is_valid',xResponse);
        xResponse:=copy(xResponse,i+9,4);
        result:=xResponse='true';

//        return preg_match('/is_valid\s*:\s*true/i', xresponse);
    end;


    function tLightOpenID.validateFB():boolean;
    var
      xServer: string;
//      xParams : stringArray;
      xToken,
      xResponse : string;
      xCode  : string;
      xQuery: string;

//      http://developers.facebook.com/docs/authentication/server-side/
    begin


        if(fdata.values['state']<>'') then begin
            setup_url := fdata.values['state'];
        end;
        if(fdata.values['error']<>'') then begin
//            setup_url := fdata.values['state'];
            result:=false;
        end;
        xCode:=fdata.values['code'];
        xServer:= 'https://graph.facebook.com/oauth/access_token';
        xQuery:='?client_id=401609313213511'
               +'&redirect_uri='+Urlencode('https://biuro.emadar.eu:7777/auth_fbfinish.htm')
               +'&client_secret=760841d4306b3819a3d6fbdb081ac544'
               +'&code='+xCode;

        xResponse:= get_contents('GET',xServer+xQuery,'');
        parse_Data(xResponse);
        xToken:=fData.values['access_token'];

        xServer:='https://graph.facebook.com/me?access_token='+xToken;
        xResponse:= get_contents('GET',xServer,'');
//        xresponse := request(xserver, 'GET', xparams);
        result:=   JSONGetValue(xResponse)='error';
   end;




    function tLightOpenID.getAxAttributes():stringArray;
    var
      xSigned:stringArray;
      xKeyMatch,
      xKey,
      xVal,
      xValue,
      xAlias : string;
//      xAttributes : stringArray;
      i      : integer;
    begin
        xalias := '';
        if  (fdata.values['openid.ns.ax'] <> 'http://openid.net/srv/ax/1.0') then begin
         // # It's the most likely case, so we'll check it before
            xalias := 'ax';
        end  else begin
            // 'ax' prefix is either undefined, or points to another extension,
            // so we search for another prefix
//            foreach ($this->data as $key => $val)
            for i := 1 to fdata.count do begin
               xKey:=fdata.names[i];
               xVal:=fdata.values[xkey];
                if (copy(xkey, 0, length('openid_ns_')) = 'openid_ns_')
                    and (xval = 'http://openid.net/srv/ax/1.0')
                 then begin
                    xalias := copy(xkey, length('openid_ns_'),length(xKey));
                    break;
                end;
            end;
        end;
        if (xalias='') then begin
            // An alias for AX schema has not been found,
            // so there is no AX data in the OP's response
            result:= make_array;
            exit;
        end;

        result := make_array;
//        foreach (explode(',', $this->data['openid_signed']) as $key) {
        xSigned:=explode(',', fdata.values['openid.signed']);

        for i:= 0 to high(xSigned) do begin
            xkeyMatch := xalias + '.value.';
            if (copy(xkey, 1, length(xkeyMatch)) <> xkeyMatch) then begin
                continue;
            end;
            xkey := copy(xkey, length(xkeyMatch),length(xKey));
            if (fdata.values['openid.' + xalias + '_type_'  +xkey]='') then begin
                // OP is breaking the spec by returning a field without
                // associated ns. This shouldn't happen, but it's better
                // to check, than cause an E_NOTICE.
                continue;
            end;
            xvalue := fdata.values['openid.' + xalias + '.value.'  +xkey];
            xkey := copy(fdata.values['openid.' + xalias + '.type.'  +xkey],
                          length('http://axschema.org/'),1000);

            set_array(result,xkey, xvalue);
        end;
    end;

    function tLightOpenID.getSregAttributes():stringarray;
    var
      xAttributes : stringarray;
      xSigned : stringArray;
      xKeyMatch,
      xName,
      xKey : string;
      i  : integer;
    begin
        xattributes := make_array;
//        sreg_to_ax := array_flip(self::$ax_to_sreg);
//        foreach (explode(',', $
        xSigned:=explode(',', fdata.values['openid.signed']);
        for i:=0 to length(xSigned) do begin

          xKey:=xSigned[i];
            xkeyMatch := 'sreg.';
            if (copy(xkey, 1, length(xkeyMatch)) <> xkeyMatch) then
                continue;

            xkey := copy(xkey, length(xkeyMatch),length(xKey));
            xName:=get_array(sreg_to_ax,xKey);
            if xName='' then begin
                // The field name isn't part of the SREG spec, so we ignore it.
                continue;
            end;
            set_array(xattributes,xName, fdata.values['openid.sreg,' + xkey]);
        end;
        result:= xattributes;
    end;

    (**
     * Gets AX/SREG attributes provided by OP. should be used only after successful validaton.
     * Note that it does not guarantee that any of the required/optional parameters will be present,
     * or that there will be no other attributes besides those specified.
     * In other words. OP may provide whatever information it wants to.
     *     * SREG names will be mapped to AX names.
     *     * @return Array Array of attributes with keys being the AX schema names, e.g. 'contact/email'
     * @see http://www.axschema.org/types/
     *)
    function tLightOpenID.getAttributes():stringArray;
    begin
        if (fdata.values['openid.ns']<>'')
            and (fdata.values['openid.ns'] = 'http://specs.openid.net/auth/2.0') then begin
          //penID 2.0
          //# We search for both AX and SREG attributes, with AX taking precedence.
          result:=getAxAttributes();
          add_array( getSregAttributes(),result);
          exit;
        end;
        result:= getSregAttributes();

   end;



    function tLightOpenId.ax_to_sreg:stringArray;
    begin
      result:=make_array('namePerson/friendly=>nickname',
        'contact/email=>email',
        'namePerson=>fullname',
        'birthDate=>dob',
        'person/gender=>gender',
        'contact/postalCode/home=>postcode',
        'contact/country/home=>country',
        'pref/language=>language',
        'pref/timezone=>timezone'
        );
    end;
    function tLightOpenId.sreg_to_ax:stringArray;
    begin
      result:=make_array('nickname=>namePerson/friendly',
        'email=>contact/email',
        'fullname=>namePerson/friendly',
        'lastname=>namePerson/last',
        'firstname=>namePerson/first',
        'dob=>birthDate',
        'gender=>person/gender',
        'postcode=>contact/postalCode/home',
        'country=>contact/country/home',
        'language=>pref/language',
        'timezone=>pref/timezone'
        );
    end;

   procedure tLightOpenID.testServer(aServer:string);
   begin
     server:=aServer;
     version:=2;
   end;

   function tLightData.parseFile(aN : string;aBool  : boolean):string;
   begin
   end;
   function tLightData.get(aName : string):string;
   begin
   end;
   function tLightData.key(i : integer):string;
   begin
   end;
   function tLightData.val(i : integer):string;
   begin
   end;
   function tLightData.count:integer;
   begin
     result:=1;
   end;

end.
