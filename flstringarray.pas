unit flstringarray;
interface
{$H+}
uses
  sysutils,
  classes,
  base64;

type
  bigInt = string;
  stringArray = array of string;
    ArrOfStr = stringArray;

  stringStringArray = array of stringArray;

function  longToBinary(l:bigint): string;
function longToBase64(astr:string):string;
function binaryToLong(asrc:string):bigint;
function base64ToLong(astr:string):string;
function base64urlToStr(astr:string):string;
function Auth_OpenID_mkNonce():string;
function in_Array(str : string;const  arr : stringArray):boolean;
function find_array(str : string;const arr : stringstringArray):integer;overload;
function find_array(str : string;const arr : stringArray):integer;overload;
function is_null(ass : stringArray):boolean;overload;
function is_null(ass : string):boolean;overload;
function add_array(str : string;var arr : stringArray):integer;overload;

function add_array(const str : stringArray;var arr : stringArray):integer;overload;
function add_array(const str : stringArray;var arr : stringStringArray):integer;overload;
function set_array(var arr : stringStringArray;st1,stV : string):integer;overload;
function set_array(var arr : stringArray;st1,stV : string):integer;overload;
function get_array(const arr : stringArray;stv : string):string;
//function set_array(const st1 : string;var arr : stringArray;stV : string):integer;override;
function make_String(s1,sv: string):string;overload;
function get_string(s1 : string;var sv: string):string;overload;
function get_string(s1 : string):string;overload;

function make_array(s1,s2: string;const s3:string='';const s4:string='';const s5:string='';const s6:string='';const s7:string=''
                                 ;const s8:string='';const s9:string='';const s10:string='';const s11:string=''):stringArray;overload;
function make_array(s1: stringArray):stringStringArray;overload;
function make_array(s1,s2: stringArray):stringStringArray;overload;
function make_array(s1,s2,s3: stringArray):stringStringArray;overload;
procedure make_list(arr : stringArray;var s1,s2 : string);
function make_array:stringArray;overload;
function explode(s1: char;const  s2: string):stringArray;overload;
function explode(sPart, sInput: string): ArrOfStr;overload;
function implode(sPart: string; arrInp: ArrOfStr): string;
function translate(arr : stringArray;ain,aOut : string):integer;

//function explode(atr : stringarray; var s1: string): string;overload;
function urldefrag(aurl:string):string;
procedure addPrefix(var arr : stringArray;s1 : string);
function SplitString(const aSeparator, aString: String; aMax: Integer = 0): Stringarray;

implementation
function  longToBinary(l:bigint): string;
var
  i : integer;
begin

//        if l < 0 then
//            raise ValueError('This function only supports positive integers')
        {
        repeat
          x:=l mod 256;
          l:=l div 256;
          Result := Result + '\x' + IntToHex(x, 2);
        until l=0;
        }
        for i:= 1 to length(l) do begin
          Result := Result + '\x' + IntToHex(ord(l[i]), 2);
        end;

        if ord(l[1]) > 127 then begin
            result:= '\x00' + result;
        end;
end;

function longToBase64(astr:string):string;
begin

        result:= base64tostr(longToBinary(astr));
end;


function binaryToLong(asrc:string):bigint;
var
  i : integer;
  xBytes : string;
  ESC: string[8];
  CharCode: integer;
  ch : char;

begin
        if (asrc = '') then begin
          result:='';
          exit;
        end;

  i:=1;
  while i <= Length(ASrc) do begin
    if ASrc[i] <> '\' then begin  {do not localize}
      xBytes := xBytes + ASrc[i]
    end else begin
      Inc(i); // skip the % char
      ch:=aSrc[i];
      if ch='x' then begin
        ESC := Copy(ASrc, i, 2); // Copy the escape code
        Inc(i, 1); // Then skip it.
        try
          CharCode := StrToIntDef('$' + ESC,0);  {do not localize}
          xBytes := xBytes + Char(CharCode);
        except end;
      end;
    end;
  end;



        // Use array_merge to return a zero-indexed array instead of a
        // one-indexed array.
//        xbytes = array_merge(unpack('C*', $str));
        result:='';
//        xBytes:=aStr;

        {if ($bytes && ($bytes[0] > 127))

            trigger_error("bytesToNum works only for positive integers.",
                          E_USER_WARNING);
            return null;
        }
        {
        for I:= 1 to length(xBytes) do begin
            result := result shl 8;
            result:=result+ord(xBytes[i]);
        end;
        }
        result:=xBytes;
end;

function base64ToLong(astr:string):string;
var
  b64 : string;
begin
        b64 := base64tostr(astr);

//        if ($b64 === false) {
//            return false;
//        }

        result:= binaryToLong(b64);
end;

function base64urlToStr(astr:string):string;
var
  sb : string;
  i  : integer;
