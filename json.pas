unit JSON;
// JSON (JavaScript Object Notation) Helper Library
// Released as New BSD license
// Revision History:
// @001 2010.01.13 Noah SILVA Started library - Moved JSON Helper functions from
//                              PlaceEngine library to this one.
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils;

Function DeQuote(const input:string):String;
Function DeBracket(const input:string):String;
Function DeBrace(const input:string):String;
Function DeParen(const input:string):String;



implementation

// Returns a string, with everything to the left of the first
// quotation mark, and everything to the right of the second quotation mark
// clipped off. e.g. "hello" -> hello
Function DeQuote(const input:string):String;
 var
  p:integer;
 begin
         result := input;
         // Remove Left Quotation
         p := pos('"', result);
         if p > 0 then
           result := copy(result, p+1, length(result)-p);
         // Remove Right Quotation
         p := pos('"', result);
         if p > 0 then
           result := copy(result, 1, p-1);
 end;

// Returns a string, with everything to the left of the first
// left square bracket, and everything to the right of the first right square
// bracket clipped off. e.g. [hello] -> hello
Function DeBracket(const input:string):String;
 var
  p:integer;
 begin
         result := input;
         // Remove Left Quotation
         p := pos('[', result);
         if p > 0 then
           result := copy(result, p+1, length(result)-p);
         // Remove Right Quotation
         p := pos(']', result);
         if p > 0 then
           result := copy(result, 1, p-1);
 end;

//@002 Begin
// Returns a string, with everything to the left of the first
// left curly brace, and everything to the right of the first right curly
// brace clipped off. e.g. {"age":39} -> "age":39
Function DeBrace(const input:string):String;
 var
  p:integer;
 begin
         result := input;
         // Remove Left Quotation
         p := pos('{', result);
         if p > 0 then
           result := copy(result, p+1, length(result)-p);
         // Remove Right Quotation
         p := pos('}', result);
         if p > 0 then
           result := copy(result, 1, p-1);
 end;

// Returns a string, with everything to the left of the first
// left parenthesis, and everything to the right of the first right parenthesis
// brace clipped off. e.g. (hello) -> hello
Function DeParen(const input:string):String;
 var
  p:integer;
 begin
         result := input;
         // Remove Left Parenthesis
         p := pos('(', result);
         if p > 0 then
           result := copy(result, p+1, length(result)-p);
         // Remove Right Parenthesis
         p := pos(')', result);
         if p > 0 then
           result := copy(result, 1, p-1);
 end;

//@002 End


end.

