{ License, info, etc
  ------------------
  This implementation is made by me, Walied Othman, to contact me
  mail to rainwolf@submanifold.be or triade@submanifold.be ,
  always mention wether it 's about the FGInt or about the 6xs,
  preferably in the subject line.
  This source code is free, but only to other free software,
  it's a two-way street, if you use this code in an application from which
  you won't make any money of (e.g. software for the good of mankind)
  then go right ahead, I won't stop you, I do demand acknowledgement for
  my work.  However, if you're using this code in a commercial application,
  an application from which you'll make money, then yes, I charge a
  license-fee, as described in the license agreement for commercial use, see
  the textfile in this zip-file.
  If you 're going to use these implementations, let me know, so I ca, put a link
  on my page if desired, I 'm always curious as to see where the spawn of my
  mind ends up in.  If any algorithm is patented in your country, you should
  acquire a license before using this software.  Modified versions of this
  software must contain an acknowledgement of the original author (=me).

  This implementation is available at
  http://www.submanifold.be

  copyright 2000, Walied Othman
  This header may not be removed. }

unit LbBigInt.Helper;

{$H+}

interface

uses SysUtils, Math, FGInt, LbBigInt;

type
  TLbBigIntHelper = class helper for TLbBigInt
  private
    function GetBase10string: string;

  public
    class function BytesToBase10string(const ABytes: TBytes;
      const Count: integer): string;  overload;
    class function BytesToBase10string(const ABytes: TBytes): string;
       overload;
    class function Base10ToBytes(const Value: string): TBytes;
    class function Base10ToLbInt(const Value: string; const LbInt: TLbBigInt): boolean;
    property Base10string: string read GetBase10string;
  end;

implementation

{ TLbBigIntHelper }

class function TLbBigIntHelper.Base10ToBytes(const Value: string): TBytes;
var
  f: TFGint;
  str256, ass: ansistring;
begin
  Base10StringToFGInt(Value,f);
  FGInt.FGIntToBase256String(f,str256);
  SetLength(Result, length(str256));
  move(str256[1], Result[0], length(str256));
end;

class function TLbBigIntHelper.Base10ToLbInt(const Value: string;
  const LbInt: TLbBigInt): boolean;
var
b: TBytes;
  begin
  b := Base10ToBytes(Value);
  try
    LbInt.CopyBuffer(b[0],length(b));
  finally
    setlength(b,0);
  end;
end;

class function TLbBigIntHelper.BytesToBase10string(const ABytes
  : TBytes): string;
begin
  Result := BytesToBase10string(ABytes, length(ABytes));
end;

class function TLbBigIntHelper.BytesToBase10string(const ABytes: TBytes;
  const Count: integer): string;
var
  f: TFGint;
  modul256, ass: ansistring;
begin
//  SetLength(modul256, Count);
//  move(ABytes[0], Pansichar(modul256)^, Count);
//  Base256StringToFGInt(modul256, f);
//  FGInt.FGIntToBase10String(f, ass);
//  Result := ass;
// bytes are digit in the little endian
  f.Init;
  //test
  //FGInt.FGIntToBase256String();
  //
  FGInt.BytesToFGInt(ABytes,Count,f);
  FGInt.FGIntToBase10String(f, ass);
  Result := ass;
end;

function TLbBigIntHelper.GetBase10string: string;
//var
//  f: TFGint;
//  modul256, ass: ansistring;
begin
//  SetLength(modul256, Int.IntBuf.dwLen);
//
//  move(Int.IntBuf.pBuf^, Pansichar(modul256)^, Int.IntBuf.dwLen);
//
//  Base256StringToFGInt(modul256, f);
//
//  FGInt.FGIntToBase10String(f, ass);
//  Result := ass;
  Result := BytesToBase10string(TBytes(Int.IntBuf.pBuf), Int.IntBuf.dwLen);
end;

end.
