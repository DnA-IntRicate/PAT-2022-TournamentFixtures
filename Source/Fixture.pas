unit Fixture;

interface

const
  LadderStage_Disqualified = -1;
  LadderStage_Qualifier = 0;
  LadderStage_Qualifier2 = 1;
  LadderStage_QuarterFinal = 2;
  LadderStage_SemiFinal = 3;
  LadderStage_Final = 4;
  LadderStage_Champion = 5;

type
  TFixture = class(TObject)
  public
    TeamID: integer;
    LadderStage: integer;
    StagePosition: integer;
    Eliminated: boolean;

    constructor Create();
    procedure Reset();
  end;

type
  TFixtures = class(TObject)
  public
    Entries: array [1 .. 39] of TFixture;
    constructor Create();
  end;

implementation

constructor TFixture.Create();
begin
  Reset();
end;

constructor TFixtures.Create();
var
  i: integer;
begin
  for i := Low(Entries) to High(Entries) do
    Entries[i] := TFixture.Create();
end;

procedure TFixture.Reset();
begin
  TeamID := 1;
  LadderStage := LadderStage_Qualifier;
  StagePosition := 0;
  Eliminated := false;
end;

end.
