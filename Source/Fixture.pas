unit Fixture;

interface

const
  LadderStage_Disqualified = -1;
  LadderStage_Qualifier = 0;
  LadderStage_QuarterFinal = 1;
  LadderStage_SemiFinal = 2;
  LadderStage_Final = 3;
  LadderStage_Champion = 4;

type
  TFixture = class(TObject)
  public
    TeamID: integer;
    LadderStage: integer;
    StagePosition: integer;
    Eliminated: boolean;

    constructor Create();
  end;

type
  TFixtures = class(TObject)
  public
    Entries: array [1 .. 20] of TFixture;
    constructor Create();
  end;

implementation

constructor TFixture.Create();
begin
  TeamID := 1;
  LadderStage := LadderStage_Qualifier;
  StagePosition := 0;
  Eliminated := false;
end;

constructor TFixtures.Create();
var
  i: integer;
begin
  for i := Low(Entries) to High(Entries) do
    Entries[i] := TFixture.Create();
end;

end.
