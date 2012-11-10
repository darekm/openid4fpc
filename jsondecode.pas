Unit jsondecode;
// JSON List decoding unit     RFC4627 http://www.json.org
// Modification history:
// @000 2010.02.01 Noah SILVA // First version
// @001 2010.03.04 Noah SILVA // Changes to JSON2List, additional functions
// @002 2010.03.05 Noah SILVA // Added JSONTreeGetMultiple, GetKey, GetValue
// @003 2010.03.10 Noah SILVA // Fixed JSON2StringList for quotations
// @004 2010.04.05 Noah SILVA // Added quotation escape handling
// @005 2010.04.22 Noah SILVA // Added function for decoding \uXXXX escaping
// @006 2010.04.22 Noah SILVA // Changes JSON2StringList to report error codes
{$IFDEF FPC}{$mode objfpc}{$ENDIF}{$H+}

// JSON terminology
// OBJECT = Unordered array of values { string:value, }
// ARRAY = Unordered array of values [ value, ]
//
// To Do/Issues:
// * More extensive validation
// * Handle character escaping
Interface

Uses
  Classes, Sysutils;

// Returns true is the passed value is a list
// LIST means an object or an array
Function JSONDataIsList(CONST JSONData:String):Boolean;                         //@002+
// True is data is a valid JSON Object (list of key:value pairs)
Function JSONDataIsObject(CONST JSONData:String):Boolean;                       //@002+
// True if data is a valid JSON Array (list of ordered values)
Function JSONDataIsArray(CONST JSONData:String):Boolean;                        //@002+
// True is data is a valid JSON Number
Function JSONDataIsNumber(CONST JSONData:String):Boolean;                       //@002+
// True is Data is a valid JSON Strong
Function JSONDataIsString(CONST JSONData:String):Boolean;                       //@002+
// Returns true is the data has exactly one colon (it is a key value pair)
Function JSONDataIsKeyValuePair(CONST JSONData:String):Boolean;                 //@002+
// If the current JSON Data is not a list, return the key (part to left of :)
Function JSONGetKey(CONST JSONData:String):String;                              //@002+
// If the current JSON Daat is not a list, return the value (part to the right
// of the color).  This may be a complex item (list), or a simple item
//Function JSONGetValue(CONST JSONData:String):String;                            //@002+
Function JSONGetValue(CONST JSONData:String):String;                            //@002+


// Decodes a JSON List into a StringList.  This only decodes the first
// level, meaning that the list items could well be strings that further
// contain more lists
Function JSON2StringList(CONST JSONString:String; VAR Decoded:TStringList):Integer;    //@000+//@006=
// Input: JSONString: JSON encoded data string.
// Output:List of key-value pairs, separated by colon
//        Each value may be a complex item (i.e. another list)
//        Does not include the original surrounding parenthesis

Function JSONGetValueByKey(CONST JSONList:TStringList; CONST Key:String):String;//@001+
// Input: JSONList = TStringList decoded by JSON2List
//        Key = Simple (one level) key to search for.  Include quotations,
//              if any.
// Output: String which comprises the value of the key searched for, or blank if
//         not located.

// the following function should be rewritten...
Function JSONTreeGet(const JSONString:String; CONST JSONPath:String):String;   //@001+
// Input: JSONString: JSON encoded data string.
// JSONPath: Path including a complex "key" to the value we want, up to
//   (but not including) the :.  It should include each string in the search
//    path, including the quotation marks, if any, separated by colons.
// Output: A single result string, which may be simple or complex
//         (another list).
// Example: if you use the complex key
//    "learning_engine":"statistics":"urgent_items_count"
// on the results of GetStudy, it will will give the number of urgent items
// Issues:
// Some entries may be duplicated, f.e. there is are multuple entries for:
// smart.fm's GetStudy's "learning_engine":"items":"progress"
// This is because it shows the progress for each vocabulary words.

// Currently crashes
//Procedure JSONTreeGetMultiple(const JSONString:String;                          //@002+
//                           CONST JSONPath:String; VAR ValueList:TStringList);   //@002+
//Function JSONTreeGetMultiple(const JSONString:String;                           //@002+
//                                          CONST JSONPath:String):TStringList;   //@002+
// Input: JSONString: JSON encoded data string.
// JSONPath: Path including a complex "key" to the value we want, up to
//   (but not including) the :.  It should include each string in the search
//    path, including the quotation marks, if any, separated by colons.
// Output: A list of result strings, each of which may be simple or complex
//         (another list).
Function JSONEscapeDecode(CONST JSONData:String):String;                        //@005+


Implementation

// unfortunately, parsing JSON is more complex than it looks, why couldn't they
// have used something like CSV? (or had more fine grained function calls?)

