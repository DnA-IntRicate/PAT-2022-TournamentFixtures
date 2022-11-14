// Adam Foflonker 11C
unit Fixture;

interface

// These const integers will be used to set LadderStage instead of typing ordinal integers.
// Initially Ladder stage was going to be an enumerated type, but it was changed due to some json
// serializing issues.
const
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

    // Default constructor
    constructor Create();
    procedure Reset();
  end;

type
  TFixtures = class(TObject)
  public
    // Max of 39 Fixture entries required
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