begin

 if (length(astr) mod 4 =0) then
   sb:=astr
 else
   sb:=astr+copy('=====',1,4-length(astr) mod 4);
 for i := 1 to length(astr) do
   case sb[i] of
    '-' : sb[i]:='+';
    '_' : sb[i]:='/';
   end;
 result:=base64ToStr(sb);


end;



function Auth_OpenID_mkNonce():string;
var
  salt : string;
begin
    // Generate a nonce with the current timestamp
    {
    salt = Auth_OpenID_CryptUtil::randomString(6, Auth_OpenID_Nonce_CHRS);
    if ($when === null)
        // It's safe to call time() with no arguments; it returns a
        // GMT unix timestamp on PHP 4 and PHP 5.  gmmktime() with no
        // args returns a local unix timestamp on PHP 4, so don't use
        // that.
        $when = time();

    $time_str = gmstrftime(Auth_OpenID_Nonce_TIME_FMT, $when);
    return $time_str . $salt;
    }
    result:=datetimeToStr(now);
end;


function in_Array(str : string;const  arr : stringArray):boolean;
var
  i : integer;
begin
 for i:= low(arr) to high(arr) do begin
   if arr[i]=str then begin
     result:=true;
     exit;
   end;
 end;
 result:=false;
end;

function find_array(str : string;const arr : stringstringArray):integer;overload;
var
  i : integer;
begin
 for i:= low(arr) to high(arr) do begin
   if arr[i][low(arr[i])]=str then begin
     result:=i;
     exit;
   end;
 end;
 result:=-1;

end;

function find_array(str : string;const arr : stringArray):integer;overload;
var
  i : integer;
  sv : string;
begin
 for i:= low(arr) to high(arr) do begin
   if get_string(arr[i],sv)=str then begin
     result:=i;
     exit;
   end;
 end;
 result:=-1;

end;


function is_Null(ass : stringArray):boolean;
begin
  result:=length(ass)=0;
end;
function is_Null(ass : string):boolean;
begin
  result:=length(ass)=0;
end;

function add_array(str : string;var arr : stringArray):integer;

begin
  result:=high(arr)+1;
//  if (result=0) and (str<>'') then inc(result);
  setLength(arr,result+1);
//  if result>0 then
  arr[result]:=str;
end;
function add_array(const str : stringarray;var arr : stringArray):integer;
var
  i : integer;
begin
  result:=length(arr);
  for i := low(str) to high(str) do begin
    inc(result);
    setLength(arr,result);
    arr[result-1]:=str[i];
  end;
end;

function add_array(const str : stringArray;var arr : stringStringArray):integer;

begin
  result:=length(arr);
  setLength(arr,result+1);
  arr[result]:=str;
end;
function set_array(var arr : stringStringArray;st1,stv : string):integer;


begin
  result:=find_array(st1,arr);
  if result>=0 then
    arr[result]:=make_Array(st1,stv)
  else
    add_array(make_Array(st1,stv),arr);
end;

function set_array(var arr : stringArray;st1,stv : string):integer;
begin
  result:=find_array(st1,arr);
  if result>=0 then
    arr[result]:=make_string(st1,stv)
  else
    add_array(make_string(st1,stv),arr);
end;


function get_array(const arr : stringArray;stv : string):string;
var
  i : integer;
  sv : string;
begin
 for i:= low(arr) to high(arr) do begin
   sv:=get_String(arr[i],result);
   if sv=stv then exit;
 end;
 result:='';

end;

{
function set_array(const st1 : string;var arr : StringArray;stv : string):integer;
begin
  result:=find_array(st1,arr);
  if result>=0 then
    arr[result]:=make_Array(st1,stv)
  else
    add_array(make_Array(st1,stv),arr);
end;
}

function make_array:stringArray;
begin
  setLength(result,0);

// add_array( '',result);
end;

function make_string(s1,sv : string):string;
begin
  if sv<>'' then
    result:=s1+'=>'+sv
  else
    result:=s1;
end;
function get_string(s1 : string;var sv: string):string;
var
  i : integer;
begin
  i:=pos('=>',s1);
  if i>0 then begin
    result:=copy(s1,1,i-1);
    sv:=copy(s1,i+2,length(s1));
  end else begin
    result:=s1;
    sv:='';
  end;
end;

function get_string(s1 : string):string;
var
  sv : string;
begin
  result:=get_string(s1,sv);
end;

function make_array(s1,s2: string;const s3:string='';const s4:string='';const s5:string='';const s6:string='';const s7:string=''
                                 ;const s8:string='';const s9:string='';const s10:string='';const s11:string=''):stringArray;

begin
 add_array(s1,result);
 if s2<>'' then add_array(s2,result);
 if s3<>'' then add_array(s3,result);
 if s4<>'' then add_array(s4,result);
 if s5<>'' then add_array(s5,result);
 if s6<>'' then add_array(s6,result);
 if s7<>'' then add_array(s7,result);
 if s8<>'' then add_array(s8,result);
 if s9<>'' then add_array(s9,result);
 if s10<>'' then add_array(s10,result);
 if s11<>'' then add_array(s11,result);