// Same as COPY function, but lets you specify the stopping position, instead
// the copy length.
Function CopyStop(const Str:String;
                  const start:Integer; const Stop:Integer):String;
  Begin
    Result := Copy(Str, Start, Stop-Start+1);
  End;

// Removes the /uXXXX type encodings, and replaces them with real unicode
Function JSONEscapeDecode(CONST JSONData:String):String;                        //@005+

var
  ptr:integer;  // This is where the \uXXXX starts

  moji_hex :String[4];
  moji:WideString;      // Holds new char as UTF16


  Procedure Moji_Process;
   begin
     if ptr >= length(JSONData) then Exit;  // Just in case;
    inc(ptr);
    CASE JSONData[ptr] of
      'u': begin // Process the \uXXXX sequence
             Inc(ptr);
             Moji_Hex := '';
             // get the next four chars
             Moji_Hex := Copy(JSONData, ptr, 4);
//             Moji_Hex := Upcase(Copy(JSONData, ptr, 4));
             Moji := '';
              // Convert from Hex to Unicode
             Moji := WideChar(StrToInt('$'+Moji_Hex));
             Result := Result + UTF8Encode(Moji);                // Add the result to output
             Inc(ptr, 3); // Skip past this part of the input string.
           End;  // of CASE U
      else
          Result := Result + JSONData[ptr];     // It was something else like /", //, etc.
    END;    // of CASE
   end; // of [sub]Procedure

begin

  Result := '';
  moji_hex:='';
  moji:='';
  ptr:=1;
  REPEAT
    WHILE (ptr <= length(JSONData)) do
      begin
        if ptr > length(JSONData) then Exit;  // Just in case;
        CASE JSONData[ptr]  of
           // It's a /, so we check the next character
          '\':  Moji_Process;
        else
          Result := Result + JSONData[ptr];
        End;
        Inc(ptr);
      End; // of WHILE

  UNTIL ptr >= length(JSONData);
 end; // of PROCEDURE

Function JSONDataIsList(CONST JSONData:String):Boolean;                         //@002+
  Begin
    Result := false;
    If Length(Trim(JSONData)) = 0 then exit;
    If Trim(JSONData)[1] in ['{','[','('] then
     Result := True;
  End;

Function JSONDataIsObject(CONST JSONData:String):Boolean;                       //@002+
  Begin
    Result := false;
    If Length(Trim(JSONData)) = 0 then exit;
    If Trim(JSONData)[1] in ['{'] then
     Result := True;
  End;

Function JSONDataIsArray(CONST JSONData:String):Boolean;                       //@002+
  Begin
    Result := false;
    If Length(Trim(JSONData)) = 0 then exit;
    If Trim(JSONData)[1] in ['['] then
     Result := True;
  End;

Function JSONDataIsNumber(CONST JSONData:String):Boolean;                        //@002+
  Var
    IndexPOS:Integer;
  Begin
    Result := false;
    If Length(Trim(JSONData)) = 0 then exit;
    Result := True;
    For IndexPos := 1 to Length(JSONData) do
       If not (JSONData[IndexPos] in
       [' ','.','e','E','-','+','0','1','2','3','4','5','6','7','8','9']) then
       begin
         Result := False;
         Exit;
       end;
    // There should only be a maximum of one each of the +,-,., and e/E
  End;

Function JSONDataIsString(CONST JSONData:String):Boolean;                       //@002+
  Begin
    Result := false;
    If Length(Trim(JSONData)) = 0 then exit;
    If Trim(JSONData)[1] in ['"'] then
     Result := True;
    // last non-whitespace char should also be double quote
  End;

Function JSONDataIsKeyValuePair(CONST JSONData:String):Boolean;                 //@002+
  var
    InputPos:Integer;
    SeparCount:Integer;
    InQuote : Boolean;
    BraceLevel:Integer;
  begin
    inputPos:=0;
    separCOunt:=0;
    inQuote:=false;
    braceLevel:=0;
    Result := false;
//    InQuote := False;
//    SeparCount := 0;
    If Length(Trim(JSONData)) = 0 then exit;
    While (InputPOS < length(JSONData))  Do
      begin
         Inc(InputPos);
         Case JSONData[InputPos] of
           '"':Begin                                                            //@004+
                 If InputPos = 1 then                                           //@004+
                   InQuote := NOT InQuote                                       //@003+
                 else if JSONData[InputPos-1] <> '\' then                       //@004+
                   InQuote := NOT InQuote;                                      //@004+
              End;                                                              //@004+
           '{' : Inc(BraceLevel);
           '}' : Dec(BraceLevel);
         end; // of CASE
         writeln('Inquote', inquote);
         writeln('BraceLevel', Bracelevel);
      //If there is no colon we must have reached the end, this is a simple key
         if (not InQuote) and (BraceLevel = 0) then
           if JSONData[InputPos] = ':' then inc(SeparCount);
        Writeln('SeparCount', SeparCount);

      end;
    Result := (SeparCount = 1);
  End;

