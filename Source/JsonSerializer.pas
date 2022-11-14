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
    function DeserializeJson(const jsonStr: string): TObject;

  private
    // Private class member variables prefixed with 'm_'
    m_Marshal: TJSONMarshal;
    m_Unmarshal: TJSONUnMarshal;
  end;

implementation

constructor TJsonSerializer.Create();
begin
  m_Marshal := TJSONMarshal.Create(TJSONConverter.Create());
  m_Unmarshal := TJSONUnMarshal.Create();

  // Create json converter for type TFixtures using a lambda/anonymous function
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

  // Create json reverter for type TFixtures using a lambda/anonymous procedure
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

function TJsonSerializer.DeserializeJson(const jsonStr: string): TObject;
begin
  Result := m_Unmarshal.Unmarshal(TJSONObject.ParseJSONValue(jsonStr))
    as TObject;
end;

end.
