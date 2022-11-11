// Adam Foflonker 11C
unit Team;

interface

type
  TTeam = class(TObject)
  public
    ID: integer;
    Name: string;
    Grade: integer;
    Layout: string;
    SubmitterAdminID: integer;

    constructor Create();
  end;

type
  TTeamList = class(TObject)
  public
    Teams: array [1 .. 20] of TTeam;

    constructor Create();
    function FindTeamByID(const ID: integer): TTeam;
    function FindTeamByName(const Name: string): TTeam;
  end;

implementation

constructor TTeam.Create();
begin
  ID := 0;
  Name := '';
  Grade := 0;
  Layout := '';
  SubmitterAdminID := 0;
end;

constructor TTeamList.Create();
var
  i: integer;
begin
  for i := Low(Teams) to High(Teams) do
    Teams[i] := TTeam.Create();
end;

function TTeamList.FindTeamByID(const ID: integer): TTeam;
var
  i: integer;
begin
  for i := Low(Teams) to High(Teams) do
  begin
    if Teams[i].ID = ID then
    begin
      Result := Teams[i];
      break;
    end;
  end;
end;

function TTeamList.FindTeamByName(const Name: string): TTeam;
var
  i: integer;
begin
  for i := Low(Teams) to High(Teams) do
  begin
    if Teams[i].Name = name then
    begin
      Result := Teams[i];
      break;
    end;
  end;
end;

end.