Function JSON2StringList(const JSONString:AnsiString; VAR Decoded:TStringList):Integer;    //@000+  //@006=
  Const
   ListItemSep=',';     // Separator between entries in a list
  Var
//   ParO:Char;   // Opening Parenthesos or similar
//   ParC:Char;   // Closing Parenthesis or similar (Matring to ParO)           //@001-
   Pos:Integer; // Processing Position in the string.
   NestCount:Integer; // Nesting Level: 1 = top level list.
   CopyPos:Integer;  // Starting Position for CopyStop function
   TmpStr:String;
   InQuote:Boolean;                                                       //@003+
  begin
    nestCount:=0;
    copyPos:=1;
    inQuote:=false;
//    Writeln('JSON2StringList: Start.');
    Decoded.Clear;                                                              //@001+
//    ParO := JSONString[1];    // The JSON should start with the enclosing char
    If not JSONDataIsList(JSONString) then
    begin
      Result := -1;
      Exit;  // we could give the key as the list?  or the value?  or both?
    End;
//    NestCount := 0;
//    CopyPos := 1;
// We should really track the nesting of different types separately, but this is
// good enough for now and should work on properly formed files.
    For Pos := 1 to Length(JSONString) do
      begin
         CASE  JSONString[Pos] of
           '"':Begin                                                            //@004+
               If pos = 1 then                                                  //@004+
                 InQuote := NOT InQuote                                         //@003+
               else if JSONString[Pos-1] <> '\' then                            //@004+
                 InQuote := NOT InQuote;                                        //@004+
              End;                                                              //@004+
          '(','[','{': if Not InQuote then Inc(NestCount);                      //@003=
          ')',']','}': if Not InQuote then                                      //@003+
                       begin
                        Dec(NestCount); // in any case, we dec the depth
                        If NestCount = 0 then  // This is the last item         //@002+
                          begin    // so we process with even with no comma

                           TmpStr :=
//                           JSONEscapeDecode(                                    //@005+
                           Trim(CopyStop(JSONString, CopyPos+1, Pos-1));         //@002+
//                           );                                                   //@005+
//                           Writeln('Adding Entry. (Last)');
                           Decoded.Append(TmpStr);
                           CopyPos := Pos;
                          end;
                       end;  // of Close Object/Array processing

          ListItemSep: If not InQuote then                                      //@003=
                       Begin
//                        Writeln('List Item Separator Detected');
                        If NestCount = 1 then  // if we are exactly one level deep
                         Begin    // then we count this one
                          TmpStr := // JSONEscapeDecode(                          //@005=
                            Trim(CopyStop(JSONString, CopyPos+1, Pos-1));        //@002+
                      //    );                                                    //@005+
//                          Writeln('Adding Entry (Internal).');
                          Decoded.Append(TmpStr);
                          CopyPos := Pos;
                         End;
                       End;  //of ListItemSep
         End; // of CASE
//           Writeln('JSON2StringList>>', 'Pos:', pos, 'NestCount:', NestCount);
      end;  // of FOR
   Result := 0;
//   Writeln('Item Count:' + IntToStr(Decoded.Count));
//   Writeln('JSON2StringList: End.');
  end;  // of PROCEDURE

Function JSONGetValueByKey(CONST JSONList:TStringList; CONST Key:String):String;//@001+
  var
   i:integer;
   _Key:String;  // Temporary variable for string comparison, we don't really need this
   DelimiterPos:Integer;
  begin
    Result := '';
    For i := 0 to JSONList.Count - 1 do
      begin
        // This isn't "Quote Safe".
        DelimiterPos := Pos(':', JSONList.Strings[i]);
        if DelimiterPOS > 1 then  // we got a delimiter
          begin
           _key := copy(JSONList.Strings[i], 1, DelimiterPOS-1);
           if _key = key then // we got a match!
             begin  // Grab the result.
               // Note that this might be a simple value,
               // or might be another list.
               Result :=  //JSONEscapeDecode(                                     //@005+
                                           CopyStop(JSONList.Strings[i],
                                                   DelimiterPOS+1,
                                                   Length(JSONList.Strings[i])) ;
                                                //   );
               Exit;  // We're done here.
             end; // of IF key...
          end; // of IF POS...
      end; // of FOR
  end; // of FUNCTION