end;
function make_array(s1: stringArray):stringStringArray;
begin
 add_array( s1,result);
end;
function make_array(s1,s2: stringArray):stringStringArray;
begin
 add_array( s1,result);
 add_array(s2,result);
// if s3<>'' then add_array(s3,result);
end;
function make_array(s1,s2,s3: stringArray):stringStringArray;
begin
 add_array( s1,result);
 add_array(s2,result);
 add_array(s3,result);
// if s3<>'' then add_array(s3,result);
end;


procedure make_list(arr : stringArray;var s1,s2 : string);
begin

  if length(arr)>0 then s1:=arr[0] else s1:='';
  if length(arr)>1 then  s2:=arr[1] else s2:='';
end;

function explode(s1: char;const s2: string):stringArray;
var
  ip,ik : integer;
begin
 ip:=1;
 for ik:= 1 to length(s2) do begin
   if s2[ik]=s1 then begin
     add_array(copy(s2,ip,ik-ip),result);
     ip:=ik+1;
   end;
 end;
 ik:=length(s2);
 if ik>=ip then
 add_array(copy(s2,ip,ik-ip+1),result);

end;


procedure addPrefix(var arr : stringArray;s1 : string);
var
 i  : integer;
begin
 for i := low(arr) to high(arr) do begin
   arr[i]:=s1+arr[i];
 end;
end;


  function urldefrag(aurl:string):string;
  var
    io : integer;
  begin
     io:=pos('#',aurl);
     if io>0 then
       result:=copy(aurl,1,io-1)
     else
       result:=aUrl;

(*
        $parts = explode("#", $url, 2);

        if (count($parts) == 1) {
            return array($parts[0], "");
        } else {
            return $parts;
        }
        *)
  end;


function explode(sPart, sInput: string): ArrOfStr;
begin
  while Pos(sPart, sInput) <> 0 do 
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := Copy(sInput, 0,Pos(sPart, sInput) - 1);
    Delete(sInput, 1,Pos(sPart, sInput));
  end;
  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := sInput;
end;

function implode(sPart: string; arrInp: ArrOfStr): string;
var 
  i: Integer;
begin
  if length(arrInp)=0 then result:=''
  else if Length(arrInp) <= 1 then Result := arrInp[0]
  else   begin
    for i := 0 to Length(arrInp) - 2 do Result := Result + arrInp[i] + sPart;
    Result := Result + arrInp[Length(arrInp) - 1];
  end;
end;

function translate(arr : stringArray;ain,aOut : string):integer;
var
  io,
  i : integer;
begin
    result:=0;
    for i := low(arr) to high(arr) do begin
      io:=pos(ain,arr[i]);
      if io>0 then begin
         delete(arr[i],io,length(ain));
         insert(aout,arr[i],io);
         inc(result);
      end;

    end;


end;


procedure sort(arrInp: ArrOfStr);
var 
  slTmp: TStringList; 
  i: Integer;
begin
  slTmp := TStringList.Create;
  for i := 0 to Length(arrInp) - 1 do slTmp.Add(arrInp[i]);
  slTmp.Sort;
  for i := 0 to slTmp.Count - 1 do arrInp[i] := slTmp[i];
  slTmp.Free;
end;

procedure rsort(arrInp: ArrOfStr);
var 
  slTmp: TStringList; 
  i: Integer;
begin
  slTmp := TStringList.Create;
  for i := 0 to Length(arrInp) - 1 do slTmp.Add(arrInp[i]);
  slTmp.Sort;
  for i := 0 to slTmp.Count - 1 do arrInp[slTmp.Count - 1 - i] := slTmp[i];
  slTmp.Free;
end;


  function SplitString(const aSeparator, aString: String; aMax: Integer = 0): Stringarray;
  var
    i, strt, cnt: Integer;
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
        result[cnt] := Copy(aString, strt, endPos - strt)
      else
        result[cnt] := '';

      Inc(cnt);
    end;

  begin
    if (aString = '') or (aMax < 0) then
    begin
      SetLength(result, 0);
      EXIT;
    end;

    if (aSeparator = '') then
    begin
      SetLength(result, 1);
      result[0] := aString;
      EXIT;
    end;

    sepLen := Length(aSeparator);
    SetLength(result, (Length(aString) div sepLen) + 1);

    i     := 1;
    strt  := i;
    cnt   := 0;
    while (i <= (Length(aString)- sepLen + 1)) do
    begin
      if (aString[i] = aSeparator[1]) then
        if (Copy(aString, i, sepLen) = aSeparator) then
        begin
          AddString;

          if (cnt = aMax) then
          begin
            SetLength(result, cnt);
            EXIT;
          end;

          Inc(i, sepLen - 1);
          strt := i + 1;
        end;

      Inc(i);
    end;

    AddString(Length(aString));

    SetLength(result, cnt);
  end;


end.
