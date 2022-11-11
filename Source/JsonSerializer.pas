// Adam Foflonker 11C
unit JsonSerializer;

interface

uses
  System.Hash, System.SysUtils, JSON, DBXJSON,
  DBXJSONReflect, Fixture;

type
  TJsonSerializer = class
  public
    constructor Create();
    function SerializeJson(obj: TObject): string;
    function SerializeJsonArray(objects: array of TObject): string;
    function DeserializeJson(const jsonStr: string): TObject;
    function DeserializeJsonArray(const jsonStr: string): TJSONArray;

  private
    m_Marshal: TJSONMarshal;
    m_Unmarshal: TJSONUnMarshal;
  end;

implementation

constructor TJsonSerializer.Create();
begin
  m_Marshal := TJSONMarshal.Create(TJSONConverter.Create());
  m_Unmarshal := TJSONUnMarshal.Create();

  m_Marshal.RegisterConverter(TFixtures, 'Entries',
    function(Data: TObject; Field: string): TListOfObjects
    var
      Fixture: TFixture;
      i: integer;
    begin
      SetLength(Result, Length(TFixtures(Data).Entries));
      i := Low(Result);

      for Fixture in TFixtures(Data).Entries do
      begin
        Result[i] := Fixture;
        Inc(i);
      end;
    end);

  m_Unmarshal.RegisterReverter(TFixtures, 'Entries',
    procedure(Data: TObject; Field: string; Args: TListOfObjects)
    var
      obj: TObject;
      i: integer;
    begin
      i := Low(TFixtures(Data).Entries);
      for obj in Args do
      begin
        TFixtures(Data).Entries[i] := TFixture(obj);
        Inc(i);
      end;
    end);
end;

function TJsonSerializer.SerializeJson(obj: TObject): string;
begin
  Result := m_Marshal.Marshal(obj).ToString();
end;

function TJsonSerializer.SerializeJsonArray(objects: array of TObject): string;
var
  serializer: TJSONMarshal;
  jsArray: TJSONArray;
  jsValue: TJSONValue;
  myArray: array [1 .. 2] of integer;
  i: integer;
begin
  myArray[1] := 21;
  myArray[2] := 9999;

  serializer := TJSONMarshal.Create(TJSONConverter.Create());
  jsArray := TJSONArray.Create();

  for i in myArray do
  begin
    jsValue := TJSONValue.Create();
    // jsValue := serializer.Marshal(i).ToString();
  end;


  // jsArray.add

  // Result := serializer.Marshal(arr).ToString();

end;

function TJsonSerializer.DeserializeJson(const jsonStr: string): TObject;
begin
  Result := m_Unmarshal.Unmarshal(TJSONObject.ParseJSONValue(jsonStr))
    as TObject;
end;

function TJsonSerializer.DeserializeJsonArray(const jsonStr: string)
  : TJSONArray;
begin
  Result := TJSONObject.ParseJSONValue(jsonStr) as TJSONArray;
end;

end.