// I can't even believe this code worked on the first try, as messy as it is!
Function JSONTreeGet(const JSONString:String; CONST JSONPath:String):String;    //@001+
  Var
   InputPOS:Integer;
   SimpleKeyStartPos:Integer;
   ThisKey:String;
   JSONList:TStringList;
  begin
    JSONList := TStringList.Create;
    If Length(JSONPath) = 0 then exit;
    InputPOS := 0;
    SimpleKeyStartPos := 0;
    Result := JSONString;  // seems odd, but we are narrowing it down from here
    Repeat
      Inc(InputPOS); // move past pos 0 the first time, or past the last colon
      SimpleKeyStartPos := InputPos; // Next key will be starting here
      // Find next colon, if any
      While (InputPOS < length(JSONPath)) and (JSONPath[InputPos] <> ':') Do
        Inc(InputPos);
      //If there is no colon we must have reached the end, this is a simple key
      if JSONPath[InputPos] <> ':' then
        ThisKey := CopyStop(JSONPath, SimpleKeyStartPos, InputPos)
      else // it was a colon
        ThisKey := CopyStop(JSONPath, SimpleKeyStartPos, InputPos - 1);
      If Length(ThisKey) = 0 then Exit;  // just a sanity check
      // process this key
      JSON2StringList(Result, JSONList);    // this gets replaced every time
      Result := JSONGetValueByKey(JSONList, ThisKey);
    Until InputPOS >= Length(JSONPath);  // Until we have processed the entire string
  end; // of FUNCTION

Procedure JSONTreeGetMultiple(const JSONString:String;                          //@002+
                          CONST JSONPath:String; Var ValueList:TStringList);    //@002+
//Function JSONTreeGetMultiple(const JSONString:String;                           //@002+
//                                         CONST JSONPath:String):TStringList;    //@002+
  Var
   InputPOS:Integer;
   SimpleKeyStartPos:Integer;
   ThisKey:String;
   JSONList:TStringList;
   tmpStr:string;
   Found:Boolean;
  begin
//    Result := TStringList.Create;  //@003-
    JSONList := TStringList.Create;
    If Length(JSONPath) = 0 then exit;
    Repeat
      Found := false;
      InputPOS := 0;
      SimpleKeyStartPos := 0;
      tmpStr := JSONString;  // seems odd, but we are narrowing it down from here
      Repeat
        Inc(InputPOS); // move past pos 0 the first time, or past the last colon
        SimpleKeyStartPos := InputPos; // Next key will be starting here
        // Find next colon, if any
        While (InputPOS < length(JSONPath)) and (JSONPath[InputPos] <> ':') Do
          Inc(InputPos);
        //If there is no colon we must have reached the end, this is a simple key
        if JSONPath[InputPos] <> ':' then
          ThisKey := CopyStop(JSONPath, SimpleKeyStartPos, InputPos)
        else // it was a colon
          ThisKey := CopyStop(JSONPath, SimpleKeyStartPos, InputPos - 1);
        If Length(ThisKey) = 0 then Exit;  // just a sanity check
        // process this key
        JSON2StringList(tmpStr, JSONList);    // this gets replaced every time
        tmpStr := JSONGetValueByKey(JSONList, ThisKey);
        If (InputPOS = Length(JSONPath)) and (tmpstr <> '') then
         Begin
           ValueList.Append(tmpStr);         //@003=
           tmpStr := '';
           Found := True;
         End;
      Until InputPOS >= Length(JSONPath);  // Until we have processed the entire string
    Until not Found;   // Try again until no more matches found

  end; // of FUNCTION


Function JSONGetKey(CONST JSONData:String):String;                              //@002+
  var
   InputPos:integer;
  Begin
    inputPos:=0;
    If Length(JSONData) = 0 then exit;
    If JSONData[1] in ['{','[', '('] then exit;
    While (InputPOS < length(JSONData)) and (JSONData[InputPos] <> ':') Do
          Inc(InputPos);
    CASE JSONData[InputPos] OF
    ':' :         // we got colon
              Result :=  // JSONEscapeDecode(                                     //@005+
                                  Trim(CopyStop(JSONData, 1, InputPos - 1))
    //                                      );                                    //@005+
    else         //  no colon to be found
         Result := '';
    end; // of CASE
  End;

Function JSONGetValue(CONST JSONData:String):String;                            //@002+
 var
   InputPos:integer;
  Begin
    inputPos:=0;
    Result := 'not set';
    If Length(JSONData) = 0 then exit;
    If JSONData[1] in ['{','[', '('] then exit;
    While (InputPOS < length(JSONData)) and (JSONData[InputPos] <> ':') Do
          Inc(InputPos);
    CASE JSONData[InputPos] OF
    ':' :         // we got colon
        Result := // JSONEscapeDecode(                                            //@005+
                        Trim(CopyStop(JSONData, InputPos + 1, Length(JSONData)))
                  //                 );                                           //@005+
    else         //  no colon to be found
         Result := 'notfound';
    end; // of CASE
  End;

End. // of Unit

