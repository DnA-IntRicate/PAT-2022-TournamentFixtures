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

end.
